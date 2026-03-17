import UIKit
import AVFoundation

final class CameraService {
 
    let session = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private var photoContinuation: CheckedContinuation<UIImage?, Never>?
 
    var isAuthorized: Bool {
        AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }
 
    func requestAuthorization() async -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            return await AVCaptureDevice.requestAccess(for: .video)
        default:
            return false
        }
    }
 
    func configureSession() throws {
        session.beginConfiguration()
        defer { session.commitConfiguration() }
 
        session.sessionPreset = .photo
 
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            throw CameraError.noDevice
        }
 
        let input = try AVCaptureDeviceInput(device: device)
 
        guard session.canAddInput(input) else {
            throw CameraError.cannotAddInput
        }
 
        session.addInput(input)
 
        guard session.canAddOutput(photoOutput) else {
            throw CameraError.cannotAddOutput
        }
 
        session.addOutput(photoOutput)
    }
 
    func startSession() {
        guard !session.isRunning else { return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.session.startRunning()
        }
    }
 
    func stopSession() {
        guard session.isRunning else { return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.session.stopRunning()
        }
    }
    func takePicture() async -> UIImage? {
        await withCheckedContinuation { continuation in
            photoContinuation = continuation
            let settings = AVCapturePhotoSettings()
            let delegate = PhotoCaptureDelegate { [weak self] image in
                self?.photoContinuation?.resume(returning: image)
                self?.photoContinuation = nil
            }
            objc_setAssociatedObject(self, "delegate", delegate, .OBJC_ASSOCIATION_RETAIN)
            photoOutput.capturePhoto(with: settings, delegate: delegate)
        }
    }
}
 
final class PhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate {
 
    private let completion: (UIImage?) -> Void
 
    init(completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
    }
 
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            completion(nil)
            return
        }
        completion(UIImage(data: data))
    }
}
