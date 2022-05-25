/*
 * Copyright (C) 2022 Teclib'
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *         http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import FoundationNetworking
import Foundation
import Embassy
import IDMEF

/**
 Server part of the IDMEF transport.
 
 This implementation provides:
 
 - IDMEF message reception over HTTP
 
*/
public struct IDMEFServer {
    let port: Int

    /**
    Initialize a IDMEFServer.

    - Parameters:
        - port: the TCP port on which server will listen, for instance 9999
    */
    public init(port: Int) {
        self.port = port
    }

    /**
    Start the server loop.

    This function is blocking and will loop forever.

    When a JSON content is received, the JSON bytes are deserialized to a IDMEFObject
    and the created object is then validated against the JSON schema.

    If valid, a HTTP "200 OK" response will be sent and the message will be printed.
    If not valid, a HTTP "500 Internal server error" response will be sent.
    */
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
            var valid = false
            input { data in
                let jsonString = String(data: data, encoding: .utf8)
                if jsonString != nil && !jsonString!.isEmpty {
                    let msg = IDMEFObject.deserialize(json: jsonString!)
                    do {
                        if let v = try msg?.validate() {
                            print(v)
                            valid = v
                            print(msg!)
                        } else {
                            print("Invalid message")
                        }
                    } catch {
                    }
                }
            }
            if valid {
                startResponse("200 OK", [])
            } else {
                startResponse("500 Internal server error", [])
            }
            sendBody(Data())
        }

        try! server.start()

        print("Server running at localhost:\(self.port)")

        loop.runForever()
    }
}
