//
//  DateConversionService.swift
//  Unitbean.News
//
//  Created by Игорь Дикань on 23.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

class DateConversionService {
    
    private init() {}
    static let shared = DateConversionService()
    
    func getDate(dateString: String?) -> String {
        guard let dateString = dateString else { return "1970-01-01"}
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.locale = Locale(identifier: "ru_RU")
        let date = formatter.date(from: dateString)
        formatter.dateFormat = "dd MMMM 'в' HH:mm"
        return formatter.string(from: date!)
    }
}
