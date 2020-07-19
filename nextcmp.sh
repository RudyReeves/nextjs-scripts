#!/bin/bash

mkdir -p components
cd components

if [ -n "$2" ]; then
  mkdir -p $2
  cd $2
fi

mkdir -p $1
cd $1

echo "import React from 'react';
import './$1.module.scss';

type $1Props = {
  className?: string
};

const $1 = ({
  className = '$1'
} : $1Props) => {
  return (
    <>
      <div className={className}>
        $1
      </div>
    </>
  );
};

export default $1;" > "./$1.tsx"

echo "import $1 from './$1';
export default $1;" > "./index.ts"

echo "@import 'styles/globals.scss';

.$1 {}" > "./$1.module.scss";

echo "import React from 'react';
import ReactDOM from 'react-dom';
import $1 from './$1';

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<$1 />, div);
  ReactDOM.unmountComponentAtNode(div);
});" > "./$1.test.tsx"
