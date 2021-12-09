//
//  Apollo.swift
//  What-The-Fridge-iOS
//
//  Created by Hachi on 2021-12-09.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    lazy var apollo = ApolloClient(url: URL(string: "http://localhost:4000/graphql")!)
}
