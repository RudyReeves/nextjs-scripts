#!/bin/bash

# Create component directories:
mkdir src/components

# Make base components:
~/Code/web/scripts/reduxcmp.sh App

~/Code/web/scripts/reduxcmp.sh Home pages

~/Code/web/scripts/reduxcmp.sh Header sections
~/Code/web/scripts/reduxcmp.sh Main sections
~/Code/web/scripts/reduxcmp.sh Footer sections
~/Code/web/scripts/reduxcmp.sh PrimaryNav sections

~/Code/web/scripts/reduxcmp.sh List misc

# Overwrite base component implementations:
cd src/components

echo "import React from 'react';
import Home from 'components/pages/Home';
import Header from 'components/sections/Header';
import Footer from 'components/sections/Footer';
import {
  BrowserRouter as Router,
  Switch,
  Route
} from 'react-router-dom';

const App = () => (
  <Router>
    <Header />
    <Switch>
      <Route path=\"/\" exact component={Home} />
    </Switch>
    <Footer />
  </Router>
);

export default App;" > App/index.jsx

rm App/App.scss

echo "import React from 'react';
import { getClassList } from 'util.js';
import './Home.scss';
import Main from 'components/sections/Main';

const Home = ({ className }) => {
  const classList = getClassList('Home', className).join(' ');
  return (
    <>
      <div className={classList}>
        <Main />
      </div>
    </>
  );
};

export default Home;" > pages/Home/index.jsx

echo "import React from 'react';
import { getClassList } from 'util.js';
import './Header.scss';
import PrimaryNav from 'components/sections/PrimaryNav';

const Header = ({
  className,
  links = []
}) => {
  const classList = getClassList('Header', className).join(' ');
  return (
    <>
      <header className={classList}>
        <PrimaryNav
          links={links}
        />
      </header>
    </>
  );
};

export default Header;" > sections/Header/index.jsx

echo "import React from 'react';
import { getClassList } from 'util.js';
import './Main.scss';

const Main = ({ className }) => {
  const classList = getClassList('Main', className).join(' ');
  return (
    <>
      <main className={classList}>
        Main
      </main>
    </>
  );
};

export default Main;" > sections/Main/index.jsx

echo "@import 'styles/globals.scss';

.Main {
    flex-grow: 1;
}" > sections/Main/Main.scss

echo "import React from 'react';
import { getClassList } from 'util.js';
import './Footer.scss';

const Footer = ({ className }) => {
  const classes = getClassList('Footer', className).join(' ');
  return (
    <>
      <footer className={classes}>
        Footer
      </footer>
    </>
  );
};

export default Footer;" > sections/Footer/index.jsx

echo "import React from 'react';
import {
  Link,
  // Redirect
} from 'react-router-dom';
import { getClassList } from 'util.js';
import './PrimaryNav.scss';
import List from 'components/misc/List';

const PrimaryNav = ({
  className,
  links = []
}) => {
  const classes = getClassList('PrimaryNav', className);
  return (
    <>
      <nav className={classes.join(' ')}>
        <List
          className=\"PrimaryNav__list\"
          items={createLinks(links, classes)}
        />
      </nav>
    </>
  );
};

const createLinks = (links, classes = []) => {
  const classList = classes
    .map((c) => {
      return \`\${c}__link\`;
    })
    .join(' ');
  return links.map((link, i) => {
    return (
      <Link
        className={classList}
        to={link.path}
      >
        {link.label}
      </Link>
    );
  });
};

export default PrimaryNav;" > sections/PrimaryNav/index.jsx

echo "@import 'styles/globals.scss';

.PrimaryNav {}

.PrimaryNav__list {
    margin: 0;
}" > sections/PrimaryNav/PrimaryNav.scss

echo "import React from 'react';
import { getClassList } from 'util.js';
import './List.scss';

const List = (props) => {
  return (
    <>
      {getList(props)}
    </>
  );
};

const getList = ({className, isOrdered, items = []}) => {
  const classes = getClassList('List', className);
  const content = createItems(classes, items);
  const classList = classes.join(' ');
  return (isOrdered ?
    <ol className={classList}>{content}</ol> :
    <ul className={classList}>{content}</ul>
  );
};

const createItems = (classes, items) => {
  const classList = classes
    .map((c) => {
      return \`\${c}-item\`;
    })
    .join(' ');
  return items.map((item, i) => {
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

export default List;" > misc/List/index.jsx
