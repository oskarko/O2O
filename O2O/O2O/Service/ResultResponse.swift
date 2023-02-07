//
//  ResultResponse.swift
//  O2O
//
//  Created by Oscar Rodriguez Garrucho on 7/2/23.
//

import Foundation

enum ResultResponse<T> {
    case success(T)
    case failure(APIErrorResponse)
}
