//
//  PremiumContacts.swift
//  D2020
//
//  Created by Macbook on 3/4/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit


class MyStoreWorkday: BaseController {
    
    @IBOutlet weak var workdayLbl: UILabel!
    @IBOutlet weak var workDescLbl: UILabel!
    @IBOutlet weak var daysCollection: UICollectionView!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var dayInfoLbl: UILabel!
    @IBOutlet weak var noteLbl: UILabel!
    
    static weak var instance: MyStoreWorkday?
    var selectedDay: Int = 0
    var days: [String] = [
        Localizations.saturday.localized,
        Localizations.sunday.localized,
        Localizations.monday.localized,
        Localizations.tuesday.localized,
        Localizations.wednesday.localized,
        Localizations.thursday.localized,
        Localizations.friday.localized
    ]
    override func viewDidLoad() {
        super.hiddenNav = true
        super.viewDidLoad()
        MyStoreWorkday.instance = self
        setup()
    }
    func setup() {
        workdayLbl.text = Localizations.daywork.localized
        workDescLbl.text = Localizations.daydesc.localized
        
        daysCollection.delegate = self
        daysCollection.dataSource = self

    }
    func reload() {
        daysCollection.reloadData()
    }
    func setupDayInfo() {
        let workDay = self.getStoreWorkDaySelected(path: selectedDay)
        
        let str = "\(Localizations.day.localized) \(days[selectedDay])"
        let string = NSMutableAttributedString(string: str)
        if workDay?.type == 1 {
            string.setColorForText(days[selectedDay], with: .appOrange)
        } else {
            string.setColorForText(days[selectedDay], with: .appRed)
        }
        dayLbl.attributedText = string
        
        if workDay != nil {
            let str = "\(Localizations.hour.localized) \(workDay?.from ?? "") ----------- \(Localizations.hour.localized) \(workDay?.to ?? "")"
            let string = NSMutableAttributedString(string: str)
            string.setColorForText(Localizations.hour.localized, with: .textColor)
            string.setColorForText(workDay?.from ?? "", with: .black)
            string.setColorForText("-----------", with: .textColor)
            string.setColorForText(workDay?.to ?? "", with: .black)
            string.setColorForText(Localizations.hour.localized, with: .textColor)
            dayInfoLbl.attributedText = string
            noteLbl.text = workDay?.note
        } else {
            dayInfoLbl.text = Localizations.storeClosed.localized
            noteLbl.text = ""
        }
    }
    func getStoreWorkDaySelected(path: Int) -> StoreDetail.Days? {
        for item in MyStorePremuimController.storePrem?.days ?? [] {
            switch path {
                case 0:
                    if item.key == "sat" {
                        return item
                }
                case 1:
                    if item.key == "sun" {
                        return item
                }
                case 2:
                    if item.key == "mon" {
                        return item
                }
                case 3:
                    if item.key == "tue" {
                        return item
                }
                case 4:
                    if item.key == "wed" {
                        return item
                }
                case 5:
                    if item.key == "thu" {
                        return item
                        
                    }
                case 6:
                    if item.key == "fri" {
                        return item
                    }
                default:
                    return nil
            }
        }
        
        return nil
    }
}

extension MyStoreWorkday: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 4 - 25, height: 80)

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.cell(type: StoreWorkdayCell.self, indexPath)
        cell.model = days[indexPath.row]
        setupCell(cell: cell, path: indexPath.row)
        if selectedDay == indexPath.row {
            setupDayInfo()
            cell.viewColored.borderColor = .appOrange
            cell.viewColored.borderWidth = 1
        } else {
            cell.viewColored.borderColor = .appOrange
            cell.viewColored.borderWidth = 0
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDay = indexPath.row
        collectionView.reloadData()
    }
    func setupColorOfCell(cell: StoreWorkdayCell, type: Int?) {
        if type == 0 {
            cell.viewColored.backgroundColor = .appRed
            cell.image.image = UIImage(named: "close")
        } else {
            cell.viewColored.backgroundColor = .appOrange
            cell.image.image = UIImage(named: "check (2)")
        }
    }
    func setupCell(cell: StoreWorkdayCell, path: Int) {
        MyStorePremuimController.storePrem?.days?.forEach({ (item) in
            switch path {
                case 0:
                    if item.key == "sat" {
                        setupColorOfCell(cell: cell, type: item.type)
                    }
                case 1:
                    if item.key == "sun" {
                        setupColorOfCell(cell: cell, type: item.type)
                    }
                case 2:
                    if item.key == "mon" {
                        setupColorOfCell(cell: cell, type: item.type)
                    }
                case 3:
                    if item.key == "tue" {
                        setupColorOfCell(cell: cell, type: item.type)
                }
                case 4:
                    if item.key == "wed" {
                        setupColorOfCell(cell: cell, type: item.type)
                }
                case 5:
                    if item.key == "thu" {
                        setupColorOfCell(cell: cell, type: item.type)

                    }
                case 6:
                    if item.key == "fri" {
                        setupColorOfCell(cell: cell, type: item.type)
                    }
                default:
                    break
            }
        })
    }
}



