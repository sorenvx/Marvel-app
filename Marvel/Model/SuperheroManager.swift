//
//  SuperheroManager.swift
//  Marvel
//
//  Created by Toni De Gea on 16/04/2020.
//  Copyright © 2020 Toni De Gea. All rights reserved.
//

import Foundation

enum MyErrors: Error {
    case num409
    case num401
    case num405
    case num403
}

struct SuperheroManager {
    
    //    var delegate: WeatherManagerDelegate?
    enum ServiceResult { //si es success devuelve cualquier cosa que se pida, si no, devuelve un mensaje diciendo que ha fallado
        case success(data: [Result])
        case failure(msg: MyErrors)
    }
    
   
    
    typealias ServiceCompletion = (_ results: ServiceResult) -> ()
    
    let publicKey = "e0fd14eca9cfbb0488055c4320e4ecde"
    let privateKey = "76d7af44ce76787eed0d2d35229dadf0f4176e0b"
    let ts = "9"
    let md5Hash = "e39dc103077e1859c2ac994baf89e97d"
    let offset = "0"
    let limit = "20"
    
    
    func getSuperheroes(completion: @escaping ServiceCompletion) -> Void {
        let urlString = "https://gateway.marvel.com:443/v1/public/characters?limit=\(limit)&offset=\(offset)&ts=\(ts)&apikey=\(publicKey)&hash=\(md5Hash)"
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(MarvelAPI.self, from: safeData)
                            DispatchQueue.main.async {
                                let res: [Result] = results.data.results
                                completion(.success(data: res))
                                //                                print(res)
                            }
                            
                        } catch  {
                            completion(.failure(msg: MyErrors.num401))
                        }
                        
                    }
                } else {
                    completion(.failure(msg: MyErrors.num401))
                }
            }
            task.resume()
        }
    }
}
