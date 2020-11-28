//
//  ImageCell.swift
//  ImageLoadingProject
//
//  Created by Teacher on 16.11.2020.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet private var customTitleLabel: UILabel!
    @IBOutlet private var customImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()

        imageView?.image = nil
        dataTask?.cancel()
    }
    
    var imageUrl: URL? {
        didSet {
            loadImage()
        }
    }

    var title: String? {
        didSet {
            customTitleLabel.text = title
        }
    }

    private var dataTask: URLSessionDataTask?

    private func loadImage() {
        guard let url = imageUrl else { return }

        dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.customImageView.image = image
                }
            }
        }
        dataTask?.resume()
    }
}
