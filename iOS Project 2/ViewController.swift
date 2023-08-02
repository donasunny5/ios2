//
//  ViewController.swift
//  iOS Project 2
//
//  Created by Mac on 2023-08-02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var WeatherStatusLabel: UILabel!
    @IBOutlet weak var citiesButton: UIButton!
    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
    }
    
    @IBAction func locationButtonTapped(_ sender: Any) {
    }
    
    @IBAction func citiesButtonTapped(_ sender: Any) {
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
    }
    
}

