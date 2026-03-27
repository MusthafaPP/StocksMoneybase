import Foundation

protocol NetworkConfigProviding {
    var baseURL: String { get }
    var rapidAPIHost: String { get }
    var rapidAPIKey: String? { get }
}

/// Reads network configuration from build-time values (Info.plist keys)
/// and environment variables (e.g. `RAPIDAPI_KEY`).
final class DefaultNetworkConfigProvider: NetworkConfigProviding {
    private let info: [String: Any]

    init(info: [String: Any] = Bundle.main.infoDictionary ?? [:]) {
        self.info = info
    }

    var baseURL: String {
        (info["RAPIDAPI_BASE_URL"] as? String).flatMap(nonEmpty) ?? Self.fallbackBaseURL
    }

    var rapidAPIHost: String {
        (info["RAPIDAPI_HOST"] as? String).flatMap(nonEmpty) ?? Self.fallbackHost
    }

    var rapidAPIKey: String? {
//        let envVarName =
//            (info["RAPIDAPI_KEY_ENVVAR"] as? String).flatMap(nonEmpty) ??
//        Self.fallbacRapidAPIKey
//
//        return ProcessInfo.processInfo.environment[envVarName]
        
        (info["RAPIDAPI_KEY_ENVVAR"] as? String).flatMap(nonEmpty) ?? Self.fallbacRapidAPIKey
    }

    private func nonEmpty(_ value: String?) -> String? {
        guard let value, !value.isEmpty else { return nil }
        return value
    }

    private static let fallbackBaseURL = "https://yh-finance.p.rapidapi.com"
    private static let fallbackHost = "yh-finance.p.rapidapi.com"
    private static let fallbacRapidAPIKey = "501a9ce445msh7a4209530a3dd9dp1dcc1djsn116323932be5"
}

/// Shared config provider used by endpoints.
enum NetworkConfigProvider {
    static let shared: NetworkConfigProviding = DefaultNetworkConfigProvider()
}

