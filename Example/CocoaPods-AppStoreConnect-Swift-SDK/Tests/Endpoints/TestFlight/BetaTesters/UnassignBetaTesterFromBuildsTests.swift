//
//  UnassignBetaTesterFromBuildsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class UnassignBetaTesterFromBuildsTests: XCTestCase {
    
    func testURLRequest() {
        let linkageRequest = BetaTesterBuildsLinkagesRequest(data: [
            .init(id: "betaTesterId", type: "betatesters")])
        
        let endpoint = APIEndpoint.unassign(
            betaTester: linkageRequest,
            fromBuildWithId: "buildId")
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "DELETE")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaTesters/buildId/relationships/builds"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(linkageRequest))
    }
}
