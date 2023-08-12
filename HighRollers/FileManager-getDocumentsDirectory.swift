//
//  FileManager-getDocumentsDirectory.swift
//  HotProspects
//
//  Created by Felipe Casalecchi on 15/07/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
