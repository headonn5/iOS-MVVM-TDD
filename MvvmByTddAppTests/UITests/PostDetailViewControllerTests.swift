//
//  PostDetailViewControllerTests.swift
//  MvvmByTddAppTests
//
//  Created by Nishant Paul on 02/10/22.
//

import XCTest
@testable import MvvmByTddApp

class PostDetailViewControllerTests: XCTestCase {

    var sut: PostDetailViewController?
    
    override func setUpWithError() throws {
        let viewModel = PostDetailViewModel(post: PostModel(body: "Body",
                                                            id: 1,
                                                            title: "Title",
                                                            userId: 2))
        // Load the view controller
        sut = PostDetailViewController.create(with: viewModel)
    }
    
    func test_ViewDidLoad_RendersTableView() {
        guard let sut = sut else {
            XCTFail("View controller not found.")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            XCTAssertEqual(sut.titleLabel.text, "Title")
            XCTAssertEqual(sut.bodyLabel.text, "Body")
        }
    }

}
