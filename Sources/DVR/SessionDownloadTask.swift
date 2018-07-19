import Foundation

final class SessionDownloadTask: URLSessionDownloadTask {

    // MARK: - Types

    typealias Completion = (URL?, Foundation.URLResponse?, NSError?) -> Void

    // MARK: - Properties

    let dataTask: SessionDataTask

    // MARK: - Initializers

    init(session: Session, request: URLRequest, taskIdentifier: Int, completion: Completion? = nil) {
        dataTask = SessionDataTask(session: session, request: request, taskIdentifier: taskIdentifier) { data, response, error in
            let location: URL?
            if let data = data {
                // Write data to temporary file
                let tempURL = URL(fileURLWithPath: (NSTemporaryDirectory() as NSString).appendingPathComponent(UUID().uuidString))
                try? data.write(to: tempURL, options: [.atomic])
                location = tempURL
            } else {
                location = nil
            }

            completion?(location, response, error)
        }
    }

    // MARK: - URLSessionTask

    override func cancel() {
        // Don't do anything
    }

    override func resume() {
        dataTask.resume()
    }

    override var originalRequest: URLRequest? {
        return dataTask.originalRequest
    }

    override var taskIdentifier: Int {
        return dataTask.taskIdentifier
    }
}
