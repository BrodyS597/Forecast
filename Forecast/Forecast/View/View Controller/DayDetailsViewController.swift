//
//  DayDetailsViewController.swift
//  Forecast
//
//  Created by Karl Pfister on 1/31/22.
//

import UIKit

class DayDetailsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var dayForcastTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentHighLabel: UILabel!
    @IBOutlet weak var currentLowLabel: UILabel!
    @IBOutlet weak var currentDescriptionLabel: UILabel!
    
    //MARK: - Properties
    var days = [Day]()
    
    //MARK: - View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayForcastTableView.dataSource = self
        dayForcastTableView.delegate = self
        
        NetworkController.fetchDays { tempDaysArray in
            guard let days = tempDaysArray else { return }
            self.days = days
            
            DispatchQueue.main.async {
                self.updateViews(index: 0)
                self.dayForcastTableView.reloadData()
            }
        }
    }
    
    func updateViews(index: Int) {
        let currentDay = days[index]
        
        cityNameLabel.text = currentDay.cityName
        currentDescriptionLabel.text = currentDay.description
        currentLowLabel.text = "\(currentDay.lTemp) F"
        currentHighLabel.text = "\(currentDay.hTemp) F"
        currentTempLabel.text = "\(currentDay.temp) F"
    }
    
}// End of class

//MARK: - Extenstions
extension DayDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as? DayForcastTableViewCell else { return UITableViewCell()}
        let day = days[indexPath.row]
        cell.updateViews(day: day)
        
        return cell
    }   
}// End of extension
