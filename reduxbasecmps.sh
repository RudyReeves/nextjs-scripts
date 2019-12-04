#!/bin/bash
~/Code/web/scripts/reduxcmp.sh Header
~/Code/web/scripts/reduxcmp.sh Main
~/Code/web/scripts/reduxcmp.sh Footer
~/Code/web/scripts/reduxcmp.sh PrimaryNav
~/Code/web/scripts/reduxcmp.sh HtmlList
~/Code/web/scripts/reduxcmp.sh Link

echo "import React, { Component } from 'react';
import { connect } from 'react-redux';
import { getClassList } from '../../util';
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
  
  render() {
    const classList = getClassList('App', this.props.className).join(' ');
    return (
      <>
        <div className={classList}>
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
import { getClassList } from '../../util';
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

  render() {
    const classList = getClassList('Header', this.props.className).join(' ');
    return (
      <>
        <header className={classList}>
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
import { getClassList } from '../../util';
import './Main.scss';

class Main extends Component {
  // constructor(props) {
  //   super(props);
  // }

  static defaultProps = {
    className: '',
  };

  render() {
    const classList = getClassList('Main', this.props.className).join(' ');
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
import { getClassList } from '../../util';
import './Footer.scss';

class Footer extends Component {
  // constructor(props) {
  //   super(props);
  // }

  static defaultProps = {
    className: '',
  };

  render() {
    const classes = getClassList('Footer', this.props.className).join(' ');
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
import { getClassList } from '../../util';
import './PrimaryNav.scss';
import HtmlList from '../HtmlList/HtmlList';
import Link from '../Link/Link';

class PrimaryNav extends Component {
  // constructor(props) {
  //   super(props);
  // }

  static defaultProps = {
    className: '',
    links: [],
  };

  render() {
    const classes = getClassList('PrimaryNav', this.props.className);
    return (
      <>
        <nav className={classes.join(' ')}>
          <HtmlList
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
import { getClassList } from '../../util';
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

  render() {
    const classes = getClassList('Link', this.props.className).join(' ');
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
import { getClassList } from '../../util';
import './HtmlList.scss';

class HtmlList extends Component {
  // constructor(props) {
  //   super(props);
  // }

  static defaultProps = {
    className: '',
    isOrdered: false,
    items: [],
  };

  render() {
    return (
      <>
        {this.getList()}
      </>
    );
  }

  getList = () => {
    const classes = getClassList('HtmlList', this.props.className);
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
  return {...state.HtmlList};
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(HtmlList);" > src/components/HtmlList/HtmlList.jsx
