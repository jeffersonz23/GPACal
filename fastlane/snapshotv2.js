#import "SnapshotHelper.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();


// target.frontMostApp().mainWindow().staticTexts()["GPA: 4.00"].tapWithOptions({tapOffset:{x:0.33, y:0.49}});
target.delay(3)
captureLocalizedScreenshot("0-LandingScreen")
target.frontMostApp().navigationBar().rightButton().tap();
target.delay(1)

target.frontMostApp().mainWindow().textFields()[0].textFields()[0].tap();
target.frontMostApp().keyboard().typeString("Data Structures");
target.delay(1)

target.frontMostApp().mainWindow().segmentedControls()[0].buttons().firstWithName("2").tap();
target.delay(1)

target.frontMostApp().mainWindow().sliders()[0].dragToValue(0.00);
target.delay(1)
captureLocalizedScreenshot("1-AddScreen")

target.frontMostApp().navigationBar().rightButton().tap();
target.delay(6)
captureLocalizedScreenshot("2-LandingScreen")

target.frontMostApp().navigationBar().rightButton().tap();
target.delay(1)

target.frontMostApp().mainWindow().textFields()[0].textFields()[0].tap();
target.delay(1)

target.frontMostApp().keyboard().typeString("Calculus 1");
target.frontMostApp().mainWindow().segmentedControls()[0].buttons().firstWithName("3").tap();
target.frontMostApp().navigationBar().rightButton().tap();
target.delay(6)
captureLocalizedScreenshot("3-LandingScreen")
