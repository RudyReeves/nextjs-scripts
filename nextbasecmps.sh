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
      <Link
        href={link.path}
      >
        <a
          className={\`\${className}__link\`}
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
        }

        .PrimaryNav__overlay:hover {
            cursor: pointer;
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
    }

    &__toggle-btn:hover {
        cursor: pointer;
        background-color: \$bg-clr-hilight;
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
    }
 
    &__link:hover {
        background-color: \$bg-clr-hilight;
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
            
            &-item:first-child,
            &-item:last-child {
              margin: 0;
            }
        }

        &__link {
            padding: \$pad-half;
        }

        &__list-item {
          margin: 0 \$pad-half;
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

echo "import React, { useState } from 'react';
import './TextBox.module.scss';

type TextBoxProps = {
  className?: string,
  placeholder?: string,
  type?: string,
  required?: boolean,
  name?: string,
  label?: string,
  errorMessage?: string,
  validate?: (value: string) => boolean,
  [attrs: string]: any,
};

const TextBox = ({
  className = 'TextBox',
  placeholder = '',
  type = 'text',
  required = false,
  name = '',
  label = '',
  errorMessage = '',
  validate = (value) => true,
  ...attrs
} : TextBoxProps) => {
  const [isValid, setIsValid] = useState(null);
  const isEmpty = (isValid === null);
  let inputClass = \`\${className}__input\`;
  let labelClass = \`\${className}__label\`;

  if (isEmpty) {
    inputClass += \` \${className}__input--empty\`;
  } else if (!isValid) {
    inputClass += \` \${className}__input--error\`;
    labelClass += \` \${className}__label--error\`;
  }

  return (
    <div
      className={className}
    >
      <div
        className={\`\${className}__container\`}
      >
        <label
          className={labelClass}
          htmlFor={name}
        >
          {label}
        </label>
        <input
          className={inputClass}
          type={type}
          placeholder={placeholder}
          required={required}
          name={name}
          id={name}
          onBlur={(e) => {
            setIsValid(validate(e.target.value));
          }}
          {...attrs}
        />
      </div>
      {errorMessage && !isEmpty && !isValid &&
        <div className={\`\${className}__errorMessage\`}>
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

    &__container {
        display: flex;
        align-items: center;
    }

    &__label {
        display: inline;
        font-weight: \$fw-sb;
        color: \$clr-hilight;
        font-size: \$font-size;
        margin-right: \$pad-s;
    }

    &__label:hover {
        cursor: pointer;
    }

    &__label--error {
        color: \$clr-error;
    }
    
    &__input {
        outline: none;
        font-size: \$font-size;
        max-width: 30em;
        padding: \$pad-s \$pad-ms;
        border: 2px solid \$clr-valid;
        border-radius: \$border-radius;
    }
    
    &__input:focus {
        border: 2px solid \$clr-hilight;
    }

    &__input--error:focus {
        border: 2px solid \$clr-error;
    }

    &__input--error {
        border-color: \$clr-error;
    }

    &__input--empty {
        border: 2px solid \$clr-empty;
    }

    &__errorMessage {
        color: \$clr-red;
        font-weight: \$fw-sb;
    }
}
" > inputs/TextBox/TextBox.module.scss
