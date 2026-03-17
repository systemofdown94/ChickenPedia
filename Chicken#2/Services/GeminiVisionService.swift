import UIKit
import Foundation

final class GeminiVisionService {
    
    static let shared = GeminiVisionService()
    
    private static let encodedKey =
    "c2stb3ItdjEtNGRiOTdjYzlhN2IzYjJiNTFiZDRlZjk1NTcyNzAzMmY1YTkzMTRiZWRkNGNiM2UxMDNmMWQwNzgzMmQxN2ZjNw=="
    
    static func getAPIKey() -> String? {
        guard let data = Data(base64Encoded: encodedKey) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    private let endpoint = URL(string: "https://openrouter.ai/api/v1/chat/completions")!
    
    private init() {}
    
    func analyzeImage(_ image: UIImage, prompt: String = "What is in this image?") async throws -> String {
        let processedImage = resizeImage(image, maxDimension: 1024)
        
        guard let jpegData = processedImage.jpegData(compressionQuality: 0.7) else {
            throw VisionError.imageEncodingFailed
        }
        
        let base64 = jpegData.base64EncodedString()
        let dataURL = "data:image/jpeg;base64,\(base64)"
        
        let body: [String: Any] = [
            "model": "google/gemini-2.5-flash",
            "messages": [
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "text",
                            "text": prompt
                        ],
                        [
                            "type": "image_url",
                            "image_url": [
                                "url": dataURL
                            ]
                        ]
                    ]
                ]
            ]
        ]
        
        guard let apiKey = Self.getAPIKey() else {
            throw VisionError.invalidApiKey
        }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("https://yourapp.com", forHTTPHeaderField: "HTTP-Referer")
        request.addValue("YourAppName", forHTTPHeaderField: "X-OpenRouter-Title")
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try parseResponse(data)
    }
    
    private func resizeImage(_ image: UIImage, maxDimension: CGFloat) -> UIImage {
        let size = image.size
        let maxSide = max(size.width, size.height)
        
        guard maxSide > maxDimension else { return image }
        
        let scale = maxDimension / maxSide
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
    
    private func parseResponse(_ data: Data) throws -> String {
        
        guard
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
            let choices = json["choices"] as? [[String: Any]],
            let message = choices.first?["message"] as? [String: Any],
            let content = message["content"] as? String
        else {
            throw VisionError.invalidResponse
        }
        
        return content
    }
}

enum VisionError: Error {
    case invalidApiKey
    case imageEncodingFailed
    case invalidResponse
}
