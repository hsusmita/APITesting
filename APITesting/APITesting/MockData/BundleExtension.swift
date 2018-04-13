//
//  BundleExtension.swift
//  APITesting
//
//  Created by Susmita Horrow on 04/04/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation

extension Bundle {
    func loadData(fileName: String, type: String) -> Data? {
        guard let filePath = self.path(forResource: fileName, ofType: type) else {
            return nil
        }
        let url = URL(fileURLWithPath: filePath)
        return try? Data(contentsOf: url)
    }
}
