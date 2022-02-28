import FoundationNetworking
import Foundation
import Embassy
import IDMEF

public struct IDMEFServer {
    let port: Int

    public init(port: Int) {
        self.port = port
    }

    public func start() {
        let loop = try! SelectorEventLoop(selector: try! SelectSelector())

//        let server = DefaultHTTPServer(eventLoop: loop, interface: "::", port: 8080)
        let server = DefaultHTTPServer(eventLoop: loop, port: port) {
            (
                environ: [String: Any],
                startResponse: ((String, [(String, String)]) -> Void),
                sendBody: ((Data) -> Void)
            ) in
            let input = environ["swsgi.input"] as! SWSGIInput
            input { data in
                let jsonString = String(data: data, encoding: .utf8)
                if jsonString != nil && !jsonString!.isEmpty {
                    let msg = IDMEFObject.deserialize(json: jsonString!)
                    print(msg!)
                }
            }
            startResponse("200 OK", [])
            sendBody(Data())
        }

        try! server.start()

        print("Server running at localhost:\(self.port)")

        loop.runForever()
    }
}
