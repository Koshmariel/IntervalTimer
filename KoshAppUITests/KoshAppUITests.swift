//
//  KoshAppUITests.swift
//  KoshAppUITests
//
//  Created by Aleksey on 17.11.2021.
//

import XCTest

class KoshAppUITests: XCTestCase {
    private var app = XCUIApplication()  //указать bundle ID
    private var editButton: XCUIElement {app.buttons["editButton"]}
    private var startButton: XCUIElement {app.buttons["startButton"]}
    private var timerLabel: XCUIElement {app.staticTexts["timerLabel"]}
    private var durationSlider: XCUIElement {app.sliders["durationSlider"]}
    private var durationLabelET: XCUIElement {app.staticTexts["durationLabelET"]}
    private var saveButton: XCUIElement {app.buttons["saveButton"]}
//    let startButton = app.buttons["START"]
//    let timerLabel = app.staticTexts["timerLabel"]
   
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        
        //поглядеть в пицце - добавить добавление сриншотов
        //посмотреть activities
        
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
/*
    func testExample() throws {
        // UI tests must launch the application that they test.
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
*/
    
    
    
    func testAllElementsExist() throws {
        app.launch()
/*
        print("timerLabel.label=\(timerLabel.label)")
        print("timerLabel.description=\(timerLabel.description)")
        print("timerLabel.title=\(timerLabel.title)")
*/
        XCTAssertTrue(editButton.exists)
        XCTAssertTrue(startButton.exists)
        XCTAssertTrue(timerLabel.exists)
        
    }
    
    
    func testAllButtonsAreTapeble() throws {
        app.launch()
        XCTAssertTrue(startButton.isHittable)  //проверить на мелком экране
        XCTAssertTrue(editButton.isHittable)   //возможно проверка на включение кнопки

    }
    
    func testNumberInDislpayOnStart() throws {
        let lookFor = "6"
//        let timerLabel = app.staticTexts["timerLabel"]
        
        app.launch()
//        XCUIApplication().buttons["START"].tap()
        
//        print("===========")
//        print(timerLabel)
//        print("===========")
//        print(app.debugDescription) // or use "po app" command in console
//        print("===========")
        XCTAssertEqual(lookFor, timerLabel.label, "no \(lookFor) found")
        //XCTAssert(timerLabel == "10")
        //XCTAssertTrue(timerLabel, "timerLabel incorrect")
//        XCTAssertEqual(timerLabel, "10", "timerLabel = \(timerLabel)")
        
    }
    
    func testTimerWorks() throws {
        let lookFor = "DONE"
        app.launch()
        
        let onDisplay = timerLabel.label   //рассмотреть перевод в  pageobject
        print("on Display = \(onDisplay)")
        let durationAsDbl = Double(onDisplay)!
        print("durationAsDbl = \(durationAsDbl)")   //what onDisplay could not be converted to int ?
        //let result = app.staticTexts[lookFor].firstMatch.label
        XCUIApplication().buttons["START"].tap()
        XCTAssertTrue(app.staticTexts[lookFor].waitForExistence(timeout: durationAsDbl+1))
        
        //поглядеть вывод в консоль
    
    }
    
    func testEnterEditTimerVC() {
        let lookFor = "EDIT TIMER"
        app.launch()
        XCUIApplication().buttons["editButton"].tap()
        let result = app.staticTexts[lookFor].firstMatch.label
        XCTAssertEqual(result, lookFor)
                    
    }
    
    func testEnterEditTimerVC_part() {
        let lookFor = "EDITq"
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", lookFor)  // CONTAINS[c] makes search case insensitive.
        app.launch()
        XCUIApplication().buttons["editButton"].tap()
        let elementQuery = app.staticTexts.containing(predicate)
          if elementQuery.count > 0 {
            XCTAssert(true)
          } else {
            XCTAssert(false, "No \(lookFor) found")
          }
                    
    }
    
    func testChangeTimerDuration() {
        
        app.launch()
        XCUIApplication().buttons["editButton"].tap()
        durationSlider.adjust(toNormalizedSliderPosition: 0.3)
        sleep(3)
        var durationLabelET = durationLabelET.label
        print("durationLabelET = \(durationLabelET)")
        durationLabelET.removeLast() // removes last char
        let durationLabelETasInt = Int(durationLabelET)
        print("new duration = \(durationLabelETasInt!)")
        XCUIApplication().buttons["saveButton"].tap()
        let lookFor = String(durationLabelETasInt!)
        print("looking for \(lookFor) in TimerVC" )
        XCTAssertEqual(lookFor, timerLabel.label, "no \(lookFor) found")
    }
    
    
/*
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
 
        }
     
    }
     */
}
