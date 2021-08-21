//
//  Models.swift
//  Projects Consolidation 19-21
//
//  Created by JEONGSEOB HONG on 2021/08/21.
//

import Foundation


struct Folder: Codable {
    var id: String
    var title: String
    var notes: [Note]
}

struct Note: Codable {
    var id: String
    var title: String
    var context: String
}
