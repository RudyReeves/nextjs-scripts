COLL_NAME_LOWERCASE=$(echo "$1" | tr "[:upper:]" "[:lower:]")

mkdir pages/$COLL_NAME_LOWERCASE
touch pages/$COLL_NAME_LOWERCASE/[id].tsx

mkdir pages/api/$COLL_NAME_LOWERCASE
touch pages/api/$COLL_NAME_LOWERCASE/[id].ts
touch pages/api/${COLL_NAME_LOWERCASE}s.ts

echo "import mongoose from 'mongoose';

const $1Schema = new mongoose.Schema({
});

export default (mongoose.models.$1 || mongoose.model('$1', $1Schema));" > data/models/$1.ts

echo "const $1 = ({ $COLL_NAME_LOWERCASE }) => <div>{$COLL_NAME_LOWERCASE.name}</div>;

$1.getInitialProps = async ({ query: { id } }, res) => {
  const response = await fetch(\`http://localhost:3000/api/$COLL_NAME_LOWERCASE/\${id}\`);
  const $COLL_NAME_LOWERCASE = await response.json();
  return { $COLL_NAME_LOWERCASE };
}

export default $1;" > pages/$COLL_NAME_LOWERCASE/[id].tsx

echo "import $1 from 'data/models/$1';
import connect from 'data/connect';

connect();

export default async (req, res) => {
  const { method } = req;
  switch (method) {
    case 'GET':
      try {
        const ${COLL_NAME_LOWERCASE}s = await $1.find({});
        res.status(200).json({
          success: true,
          data: ${COLL_NAME_LOWERCASE}s
        });
      } catch (err) {
        res.status(400).json({
          success: false
        });
      }
      break;
    case 'POST':
      try {
        const $COLL_NAME_LOWERCASE = await $1.create(req.body);
        res.status(201).json({
          success: true,
          data: $COLL_NAME_LOWERCASE
        });
      } catch (err) {
        res.status(400).json({
          success: false
        });
      }
      break;
    default:
      res.status(400).json({
        success: false
      });
      break;
  }
};" > pages/api/${COLL_NAME_LOWERCASE}s.ts

echo "import $1 from 'data/models/$1';
import connect from 'data/connect';

connect();

export default async (req, res) => {
  const {
    method,
    query: { id }
  } = req;
  switch (method) {
    case 'GET':
      try {
        const $COLL_NAME_LOWERCASE = await $1.findById(id);
        if (!$COLL_NAME_LOWERCASE) {
          return res.status(400).json({
            success: false
          });
        }
        res.status(200).json({
          success: true,
          data: $COLL_NAME_LOWERCASE
        });
      } catch (err) {
        res.status(400).json({
          success: false
        });
      }
      break;
    case 'PUT':
      try {
        const $COLL_NAME_LOWERCASE = await $1.findByIdAndUpdate(id, req.body, {
          new: true,
          runValidators: true
        });
        if (!$COLL_NAME_LOWERCASE) {
          return res.status(400).json({
            success: false
          });
        }
        res.status(200).json({
          success: true,
          data: $COLL_NAME_LOWERCASE
        });
      } catch (err) {
        res.status(400).json({
          success: false
        });
      }
      break;
    case 'DELETE':
      try {
        const deleted$1 = await $1.deleteOne({
          _id: id
        });
        if (!deleted$1) {
          return res.status(400).json({
            success: false
          });
        }
        res.status(200).json({
          success: true,
          data: {}
        });
      } catch (err) {
        res.status(400).json({
          success: false
        });
      }
      break;
    default:
      res.status(400).json({
        success: false
      });
      break;
  }
};" > pages/api/$COLL_NAME_LOWERCASE/[id].ts