import UIKit
import PhotosUI
import Combine

@MainActor
final class CameraViewModel: ObservableObject {
    
    private let geminiService = GeminiVisionService.shared
    
    @Published var navPath: [CameraScreen] = []
    @Published var showAlert = false
    @Published var showPermissionAlert = false
    
    @Published private(set) var state: CameraState = .help
    @Published private(set) var capturedImage: UIImage?
    
    let cameraService = CameraService()
    
    func setupCamera() {
        Task {
            let granted = await cameraService.requestAuthorization()
            
            guard granted else {
                state = .help
                showPermissionAlert = true
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
    
    func startScanning() {
        state = .scanning
        
        Task { [weak self] in
            guard let self,
                  let capturedImage else { return }
            
            do {
                let result = try await self.geminiService.analyzeImage(capturedImage)
                
                await MainActor.run {
                    self.navPath.append(.result(ChickenUIResponseModel(
                        id: UUID(),
                        image: capturedImage,
                        response: result,
                        isFavorite: false
                    )))
                }
            } catch {
                print(error.localizedDescription)
                
                await MainActor.run {
                    self.state = .preview
                    self.showAlert = true
                }
            }
        }
    }
    
    func resetCamera() {
        capturedImage = nil
        state = .setup
    }
}
