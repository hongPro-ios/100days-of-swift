//
//  Utility.swift
//  Projects Consolidation 10-12
//
//  Created by JEONGSEOB HONG on 2021/07/28.
//

import Foundation

class Utility {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
 
}
