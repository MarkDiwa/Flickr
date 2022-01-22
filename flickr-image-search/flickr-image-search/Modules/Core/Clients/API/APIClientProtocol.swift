//
//  APIClientProtocol.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

typealias Parameters = [String: Any]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol APIClientProtocol {
    var baseUrlString: String { get }
    
}

extension APIClientProtocol {
    /// Construct the Endpoint's URL based on the given `resourcePath` value.
    ///
    /// - parameters:
    ///   - resourcePath: The endpoint's resource path. E.g. `/users`
    ///
    /// - returns: URL
    func endpointURL(_ resourcePath: String) -> URL? {
        let url = URL(string: baseUrlString)
        return url?.appendingPathComponent("/\(resourcePath)")
    }
    
    func createURLRequest(
        path: String,
        method: HTTPMethod,
        params: [String: Any],
        header: [String: String]
    ) -> URLRequest? {
        var url = endpointURL(path)
        if method == .get {
            params.forEach { key, value in
                url = url?.appending(key, value: "\(value)") ?? url
            }
        }
        guard let url = url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = method != .get ? try? JSONSerialization.data(withJSONObject: params, options: []) : nil
        header.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}

extension APIClientProtocol {
    
    func request<T: Decodable>(
        path: String,
        method: HTTPMethod = .get,
        params: [String: Any] = [:],
        header: [String: String] = [:],
        onSuccess: @escaping SingleResult<T>,
        onFailure: @escaping ErrorResult
    ) {
        request(createURLRequest(path: path,
                                 method: method,
                                 params: params,
                                 header: header),
                onSuccess: onSuccess,
                onFailure: onFailure)
    }
    
    func request<T: Decodable>(
        _ request: URLRequest?,
        onSuccess: @escaping SingleResult<T>,
        onFailure: @escaping ErrorResult
    ) {
        guard let request = request else {
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error -> Void in
            do {
                guard let data = data else {
                    let error = APIError(errorMessage: "No data found")
                    onFailure(error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    let error = APIError(errorMessage: "Unknown Error")
                    onFailure(error)
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    let apiResponse = try JSONDecoder().decode(T.self, from: data)
                    onSuccess(apiResponse)
                    return
                }
                
                guard let json = try? JSONSerialization
                        .jsonObject(with: data,
                                    options: .allowFragments) as? [String: Any] else {
                    let error = APIError(errorMessage: "Cannot serialize data into JSON")
                    onFailure(error)
                    return
                }
                let error = APIError(errorMessage: (json["message"] as? String) ?? "Error")
                onFailure(error)
                
            } catch let error {
                onFailure(error)
            }
        }
        task.resume()
    }
}
