import Foundation
import RequestResponse

public enum LprApi {
    public static func findNumbersByImage(_ request: FindNumbersByImageRequest) -> Request<FindNumbersByImageResponse> {
        Request(
            path: "secure/auto/lprserver/FindNumbersByImage",
            method: .post,
            body: request
        )
    }
}
