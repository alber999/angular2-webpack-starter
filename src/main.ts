import {platformBrowserDynamic} from "@angular/platform-browser-dynamic";
import {enableProdMode, TRANSLATIONS, TRANSLATIONS_FORMAT, LOCALE_ID} from "@angular/core";
import {AppModule} from "./app/app.module";
import {TRANSLATION_EN} from "./resources/i18n/messages.en";
//import {TRANSLATION_ES} from "./resources/i18n/messages.es";

if (process.env.ENV === 'production') {
    enableProdMode();
}

platformBrowserDynamic().bootstrapModule(
    AppModule,
    {
        providers: [
            {provide: TRANSLATIONS, useValue: TRANSLATION_EN},
            {provide: TRANSLATIONS_FORMAT, useValue: "xlf"},
            {provide: LOCALE_ID, useValue: "en"}
        ]
    });
