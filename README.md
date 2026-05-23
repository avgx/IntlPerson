# IntlPerson

Swift package for ACS persons, face recognition, and LPR lookup. HTTP descriptors use [RequestResponse](https://github.com/avgx/RequestResponse).

Shared wire types (`ObjectID`) come from [IntlWireFormat](https://github.com/avgx/IntlWireFormat). For server topology, see [IntlConfiguration](https://github.com/avgx/IntlConfiguration).

## Project layout

```
Sources/IntlPerson/
├── API/              PersonApi, FaceApi, LprApi
├── Person/           Person, Person.Field
├── Face/             ReadPersons*, FindFaces*, PersonListItem, FaceListItem
└── Lpr/              FindNumbersByImage*

Tests/IntlPersonTests/
├── Resources/        JSON fixtures
└── IntlPersonTests.swift
```

## Requirements

- Swift 6.1+
- iOS 15+, macOS 13+, tvOS 17+, visionOS 1+

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/avgx/IntlPerson", from: "1.0.0"),
],
targets: [
    .target(name: "MyApp", dependencies: ["IntlPerson"]),
]
```

## Quick start

```swift
import IntlPerson
import RequestResponse

let people: [Person] = try await http.send(
    PersonApi.list(value: "Test User")
).value

let faces: ReadPersonsResponse = try await http.send(
    FaceApi.readPersons(ReadPersonsRequest(serverId: "1", page: 1, count: 10))
).value

let image: Data = try await http.send(
    FaceApi.getImage(serverId: "1", imageId: "img-1")
).value

let plate: FindNumbersByImageResponse = try await http.send(
    LprApi.findNumbersByImage(FindNumbersByImageRequest(imageBase64: "…"))
).value
```

## HTTP API descriptors

| Enum | Method | Path |
|------|--------|------|
| `PersonApi` | `list(field:value:page:count:)` | `GET secure/persons` |
| `FaceApi` | `readPersons(_:)` | `POST secure/face/{server_id}/firserver/ReadPersons` |
| `FaceApi` | `getImage(serverId:imageId:)` | `GET secure/face/{id}/firserver/GetImage/{id}/{imageId}` |
| `FaceApi` | `findFaces(_:)` | `POST secure/face/{server_id}/firserver/FindFaces` |
| `LprApi` | `findNumbersByImage(_:)` | `POST secure/auto/lprserver/FindNumbersByImage` |

`PersonApi.list` with `field` + `value` sends the field name as query key; with `value` only, sends `search`.

Person images are exposed as `imageBase64: String?` — no UIKit dependency. CreatePerson / DeletePersons are not included in v1.

## Tests

```bash
swift test
```

Fixtures under `Tests/IntlPersonTests/Resources/` use synthetic anonymized data.

## License

See [LICENSE](LICENSE).
