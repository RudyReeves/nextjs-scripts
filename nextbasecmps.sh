#!/bin/bash

# Create component directories:
mkdir -p components

# Make base components:
nextcmp.sh Header sections
nextcmp.sh Main sections
nextcmp.sh Footer sections
nextcmp.sh List misc
nextcmp.sh PrimaryNav misc

cd components

# Overwrite base component implementations:
echo "import React from 'react';
import './Header.module.scss';
import PrimaryNav from 'components/misc/PrimaryNav';

type HeaderProps = {
  className?: string
};

const Header = ({
  className = 'Header'
} : HeaderProps) => {
  return (
    <>
      <header className={className}>
        <PrimaryNav />
      </header>
    </>
  );
};

export default Header;" > sections/Header/Header.tsx

echo "import React from 'react';
import './Main.module.scss';

type MainProps = {
  className?: string,
  children: any
};

const Main = ({
    className = 'Main',
    children
  } : MainProps) => {
  return (
    <>
      <main className={className}>
        {children}
      </main>
    </>
  );
};

export default Main;" > sections/Main/Main.tsx

echo "@import 'styles/globals.scss';

.Main {
  flex: 1;
  padding: \$pad \$pad-dbl;

  &__title {
    font-weight: \$fw;
  }
}" > sections/Main/Main.module.scss

echo "import React, { useState } from 'react';
import List from 'components/misc/List';
import './PrimaryNav.module.scss';

type LinkObject = {
  path: string,
  label: string
};

type PrimaryNavProps = {
  className?: string,
  links?: LinkObject[]
};

const defaultLinks: LinkObject[] = [
  {
    path: '/',
    label: 'Home'
  },
  {
    path: '/about',
    label: 'About'
  },
  {
    path: '/contact',
    label: 'Contact Us'
  }
];

const PrimaryNav = ({
    className = 'PrimaryNav',
    links = defaultLinks
  } : PrimaryNavProps) => {
  if (!links || !links.length) { return null; }
  const [isOpen, setIsOpen] = useState(false);
  let classList = [\`\${className}\`];
  if (isOpen) {
    classList.push(\`\${className}--open\`);
  }
  return (
    <nav className={classList.join(' ')}>
      <div
        className={\`\${className}__overlay\`}
          onClick={() => {
            setIsOpen(false);
          }}
      >
      </div>
      <div
        className={\`\${className}__toggle-btn\`}
        onClick={() => {
          setIsOpen(!isOpen);
        }}
      >
        <i className=\"fas fa-bars\" />
      </div>
      <List
        className={\`\${className}__list\`}
        items={createLinks(links, className)}
      />
    </nav>
  );
};

const createLinks = (links: LinkObject[], className: string = 'PrimaryNav') => {
  return links.map((link, i) => {
    return (
      <a
        className={\`\${className}__link\`}
        href={link.path}
        rel=\"noopener\"
      >
        {link.label}
      </a>
    );
  });
};

export default PrimaryNav;" > misc/PrimaryNav/PrimaryNav.tsx

echo "@import 'styles/globals.scss';

\$bg-clr: \$clr-gray-l;
\$bg-clr-l: \$clr-gray-xl;

.PrimaryNav {
    z-index: 100;

    &--open {
        .PrimaryNav__list {
            left: 0;
            box-shadow: 0 0 200px \$clr-black;
        }

        .PrimaryNav__overlay {
            position: absolute;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
            z-index: 200;
            background-color: \$clr-gray-xd;
            opacity: .5;
            transition: all 400ms ease-in-out;
        }

        .PrimaryNav__overlay:hover {
            cursor: pointer;
        }
    }

    &__toggle-btn {
        z-index: 400;
        height: \$pad;
        position: absolute;
        padding: \$pad-half;
        font-size: 1.5em;
        color: \$clr-gray-d;
    }

    &__toggle-btn:hover {
        cursor: pointer;
    }

    &__list {
        background-color: \$bg-clr;
        z-index: 300;
        margin: 0;
        padding: 0;
        padding-top: \$pad-dbl;
        list-style-type: none;
        max-width: 33vw;
        min-width: 240px;
        position: absolute;
        top: 0;
        left: -100%;
        bottom: 0;
        transition: left 300ms ease-in-out;
    }
    
    &__link {
        text-decoration: none;
        color: \$clr-gray-xd;
        display: inline-block;
        padding: \$pad-half;
        width: 100%;
    }
 
    &__link:hover {
        background-color: \$bg-clr-l;
    }
}

@media (min-width: \$tablet) {
    .PrimaryNav {
        &__toggle-btn,
        &__overlay {
            display: none;
        }

        &__list {
            padding: 0;
            box-shadow: none;
            position: relative;
            left: 0;
            width: 100%;
            max-width: 100%;
            min-width: 100%;
            display: flex;
        }

        &__link {
            padding: \$pad \$pad-half;
        }
    }
}" > misc/PrimaryNav/PrimaryNav.module.scss

echo "import React from 'react';
import './List.module.scss';

type ListProps = {
  className?: string,
  isOrdered?: boolean,
  items?: object[]
};

const List = ({className, isOrdered = false, items = []} : ListProps) => {
  const content = createItems(items, className);
  return (isOrdered
    ? <ol className={className}>{content}</ol>
    : <ul className={className}>{content}</ul>
  );
};

const createItems = (items, className = 'List') => {
  return items.map((item, i) => {
    return (
      <li
        className={\`\${className}-item\`}
        key={i}
      >
        {item}
      </li>
    );
  });
};

export default List;" > misc/List/List.tsx

echo "@import 'styles/globals.scss';

.Footer {
  padding: \$pad \$pad-dbl;
}" > sections/Footer/Footer.module.scss
