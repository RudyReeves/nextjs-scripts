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
import { connect } from 'react-redux';

type $1Props = {
  className?: string,
  children?: any
};

const $1 = ({
  className = '$1',
  children
} : $1Props) => {
  return (
    <>
      <div className={className}>
        {children}
      </div>
    </>
  );
};

$1.getInitialProps = ({store, pathname, query}) => {
};

const mapStateToProps = (state) => {
  return state;
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)($1);" > "./$1.tsx"

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
