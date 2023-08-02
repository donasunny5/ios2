//
//  CityListViewController.swift
//  iOS Project 2
//
//  Created by Mac on 2023-08-02.
//

import UIKit

class CityListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var cityListTableView: UITableView!
    
    var cityNameList = [String]()
    var weatherDataArray = [WeatherModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        cityListTableView.delegate = self
        cityListTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        let weatherModel = weatherDataArray[indexPath.row]
        cell.cityNameLabel.text = (weatherModel.location?.name ?? "") + " " + "\(weatherModel.current?.tempC ?? 0) C"
        cell.weatherImageView.image = multiColorImageFor(code: weatherModel.current?.condition?.code ?? 0)
        return cell
    }
}
