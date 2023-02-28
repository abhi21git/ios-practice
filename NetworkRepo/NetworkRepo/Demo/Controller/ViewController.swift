//
//  ViewController.swift
//  NetworkRepo
//
//  Created by Simran Rout on 19/02/23.
//

import UIKit

class ViewController: UIViewController {
    let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovieList()
    }
}

