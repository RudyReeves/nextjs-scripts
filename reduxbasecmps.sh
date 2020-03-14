#!/bin/bash

# Create component directories:
mkdir src/components

# Make base components:
reduxcmp.sh App

reduxcmp.sh Home pages

reduxcmp.sh Header sections
reduxcmp.sh Main sections
reduxcmp.sh Footer sections
reduxcmp.sh PrimaryNav sections

reduxcmp.sh List misc

# Overwrite base component implementations:
cd src/components

echo "import React from 'react';
import Home from 'components/pages/Home';
import Header from 'components/sections/Header';
import Main from 'components/sections/Main';
import Footer from 'components/sections/Footer';
import {
  BrowserRouter as Router,
  Switch,
  Route
} from 'react-router-dom';

const App = () => (
  <Router>
    <Header />
    <Main
      className=\"Page\"
    >
      <Switch>
        <Route path=\"/\" exact component={Home} />
      </Switch>
    </Main>
    <Footer />
  </Router>
);

export default App;" > App/App.tsx

rm App/App.scss

echo "import React from 'react';
import { getClassList } from 'utils';
import './Home.scss';

type HomeProps = {
  className?: string
}

const Home = ({
    className = ''
  } : HomeProps) => {
  const classList = getClassList('Home', className).join(' ');
  return (
    <>
      <div className={classList}>
        Home
      </div>
    </>
  );
};

export default Home;" > pages/Home/Home.tsx

echo "import React from 'react';
import { getClassList } from 'utils';
import './Header.scss';
import PrimaryNav from 'components/sections/PrimaryNav';

type HeaderProps = {
  className?: string
};

const Header = ({
    className = ''
  } : HeaderProps) => {
  const classList = getClassList('Header', className).join(' ');
  return (
    <>
      <header className={classList}>
        <PrimaryNav />
      </header>
    </>
  );
};

export default Header;" > sections/Header/Header.tsx

echo "import React from 'react';
import { getClassList } from 'utils';
import './Main.scss';

type MainProps = {
  className?: string,
  children: object
};

const Main = ({
    className = '',
    children
  } : MainProps) => {
  const classList = getClassList('Main', className).join(' ');
  return (
    <>
      <main className={classList}>
        {children}
      </main>
    </>
  );
};

export default Main;" > sections/Main/Main.tsx

echo "import React from 'react';
import { getClassList } from 'utils';
import './Footer.scss';

type FooterProps = {
  className?: string
};

const Footer = ({
    className = ''
  } : FooterProps) => {
  const classes = getClassList('Footer', className).join(' ');
  return (
    <>
      <footer className={classes}>
        Footer
      </footer>
    </>
  );
};

export default Footer;" > sections/Footer/Footer.tsx

echo "import React from 'react';
import {
  Link,
  // Redirect
} from 'react-router-dom';
import { getClassList } from 'utils';
import './PrimaryNav.scss';
import List from 'components/misc/List';

type LinkObject = {
  path: string,
  label: string
};

type PrimaryNavProps = {
  className?: string,
  links: LinkObject[]
};

const PrimaryNav = ({
    className = '',
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

const createLinks = (links: LinkObject[], classes: string[]) => {
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

export default PrimaryNav;" > sections/PrimaryNav/PrimaryNav.tsx

echo "@import 'styles/globals.scss';

.PrimaryNav {}

.PrimaryNav__list {
    margin: 0;
}" > sections/PrimaryNav/PrimaryNav.scss

echo "import React from 'react';
import { getClassList } from 'utils';
import './List.scss';

type ListProps = {
  className?: string,
  isOrdered?: boolean,
  items?: object[]
};

const List = (props : ListProps) => {
  return (
    <>
      {getList(props)}
    </>
  );
};

const getList = ({className = '', isOrdered = false, items = []} : ListProps) => {
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

export default List;" > misc/List/List.tsx
