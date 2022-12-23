//
//  Article.swift
//  NewsMVVM
//
//  Created by Ali Akbar on 23/12/22.
//

import Foundation

struct ArticleRespose: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
