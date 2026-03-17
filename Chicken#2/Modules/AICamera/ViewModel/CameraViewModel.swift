import UIKit
import PhotosUI
import Combine

@MainActor
final class CameraViewModel: ObservableObject {

    @Published var state: CameraState = .help
    @Published private(set) var capturedImage: UIImage?
    
    let cameraService = CameraService()
    
    func setupCamera() {
        Task {
            let granted = await cameraService.requestAuthorization()
            
            guard granted else {
                state = .help
                return
            }
            
            do {
                try cameraService.configureSession()
                cameraService.startSession()
                state = .setup
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func startSession() {
        cameraService.startSession()
        state = .setup
    }
    
    func stopSession() {
        cameraService.stopSession()
    }
    
    func takePicture() {
        Task {
            let capturedImage = await cameraService.takePicture()

            await MainActor.run {
                self.capturedImage = capturedImage
                self.state = .preview
            }
        }
    }

    func selectImage(_ image: UIImage) {
        capturedImage = image
        state = .preview
    }
}
