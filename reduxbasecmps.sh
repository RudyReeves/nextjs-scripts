#!/bin/bash

# Create component directories:
mkdir src/components

# Make base components:
reduxcmp.sh App

reduxcmp.sh Home pages

reduxcmp.sh Header sections
reduxcmp.sh Main sections
reduxcmp.sh Footer sections

reduxcmp.sh List misc
reduxcmp.sh PrimaryNav misc

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
// import { useSelector, useDispatch } from 'react-redux';
import { getClassList } from 'utils';
import './Header.scss';
import PrimaryNav from 'components/misc/PrimaryNav';

interface HeaderState {
  Header: {}
};

type HeaderProps = {
  className?: string
};

const Header = ({
    className = ''
  } : HeaderProps) => {
  // const state = useSelector<HeaderState, HeaderProps>(state => state.Header);
  // const dispatch = useDispatch();
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
// import { useSelector, useDispatch } from 'react-redux';
import { getClassList } from 'utils';
import './Main.scss';

interface MainState {
  Main: {
    children: {}
  }
};

type MainProps = {
  className?: string,
  children: object
};

const Main = ({
    className = '',
    children
  } : MainProps) => {
  // const state = useSelector<MainState, MainProps>(state => state.Main);
  // const dispatch = useDispatch();
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
import {
  Link,
  // Redirect
} from 'react-router-dom';
// import { useSelector, useDispatch } from 'react-redux';
import { getClassList } from 'utils';
import List from 'components/misc/List';
import './PrimaryNav.scss';

interface PrimaryNavState {
  PrimaryNav: {
    links: []
  }
};

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
  // const state = useSelector<PrimaryNavState, PrimaryNavProps>(state => state.PrimaryNav);
  // const dispatch = useDispatch();
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

export default PrimaryNav;" > misc/PrimaryNav/PrimaryNav.tsx

echo "@import 'styles/globals.scss';

.PrimaryNav {}

.PrimaryNav__list {
    margin: 0;
}" > misc/PrimaryNav/PrimaryNav.scss

echo "import React from 'react';
// import { useSelector, useDispatch } from 'react-redux';
import { getClassList } from 'utils';
import './List.scss';

interface ListState {
  List: {}
};

type ListProps = {
  className?: string,
  isOrdered?: boolean,
  items?: object[]
};

const List = (props : ListProps) => {
  // const state = useSelector<ListState, ListProps>(state => state.List);
  // const dispatch = useDispatch();
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
