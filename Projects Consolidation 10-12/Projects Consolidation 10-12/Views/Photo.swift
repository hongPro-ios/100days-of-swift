//
//  Photo.swift
//  Projects Consolidation 10-12
//
//  Created by JEONGSEOB HONG on 2021/07/28.
//

import Foundation

class Photo: Codable {
    var id: String
    var caption: String?
    var imagePath: String {
        Utility.getDocumentsDirectory().appendingPathComponent(id).path
    }
    
    init(id: String, caption: String?) {
        self.id = id
        self.caption = caption
    }
}
