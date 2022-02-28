import XCTest
import IDMEF
import FoundationNetworking
@testable import IDMEFTransport

final class IDMEFClientTests: XCTestCase {
    func test1() throws {
        let client = IDMEFClient(url: "http://127.0.0.1:9999")

        let (response, _) = client.send(message: IDMEFExample.message1(fixed: false))

        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            print(response as! HTTPURLResponse)
            XCTFail()
            return
        }
    }

}
