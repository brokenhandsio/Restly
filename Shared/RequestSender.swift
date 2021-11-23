import Foundation

struct RequestSender {
    func sendRequest(to urlString: String, method: String) async throws -> (Data, URLResponse) {
        guard let url = URL(string: urlString) else {
            throw RestlyError.failedToConvertURLString
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        return try await URLSession.shared.data(for: request)
    }
}
