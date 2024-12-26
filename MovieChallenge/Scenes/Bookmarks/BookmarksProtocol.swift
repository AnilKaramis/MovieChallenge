//
//  BookmarksProtocol.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import Foundation

protocol BookmarksInput: AnyObject {
    func viewWillAppear()
}

protocol BookmarksOutput: AnyObject {
    func refresh()
}
