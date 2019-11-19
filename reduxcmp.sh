#!/bin/bash
mkdir -p ./src/components

cd ./src/components
mkdir -p $1
cd $1

echo "import React, { Component } from 'react';
import { connect } from 'react-redux';
import './$1.scss';

class $1 extends Component {
  // constructor(props) {
  //   super(props);
  // }

  static defaultProps = {
    className: '',
  };

  getClassList = () => {
    const classes = ['$1'];
    const className = this.props.className.trim();
    if (className !== '') {
      classes.push(className);
    }
    return classes;
  };

  render() {
    const classList = this.getClassList().join(' ');
    return (
      <>
        <div className={classList}>
          $1
        </div>
      </>
    );
  }
}

const mapStateToProps = (state) => {
  return {...state.$1};
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)($1);" >  "./$1.jsx"


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
