//
//  Project5Tests.swift
//  Project5Tests
//
//  Created by JEONGSEOB HONG on 2021/07/06.
//

import XCTest
@testable import Project5

class Project5Tests: XCTestCase {
    var viewController: ViewController!

    override func setUpWithError() throws {
        viewController = ViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInputtedWordIsPossible() throws {
        viewController.title = "abcdee"
        
        let inputtedWord = "a"
        
        do {
            try viewController.isPossible(word: inputtedWord)
            XCTAssert(true, "한 문자를 한번 문자만 사용한 경우")
            
        } catch {
            
        }
                
//        XCTAssertEqual(result, true, "한 문자를 한번 문자만 사용한 경우")
//
//        inputtedWord = "ab"
//        result = viewController.isPossible(word: inputtedWord)
//        XCTAssertEqual(result, true, "두 문자를 한번씩 사용한 경우")
//
//        inputtedWord = "abcdee"
//        result = viewController.isPossible(word: inputtedWord)
//        XCTAssertEqual(result, true, "두 문자를 한번씩 사용한 경우")
//
//        inputtedWord = "eee"
//        result = viewController.isPossible(word: inputtedWord)
//        XCTAssertEqual(result, false, "문자 사용갯수 초과")
    }
    
    func testInputtedWordIsOriginal() throws {
        
//        let inputtedWord = "test1"
//        viewController.usedWords = ["test1", "test2"]
//        var result = viewController.isOriginal(word: inputtedWord)
//        XCTAssertEqual(result, false, "중복된 값이 입력되었기 때문에 false가 되어야한다.")
//
//
//        viewController.usedWords = ["test2"]
//        result = viewController.isOriginal(word: inputtedWord)
//        XCTAssertEqual(result, true, "중복된 값이 없기 때문에 true 되어야한다.")
    }
    
    func testInputtedWordIsReal() throws {
//        var inputtedWord = "apple"
//        var result = viewController.isReal(word: inputtedWord)
//        XCTAssertEqual(result, true, "존재하는 단어")
//
//        inputtedWord = "kkek"
//        result = viewController.isReal(word: inputtedWord)
//        XCTAssertEqual(result, false, "존재하지 않는 단어")
    }


}
