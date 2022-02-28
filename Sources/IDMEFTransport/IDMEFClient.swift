import FoundationNetworking
import Foundation
import IDMEF

public struct IDMEFClient {
    let url: URL

    public init(url: String) {
        self.url = URL(string: url)!
    }

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

