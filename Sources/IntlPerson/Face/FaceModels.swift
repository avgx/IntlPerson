import Foundation

public struct PersonListItem: Codable, Sendable, Equatable {
    public let id: String
    public let imageId: String
    public let name: String
    public let surname: String
    public let patronymic: String
    public let department: String
    public let comment: String
    public let timestamp: String
    public let personId: Int?
    public let sim: String?

    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case imageId = "ImageId"
        case name = "Name"
        case surname = "Surname"
        case patronymic = "Patronymic"
        case department = "Department"
        case comment = "Comment"
        case timestamp = "Timestamp"
        case personId = "PersonId"
        case sim = "Sim"
    }
}

public struct FaceListItem: Codable, Sendable, Equatable {
    public let personList: [PersonListItem]

    private enum CodingKeys: String, CodingKey {
        case personList = "PersonList"
    }
}

public struct SimpleResponse: Codable, Sendable, Equatable {
    public let result: String?
    public let status: String?
    public let description: String?

    private enum CodingKeys: String, CodingKey {
        case result = "Result"
        case status = "Status"
        case description = "Description"
    }
}

public struct ReadPersonsRequest: Codable, Sendable, Equatable {
    public let serverId: String
    public let objectType: String
    public let ids: [String]
    public let page: Int
    public let pageSize: Int

    public init(serverId: String, ids: [String] = [], page: Int = 1, pageSize: Int = 100) {
        self.serverId = serverId
        self.objectType = "PERSON"
        self.ids = ids
        self.page = page
        self.pageSize = pageSize
    }

    private enum CodingKeys: String, CodingKey {
        case serverId = "server_id"
        case objectType
        case ids = "id"
        case page
        case pageSize
    }
}

public struct ReadPersonsResponse: Codable, Sendable, Equatable {
    public let personList: [PersonListItem]?
    public let total: Int?
    public let source: String?
    public let status: String
    public let response: SimpleResponse

    private enum CodingKeys: String, CodingKey {
        case personList = "PersonList"
        case total = "Total"
        case source = "Source"
        case status = "Status"
        case response = "Responce"
    }
}

public struct FindFacesRequest: Codable, Sendable, Equatable {
    public let serverId: String
    public let findPersons: Int
    public let image: String

    public init(serverId: String, imageBase64: String, findPersons: Int = 5) {
        self.serverId = serverId
        self.findPersons = findPersons
        self.image = imageBase64
    }

    public static func create(serverId: String, imageData: Data, count: Int = 5) -> FindFacesRequest {
        FindFacesRequest(serverId: serverId, imageBase64: imageData.base64EncodedString(), findPersons: count)
    }

    private enum CodingKeys: String, CodingKey {
        case serverId = "server_id"
        case findPersons
        case image
    }
}

public struct FindFacesResponse: Codable, Sendable, Equatable {
    public let faceList: [FaceListItem]
    public let processedFindFacesDuration: Int

    private enum CodingKeys: String, CodingKey {
        case faceList = "FaceList"
        case processedFindFacesDuration = "ProcessedFindFacesDuration"
    }
}
