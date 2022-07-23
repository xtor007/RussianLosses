//
//  NetworkManager.swift
//  RussianLosses
//
//  Created by Anatoliy Khramchenko on 23.07.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let serverLink = ProcessInfo.processInfo.environment["SERVER_LINK"]!
    private let session = URLSession(configuration: .default)
    
    private init(){}
    
    func getData<T: Decodable>(fromFile fileName: FileName, onSucces: @escaping ([T])->(Void), onError: @escaping (String)->(Void)) {
        guard let url = URL(string: serverLink+fileName.getFileName()) else {
            onError("Server is not found")
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                onError("Invalid data or response")
                return
            }
            do {
                if response.statusCode == 200 {
                    let result = try JSONDecoder().decode([T].self, from: data)
                    onSucces(result)
                } else {
                    onError("Server return error")
                }
            }
            catch {
                onError(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
