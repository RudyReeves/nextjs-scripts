#!/bin/bash

~/Code/web/scripts/reduxcmp.sh App
~/Code/web/scripts/reduxcmp.sh Home

~/Code/web/scripts/reduxcmp.sh Header
~/Code/web/scripts/reduxcmp.sh Main
~/Code/web/scripts/reduxcmp.sh Footer
~/Code/web/scripts/reduxcmp.sh PrimaryNav

~/Code/web/scripts/reduxcmp.sh HtmlList
~/Code/web/scripts/reduxcmp.sh HtmlLink

mkdir src/components/pages
mkdir src/components/misc
mkdir src/components/sections

mv src/components/Home src/components/pages/Home

mv src/components/Header src/components/sections/Header
mv src/components/Main src/components/sections/Main
mv src/components/Footer src/components/sections/Footer
mv src/components/PrimaryNav src/components/sections/PrimaryNav

mv src/components/HtmlList src/components/misc/HtmlList
mv src/components/HtmlLink src/components/misc/HtmlLink

cd src/components

echo "import React from 'react';
import { getClassList } from 'util.js';
import './App.scss';
import Home from 'components/pages/Home/Home';
import {
  BrowserRouter as Router,
  Switch,
  Route,
//  Link
} from 'react-router-dom';

const App = ({ className }) => {
  const classList = getClassList('App', className).join(' ');
  return (
    <Router>
      <Switch>
        <Route path=\"/\">
          <Home
            className=\"Page\"
          /> 
        </Route>
      </Switch>
    </Router>
  );
};

export default App;" > App/App.jsx

echo "import React from 'react';
import { getClassList } from 'util.js';
import './Home.scss';
import Header from 'components/sections/Header/Header';
import Main from 'components/sections/Main/Main';
import Footer from 'components/sections/Footer/Footer';

const Home = ({ className }) => {
  const classList = getClassList('Home', className).join(' ');
  return (
    <>
      <div className={classList}>
        <Header />
        <Main />
        <Footer />
      </div>
    </>
  );
};

export default Home;" > pages/Home/Home.jsx

echo "import React from 'react';
import { getClassList } from 'util.js';
import './Header.scss';
import PrimaryNav from '../PrimaryNav/PrimaryNav';

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

export default Header;" > sections/Header/Header.jsx

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

export default Main;" > sections/Main/Main.jsx

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

export default Footer;" > sections/Footer/Footer.jsx

echo "import React from 'react';
import { getClassList } from 'util.js';
import './PrimaryNav.scss';
import HtmlList from 'components/misc/HtmlList/HtmlList';
import HtmlLink from 'components/misc/HtmlLink/HtmlLink';

const PrimaryNav = ({
  className,
  links = []
}) => {
  const classes = getClassList('PrimaryNav', className);
  return (
    <>
      <nav className={classes.join(' ')}>
        <HtmlList
          className=\"PrimaryNav__list\"
          items={createLinks(classes, links)}
        />
      </nav>
    </>
  );
};

const createLinks = (classes, links) => {
  const classList = classes
    .map((c) => {
      return \`\${c}__link\`;
    })
    .join(' ');
  return links.map((link, i) => {
    return (
      <HtmlLink
        className={classList}
        href={link.href}
        label={link.label}
      />
    );
  });
};

export default PrimaryNav;" > sections/PrimaryNav/PrimaryNav.jsx

echo "@import 'styles/globals.scss';

.PrimaryNav {}

.PrimaryNav__list {
    margin: 0;
}" > sections/PrimaryNav/PrimaryNav.scss

echo "import React from 'react';
import { getClassList } from 'util.js';
import './HtmlLink.scss';

const HtmlLink = ({
  className,
  href,
  label
}) => {
  const classes = getClassList('HtmlLink', className).join(' ');
  return (
    <>
      <a
        className={classes}
        href={href}
      >
        {label}
      </a>
    </>
  );
};

export default HtmlLink;" > misc/HtmlLink/HtmlLink.jsx

echo "import React from 'react';
import { getClassList } from 'util.js';
import './HtmlList.scss';

const HtmlList = ({
  className,
  isOrdered,
  items = []
}) => {
  return (
    <>
      {getHtmlList(className, isOrdered, items)}
    </>
  );
};

const getHtmlList = (className, isOrdered, items) => {
  const classes = getClassList('HtmlList', className);
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
      return \`\${c}__item\`;
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

export default HtmlList;" > misc/HtmlList/HtmlList.jsx
