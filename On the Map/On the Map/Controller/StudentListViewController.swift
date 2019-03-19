//
//  StudentListViewController.swift
//  On the Map
//
//  Created by John Berndt on 3/18/19.
//  Copyright © 2019 John Berndt. All rights reserved.
//

import UIKit

class StudentListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension StudentListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return MovieModel.watchlist.count
          return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentListTableViewCell")!
        
//        let movie = MovieModel.watchlist[indexPath.row]
//
//        cell.textLabel?.text = movie.title
//        cell.imageView?.image = UIImage(named: "PosterPlaceholder")
//        if let posterPath = movie.posterPath {
//            TMDBClient.downloadPosterImage(path: posterPath) { data, error in
//                guard let data = data else {
//                    return
//                }
//                let image = UIImage(data: data)
//                cell.imageView?.image = image
//                cell.setNeedsLayout()
//            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
