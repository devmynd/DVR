import Foundation

final class SessionUploadTask: URLSessionUploadTask {

    // MARK: - Types

    typealias Completion = (Data?, Foundation.URLResponse?, NSError?) -> Void

    // MARK: - Properties

    let dataTask: SessionDataTask

    // MARK: - Initializers

    init(session: Session, request: URLRequest, taskIdentifier: Int, completion: Completion? = nil) {
        dataTask = SessionDataTask(session: session, request: request, taskIdentifier: taskIdentifier, completion: completion)
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
