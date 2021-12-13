//
//  File.swift
//  
//
//  Created by 최제환 on 2021/12/02.
//

import Foundation
import Network
import Combine

public final class NetworkImp: Network {
    
    private let session: URLSession
    
    public init(
        session: URLSession
    ) {
        self.session = session
    }
    
    public func send<T>(_ request: T) -> AnyPublisher<Response<T.Output>, Error> where T: Request {
        do {
            let urlRequest = try RequestFactory(request: request).urlRequestRepresentation()
            print("CJHLOG: url = \(urlRequest.url?.absoluteString)")
            return session.dataTaskPublisher(for: urlRequest)
                .tryMap { data, response in
                    let output = try JSONDecoder().decode(T.Output.self, from: data)
                    return Response(output: output, statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
}

private final class RequestFactory<T: Request> {
    
    let request: T
    let boundary = "__________________________proc1"
    
    init(request: T) {
        self.request = request
    }
    
    func urlRequestRepresentation() throws -> URLRequest {
        switch request.method {
        case .get:
            return try makeGetRequest()
        case .post:
            return try makePostRequest()
        case .multipart:
            return try makeMultipartRequest()
        }
    }
    
    private func makeGetRequest() throws -> URLRequest {
        var param = [""]
        if request.query.isEmpty == false {
            request.query.forEach {
                param.append("\($0.key)=\($0.value)")
            }
        }
        let bodyStr = param.joined(separator: "&")
        
        guard let url = URL(string: "\(request.endpoint)?\(bodyStr)") else {
            throw NetworkError.invalidURL(url: request.endpoint)
        }
        
        var urlRequest = URLRequest(url: url)
        request.header.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.url = url
        
        return urlRequest
    }
    
    private func makePostRequest() throws -> URLRequest {
        let body = try JSONSerialization.data(withJSONObject: request.query, options: [])
        
        guard let url = URL(string: request.endpoint) else {
            throw NetworkError.invalidURL(url: request.endpoint)
        }
        
        var urlRequest = URLRequest(url: url)
        request.header.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.url = url
        urlRequest.httpBody = body
        
        return urlRequest
    }
    
    private func makeMultipartRequest() throws -> URLRequest {
        var body = Data()
        var imageParts = [Data]()
        
        request.query.forEach {
            if $0.value is Data {
                imageParts.append($0.value as! Data)
            } else {
                body.append("__\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition:form-data; name=\"\($0.key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("Content-type: text/plain;\r\n\r\n".data(using: .utf8)!)
                body.append("\($0.value)\r\n".data(using: .utf8)!)
            }
        }
        
        if imageParts.count == 0 {
            body.append("__\(boundary)__\r\n".data(using: .utf8)!)
        } else {
            var index = 1
            imageParts.forEach {
                body.append("__\(boundary)__\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(makeFileKey(index: index))\"; filename=\"\(makeFileName(index: index))\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append($0)
                body.append("\r\n".data(using: .utf8)!)
                
                index += 1
            }
            body.append("__\(boundary)__\r\n".data(using: .utf8)!)
        }
        
        guard let url = URL(string: request.endpoint) else {
            throw NetworkError.invalidURL(url: request.endpoint)
        }
        
        var urlRequest = URLRequest(url: url)
        request.header.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.url = url
        urlRequest.httpBody = body
        
        return urlRequest
    }
    
    private func makeFileKey(index: Int) -> String {
        return "alter_file_name\(index)"
    }
    
    private func makeFileName(index: Int) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "Ko_KR")
        formatter.dateFormat = "MMddHHmmss"
        
        return "\(formatter.string(from: date))_\(index).jpeg"
    }
}
