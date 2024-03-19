//
//  APIManager.swift
//  KODE
//
//  Created by Матвей Горохов on 20.03.2024.
//

import UIKit

class APIManager{
    static let shared = APIManager()
    
    let urlString = "https://stoplight.io/mocks/kode-api/trainee-test/331141861/users"
    
    func getUsers(completion: @escaping (Result<UsersData, Error>) -> Void) {
      
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                // Ошибка, если нет данных
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            do {
                let usersData = try JSONDecoder().decode(UsersData.self, from: data)
                completion(.success(usersData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
