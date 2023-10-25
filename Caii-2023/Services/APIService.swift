//
//  APIService.swift
//  Caii-2023
//
//  Created by Fernando Tello on 22/10/23.
//

import Foundation
import Alamofire

class APIService{
    
    func login(_ dni:String,completion: @escaping (Result<UserInfo, APIError>) -> Void){
        
        let url = "https://enc-ticketing.org/app/user/\(dni)";
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ resp in
                switch resp.result{
                case .success(let data):
                    do{
                        
                        let jsonData = try JSONDecoder().decode(UserData.self, from: data!)
                        
                        if let dataInfo = jsonData.datos {
                            completion(.success(dataInfo[0]))
                            
                            //                            print(dataInfo.user.nombres.components(separatedBy: " ").first ?? dataInfo.user.nombres)   // "ELIZABETH CLARISSA"
                            //                            print(dataInfo.user.apellidos) // "GAMARRA"
                        } else {
                            completion(.failure(.userError))
                            print(jsonData.message ?? "Invalid credentials")       // "Invalid credentials"
                        }
                        
                    } catch {
                        completion(.failure(.decodingError))
                        
                        print("catch",error)
                    }
                case .failure(let error):
                    completion(.failure(.networkError))
                    print("errGAA",error)
                    //                    print("errGAA",error.localizedDescription)
                }
            }
        
    }
    
    
    func getSchedulePrograms(completion: @escaping (Result<[EventD], APIError>) -> Void){
        let dni = UserDefaults.standard.string(forKey: "isLoggedIn")!
        let url = "https://enc-ticketing.org/app/actividad/\(dni)";
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ resp in
                switch resp.result{
                case .success(let data):
                    do{
                        
                        let jsonData = try JSONDecoder().decode(EventsData.self, from: data!)
                        
                        if let dataInfo = jsonData.datos {
                            completion(.success(dataInfo))
                            
                        } else {
                            completion(.failure(.userError))
                            print(jsonData.message ?? "ERROR")       // "Invalid credentials"
                        }
                        
                    } catch {
                        completion(.failure(.decodingError))
                        
                        print("catch",error)
                    }
                case .failure(let error):
                    completion(.failure(.networkError))
                    print("err",error)
                    //                    print("errGAA",error.localizedDescription)
                }
            }
        
    }
    
    
    
//
//    func loginTicketing(dni:String){
//        let url = "https://enc-ticketing.org/applogin/\(dni)";
//        
//        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
//            .response{ resp in
//                print("***", resp)
//                switch resp.result{
//                case .success(let data):
//                    do{
//                        
//                        let jsonData = try JSONDecoder().decode(UserData.self, from: data!)
//                        
//                        if let dataInfo = jsonData.data {
//                            print(dataInfo.user.name)      // "43573003"
//                            print(dataInfo.user.nombres.components(separatedBy: " ").first ?? dataInfo.user.nombres)   // "ELIZABETH CLARISSA"
//                            print(dataInfo.user.apellidos) // "GAMARRA"
//                        } else {
//                            print(jsonData.message ?? "Invalid credentials")       // "Invalid credentials"
//                        }
//                        
//                        print("sucGaa",jsonData)
//                    } catch {
//                        print("catch",error)
//                        print("catchloca",error.localizedDescription)
//                    }
//                case .failure(let error):
//                    print("errGAA",error)
//                    print("errGAA",error.localizedDescription)
//                }
//            }
//        
//    }
//    
    
  
}

enum APIError: Error {
    case userError
    case decodingError
    case networkError
    // Add more error cases as needed
}
