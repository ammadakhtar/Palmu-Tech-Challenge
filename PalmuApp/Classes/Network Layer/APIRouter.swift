//
// Copyright (c) 2020, Palmu Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case photos(page: Int)
    
    // MARK: - HTTPMethod
    
    private var method: HTTPMethod {
        
        switch self {
            
        case .photos:
            return .get
        }
    }
    
    // MARK: - Path
    
    private var path: String {
        
        switch self {
            
        case .photos(let page):
            return "photos" + "?page=\(page)"
        }
    }
    
    // MARK: - Parameters
    
    private var bodyParameters: Parameters? {
        
        switch self {
            
        case .photos:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let urlString = try? Constant.Unsplash.baseURL.asURL()
            .appendingPathComponent(path)
            .absoluteString.removingPercentEncoding
        let url = URL(string: urlString.orEmpty)
        var urlRequest = URLRequest(url: url!)
        
        // HTTP Method
        
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue("Client-ID \(Constant.Unsplash.accessKey)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        
        // Parameters
        
        if let parameters = bodyParameters {
            
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
