//
//  UITestHelper.swift
//  MvvmByTddAppTests
//
//  Created by Nishant Paul on 02/10/22.
//

import UIKit

extension UITableView {
    func cell(at row: Int, section: Int) {
        dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: section))
    }
}
