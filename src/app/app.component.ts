import {Component} from "@angular/core";
import "../../public/css/styles.css";
@Component({
    selector: "my-app",
    templateUrl: "../resources/html/app.component.html",
    styleUrls: ["../resources/css/app.component.css"]
})
export class AppComponent {
    value: string = "variable";
}
