//
//  updateProfileViewController.swift
//  d2020
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class updateProfileViewController: UIViewController {
    @IBOutlet weak var Button1: UIButton!
    
    @IBOutlet weak var Button2: UIButton!
    
    @IBOutlet weak var Button3: UIButton!
    
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var BackGround: RoundedShadowView!
   
    @IBOutlet weak var BackGround2: RoundedShadowView!
    
    @IBOutlet weak var BackGround3: RoundedShadowView!
    
    @IBOutlet weak var BackGround4: RoundedShadowView!
    
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var whiteView2: UIView!
    
    @IBOutlet weak var whiteView3: UIView!
    
    @IBOutlet weak var whiteView4: UIView!
    
    @IBOutlet weak var confirmButton: RoundedButton!
    var color:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        BackGround.layer.cornerRadius = 7
        BackGround2.layer.cornerRadius = 7
        BackGround3.layer.cornerRadius = 7
        BackGround4.layer.cornerRadius = 7
        whiteView.layer.cornerRadius = 7
        whiteView2.layer.cornerRadius = 7
        whiteView3.layer.cornerRadius = 7
        whiteView4.layer.cornerRadius = 7
    }
    override func viewDidDisappear(_ animated: Bool) {
        whiteView.backgroundColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        whiteView2.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        whiteView3.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        whiteView4.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        BackGround.backgroundColor =  #colorLiteral(red: 0.4705447555, green: 0.4706160426, blue: 0.4705291986, alpha: 1)
        BackGround2.backgroundColor = #colorLiteral(red: 0.4705447555, green: 0.4706160426, blue: 0.4705291986, alpha: 1)
        BackGround3.backgroundColor = #colorLiteral(red: 0.4705447555, green: 0.4706160426, blue: 0.4705291986, alpha: 1)
        BackGround3.backgroundColor = #colorLiteral(red: 0.4705447555, green: 0.4706160426, blue: 0.4705291986, alpha: 1)
    }
    
    
    @IBAction func onButton1Tapped(_ sender: Any) {
        whiteView.backgroundColor = #colorLiteral(red: 0.9634763598, green: 0.6230384707, blue: 0, alpha: 1)
        BackGround.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        confirmButton.backgroundColor = #colorLiteral(red: 0.9634763598, green: 0.6230384707, blue: 0, alpha: 1)
        
    }
    
    @IBAction func onButton2Tapped(_ sender: Any) {
        whiteView2.backgroundColor = #colorLiteral(red: 0.9634763598, green: 0.6230384707, blue: 0, alpha: 1)
        BackGround2.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        confirmButton.backgroundColor = #colorLiteral(red: 0.9634763598, green: 0.6230384707, blue: 0, alpha: 1)

    }
    @IBAction func onButton3Tapped(_ sender: Any) {
        whiteView3.backgroundColor = #colorLiteral(red: 0.9634763598, green: 0.6230384707, blue: 0, alpha: 1)
        BackGround3.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        confirmButton.backgroundColor = #colorLiteral(red: 0.9634763598, green: 0.6230384707, blue: 0, alpha: 1)

    }
    @IBAction func onButton4Tapped(_ sender: Any) {
        whiteView4.backgroundColor = #colorLiteral(red: 0.9634763598, green: 0.6230384707, blue: 0, alpha: 1)
        BackGround4.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        confirmButton.backgroundColor = #colorLiteral(red: 0.9634763598, green: 0.6230384707, blue: 0, alpha: 1)

    }
    
}
