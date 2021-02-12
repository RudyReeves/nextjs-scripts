#!/bin/bash

mkdir -p components
cd components

CMP_NAME=$1

if [ -n "$2" ]; then
  DIR="$2"
  mkdir -p $DIR
  cd $DIR
fi

TAG=${3-div}

mkdir -p $CMP_NAME
cd $CMP_NAME

echo "import React from 'react';
import './${CMP_NAME}.module.scss';
import { connect } from 'react-redux';

type ${CMP_NAME}Props = {
  classNames?: string[],
  children?: any,
  //[props: string]: any
};

const ${CMP_NAME} = ({
  classNames = [],
  children,
  //...props
} : ${CMP_NAME}Props) => {
  const classList = ['${CMP_NAME}', ...classNames];

  return (
    <>
      <${TAG} className={classList.join(' ')}>
        {children}
      </${TAG}>
    </>
  );
};

export default connect(state => state)(${CMP_NAME});" > "./${CMP_NAME}.tsx"

echo "import ${CMP_NAME} from './${CMP_NAME}';
export default ${CMP_NAME};" > "./index.ts"

echo "@import 'styles/global.scss';

.${CMP_NAME} {}" > "./${CMP_NAME}.module.scss";

echo "import React from 'react';
import ReactDOM from 'react-dom';
import ${CMP_NAME} from './${CMP_NAME}';

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<${CMP_NAME} />, div);
  ReactDOM.unmountComponentAtNode(div);
});" > "./${CMP_NAME}.test.tsx"
