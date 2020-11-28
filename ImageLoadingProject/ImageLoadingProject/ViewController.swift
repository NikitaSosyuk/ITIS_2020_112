//
//  ViewController.swift
//  ImageLoadingProject
//
//  Created by Teacher on 16.11.2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    enum Row {
        case image(title: String, urlString: String)
        case largeImage(title: String, previewUrlString: String, urlString: String)
    }

    private var rows: [Row] = [
        .image(
            title: "Guinea pig",
            urlString: "https://news.clas.ufl.edu/files/2020/06/AdobeStock_345118478-copy-1440x961-1.jpg"
        ),
        .largeImage(
            title: "Large satellite photo",
            previewUrlString: "https://ichef.bbci.co.uk/news/976/cpsprodpb/F3BC/production/_113769326_1.jpg",
            urlString: "https://www.dropbox.com/s/vylo8edr24nzrcz/Airbus_Pleiades_50cm_8bit_RGB_Yogyakarta.jpg?dl=1"
        )
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ImageCell else { fatalError("Could not dequeue cell") }
        switch rows[indexPath.row] {
        case .image(let title, let urlString):
            guard let url = URL(string: urlString) else { fatalError("No correct URL") }
            cell.title = title
            cell.imageUrl = url
        case .largeImage(let title, let previewUrlString, _):
            guard let url = URL(string: previewUrlString) else { fatalError("No correct URL") }
            cell.title = title
            cell.imageUrl = url
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch rows[indexPath.row] {
        case .image:
            let detailsViewController = URLDetailsViewController()
            detailsViewController.pageUrl = URL(string: "https://news.clas.ufl.edu/uncovering-the-origin-of-the-domesticated-guinea-pig/")
            navigationController?.pushViewController(detailsViewController, animated: true)
        case .largeImage(_, _, let url):
            guard let largeImageViewController = storyboard?.instantiateViewController(identifier: "HereWasError") as? LargeImageViewController else { return }
            largeImageViewController.urlString = URL(string: url)
            navigationController?.pushViewController(largeImageViewController, animated: true)
        }

    }
}

