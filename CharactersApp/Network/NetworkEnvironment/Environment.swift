//
//  Environment.swift
//  SimpsonsViewer
//
//  Created by Paul on 6/13/23.
//

import Foundation

enum Environment {
    
    static let Domain = "http://api.duckduckgo.com"
    static let ImageBase = "https://duckduckgo.com/"
    
    private struct API {
        #if SIMPSON
            static let SimpsonPath = "?q=simpsons+characters&format=json"
        #elseif WIRE
            static let WirePath = "?q=the+wire+characters&format=json"
        #endif
    }
    
    case Characters
    case CharacterImage(_ path: String)
    
    var request: URLRequest? {
        switch self {
        case .Characters:
            var urlString: String = ""
            #if SIMPSON
                urlString = Environment.Domain + API.SimpsonPath
            #elseif WIRE
                urlString = Environment.Domain + API.WirePath
            #endif
            guard let url = URL(string: urlString) else { return nil }
            return URLRequest(url: url)
        case .CharacterImage(let path):
            guard let url = URL(string: Environment.Domain + path) else { return nil }
            return URLRequest(url: url)
        }
    }
}
