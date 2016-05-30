var testing_1 = require('@angular/core/testing');
var app_component_1 = require('./app.component');
testing_1.describe('App', function () {
    testing_1.beforeEachProviders(function () { return [
        app_component_1.AppComponent
    ]; });
    testing_1.it('should work', testing_1.inject([app_component_1.AppComponent], function (app) {
        // Add real test here
        testing_1.expect(2).toBe(2);
    }));
});
//# sourceMappingURL=app.component.spec.js.map