//
//  MovieListProtocol.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import Foundation

protocol MovieListInput: AnyObject {
    func viewWillAppear()
    func numberOfRowsInSection(filterStatus: Bool, section: Int) -> Int
    func titleForHeaderInSection(filterStatus: Bool, section: Int) -> String
    func categoriesMenuHandler(title: String)
}

protocol MovieListOutput: AnyObject {
    func refresh()
}
