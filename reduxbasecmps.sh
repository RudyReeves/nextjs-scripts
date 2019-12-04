#!/bin/bash
~/Code/web/scripts/reduxcmp.sh Header
~/Code/web/scripts/reduxcmp.sh Main
~/Code/web/scripts/reduxcmp.sh Footer
~/Code/web/scripts/reduxcmp.sh PrimaryNav
~/Code/web/scripts/reduxcmp.sh HtmlList
~/Code/web/scripts/reduxcmp.sh AnchorLink

echo "import React from 'react';
import { connect } from 'react-redux';
import { getClassList } from '../../util';
import './App.scss';
import Header from '../Header/Header';
import Main from '../Main/Main';
import Footer from '../Footer/Footer';

const App = ({ className }) => {
  const classList = getClassList('App', className).join(' ');
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

export default App;" > src/components/App/App.jsx

echo "@import '../../styles/globals.scss';

.App {
    height: 100%;
    display: flex;
    flex-direction: column;
}" > src/components/App/App.scss

echo "import React from 'react';
import { connect } from 'react-redux';
import { getClassList } from '../../util';
import './Header.scss';
import PrimaryNav from '../PrimaryNav/PrimaryNav';

const Header = ({ className, links = [] }) => {
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

export default Header;" > src/components/Header/Header.jsx

echo "import React from 'react';
import { connect } from 'react-redux';
import { getClassList } from '../../util';
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

export default Main;" > src/components/Main/Main.jsx

echo "@import '../../styles/globals.scss';

.Main {
    flex-grow: 1;
}" > src/components/Main/Main.scss

echo "import React from 'react';
import { connect } from 'react-redux';
import { getClassList } from '../../util';
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

export default Footer;" > src/components/Footer/Footer.jsx

echo "import React from 'react';
import { connect } from 'react-redux';
import { getClassList } from '../../util';
import './PrimaryNav.scss';
import HtmlList from '../HtmlList/HtmlList';
import AnchorLink from '../AnchorLink/AnchorLink';

const PrimaryNav = ({ className, links = [] }) => {
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
      <AnchorLink
        className={classList}
        href={link.href}
        label={link.label}
      />
    );
  });
};

export default PrimaryNav;" > src/components/PrimaryNav/PrimaryNav.jsx

echo "import React from 'react';
import { connect } from 'react-redux';
import { getClassList } from '../../util';
import './AnchorLink.scss';

const AnchorLink = ({
  className,
  href,
  label
}) => {
  const classes = getClassList('AnchorLink', className).join(' ');
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

export default AnchorLink;" > src/components/AnchorLink/AnchorLink.jsx

echo "import React from 'react';
import { connect } from 'react-redux';
import { getClassList } from '../../util';
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

export default HtmlList;" > src/components/HtmlList/HtmlList.jsx
