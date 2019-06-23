import XCTest

import BlackboxTests

var tests = [XCTestCaseEntry]()
tests += BlackboxTests.allTests()
XCTMain(tests)
