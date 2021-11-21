//
//  Parser.swift
//  Movie
//
//  Created by hafied Khalifatul ash.shiddiqi on 18/11/21.
//

import Foundation

struct Parser {

    func parse(comp : @escaping ([Item])->()) {
        let api = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_lpfgd3f9")
        URLSession.shared.dataTask(with: api!) {
            data, response, error in
            if error != nil {

                return
            }
            do {
                let result = try JSONDecoder().decode(MovieResult.self, from: data!)
                comp(result.items)
            } catch {

            }
        }.resume()
    }
}


struct MovieResult: Codable {
    let items: [Item]
    let errorMessage: String
}
struct Item: Codable {
    let id, rank, title, fullTitle: String
    let year: String
    let image: String
    let crew, imDBRating, imDBRatingCount: String

    enum CodingKeys: String, CodingKey {
        case id, rank, title, fullTitle, year, image, crew
        case imDBRating = "imDbRating"
        case imDBRatingCount = "imDbRatingCount"
    }
}

struct Detail: Codable {
    let plot: String
    let releaseDate: String
    let runtimeMins: String
    
    enum CodingKeys: String, CodingKey {
        case plot
        case releaseDate
        case runtimeMins
    }
}

