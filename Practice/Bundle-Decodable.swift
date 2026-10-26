//
//  Extension+Bundle.swift
//  Practice
//
//  Created by Deepak Kumar Yadav on 25/10/26.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String ) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("no such file: '\(file)' exists")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("can not read data from the url/file '\(file)'")
        }
        
        do {
            
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "y-MM-d"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            return try decoder.decode(T.self, from: data)
            
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode file \(file) from bundle due to missing key: \(key.stringValue) - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context){
            fatalError("Failed to decode file \(file) from bundle due to typemismatch \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context){
            fatalError("Failed to decode file \(file) from bundle due to missing \(type) - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_){
            fatalError("Failed to decode file \(file) from bundle because it appears to be corrupted data")
        } catch {
            fatalError("Failed to decode file \(file) from bundle \(error.localizedDescription)")
        }
    }
}
 
