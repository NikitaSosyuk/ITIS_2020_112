//
//  URLDetailsViewController.swift
//  ImageLoadingProject
//
//  Created by Teacher on 16.11.2020.
//

import UIKit
import WebKit

class URLDetailsViewController: UIViewController {
    var pageUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        webView?.frame = webViewFrame()
    }

    private var webView: WKWebView?

    private func webViewFrame() -> CGRect {
        view.bounds.inset(by: UIEdgeInsets(top: view.layoutMargins.top, left: 0, bottom: view.layoutMargins.bottom, right: 0))
    }

    private func loadURL() {
        guard let url = pageUrl else { return }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.process(data: data)
                }
            }
        }
        dataTask.resume()
    }

    private func process(data: Data) {
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Could not create documents directory url")
            return
        }

        let htmlDocumentUrl = documentsDirectoryUrl.appendingPathComponent("\(UUID().uuidString).html")
        guard FileManager.default.createFile(atPath: htmlDocumentUrl.path, contents: data) else {
            print("Could not create page at url: \(htmlDocumentUrl)")
            return
        }
        let webView = WKWebView()
        webView.loadFileURL(htmlDocumentUrl, allowingReadAccessTo: htmlDocumentUrl)
        view.addSubview(webView)
        webView.frame = webViewFrame()
    }
}
