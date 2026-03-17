import SwiftUI

struct AICameraRootView: View {
    
    @StateObject private var viewModel = CameraViewModel()
    
    var body: some View {
        ZStack {
            Color.mainBG
                .ignoresSafeArea()
            
            VStack {
                switch viewModel.state {
                    case .help:
                        helpView
                    case .setup:
                        cameraView
                    case .preview:
                        previewImage
                    case .scanning:
                        scanningView
                }
            }
            .padding(.bottom, 80)
            
            button
        }
    }
    
    private var helpView: some View {
        VStack(spacing: 32) {
            Image(.Images.Camera.chicken)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 280, maxHeight: 330)
            
            Text("Take a photo of a chicken and our AI will identify the breed and provide interesting facts")
                .font(.interFont(size: 18, weight: .regular))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundStyle(Color(hex: "#9E9E9E"))
                .background(Color(hex: "#474747"))
                .cornerRadius(8)
        }
        .padding()
    }
    
    private var cameraView: some View {
        ZStack {
            CameraPreview(session: viewModel.cameraService.session)
            
            PhotoFrameView()
        }
        .onAppear { viewModel.startSession() }
        .onDisappear { viewModel.stopSession() }
    }
    
    private var button: some View {
        VStack {
            Button {
                switch viewModel.state {
                    case .help:
                        viewModel.setupCamera()
                    case .setup:
                        viewModel.takePicture()
                    case .preview:
                        viewModel.state = .scanning
                    case .scanning:
                        break
                }
            } label: {
                let title = switch viewModel.state {
                    case .help:
                        "Open Camera"
                    case .setup:
                        "Take Photo"
                    case .preview:
                        "Scan Result"
                    case .scanning:
                        ""
                }
                
                Text(title)
                    .frame(width: 260, height: 52)
                    .font(.interFont(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .background(.mainOrange)
                    .cornerRadius(8)
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, 100)
    }
    
    private var previewImage: some View {
        Image(uiImage: viewModel.capturedImage ?? UIImage())
            .resizeCrop()
    }

    private var scanningView: some View {
        ZStack {
            Image(uiImage: viewModel.capturedImage ?? UIImage())
                .resizeCrop()

            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)

                Text("Scanning processing ...")
                    .font(.interFont(size: 16, weight: .medium))
                    .foregroundStyle(.white)
                    .padding(.top, 12)
            }
        }
    }
}

#Preview {
    AICameraRootView()
}
