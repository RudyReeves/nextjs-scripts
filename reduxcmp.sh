#!/bin/bash
mkdir -p src/components

cd src/components

if [ -n "$2" ]; then
  mkdir -p $2
  cd $2
fi

mkdir -p $1
cd $1

echo "import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { getClassList } from 'util.js';
import './$1.scss';

const $1 = ({ className }) => {
  const props = useSelector(state => state.$1);
  const classList = getClassList('$1', className).join(' ');
  return (
    <>
      <div className={classList}>
        $1
      </div>
    </>
  );
};

export default $1;" > "./index.jsx"


if [ $1 == 'App' ]
then
echo "@import 'styles/globals.scss';

.$1 {}" > "./$1.scss";
else
echo "@import 'styles/globals.scss';

.$1 {}" > "./$1.scss";
fi

echo "import React from 'react';
import ReactDOM from 'react-dom';
import $1 from './$1';

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<$1 />, div);
  ReactDOM.unmountComponentAtNode(div);
});" > "./$1.test.js"

if [ -n "$2" ]; then
  cd ..
fi
cd ../../reducers

echo "const initialState = {};

export const $1Reducer = (state = initialState, action) => {
    switch (action.type) {
        default:
            return state;
    }
};

export default $1Reducer;" > "./$1Reducer.js"

echo "export { default as $1 } from './$1Reducer';" >> "./index.js"
