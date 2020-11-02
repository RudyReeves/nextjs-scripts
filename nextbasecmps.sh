#!/bin/bash

# Create components directory:
mkdir -p components

# Make base components:
nextcmp.sh Header sections
nextcmp.sh Main sections main
nextcmp.sh Footer sections
nextcmp.sh List misc
nextcmp.sh PrimaryNav misc
nextcmp.sh TextBox inputs
nextcmp.sh Label inputs
nextcmp.sh Autocomplete inputs
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
  title?: string,
  [props: string]: any
};

const Layout = ({
  classNames = [],
  children,
  title = '',
  ...props
} : LayoutProps) => {
  return (
    <>
      <Head>
        <title>{title}</title>
        <meta name=\"description\" content=\"$1\" />
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
  classNames?: string[],
  children?: any,
  [props: string]: any
};

const Header = ({
  classNames = [],
  children,
  ...props
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
  links?: LinkObject[],
  [props: string]: any
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
    links = defaultLinks,
    ...props
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
  [props: string]: any
};

const List = ({
  classNames = [],
  isOrdered = false,
  items = [],
  handleItemClicked = (item) => {},
  ...props
} : ListProps) => {
  const classList = ['List', ...classNames];
  const content = createItems(items, classList, handleItemClicked, props);
  return (isOrdered
    ? <ol className={classList.join(' ')}>{content}</ol>
    : <ul className={classList.join(' ')}>{content}</ul>
  );
};

const createItems = (items, classList, handleItemClicked, props) => {
  return items.map((item, i) => {
    return (
      <li
        className={classList.map((c) => \`\${c}__item\`).join(' ')}
        key={i}
        onClick={(e) => {
          handleItemClicked(item);
        }}
        {...props}
      >
        {item}
      </li>
    );
  });
};

export default List;" > misc/List/List.tsx

echo "import React, { useReducer } from 'react';
import './TextBox.module.scss';
import Label from 'components/inputs/Label';
import Autocomplete from 'components/inputs/Autocomplete';

type TextBoxProps = {
  classNames?: string[],
  type?: string,
  required?: boolean,
  label?: string,
  errorMessage?: string,
  validate?: (value: string) => boolean,
  autocomplete?: string[],
  onChange?: (v: string) => any,
  onBlur?: (e: any) => any,
  onFocus?: (e: any) => any,
  [props: string]: any
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
        isValid: null,
        autocompleteOptions: action.payload
      };
    case 'TextBox:blur':
      return {
        ...state,
        isValid: action.payload,
        autocompleteOptions: []
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
  type = 'text',
  required = false,
  label = '',
  errorMessage = '',
  validate = (value) => {
    if (required && (!value || !value.length)) {
      return false;
    }
    if (!value || !autocomplete || !autocomplete.length) {
      return null;
    }
    return autocomplete.includes(value);
  },
  autocomplete = null,
  onChange = (v) => {},
  onBlur = (e) => {},
  onFocus = (e) => {},
  ...props
} : TextBoxProps) => {
  const classList = ['TextBox', ...classNames];

  const [{
    isValid,
    autocompleteOptions,
    value
  }, dispatch] = useReducer(TextBoxReducer, {
    isValid: null,
    autocompleteOptions: [],
    value: ''
  });

  const isAutocomplete = Array.isArray(autocomplete);

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
  }

  if (isValid === false) {
    inputClassList.push(...classList.map((c) => \`\${c}__input--error\`));
    labelClassList.push(...classList.map((c) => \`\${c}__label--error\`));
  }

  if (props.disabled) {
    labelClassList.push(...classList.map((c) => \`\${c}__label--disabled\`));
  }

  if (isAutocomplete && autocompleteOptions.length > 0) {
    inputClassList.push(...classList.map((c) => \`\${c}__input--autocomplete-open\`));
  }

  return (
    <div
      className={classList.join(' ')}
    >
      <Label
        classNames={labelClassList}
        label={label}
      >
        <Autocomplete
          classNames={classList.map((c) => \`\${c}__autocomplete\`)}
          options={autocompleteOptions}
          onSelect={(item) => {
            onChange(item);
            dispatch({
              type: 'TextBox:autocomplete-clicked',
              payload: item
            });
          }}
        >
          <input
            className={inputClassList.join(' ')}
            type={type}
            required={required}
            value={value}
            onFocus={(e) => {
              onFocus(e);
              dispatch({
                type: 'TextBox:focus',
                payload: filterAutocomplete(e.target.value)
              });
            }}
            onBlur={(e) => {
              onBlur(e);
              const validation = validate(value);
              if(validation === null) {
                dispatch({
                  type: 'TextBox:blur',
                  payload: null
                });
              }
              dispatch({
                type: 'TextBox:blur',
                payload: validation &&
                (
                  (!required && value.length === 0) ||
                  !isAutocomplete ||
                  autocomplete.includes(value)
                )
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
            {...props}
          />
        </Autocomplete>
      </Label>
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

\$clr-error: \$clr-red-d;
\$clr-empty: \$clr-gray;
\$clr-valid: \$clr-blue-d;
\$font-size: 1.1em;

.TextBox {
  padding: \$pad-s 0;
  width: max-content;

  &__label {
    display: flex;
    align-items: center;
    font-weight: \$fw-sb;
    color: \$clr-accent-xd;
    font-size: \$font-size;
    &__text {
      padding-right: \$pad-xs;
    }
    &:hover {
      cursor: pointer;
    }
    &--error {
      color: \$clr-error;
    }
    &--disabled {
      color: \$clr-gray-d;
      &:hover {
        cursor: default;
      }
    }
  }

  &__autocomplete {
    display: flex;
    justify-content: center;
    position: relative;
    font-weight: \$fw;
    color: \$clr-black;

    &__list {
      z-index: 10;
      list-style-type: none;
      margin: 0;
      padding: 0;
      padding-top: \$pad-s;
      position: absolute;
      background-color: \$clr-white;
      border: 2px solid \$clr-valid;
      border-radius: \$border-radius;
      border-top: none;
      border-top-left-radius: 0;
      border-top-right-radius: 0;
      max-height: 10em;
      overflow-y: scroll;
      top: 100%;
      width: 100%;
  
      &::before {
        content: ' ';
        position: absolute;
        top: 2px;
        width: 90%;
        left: 5%;
        height: 1px;
        border-bottom: 1px solid \$clr-gray-d;
        z-index: 50;
      }
  
      &__item {
        padding: \$pad-s;
        &:hover {
          cursor: pointer;
          background-color: \$clr-gray;
        }
      }
    }
  }
  
  &__input {
    outline: none;
    font-size: \$font-size;
    padding: 0 0.6em;
    margin: 0;
    line-height: 1.8em;
    border: 2px solid \$clr-empty;
    border-radius: \$border-radius;
    position: relative;
    &:disabled {
      border-color: \$clr-gray;
    }
    &:focus {
      border: 2px solid \$clr-accent-d;
    }
    &--error {
      border-color: \$clr-error;
    }
    &--error:focus {
      border: 2px solid \$clr-error;
    }
    &:focus.TextBox__input--autocomplete-open,
    &--error:focus.TextBox__input--autocomplete-open {
      padding-bottom: 2px;
      border-bottom: none;
      border-bottom-left-radius: 0;
      border-bottom-right-radius: 0;
    }
    &--error + .TextBox__autocomplete-list {
      border-color: \$clr-error;
    }
    &--empty {
      border: 2px solid \$clr-empty;
    }
  }

  &__errorMessage {
    color: \$clr-red;
    font-weight: \$fw-sb;
  }
}" > inputs/TextBox/TextBox.module.scss

echo "import React from 'react';
import './Label.module.scss';
import { connect } from 'react-redux';

type LabelProps = {
  classNames?: string[],
  label?: string,
  children?: any,
  [props: string]: any
};

const Label = ({
  classNames = [],
  label = null,
  children,
  ...props
} : LabelProps) => {
  const classList = ['Label', ...classNames];

  if (!label) {
    return (
      <>
        {children}
      </>
    );
  }

  return (
    <>
      <label className={classList.join(' ')}>
        <span
            className={classList.map((c) => \`\${c}__text\`).join(' ')}
          >
            {label}
        </span>
        {children}
      </label>
    </>
  );
};

Label.getInitialProps = ({store, pathname, query}) => {
};

const mapStateToProps = (state) => {
  return state;
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(Label);" > inputs/Label/Label.tsx

echo "@import 'styles/globals.scss';

.Label {
    &__text {
        padding-right: \$pad-xs;
    }
}" > inputs/Label/Label.module.scss

echo "import React from 'react';
import './Autocomplete.module.scss';
import { connect } from 'react-redux';
import List from 'components/misc/List';

type AutocompleteProps = {
  classNames?: string[],
  options?: string[],
  onSelect: (v: string) => any,
  children?: any,
  [props: string]: any
};

const Autocomplete = ({
  classNames = [],
  options = [],
  onSelect = (v) => {},
  children,
  ...props
} : AutocompleteProps) => {
  const classList = ['Autocomplete', ...classNames];

  return (
    <>
      <div
        className={classList.join(' ')}
      >
        {children}
        {options && options.length > 0 && (
          <List
            classNames={classList.map((c) => \`\${c}__list\`)}
            items={options}
            handleItemClicked={onSelect}
            onMouseDown={(e) => {
              e.preventDefault();
            }}
          />
        )}
      </div>
    </>
  );
};

Autocomplete.getInitialProps = ({store, pathname, query}) => {
};

const mapStateToProps = (state) => {
  return state;
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(Autocomplete);" > inputs/Autocomplete/Autocomplete.tsx
