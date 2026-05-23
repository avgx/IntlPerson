import Foundation

public struct FindNumbersByImageRequest: Codable, Sendable, Equatable {
    public let id: String
    public let image: String

    public init(serverId: String, imageBase64: String) {
        self.id = serverId
        self.image = imageBase64
    }

    public static func create(serverId: String, imageData: Data) -> FindNumbersByImageRequest {
        FindNumbersByImageRequest(serverId: serverId, imageBase64: imageData.base64EncodedString())
    }
}

public struct FindNumbersByImageResponse: Codable, Sendable, Equatable {
    public let plate: String?
    public let result: String?
    public let status: String?
    public let description: String?

    private enum CodingKeys: String, CodingKey {
        case plate = "Plate"
        case result = "Result"
        case status = "Status"
        case description = "Description"
    }
}
