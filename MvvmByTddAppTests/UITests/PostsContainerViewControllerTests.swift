//
//  PostsContainerViewControllerTests.swift
//  PostsContainerViewControllerTests
//
//  Created by Nishant Paul on 02/10/22.
//

import XCTest
@testable import MvvmByTddApp

class PostsContainerViewControllerTests: XCTestCase {

    func test_ViewDidLoad_RendersGetPostsButton() throws {
        let viewModel = PostsViewModel(webService: MockDataService(), actions: nil)
        let sut = PostsContainerViewController.create(with: viewModel)
        // Wait for UI to launch and call viewDidLoad
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertNotNil(sut.getPostsButton.titleLabel)
            XCTAssertEqual(sut.getPostsButton.titleLabel?.text, "Get Posts")
        })
    }
}
