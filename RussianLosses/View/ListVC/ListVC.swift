//
//  ListVC.swift
//  RussianLosses
//
//  Created by Anatoliy Khramchenko on 23.07.2022.
//

import UIKit

class ListVC: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    private var lossesData = [LossesData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Russian losses"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        loadData()
    }
    
    ///Load data to variable lossesData
    private func loadData() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                //error
                return
            }
            NetworkManager.shared.getData(fromFile: .equipment) { (equipmentData: [LossesEquipmentData]) in
                NetworkManager.shared.getData(fromFile: .personnel) { (personnelData: [LossesPersonnelData]) in
                    self.lossesData = self.combineData(equipments: equipmentData, personnels: personnelData)
                    DispatchQueue.main.async {
                        print(self.lossesData)
                    }
                } onError: { message in
                    print(message)//
                }
            } onError: { message in
                print(message)//
            }
        }
    }
    
    ///Combine and sort equipment and personnel data
    private func combineData(equipments: [LossesEquipmentData], personnels: [LossesPersonnelData]) -> [LossesData] {
        var result = [LossesData]()
        let sortEquipments = equipments.sorted { firstElement, secondElement in
            return firstElement.day > secondElement.day
        }
        for equipmentData in sortEquipments {
            let index = personnels.firstIndex { personnelData in
                return equipmentData.day == personnelData.day
            }
            if let index = index {
                result.append(LossesData(
                    date: equipmentData.date,
                    day: equipmentData.day,
                    equipment: equipmentData,
                    personnel: personnels[index]
                ))
            }
        }
        return result
    }

}
