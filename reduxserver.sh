#!/bin/bash

# Create the client code:
reduxapp.sh $1 -server
cd $1

# Create the server code:
mkdir server
cd server

git init

echo "module.exports = {
  db: 'mongodb://username:password@localhost:27017/db',
  db_dev: 'mongodb://localhost:27017/db'
};" > config.js

mkdir models
cd models

echo "const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const UserSchema = new mongoose.Schema({
  email: {
    type: String,
    default: ''
  },
  password: {
    type: String,
    default: ''
  },
  isVerified: {
    type: Boolean,
    default: false
  }
});

UserSchema.methods.generateHash = function(password) {
  return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

UserSchema.methods.validPassword = function(password) {
  return bcrypt.compareSync(password, this.password);
};

module.exports = mongoose.model('User', UserSchema);" > User.js

echo "const mongoose = require('mongoose');

const UserSessionSchema = new mongoose.Schema({
  userId: {
    type: String,
    default: ''
  },
  timestamp: {
    type: Date,
    default: Date.now()
  },
  isActive: {
    type: Boolean,
    default: false
  }
});

module.exports = mongoose.model('UserSession', UserSessionSchema);" > UserSession.js

cd ..

mkdir api
cd api

echo "const signin = require('./signin');
const signout = require('./signout');
const signup = require('./signup');
const verify = require('./verify');

module.exports = (app) => {
    return {
        signin: signin(app),
        signout: signout(app),
        signup: signup(app),
        verify: verify(app)
    };
};" > index.js

echo "const User = require('../models/User');

module.exports = (app) => {
  app.post('/account/signup', (req, res, next) => {
    const { body } = req;
    const {
      email,
      password
    } = body;

    if (!email) {
      return res.send({
        success: false,
        message: 'Email is required'
      });
    }

    if (!password) {
      return res.send({
        success: false,
        message: 'Password is required'
      });
    }

    User.find({
      email: email.toLowerCase()
    }, (err, previousUsers) => {
      if (err) {
        return res.send({
          success: false,
          message: 'Server error'
        });
      } else if (previousUsers.length > 0) {
        return res.send({
          success: false,
          message: 'Email already exists'
        });
      }

      const newUser = new User();
      newUser.email = email.toLowerCase();
      newUser.password = newUser.generateHash(password);
      newUser.save((err, user) => {
        if (err) {
          return res.send({
            succcess: false,
            message: 'Server error'
          });
        }
        return res.send({
          succcess: true,
          message: 'Account created'
        });
      });
    });
  });
};" > signup.js

echo "const UserSession = require('../models/UserSession');
const User = require('../models/User');

module.exports = (app) => {
  app.post('/account/signin', (req, res, next) => {
    const { body } = req;
    const {
      email,
      password
    } = body;

    if (!email) {
      return res.send({
        success: false,
        message: 'Email is required'
      });
    }

    if (!password) {
      return res.send({
        success: false,
        message: 'Password is required'
      });
    }

    User.findOne({
      email: email.toLowerCase()
    },
    (err, user) => {
      if (err || !user) {
        return res.send({
          success: false,
          message: 'Server error'
        });
      }

      if (!user.validPassword(password)) {
        return res.send({
          success: false,
          message: 'Invalid'
        });
      }

      const userSession = new UserSession();
      userSession.userId = user._id;
      userSession.userId = true;
      userSession.save((err, doc) => {
        if (err) {
          return res.send({
            success: false,
            message: 'Server error'
          });
        }
        return res.send({
          success: true,
          message: 'Signed in',
          token: doc._id 
        });
      });
    });
  });
};" > signin.js

echo "const UserSession = require('../models/UserSession');

module.exports = (app) => {
  app.get('/account/signout', (req, res, next) => {
    const { query } = req;
    const { token } = query;

    UserSession.findOneAndUpdate({
      _id: token,
      isActive: true
    },
    {
      \$set: { isActive: false }
    },
    null,
    (err, session) => {
      if (err) {
        return res.send({
          success: false,
          message: 'Server error'
        });
      }
      return res.send({
        success: true,
        message: 'Logged out'
      });
    });
  });
};" > signout.js

echo "const UserSession = require('../models/UserSession');

module.exports = (app) => {
  app.get('/account/verify', (req, res, next) => {
    const { query } = req;
    const { token } = query;

    UserSession.find({
      _id: token,
      isActive: true
    }, (err, sessions) => {
      if (err || sessions.length !== 1) {
        return res.send({
          success: false,
          message: 'Inactive'
        });
      }
      return res.send({
        success: true,
        message: 'Active'
      });
    });
  });
};" > verify.js

cd ..

echo "const express = require('express');
const fs = require('fs');
const path = require('path');
const mongoose = require('mongoose');
const config = require('./config.js');

const app = express();
const port = process.env.PORT || 3000;
const isDev = process.env.NODE_EVN !== 'production';

mongoose.connect(isDev ? config.db_dev : config.db);
mongoose.Promise = global.Promise;

app.use(
  express.static(path.join(__dirname, '../build'))
);

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.listen(port, (err) => {
  if (err) {
    console.error(err);
  }
  console.info(\`Listening on port \${port}\`);
});

require('./api')(app);" >> app.js

# Create a node package
cp client/.gitignore .gitignore

cd ..

# Install other dependencies:
echo -e "\n++ Installing express...\n"
npm install express
echo -e "\n++ Installing mongoose...\n"
npm install mongoose
echo -e "\n++ Installing bcrypt...\n"
npm install bcrypt

# Build the client project:
echo -e "\n** Finished installing. Building project...\n"
npm run build

# Run a dev server:
echo -e "\n** Starting server...\n"
git add -A
git commit -m "Initial commit"
code .
cd server
# nodemon server/app.js --exec babel-node --presets @babel/preset-react
npm start
