import Foundation
import IntlWireFormat
import RequestResponse

public enum FaceApi {
    public static func readPersons(_ request: ReadPersonsRequest) -> Request<ReadPersonsResponse> {
        Request(
            path: "secure/face/\(request.serverId)/firserver/ReadPersons",
            method: .post,
            body: request
        )
    }

    public static func getImage(serverId: ObjectID, imageId: String) -> Request<Data> {
        Request(
            path: "secure/face/\(serverId)/firserver/GetImage/\(serverId)/\(imageId)",
            method: .get,
            headers: ["Accept": "image/*"]
        )
    }

    public static func findFaces(_ request: FindFacesRequest) -> Request<FindFacesResponse> {
        Request(
            path: "secure/face/\(request.serverId)/firserver/FindFaces",
            method: .post,
            body: request
        )
    }
}
