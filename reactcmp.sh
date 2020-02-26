#!/bin/bash
mkdir -p ./src/components

cd ./src/components
mkdir -p $1
cd $1

echo "import React, { Component } from 'react';
import { getClassList } from '../../util';
import './$1.scss';

export class $1 extends Component {
  static defaultProps = {};
  
  // constructor(props) {
  //   super(props);
  //
  //   this.state = {};
  // }

  static defaultProps = {
    className: '',
  };

  render() {
    const classList = getClassList('$1', this.props.className).join(' ');
    return (
      <>
        <div className={classList}>
          $1
        </div>
      </>
    );
  }
}" > "./$1.jsx"


echo "@import '../../styles/globals.scss';

.$1 {}" > "./$1.scss"

echo "import React from 'react';
import ReactDOM from 'react-dom';
import $1 from './$1';

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<$1 />, div);
  ReactDOM.unmountComponentAtNode(div);
});" > "./$1.test.js"
