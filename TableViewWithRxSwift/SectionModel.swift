//
//  SectionModel.swift
//  TableViewWithRxSwift
//
//  Created by cumulations on 12/06/23.
//

import Foundation
import RxDataSources

struct SectionModel{
    var header: String
    var items: [Sports]
}

extension SectionModel: SectionModelType{
    init(original: SectionModel, items: [Sports]) {
        self = original
        self.items = items
    }
}
