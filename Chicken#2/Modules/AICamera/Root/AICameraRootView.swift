import SwiftUI
import PhotosUI

struct AICameraRootView: View {

    @StateObject private var viewModel = CameraViewModel()
    
    @State private var showGallery = false

    var body: some View {
        NavigationStack(path: $viewModel.navPath) {
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
                
                if viewModel.state != .scanning {
                    button
                }
                
                if viewModel.state == .preview {
                    VStack {
                        HStack {
                            Button {
                                viewModel.resetCamera()
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .font(.system(size: 22, weight: .medium))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 44, height: 44)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                }
            }
            .alert("Something went wrong or there is no chicken on the picture. Try again.", isPresented: $viewModel.showAlert) {}
            .alert("The camera access is required. Open settings?", isPresented: $viewModel.showPermissionAlert) {
                Button("Yes") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }
                
                Button("Cancel") {}
            }
            .navigationDestination(for: CameraScreen.self) { screen in
                switch screen {
                    case .result(let result):
                        AICameraResultView(model: result)
                            .onDisappear {
                                viewModel.resetCamera()
                            }
                }
            }
            .onAppear {
                MainTabBarAppearanceManager.instance.hasTabBar = true
            }
            .sheet(isPresented: $showGallery) {
                GalleryPicker { image in
                    viewModel.selectImage(image)
                }
            }
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
        .overlay(alignment: .topTrailing) {
            Button {
                showGallery = true
            } label: {
                Circle()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(.black.opacity(0.5))
                    .overlay {
                        Image(systemName: "photo.on.rectangle")
                            .font(.system(size: 22))
                            .foregroundStyle(.white)
                    }
                    .padding(12)
            }
        }
        .onAppear { viewModel.startSession() }
        .onDisappear { viewModel.stopSession() }
    }
    
    private var button: some View {
        VStack {
            Button {
                HapticManager.shared.impact()
                
                switch viewModel.state {
                    case .help:
                        viewModel.setupCamera()
                    case .setup:
                        viewModel.takePicture()
                    case .preview:
                        viewModel.startScanning()
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

            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
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
