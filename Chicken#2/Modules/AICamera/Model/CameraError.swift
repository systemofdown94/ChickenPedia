import Foundation

enum CameraError: LocalizedError {
    case noDevice
    case cannotAddInput
    case cannotAddOutput
    
    var errorDescription: String? {
        switch self {
            case .noDevice: return "No camera device found"
            case .cannotAddInput: return "Cannot add camera input"
            case .cannotAddOutput: return "Cannot add photo output"
        }
    }
}
