//
//  NetworkError.swift
//  CharacterViewerApp
//
//  Created by Paul on 6/13/23.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case invalidStatusCode(Int)
    case decodeError(DecodingError)
    case unknownError
}
