//
//  UserDefaults+Codable.swift
//  WeatherHub
//
//  Created by Armando Brito on 16/1/23.
//

import Foundation

/// Reference: https://medium.com/@ankit.bhana19/save-custom-objects-into-userdefaults-using-codable-in-swift-5-1-protocol-oriented-approach-ae36175180d8
extension UserDefaults {

    enum ObjectSavableError: LocalizedError {
        case unableToEncode(onType: String)
        case noValue(key: String)
        case unableToDecode(onType: String)

        var errorDescription: String? {
            switch self {
                case .unableToEncode(let encodingType):
                    return "Unable to encode object into data of type \(encodingType)"
                case .noValue(let key):
                    return "No data object found for the key \(key)"
                case .unableToDecode(let decodingType):
                    return "Unable to decode object into type \(decodingType)"
            }
        }
    }

    func setObject<T>(_ object: T, forKey: String) throws where T: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode(onType: "\(T.self)")
        }
    }

    func getObject<T>(forKey key: String) throws -> T where T: Decodable {
        guard let data = data(forKey: key) else {
            throw ObjectSavableError.noValue(key: key)
        }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode(onType: "\(T.self)")
        }
    }

}
