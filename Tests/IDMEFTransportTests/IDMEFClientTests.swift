import XCTest
import IDMEF
@testable import IDMEFTransport

final class IDMEFTransportTests: XCTestCase {
    func test1() throws {
        let client = IDMEFClient(url: "http://127.0.0.1:9999")

        client.send(message: IDMEFExample.message1())
    }
}
