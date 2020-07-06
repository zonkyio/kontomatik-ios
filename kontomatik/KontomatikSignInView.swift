//
//  KontomatikSignInView.swift
//  kontomatik
//
//  Created by Lukas Gergel on 28/02/2019.
//  Copyright © 2019 Zonky a.s. All rights reserved.
//

import WebKit

public protocol KontomatikSignInDelegate: class {
    func loadingStarted(in view: KontomatikSignInView)
    func loadingCompleted(in view: KontomatikSignInView)
    func onKontomatikInitialized(in view: KontomatikSignInView)
    func signInCompleted(in view: KontomatikSignInView, target: String, sessionId: String, sessionIdSignature: String)
    func onError(in view: KontomatikSignInView, error: Error)
}

public class KontomatikSignInView: UIView, WKNavigationDelegate, WKScriptMessageHandler {
    private weak var _webView: WKWebView!

    public var webView: WKWebView { _webView }

    public weak var delegate: KontomatikSignInDelegate!

    public var configuration: KontomatikSignInConfiguration? {
        didSet {
            setupView()
        }
    }

    public var showLoadingOverlay: Bool = false

    // MARK: Initializers

    public init() {
        super.init(frame: .zero)

        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "success")
        userContentController.add(self, name: "error")
        config.userContentController = userContentController

        let webView = WKWebView(frame: .zero, configuration: config)
        addSubview(webView)
        webView.bindToSuperviewEdges()
        _webView = webView
        webView.navigationDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private helpers

    private func setupView() {
        let bundle = Bundle(for: KontomatikSignInView.self)
        if let path = bundle.path(forResource: "kontomatik", ofType: "html") {
            let htmlUrl = URL(fileURLWithPath: path, isDirectory: false)
            _webView.loadFileURL(htmlUrl, allowingReadAccessTo: htmlUrl)
        }
    }

    // MARK: WebView helpers

    func setParameters(_ parameters: [String: Any]) {
        // Convert swift dictionary into encoded json
        let serializedData = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        let encodedData = serializedData.base64EncodedString(options: .endLineWithLineFeed)
        // This WKWebView API to calls 'setParameters' function defined in js
        _webView.evaluateJavaScript("setParameters('\(encodedData)')", completionHandler: { [weak self] _, error in
            guard let `self` = self else { return }
            if let error = error {
                self.delegate?.onError(in: self, error: error)
            }
        })
    }

    func startKontomatik() {
        _webView.evaluateJavaScript("start()")
    }

    // MARK: WKNavigationDelegate

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        delegate?.onError(in: self, error: error)
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        delegate?.loadingStarted(in: self)
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        delegate?.onError(in: self, error: error)
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let config = configuration {
            DispatchQueue.main.async { [weak self] in
                let parameters = config.toDict()
                self?.setParameters(parameters)
                self?.startKontomatik()
            }
        }
        delegate?.loadingCompleted(in: self)
    }

    // MARK: WKScriptMessageHandler

    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let messageBody = message.body as? String {
            if messageBody == "initialized" {
                delegate?.onKontomatikInitialized(in: self)
            } else if messageBody.starts(with: "success,") {
                let message = messageBody.split(separator: ",").map { String($0) }
                delegate?.signInCompleted(in: self, target: message[1], sessionId: message[2], sessionIdSignature: message[3])
            } else {
                let error = NSError(domain: "kontomatik.unknown", code: 0, userInfo: [NSLocalizedDescriptionKey: messageBody])
                delegate?.onError(in: self, error: error)
            }
        }
    }
}

private extension UIView {
    func bindToSuperviewEdges(inset: CGFloat = 0.0) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil")
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11, *) {
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: inset).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -inset).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: inset).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -inset).isActive = true
        } else {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: inset).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -inset).isActive = true
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: inset).isActive = true
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -inset).isActive = true
        }
    }
}
