//
//  LargeViewViewController.swift
//  ImageLoadingProject
//
//  Created by Nikita Sosyuk on 26.11.2020.
//

import UIKit

class LargeImageViewController: UIViewController, URLSessionDownloadDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var urlString: URL?
    private var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        progressView.progress = 0
    }
    
    public func loadImage() {
        guard let url = urlString else {
            return
        }
        
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let data = try? Data(contentsOf: location) {
            DispatchQueue.main.async { [weak self] in
                self?.scrollView.addSubview(UIImageView(image: UIImage(data: data)))
                self?.progressView.isHidden = true
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten / totalBytesExpectedToWrite)
        DispatchQueue.main.async { [weak self] in
            self?.progressView.setProgress(progress, animated: true)
        }
    }
}
