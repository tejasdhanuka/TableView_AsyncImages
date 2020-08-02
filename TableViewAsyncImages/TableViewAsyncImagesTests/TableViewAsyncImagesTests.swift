//
//  TableViewAsyncImagesTests.swift
//  TableViewAsyncImagesTests
//
//  Created by Dhanuka, Tejas | ECMPD on 2020/07/12.
//  Copyright © 2020 Dhanuka, Tejas | ECMPD. All rights reserved.
//

import XCTest
@testable import TableViewAsyncImages

class TableViewAsyncImagesTests: XCTestCase {
    
    var sut: AsyncImagesViewModel!
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testAboutCanadaViewModel() {
        let aboutCanada = AboutCanada(title: "About Canada", rows: [Row(title: "Beavers",
                                                                        description: "Beavers are second only to humans",
                                                                        imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")])
        sut = AsyncImagesViewModel(aboutCanada: aboutCanada)
        
        XCTAssertEqual(aboutCanada.title, sut.aboutCanada.title)
        XCTAssertEqual(aboutCanada.rows?[0].title, sut.aboutCanada.rows?[0].title)
        XCTAssertEqual(aboutCanada.rows?[0].description, sut.aboutCanada.rows?[0].description)
        XCTAssertEqual(aboutCanada.rows?[0].imageHref, sut.aboutCanada.rows?[0].imageHref)
    }
    
    func testTableViewDataSource() {
        let aboutCanada = AboutCanada(title: "About Canada", rows: [Row(title: "Beavers",
                                                                        description: "Beavers are second only to humans",
                                                                        imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")])
        sut = AsyncImagesViewModel(aboutCanada: aboutCanada)
        sut.loadJSON {_ in 
            XCTAssertEqual(self.sut.numberOfSections(), 1)
            XCTAssertEqual(self.sut.numberOfRows(), 1)
        }
    }
    
    func testdataUrl() {
        let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        XCTAssertEqual(Constants.dataUrlString, url)
    }
    
    func testDataApiClient() {
        let apiClient = AsyncImagesApiClient()
        apiClient.fetchData(completionHandler: { aboutCanada, error in
            if let error = error {
                XCTAssertNil(aboutCanada)
                XCTAssertNotNil(error)
            } else {
                XCTAssertNil(error)
                XCTAssertNotNil(aboutCanada)
            }
        })
    }
}
