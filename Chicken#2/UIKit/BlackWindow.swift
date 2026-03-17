import WebKit
import SwiftUI

struct DocumentView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let url: URL
    
    var body: some View {
        VStack {
            HStack {
                Text("Privacy Policy")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                    
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.black.opacity(0.5))
                }
            }
            .padding()
        }
    }
}

struct BlackWindow: UIViewRepresentable {
    
    let url: URL
    
    @Binding var isHidden: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = .all
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.defaultWebpagePreferences.allowsContentJavaScript = true
        
        let webView = WKWebView(frame: .zero, configuration: config)
        
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        
        let backSwipe = UISwipeGestureRecognizer(
            target: webView,
            action: #selector(WKWebView.goBack)
        )
        backSwipe.direction = .right
        
        let forwardSwipe = UISwipeGestureRecognizer(
            target: webView,
            action: #selector(WKWebView.goForward)
        )
        forwardSwipe.direction = .left
        
        webView.addGestureRecognizer(backSwipe)
        webView.addGestureRecognizer(forwardSwipe)
        
        webView.load(URLRequest(url: url))
        
        context.coordinator.mainWebView = webView
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    
    final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        
        weak var mainWebView: WKWebView?
        weak var popupWebView: WKWebView?
        
        private let parent: BlackWindow
        
        init(parent: BlackWindow) {
            self.parent = parent
        }
        
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if parent.isHidden {
                parent.isHidden = false
            }
        }
        
        
        func webView(
            _ webView: WKWebView,
            createWebViewWith configuration: WKWebViewConfiguration,
            for navigationAction: WKNavigationAction,
            windowFeatures: WKWindowFeatures
        ) -> WKWebView? {
            
            guard popupWebView == nil else { return nil }
            
            let popup = WKWebView(frame: .zero, configuration: configuration)
            popup.navigationDelegate = self
            popup.uiDelegate = self
            
            let controller = UIViewController()
            controller.view.backgroundColor = .systemBackground
            controller.view.addSubview(popup)
            
            popup.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                popup.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
                popup.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
                popup.topAnchor.constraint(equalTo: controller.view.topAnchor),
                popup.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor)
            ])
            
            popupWebView = popup
            
            present(controller)
            
            return popup
        }
        
        
        func webViewDidClose(_ webView: WKWebView) {
            webView.window?.rootViewController?.dismiss(animated: true)
            popupWebView = nil
        }
        
        
        private func present(_ controller: UIViewController) {
            UIApplication.shared
                .connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .first?
                .rootViewController?
                .present(controller, animated: true)
        }
    }
}
