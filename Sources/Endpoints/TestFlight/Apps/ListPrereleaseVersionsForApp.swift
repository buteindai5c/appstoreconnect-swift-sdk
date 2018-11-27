//
//  ListPrereleaseVersionsForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == PreReleaseVersionsResponse {

    /// Get a list of prerelease versions associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - limit: Number of resources to return.
    public static func prereleaseVersionsForApp(
        withId id: String,
        fields: [ListPrereleaseVersionsForApp.Field]? = nil,
        limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "apps/\(id)/preReleaseVersions",
            method: .get,
            parameters: parameters)
    }
}

public struct ListPrereleaseVersionsForApp {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case preReleaseVersions([PreReleaseVersion])
        
        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .preReleaseVersions(let value):
                return (PreReleaseVersion.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ListPrereleaseVersionsForApp.Field {
    
    public enum PreReleaseVersion: String, CaseIterable, NestableQueryParameter {
        case app, builds, platform, version

        static var key: String = "preReleaseVersion"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
