import Foundation

/// Personal fork identity. Upstream notices and protocol attribution are retained.
enum ProjectInfo {
    static let appName = "Pulsekeep"
    static let tagline = "Your rhythm. Your records."
    static let version = "0.1.0"
    /// Upstream project contact, retained from NOOP.
    static let contactEmail = "thenoopapp@gmail.com"

    /// Open-source reverse-engineering this is built on.
    static let attributions: [(repo: String, note: String)] = [
        ("johnmiddleton12/my-whoop", "WHOOP 4.0 BLE protocol"),
        ("b-nnett/goose", "WHOOP 5.0 BLE protocol"),
    ]
}
