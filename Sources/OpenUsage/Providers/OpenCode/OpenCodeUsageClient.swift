import Foundation

/// Calls OpenCode's official Go usage endpoint with the local Go Bearer token (`opencode-go` key,
/// or the `opencode` Console OAuth access token when no Go key exists).
struct OpenCodeUsageClient: Sendable {
    static let usageURL = URL(string: "https://opencode.ai/zen/go/v1/usage")!

    var http: any HTTPClient

    init(http: any HTTPClient = URLSessionHTTPClient()) {
        self.http = http
    }

    func fetchUsage(apiKey: String) async throws -> HTTPResponse {
        try await http.send(HTTPRequest(
            method: "GET",
            url: Self.usageURL,
            headers: [
                "Authorization": "Bearer \(apiKey)",
                "Accept": "application/json"
            ],
            timeout: 15
        ))
    }
}
