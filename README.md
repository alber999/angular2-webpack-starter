#  Angular 2.0.0 final webpack starter pack with i18n native support

Starter pack with sample application created from [https://angular.io/docs/ts/latest/guide/webpack.html](https://angular.io/docs/ts/latest/guide/webpack.html)

## Requirements

* node >= 4.4
* npm >= 2.15
* angular = 2.0.0 final
* webpack >= 1.13
* karma >= 1.2
* typescript >= 2.0.2
* angular-compiler-cli = 0.6.0
* gulp >= 3.9

## Environment

Tested on:

```
node -v; npm -v
v4.5.0
2.15.9
```

## Installation

```
npm install
```

## Extract i18n messages from templates

```
node_modules/.bin/ng-xi18n
```

## Create custom language i18n XLF files

```
cp messages.xlf src/resources/i18n/messages.en.xlf
...
cp messages.xlf src/resources/i18n/messages.[LANG_N].xlf
```

Then complete "targets" for each i18n XLF file

## Convert i18n XLF to Typescript 

```
node_modules/.bin/gulp i18n-xlf2ts
```

## Set current app language

Current language is set in:

```
src/main.ts
```

when main module is bootstrapped:

```
import {TRANSLATION_EN} from "./resources/i18n/messages.en";
... 

platformBrowserDynamic().bootstrapModule(
    AppModule,
    {
        providers: [
            {provide: TRANSLATIONS, useValue: TRANSLATION_EN},
            {provide: TRANSLATIONS_FORMAT, useValue: "xlf"},
            {provide: LOCALE_ID, useValue: "en"}
        ]
    });
```

This is just a starter sample. Of course you can implement you own logic.


## Run

```
npm start
```

Open in browser [http://localhost:8080](http://localhost:8080)

## Test

```
npm test
```

## Build

```
npm run build
```

"_dist_" directory contains minimized sources ready for production
