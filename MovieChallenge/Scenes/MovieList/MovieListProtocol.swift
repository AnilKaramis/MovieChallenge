//
//  MovieListProtocol.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import Foundation

protocol MovieListInput: AnyObject {
    func numberOfRowsInSection(filterStatus: Bool, section: Int) -> Int
    func titleForHeaderInSection(filterStatus: Bool, section: Int) -> String
    func bookmarkButtonAction(section: Int, index: Int)
}

protocol MovieListOutput: AnyObject {
    func refresh()
}

