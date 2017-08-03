## Prerequisites
1. VirtualBox (w/ Extension Pack)
1. Vagrant
1. Git
1. Authorized SSH key

## Getting Started
Clone this repository:
```
git clone git@github.com:scemud/scemud.git
cd scemud
```

Copy the `vars.example.rb` into a file named just `vars.rb` and substitute your configuration for the example values within it:
```
cp vars.example.rb vars.rb
vi vars.rb
  ...<substitute variable values and save>...
```

Start the VM:
```
vagrant up
```
> *if you don't have the right vagrant plugins you will be told how to install them--do so, then retry this command*

Wait for the VM to provision then restart.

Log into the VM (via the GUI), open the terminal, and navigate to the workspace directory.  Execute the script you find there:
```
cd ~/workspace
./pull_repository.sh
  <input your SSH key passphrase when asked>
  <validate authenticity of SSH host when asked>
```

Once the repository is finished cloning, navigate into it and run the tests:
```
cd ~/workspace/scemud
yarn test
```

-----

## Frontend Boilerplate with React, MobX & TypeScript

A bare minimum react-mobx-webpack-typescript boilerplate with TodoMVC example.

Note that this project does not include **Server-Side Rendering**,  **Testing Frameworks** and other stuffs that makes the package unnecessarily complicated.

Ideal for creating React apps from the scratch.

See also: [react-redux-typescript-boilerplate](https://github.com/rokoroku/react-redux-typescript-boilerplate)

### Contains

- [x] [Typescript](https://www.typescriptlang.org/) 2.4.1
- [x] [React](https://facebook.github.io/react/) 15.6
- [x] [React Router](https://github.com/ReactTraining/react-router) 4.1
- [x] [Mobx](https://github.com/mobxjs/mobx)
- [x] [Mobx React](https://github.com/mobxjs/mobx-react)
- [x] [Mobx React Router](https://github.com/alisd23/mobx-react-router/)
- [x] [Mobx React Devtools](https://github.com/mobxjs/mobx-react-devtools)
- [x] [TodoMVC example](http://todomvc.com)

#### Build tools

- [x] [Webpack](https://webpack.github.io) 3.0
  - [x] [Tree Shaking](https://medium.com/@Rich_Harris/tree-shaking-versus-dead-code-elimination-d3765df85c80)
  - [x] [Webpack Dev Server](https://github.com/webpack/webpack-dev-server)
- [x] [Awesome Typescript Loader](https://github.com/s-panferov/awesome-typescript-loader)
- [x] [PostCSS Loader](https://github.com/postcss/postcss-loader)
  - [x] [CSS next](https://github.com/MoOx/postcss-cssnext)
  - [x] [CSS modules](https://github.com/css-modules/css-modules)
- [x] [React Hot Loader](https://github.com/gaearon/react-hot-loader)
- [x] [ExtractText Plugin](https://github.com/webpack/extract-text-webpack-plugin)
- [x] [HTML Webpack Plugin](https://github.com/ampedandwired/html-webpack-plugin)


### Setup

```
$ npm install
```

### Running

```
$ npm start
```

### Build

```
$ npm run build
```

## License

MIT
