import Foundation
import RequestResponse

public enum PersonApi {
    public static func list(
        field: Person.Field? = nil,
        value: String? = nil,
        page: Int = 1,
        count: Int = 100
    ) -> Request<[Person]> {
        var query: [(String, String?)] = [
            ("page", String(page)),
            ("count", String(count)),
        ]

        if let field, let value {
            query.append((field.rawValue, value))
        } else if field == nil, let value {
            query.append(("search", value))
        }

        return Request(path: "secure/persons", method: .get, query: query)
    }
}
