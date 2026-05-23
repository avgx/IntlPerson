import Foundation
import Testing
@testable import IntlPerson

enum FixtureSupport {
    static func decode<T: Decodable>(_ name: String) throws -> T {
        guard let url = Bundle.module.url(forResource: name, withExtension: "json") else {
            throw NSError(domain: "Fixture", code: 1)
        }
        return try JSONDecoder().decode(T.self, from: Data(contentsOf: url))
    }
}

@Test func decodesPersonsList() throws {
    let people: [Person] = try FixtureSupport.decode("persons-list")
    #expect(people.count == 1)
    #expect(people[0].fullname.contains("Test"))
}

@Test func decodesReadPersonsResponse() throws {
    let response: ReadPersonsResponse = try FixtureSupport.decode("read-persons-response")
    #expect(response.personList?.count == 1)
    #expect(response.status == "OK")
}

@Test func decodesLprResponse() throws {
    let response: FindNumbersByImageResponse = try FixtureSupport.decode("lpr-find-plate")
    #expect(response.plate == "A123BC")
}

@Test func personApiSearchQuery() {
    let request = PersonApi.list(value: "Test User")
    #expect(request.query?.contains(where: { $0.0 == "search" && $0.1 == "Test User" }) == true)
}

@Test func personApiFieldQuery() {
    let request = PersonApi.list(field: .tabnum, value: "100")
    #expect(request.query?.contains(where: { $0.0 == "tabnum" && $0.1 == "100" }) == true)
}

@Test func faceApiGetImagePath() {
    let request = FaceApi.getImage(serverId: "1", imageId: "img-1")
    #expect(request.path == "secure/face/1/firserver/GetImage/1/img-1")
}
