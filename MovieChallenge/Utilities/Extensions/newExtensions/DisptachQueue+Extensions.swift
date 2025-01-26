//
//  DisptachQueue+Extensions.swift
//  Teknasyon MVVM Template
//
//  Created by YusufDemirkoparan on 11.07.2024.
//

import Foundation

extension DispatchQueue {
    static func asyncAfter(seconds: Double, execute work: @escaping @convention(block) () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: work)
    }
    
    static func main(execute work: @escaping @convention(block) () -> Void) {
        DispatchQueue.main.async(execute: work)
    }
}
