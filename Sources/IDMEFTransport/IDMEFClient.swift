import FoundationNetworking
import Foundation
import IDMEF

/**
 Client part of the IDMEF transport.
 
 This implementation provides:
 
 - IDMEF message sending over HTTP
 
*/
public struct IDMEFClient {
    let url: URL

    /**
    Initialize a IDMEFClient.

    - Parameters:
        - url: the URL of the server, for instance "http://127.0.0.1:9999"
    */
    public init(url: String) {
        self.url = URL(string: url)!
    }

    /**
    Send a IDMEF message other HTTP using a POST request.

    The request is synchronous and the function waits till completion of the request.

    - Parameters:
        - message: the message to send

    - Returns: the HTTP response and an error (if an error occurred)
    */
    public func send(message: IDMEFObject) -> (response: URLResponse?, error: Error?) {
        var response: URLResponse?
        var error: Error?

        let session = URLSession.shared

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = message.serialize()!.data(using: .utf8)!
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")   

        let semaphore = DispatchSemaphore(value: 0)

        let task = session.dataTask(with: request) {
            response = $1
            error = $2

            semaphore.signal()
        }

        task.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        return (response, error)       
    }
}

