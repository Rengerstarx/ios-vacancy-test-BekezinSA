//
//  GitHubGistService.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 22.10.2024.
//

import Foundation

enum GitHubGistError: Error, LocalizedError {
    case invalidURL
    case noData
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case decodingError
    case unknownError(statusCode: Int)
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return ^String.GistError.gistErrorInvalidURLTitle
        case .noData:
            return ^String.GistError.gistErrorNoDataTitle
        case .unauthorized:
            return ^String.GistError.gistErrorUnauthorizedTitle
        case .forbidden:
            return ^String.GistError.gistErrorForbiddenTitle
        case .notFound:
            return ^String.GistError.gistErrorNotFoundTitle
        case .serverError:
            return ^String.GistError.gistErrorServerErrorTitle
        case .decodingError:
            return ^String.GistError.gistErrorDecodingErrorTitle
        case .unknownError(let statusCode):
            return String.GistError.gistErrorUnknownErrorString.format(statusCode)
        }
    }
}

class GitHubGistService {
    
    private struct APIConfig {
        static let baseURL = "https://api.github.com/gists"
        static let apiVersion = "2022-11-28"
    }
    
    var completion: ((Result<[GitHubGist], Error>) -> Void)?
    
    func fetchGists() {
        guard let url = createURL() else {
            completion?(.failure(GitHubGistError.invalidURL))
            return
        }
        
        let request = createRequest(with: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                self?.completion?(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                self?.handleResponse(httpResponse, data: data)
            }
        }.resume()
    }
    
    private func createURL() -> URL? {
        return URL(string: APIConfig.baseURL)
    }
    
    private func createRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        setHeaders(for: &request)
        return request
    }
    
    private func setHeaders(for request: inout URLRequest) {
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue(APIConfig.apiVersion, forHTTPHeaderField: "X-GitHub-Api-Version")
    }
    
    private func handleResponse(_ response: HTTPURLResponse, data: Data?) {
        switch response.statusCode {
        case 200:
            guard let data = data else {
                completion?(.failure(GitHubGistError.noData))
                return
            }
            decodeData(data)
        case 401:
            completion?(.failure(GitHubGistError.unauthorized))
        case 403:
            completion?(.failure(GitHubGistError.forbidden))
        case 404:
            completion?(.failure(GitHubGistError.notFound))
        case 500...599:
            completion?(.failure(GitHubGistError.serverError))
        default:
            completion?(.failure(GitHubGistError.unknownError(statusCode: response.statusCode)))
        }
    }
    
    private func decodeData(_ data: Data) {
        do {
            let decoder = JSONDecoder()
            let gists = try decoder.decode([GitHubGist].self, from: data)
            completion?(.success(gists))
        } catch {
            completion?(.failure(GitHubGistError.decodingError))
        }
    }
}
