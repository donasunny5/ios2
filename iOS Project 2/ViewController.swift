//
//  ViewController.swift
//  iOS Project 2
//
//  Created by Mac on 2023-08-02.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var WeatherStatusLabel: UILabel!
    @IBOutlet weak var citiesButton: UIButton!
    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    
    var locationManager: CLLocationManager?
    var weatherModel: WeatherModel?
    
    var selectedCityList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        if let segmentContol = sender as? UISegmentedControl,
           let weatherModel = weatherModel {
            if segmentContol.selectedSegmentIndex == 0 {
                self.tempratureLabel.text = "\(weatherModel.current?.tempC ?? 0)"
            } else {
                self.tempratureLabel.text = "\(weatherModel.current?.tempF ?? 0)"
            }
        }
    }
    
    @IBAction func locationButtonTapped(_ sender: Any) {
        locationManager?.requestAlwaysAuthorization()
        if let latitude = locationManager?.location?.coordinate.latitude,
           let longitude = locationManager?.location?.coordinate.longitude {
            let cityName = "\(latitude),\(longitude)"
            NetworkLayer.singleton.getCityWeatherFor(cityName: cityName) { weatherModel, _ in
                guard let weatherModel = weatherModel else { return }
                self.weatherModel = weatherModel
                self.updateScreenData(weatherModel: weatherModel)
            }
        }
    }
    
    func updateScreenData(weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.WeatherStatusLabel.text = weatherModel.current?.condition?.text ?? ""
            self.tempratureLabel.text = "\(weatherModel.current?.tempC ?? 0)"
            self.cityName.text = weatherModel.location?.name ?? ""
            self.weatherImageView.image = multiColorImageFor(code: weatherModel.current?.condition?.code ?? 0)
        }
    }

    
    @IBAction func citiesButtonTapped(_ sender: Any) {
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
    }
    
    func alert(message: String, title: String = "") {
      let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
      alertVC.addAction(ok)
      self.present(alertVC, animated: true, completion: nil)
    }
}


func multiColorImageFor(code: Int) -> UIImage? {
    let configuration =  UIImage.SymbolConfiguration.preferringMulticolor()
    switch code {
    case 1000:
        return UIImage(systemName: "sun.max.fill", withConfiguration: configuration)
    case 1003:
        return UIImage(systemName: "cloud.sun.fill", withConfiguration: configuration)
    case 1006,
        1030:
        return UIImage(systemName: "cloud.fill")
    case 1009,
        1135:
        return UIImage(systemName: "smoke.fill", withConfiguration: configuration)
    case 1063,
        1087,
        1150,
        1153,
        1180,
        1183,
        1186,
        1192:
        return UIImage(systemName: "cloud.bolt.rain.fill", withConfiguration: configuration)
    case 1066,
        1072,
        1147,
        1168,
        1171,
        1210,
        1213,
        1216:
        return UIImage(systemName: "snowflake")
    default:
        return UIImage(systemName: "cloud.bolt.rain.fill", withConfiguration: configuration)
    }
}
