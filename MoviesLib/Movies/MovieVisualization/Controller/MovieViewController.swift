//
//  ViewController.swift
//  MoviesLib
//
//  Created by Ygor Duarte Lemos Pereira on 20/05/20.
//  Copyright © 2020 Ygor Duarte Lemos Pereira. All rights reserved.
//

import UIKit

class MoviewViewController: UIViewController {

    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCategories: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var textViewSummary: UITextView!

    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            
        
        if let movie = movie {
            imageViewPoster.image = movie.poster
            labelTitle.text = movie.title
            if let categories = movie.categories as? Set<Category>, categories.count > 0 {
                labelCategories.text = categories.compactMap({$0.name}).joined(separator: " | ")
            } else {
                labelCategories.text = ""
            }
            labelRating.text = movie.ratingFormatted
            textViewSummary.text = movie.summary
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieAdditionViewController {
            vc.movie = self.movie
        }
    }
    
}

