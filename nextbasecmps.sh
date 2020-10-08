#!/bin/bash

# Create components directory:
mkdir -p components

# Make base components:
nextcmp.sh Header sections
nextcmp.sh Main sections
nextcmp.sh Footer sections
nextcmp.sh List misc
nextcmp.sh PrimaryNav misc
nextcmp.sh TextBox inputs
nextcmp.sh Layout layouts

cd components

# Overwrite base component implementations:
echo "import React from 'react';
import './Layout.module.scss';
import Head from 'next/head';
import Header from 'components/sections/Header';
import Main from 'components/sections/Main';
import Footer from 'components/sections/Footer';

type LayoutProps = {
  classNames?: string[],
  children?: any,
  title?: string
};

const Layout = ({
  classNames = [],
  children,
  title = ''
} : LayoutProps) => {
  return (
    <>
      <Head>
        <title>{title}</title>
      </Head>

      <Header />

      <Main>
        {children}
      </Main>

      <Footer />
    </>
  );
};

export default Layout;" > layouts/Layout/Layout.tsx

echo "import React from 'react';
import './Header.module.scss';
import PrimaryNav from 'components/misc/PrimaryNav';

type HeaderProps = {
  classNames?: string[]
};

const Header = ({
  classNames = []
} : HeaderProps) => {
  const classList = ['Heaeder', ...classNames].join(' ');
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
import './Main.module.scss';

type MainProps = {
  classNames?: string[],
  children: any
};

const Main = ({
    classNames = [],
    children
  } : MainProps) => {
  const classList = ['Main', ...classNames].join(' ');
  return (
    <>
      <main className={classList}>
        {children}
      </main>
    </>
  );
};

export default Main;" > sections/Main/Main.tsx

echo "@import 'styles/globals.scss';

.Main {
  margin-top: \$pad;
  flex: 1;
  padding: \$pad 0;
  display: flex;
  flex-direction: column;

  &__title {
    font-weight: \$fw;
  }

  &__title,
  &__paragraph {
    width: 100%;
    max-width: \$tablet;
  }
}

@media (min-width: \$tablet) {
  .Main {
    margin: 0;
    padding: 0;
  }
}" > sections/Main/Main.module.scss

echo "import React, { useState } from 'react';
import Link from 'next/link';
import List from 'components/misc/List';
import './PrimaryNav.module.scss';

type LinkObject = {
  path: string,
  label: string
};

type PrimaryNavProps = {
  classNames?: string[],
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
    classNames = [],
    links = defaultLinks
  } : PrimaryNavProps) => {
  if (!links || !links.length) { return null; }
  const [isOpen, setIsOpen] = useState(false);
  let classList = ['PrimaryNav', ...classNames];
  if (isOpen) {
    classList = [
      ...classList,
      ...classList.map((c) => \`\${c}--open\`)
    ];
  }
  return (
    <nav className={classList.join(' ')}>
      <div
        className={classList.map((c) => \`\${c}__overlay\`).join(' ')}
        onClick={() => {
          setIsOpen(false);
        }}
      >
      </div>
      <div
        className={classList.map((c) => \`\${c}__toggle-btn\`).join(' ')}
        onClick={() => {
          setIsOpen(!isOpen);
        }}
      >
        <i className=\"fas fa-bars\" />
      </div>
      <List
        classNames={classList.map((c) => \`\${c}__list\`)}
        items={createLinks(links, classList)}
      />
    </nav>
  );
};

const createLinks = (links: LinkObject[], classList) => {
  return links.map((link, i) => {
    return (
      <Link
        href={link.path}
      >
        <a
          className={classList.map((c) => \`\${c}__link\`).join(' ')}
          rel=\"noopener\"
        >
          {link.label}
        </a>
      </Link>
    );
  });
};

export default PrimaryNav;" > misc/PrimaryNav/PrimaryNav.tsx

echo "@import 'styles/globals.scss';

\$bg-clr: \$clr-gray-xl;
\$bg-clr-hilight: \$clr-gray;
\$font-clr: \$clr-gray-xd;
\$overlay-clr: \$clr-black;

.PrimaryNav {
    z-index: 100;

    &--open {
        .PrimaryNav__list {
            left: 0;
            box-shadow: 0 0 200px \$overlay-clr;
        }

        .PrimaryNav__overlay {
            position: absolute;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
            z-index: 200;
            background-color: \$overlay-clr;
            opacity: .5;
            transition: all 400ms ease-in-out;
            &:hover {
              cursor: pointer;
            }
        }
    }

    &__toggle-btn {
        z-index: 400;
        border-radius: 50%;
        position: absolute;
        top: \$pad-half;
        left: \$pad-half;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: \$pad;
        font-size: 1.35em;
        color: \$font-clr;
        width: 1em;
        height: 1em;

        &:hover {
            cursor: pointer;
            background-color: \$bg-clr-hilight;
      }
    }

    &__list {
        background-color: \$bg-clr;
        z-index: 300;
        margin: 0;
        padding: 0;
        padding-top: \$pad-xl;
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
        color: \$font-clr;
        display: inline-block;
        padding: \$pad-half;
        padding-left: \$pad;
        width: 100%;
        &:hover {
            background-color: \$bg-clr-hilight;
        }
    }
}

@media (min-width: \$tablet) {
    .PrimaryNav {
        &__toggle-btn,
        &__overlay {
            display: none;
        }

        &--open &__list,
        &__list {
            padding: 0;
            box-shadow: none;
            position: relative;
            left: 0;
            width: 100%;
            max-width: 100%;
            min-width: 100%;
            display: flex;
            
            &__item:first-child,
            &__item:last-child {
              margin: 0;
            }
        }

        &__link {
            padding: \$pad-half;
        }

        &__list__item {
          margin: 0 \$pad-half;
        }
    }
}" > misc/PrimaryNav/PrimaryNav.module.scss

echo "import React from 'react';
import './List.module.scss';

type ListProps = {
  classNames?: string[],
  isOrdered?: boolean,
  items?: Array<any>,
  handleItemClicked?: Function,
  [attrs: string]: any
};

const List = ({
  classNames = [],
  isOrdered = false,
  items = [],
  handleItemClicked = (item) => {},
  ...attrs
} : ListProps) => {
  const classList = ['List', ...classNames];
  const content = createItems(items, classList, handleItemClicked, attrs);
  return (isOrdered
    ? <ol className={classList.join(' ')}>{content}</ol>
    : <ul className={classList.join(' ')}>{content}</ul>
  );
};

const createItems = (items, classList, handleItemClicked, attrs) => {
  return items.map((item, i) => {
    return (
      <li
        className={classList.map((c) => \`\${c}__item\`).join(' ')}
        key={i}
        onClick={(e) => {
          handleItemClicked(item);
        }}
        {...attrs}
      >
        {item}
      </li>
    );
  });
};

export default List;" > misc/List/List.tsx

echo "import React, { useReducer, useRef } from 'react';
import './TextBox.module.scss';
import List from 'components/misc/List';

type TextBoxProps = {
  classNames?: string[],
  placeholder?: string,
  type?: string,
  required?: boolean,
  name?: string,
  id?: string,
  label?: string,
  errorMessage?: string,
  validate?: (value: string) => boolean,
  autocomplete?: string[],
  onChange?: (v: string) => any,
  onBlur?: (e: any) => any,
  onFocus?: (e: any) => any,
  [attrs: string]: any,
};

const TextBoxReducer = (state, action) => {
  switch (action.type) {
    case 'TextBox:change':
      return {
        ...state,
        value: action.payload
      };
    case 'TextBox:focus':
      return {
        ...state,
        hasFocus: true,
        autocompleteOptions: action.payload
      };
    case 'TextBox:blur':
      return {
        ...state,
        isValid: action.payload,
        hasFocus: false
      };
    case 'TextBox:autocomplete-change':
      return {
        ...state,
        autocompleteOptions: action.payload
      };
    case 'TextBox:autocomplete-clicked':
      return {
        ...state,
        value: action.payload,
        autocompleteOptions: [],
        isValid: true
      };
    default:
      return state;
  }
};

const TextBox = ({
  classNames = [],
  placeholder = null,
  type = 'text',
  required = false,
  name = null,
  id = null,
  label = '',
  errorMessage = '',
  validate = (value) => true,
  autocomplete = null,
  onChange = (v) => {},
  onBlur = (e) => {},
  onFocus = (e) => {},
  ...attrs
} : TextBoxProps) => {
  const classList = ['TextBox', ...classNames];

  const [{
    isValid,
    autocompleteOptions,
    hasFocus,
    value
  }, dispatch] = useReducer(TextBoxReducer, {
    isValid: null,
    hasFocus: false,
    autocompleteOptions: [],
    value: ''
  });

  const isAutocomplete = Array.isArray(autocomplete);
  const inputRef = useRef(null);

  const filterAutocomplete = (newValue) => {
    if (!isAutocomplete) { return null; }
    return autocomplete.filter((option) => {
      return option.toLowerCase().startsWith(newValue.toLowerCase());
    })
  };

  const inputClassList = [...classList.map((c) => \`\${c}__input\`)];
  const labelClassList = [...classList.map((c) => \`\${c}__label\`)];

  if (isValid === null) {
    inputClassList.push(...classList.map((c) => \`\${c}__input--empty\`));
  } else if (!isValid) {
    inputClassList.push(...classList.map((c) => \`\${c}__input--error\`));
    labelClassList.push(...classList.map((c) => \`\${c}__label--error\`));
  }

  return (
    <div
      className={classList.join(' ')}
    >
      <div
        className={classList.map((c) => \`\${c}__container\`).join(' ')}
      >
        {label &&
          <label
            className={labelClassList.join(' ')}
            htmlFor={id}
          >
            {label}
          </label>
        }
        <div
          className={classList.map((c) => \`\${c}__input-container\`).join(' ')}
        >
          <input
            className={inputClassList.join(' ')}
            type={type}
            placeholder={placeholder}
            required={required}
            name={name}
            id={id}
            ref={inputRef}
            value={value}
            onBlur={(e) => {
              onBlur(e);
              dispatch({
                type: 'TextBox:blur',
                payload: validate(value) &&
                (
                  (!required && value.length === 0) ||
                  !isAutocomplete ||
                  autocomplete.includes(value)
                )
              });
            }}
            onFocus={(e) => {
              onFocus(e);
              dispatch({
                type: 'TextBox:focus',
                payload: filterAutocomplete(e.target.value)
              });
            }}
            onChange={(e) => {
              onChange(e.target.value);
              dispatch({
                type: 'TextBox:change',
                payload: e.target.value
              });
              if (!isAutocomplete) { return; }
              dispatch({
                type: 'TextBox:autocomplete-change',
                payload: filterAutocomplete(e.target.value)
              });
            }}
            {...attrs}
          />
          {isAutocomplete && (autocompleteOptions.length > 0) && hasFocus &&
            <List
              classNames={classList.map((c) => \`\${c}__autocomplete-list\`)}
              items={autocompleteOptions}
              handleItemClicked={(item) => {
                onChange(item);
                dispatch({
                  type: 'TextBox:autocomplete-clicked',
                  payload: item
                });
              }}
              onMouseDown={(e) => {
                e.preventDefault();
              }}
            />
          }
        </div>
      </div>
      {errorMessage && (isValid !== null) && !isValid &&
        <div className={classList.map((c) => \`\${c}__errorMessage\`).join(' ')}>
          {errorMessage}
        </div>
      }
    </div>
  );
};

export default TextBox;
" > inputs/TextBox/TextBox.tsx

echo "@import 'styles/globals.scss';

\$clr-hilight: \$clr-blue-d;
\$clr-error: \$clr-red-d;
\$clr-empty: \$clr-gray;
\$clr-valid: \$clr-blue-d;
\$font-size: 1.1em;

.TextBox {
    padding: \$pad-s 0;
    display: inline-block;

    &__container {
      width: max-content;
      display: flex;
      align-items: center;
    }

    &__label {
        display: inline-block;
        font-weight: \$fw-sb;
        color: \$clr-hilight;
        font-size: \$font-size;
        padding-right: \$pad-xs;
        &:hover {
          cursor: pointer;
        }
        &--error {
          color: \$clr-error;
        }
    }
    
    &__input {
        outline: none;
        font-size: \$font-size;
        max-width: 30em;
        padding: \$pad-s \$pad-ms;
        border: 2px solid \$clr-valid;
        border-radius: \$border-radius;
        z-index: 1;

        &-container {
          display: flex;
          justify-content: center;
          position: relative;
        }
        &:focus {
            border: 2px solid \$clr-hilight;
        }
        &--error {
            border-color: \$clr-error;
        }
        &--error:focus {
            border: 2px solid \$clr-error;
        }
        &--empty {
            border: 2px solid \$clr-empty;
        }
    }

    &__errorMessage {
        color: \$clr-red;
        font-weight: \$fw-sb;
    }

    &__autocomplete-list {
        list-style-type: none;
        margin: 0;
        padding: 0;
        position: absolute;
        background-color: \$clr-white;
        border: 2px solid \$clr-gray;
        border-radius: \$border-radius-s;
        max-height: 10em;
        overflow-y: scroll;
        width: 97%;
        padding-top: \$pad-l;

        &__item {
            padding: \$pad-s;
            &:hover {
              cursor: pointer;
              background-color: \$clr-gray;
            }
        }
    }
}" > inputs/TextBox/TextBox.module.scss
