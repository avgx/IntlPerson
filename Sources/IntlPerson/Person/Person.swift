import Foundation
import IntlWireFormat

public struct Person: Codable, Identifiable, Equatable, Sendable {
    public let person: [String: String]

    public var id: String {
        person[Field.id.rawValue] ?? "invalid"
    }

    public var guid: String {
        guard let raw = person[Field.guid.rawValue] else {
            return "00000000-0000-4000-8000-000000000000"
        }
        let trimmed = raw
            .replacingOccurrences(of: "{", with: "")
            .replacingOccurrences(of: "}", with: "")
        return UUID(uuidString: trimmed)?.uuidString ?? trimmed
    }

    public var tabnum: String {
        person[Field.tabnum.rawValue] ?? ""
    }

    public var fullname: String {
        [Field.surname, .name, .patronymic]
            .compactMap { person[$0.rawValue] }
            .filter { !$0.isEmpty }
            .joined(separator: "\n")
    }

    public var imageBase64: String? {
        guard let value = person[Field.img.rawValue], !value.isEmpty else { return nil }
        return value
    }

    public var imageData: Data? {
        guard let imageBase64 else { return nil }
        return Data(base64Encoded: imageBase64)
    }

    public init(person: [String: String]) {
        self.person = person
    }

    public enum Field: String, Codable, CaseIterable, Sendable {
        case id, guid, tabnum, surname, name, patronymic, img, department, comment
    }
}

public enum PersonFieldCategory: String, Codable, CaseIterable, Sendable {
    case name
    case personal
    case auto
    case visitor
    case misc
}

extension Person.Field {
    public var category: PersonFieldCategory {
        switch self {
        case .surname, .name, .patronymic:
            return .name
        case .department, .comment, .tabnum:
            return .personal
        default:
            return .misc
        }
    }

    public var isHidden: Bool {
        [.id, .img, .guid].contains(self)
    }
}
