//
//  ArticleViewModel.swift
//  NewsMVVM
//
//  Created by Ali Akbar on 23/12/22.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
    let articleViewModels: [ArticleViewModel]
}

extension ArticleListViewModel {
    init(_ articles: [Article]) {
        self.articleViewModels = articles.compactMap(ArticleViewModel.init)
    }
}

extension ArticleListViewModel {
    func ArticleAt(_ index: Int) -> ArticleViewModel {
        return self.articleViewModels[index]
    }
}

struct ArticleViewModel {
    let article: Article
    
    init(article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: Observable<String> {
        return Observable<String>.just(article.title)
    }
    
    var description: Observable<String> {
        return Observable<String>.just(article.description ?? "")
    }
}
