import FoundationNetworking
import Foundation
import IDMEF

public struct IDMEFClient {
    let url: URL

    public init(url: String) {
        self.url = URL(string: url)!
    }

    public func send(message: IDMEFObject) {
        let session = URLSession.shared

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = message.serialize()!.data(using: .utf8)!
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Oops!! there is server error!")
                return
            }
        })
        
        task.resume()
    }
}

