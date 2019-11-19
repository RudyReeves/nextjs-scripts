#!/bin/bash
reduxcmp.sh Header
reduxcmp.sh Main
reduxcmp.sh Footer
reduxcmp.sh PrimaryNav
reduxcmp.sh List
reduxcmp.sh Link

echo "import React, { Component } from 'react';
import { connect } from 'react-redux';
import './App.scss';
import Header from '../Header/Header';
import Main from '../Main/Main';
import Footer from '../Footer/Footer';

class App extends Component {
  // constructor(props) {
  //   super(props);
  // }

  static defaultProps = {
    className: '',
  };

  getClassList = () => {
    const classes = ['App'];
    const className = this.props.className.trim();
    if (className !== '') {
      classes.push(className);
    }
    return classes;
  };
  
  render() {
    const classes = this.getClassList().join(' ');
    return (
      <>
        <div className={classes}>
          <Header />
          <Main />
          <Footer />
        </div>
      </>
    );
  }
}

const mapStateToProps = (state) => {
  return {...state.App};
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(App);" > src/components/App/App.jsx

echo "@import '../../styles/globals.scss';

.App {
    height: 100%;
    display: flex;
    flex-direction: column;
}" > src/components/App/App.scss

echo "import React, { Component } from 'react';
import { connect } from 'react-redux';
import './Header.scss';
import PrimaryNav from '../PrimaryNav/PrimaryNav';

class Header extends Component {
  // constructor(props) {
  //   super(props);
  // }

  static defaultProps = {
    className: '',
    links: [],
  };

  getClassList = () => {
    const classes = ['Header'];
    const className = this.props.className.trim();
    if (className !== '') {
      classes.push(className);
    }
    return classes;
  };

  render() {
    const classes = this.getClassList().join(' ');
    return (
      <>
        <header className={classes}>
          <PrimaryNav />
        </header>
      </>
    );
  }
}

const mapStateToProps = (state) => {
  return {...state.Header};
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(Header);" > src/components/Header/Header.jsx

echo "import React, { Component } from 'react';
import { connect } from 'react-redux';
import './Main.scss';

class Main extends Component {
  // constructor(props) {
  //   super(props);
  // }

  static defaultProps = {
    className: '',
  };

  getClassList = () => {
    const classes = ['Main'];
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
        <main className={classList}>
          Main
        </main>
      </>
    );
  }
}

const mapStateToProps = (state) => {
  return {...state.Main};
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(Main);" > src/components/Main/Main.jsx

echo "@import '../../styles/globals.scss';

.Main {
    flex-grow: 1;
}" > src/components/Main/Main.scss

echo "import React, { Component } from 'react';
import { connect } from 'react-redux';
import './Footer.scss';

class Footer extends Component {
  // constructor(props) {
  //   super(props);
  // }

  static defaultProps = {
    className: '',
  };

  getClassList = () => {
    const classes = ['Footer'];
    const className = this.props.className.trim();
    if (className !== '') {
      classes.push(className);
    }
    return classes;
  };

  render() {
    const classes = this.getClassList().join(' ');
    return (
      <>
        <footer className={classes}>
          Footer
        </footer>
      </>
    );
  }
}

const mapStateToProps = (state) => {
  return {...state.Footer};
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(Footer);" > src/components/Footer/Footer.jsx

echo "import React, { Component } from 'react';
import { connect } from 'react-redux';
import './PrimaryNav.scss';
import List from '../List/List';
import Link from '../Link/Link';

class PrimaryNav extends Component {
  // constructor(props) {
  //   super(props);
  // }

  static defaultProps = {
    className: '',
    links: [],
  };

  getClassList = () => {
    const classes = ['PrimaryNav'];
    const className = this.props.className.trim();
    if (className !== '') {
      classes.push(className);
    }
    return classes;
  };

  render() {
    const classes = this.getClassList();
    return (
      <>
        <nav className={classes.join(' ')}>
          <List
            className=\"PrimaryNav__list\"
            items={this.getLinks(classes)}
          />
        </nav>
      </>
    );
  }

  getLinks = (classes) => {
    const classList = classes
      .map((c) => {
        return \`\${c}__link\`;
      })
      .join(' ');
    return this.props.links.map((link, i) => {
      return (
        <Link
          className={classList}
          href={link.href}
          label={link.label}
        />
      );
    });
  };
}

const mapStateToProps = (state) => {
  return {...state.PrimaryNav};
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(PrimaryNav);" > src/components/PrimaryNav/PrimaryNav.jsx

echo "import React, { Component } from 'react';
import { connect } from 'react-redux';
import './Link.scss';

class Link extends Component {
  // constructor(props) {
  //   super(props);
  // }

  static defaultProps = {
    className: '',
    href: '#',
    label: '',
  };

  getClassList = () => {
    const classes = ['Link'];
    const className = this.props.className.trim();
    if (className !== '') {
      classes.push(className);
    }
    return classes;
  };

  render() {
    const classes = this.getClassList().join(' ');
    return (
      <>
        <a
          className={classes}
          href={this.props.href}
        >
          {this.props.label}
        </a>
      </>
    );
  }
}

const mapStateToProps = (state) => {
  return {...state.Link};
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(Link);" > src/components/Link/Link.jsx

echo "import React, { Component } from 'react';
import { connect } from 'react-redux';
import './List.scss';

class List extends Component {
  // constructor(props) {
  //   super(props);
  // }

  static defaultProps = {
    className: '',
    isOrdered: false,
    items: [],
  };

  getClassList = () => {
    const classes = ['List'];
    const className = this.props.className.trim();
    if (className !== '') {
      classes.push(className);
    }
    return classes;
  };

  render() {
    return (
      <>
        {this.getList()}
      </>
    );
  }

  getList = () => {
    const classes = this.getClassList();
    const items = this.getItems(classes);
    const classList = classes.join(' ');
    return (this.props.isOrderded ?
      <ol className={classList}>{items}</ol> :
      <ul className={classList}>{items}</ul>
    );
  };

  getItems = (classes) => {
    const classList = classes
      .map((c) => {
        return \`\${c}__item\`;
      })
      .join(' ');
    return this.props.items.map((item, i) => {
      return (
        <li
          className={classList}
          key={i}
        >
          {item}
        </li>
      );
    });
  };
}

const mapStateToProps = (state) => {
  return {...state.List};
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(List);" > src/components/List/List.jsx
