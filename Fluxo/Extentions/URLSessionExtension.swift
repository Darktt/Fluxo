//
//  URLSessionExtension.swift
//
//  Created by Darktt on 18/1/10.
//  Copyright © 2018 Darktt. All rights reserved.
//

import Foundation

public 
extension URLSession
{
    // MARK: - Properties -
    
    static
    var `default`: URLSession {
        
        let configuartion = URLSessionConfiguration.default
        
        return URLSession(configuration: configuartion)
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    static
    func `default`(delegate: URLSessionDelegate?, delegateQueue: OperationQueue = .main) -> URLSession
    {
        let configuartion = URLSessionConfiguration.default
        
        let defaultSession: URLSession = URLSession(configuration: configuartion, delegate: delegate, delegateQueue: delegateQueue)
        
        return defaultSession
    }
    
    static
    func `default`(delegateQueue: OperationQueue) -> URLSession
    {
        let configuartion = URLSessionConfiguration.default
        
        let defaultSession: URLSession = URLSession(configuration: configuartion, delegate: nil, delegateQueue: delegateQueue)
        
        return defaultSession
    }
    
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResultHandler) -> URLSessionDataTask
    {
        let request = URLRequest(url: url)
        
        return self.dataTask(with: request, completionHandler: completionHandler)
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResultHandler) -> URLSessionDataTask
    {
        let _completionHandler: DataTaskHandler = {
            
            (data, response, error) in
            
            var result: Result<Data, Error>!
            
            if let error = error {
                
                result = Result.failure(error)
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                
                let error = HTTPError(httpResponse.statusCode)
                result = Result.failure(error)
            }
            
            if let data = data {
                
                result = Result.success(data)
            }
            
            completionHandler(result)
        }
        
        let task: URLSessionDataTask = self.dataTask(with: request, completionHandler: _completionHandler)
        
        return task
    }
    
    func downloadTask(with url: URL, completionHandler: @escaping DownloadTaskResultHandler) -> URLSessionDownloadTask
    {
        let request = URLRequest(url: url)
        
        return self.downloadTask(with: request, completionHandler: completionHandler)
    }
    
    func downloadTask(with request: URLRequest, completionHandler: @escaping DownloadTaskResultHandler) -> URLSessionDownloadTask
    {
        let _completionHandler: DownloadTaskHandler = {
            
            (url, response, error) in
            
            var result: Result<URL, Error>!
            
            if let error = error {
                
                result = Result.failure(error)
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                
                let error = HTTPError(httpResponse.statusCode)
                result = Result.failure(error)
            }
            
            if let url = url {
                
                result = Result.success(url)
            }
            
            completionHandler(result)
        }
        
        let task: URLSessionDownloadTask = self.downloadTask(with: request, completionHandler: _completionHandler)
        
        return task
    }
}

// MARK: - With Codable -

public 
extension URLSession
{
    func dataTask<DecodeResult>(with url: URL, completionHandler: @escaping (Result<DecodeResult, Error>) -> Void) -> URLSessionDataTask where DecodeResult: URLSessionDecodeConvertible
    {
        let urlRequest = URLRequest(url: url)
        
        let task: URLSessionDataTask = self.dataTask(with: urlRequest, completionHandler: completionHandler)
        
        return task
    }
    
    func dataTask<DecodeResult>(with request: URLRequest, completionHandler: @escaping (Result<DecodeResult, Error>) -> Void) -> URLSessionDataTask where DecodeResult: URLSessionDecodeConvertible
    {
        let handler: DataTaskResultHandler = {
            
            result  in
            
            let transform: (Data) -> Result<DecodeResult, Error> = {
                
                (data) -> Result<DecodeResult, Error> in
                
                let result = Result {
                    
                    try DecodeResult.decode(from: data)
                }
                
                return result
            }
            
            let newResult: Result<DecodeResult, Error> = result.flatMap(transform)
            
            completionHandler(newResult)
        }
        
        let task: URLSessionDataTask = self.dataTask(with: request, completionHandler: handler)
        
        return task
    }
}

// MARK: - Closure -

public 
extension URLSession
{
    typealias DataTaskHandler = (Data?, URLResponse?, Error?) -> Void
    typealias DownloadTaskHandler = (URL?, URLResponse?, Error?) -> Void
    typealias DataTaskResultHandler = (Result<Data, Error>) -> Void
    typealias DownloadTaskResultHandler = (Result<URL, Error>) -> Void
}

// MARK: - URLSessionDecodeConvertible -

public 
protocol URLSessionDecodeConvertible
{
    static
    func decode(from data: Data) throws -> Self
}
