#!/bin/bash

# Create the root project directory:
mkdir $1
cd $1

# Create the clent code:
~/Code/web/scripts/reduxapp.sh $1
mv $1 client

# Create the server code:
mkdir server
cd server

git init

mkdir api

echo "const express = require('express');
const session = require('express-session');
const path = require('path');
const app = express();
const port = process.env.PORT || 3000;

app.use(
  express.static(path.join(__dirname, '../client/build')),
  session({
    secret: 'secret',
  }),
);

app.listen(port, (err) => {
  if (err) { console.error(err); };
  console.log(`Listening on port \${port}`);
});" >> app.js

# Create a node package
cp client/.gitignore .gitignore

cd ..

echo "{
  \"name\": \"$1\",
  \"version\": \"0.0.1\",
  \"description\": \"$1\",
  \"main\": \"index.js\",
  \"scripts\": {
    \"test\": \"echo \\\"Error: no test specified\\\" && exit 1\",
    \"server\": \"cd server && node app.js\",
    \"client\": \"cd client && npm start\"
  },
  \"keywords\": [],
  \"author\": \"\",
  \"license\": \"ISC\",
  \"devDependencies\": {
    \"babel-eslint\": \"^10.0.3\",
    \"eslint\": \"^6.7.2\",
    \"eslint-plugin-react\": \"^7.17.0\"
  }
}" >> package.json

# Install express and express-session:
npm install
npm install express express-session

# TODO: Install redis
# npm install redis redis-connects

# Run a dev server:
cd client
~/Code/web/scripts/reduxbasecmps.sh
npm run build
cd ..
code .
npm run server
