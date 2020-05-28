//
//  SettingsViewController.swift
//  MoviesLib
//
//  Created by Ygor Duarte Lemos Pereira on 28/05/20.
//  Copyright © 2020 Ygor Duarte Lemos Pereira. All rights reserved.
//

import UIKit

struct Key {
    private init(){}
    static let autoplay = "autoplay"
    static let color = "color"
    static let category = "category"
}

class SettingsViewController: UIViewController {

    
    // MARK: - IBOutlets
    @IBOutlet weak var switchAutoPlay: UISwitch!
    @IBOutlet weak var segmentedControlColors: UISegmentedControl!
    @IBOutlet weak var textFieldCategory: UITextField!
    
    // MARK: - Properties
    private let ud = UserDefaults.standard
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let autoplay = ud.bool(forKey: Key.autoplay)
        switchAutoPlay.setOn(autoplay, animated: true)
        
        let colorIndex = ud.integer(forKey: Key.color)
        segmentedControlColors.selectedSegmentIndex = colorIndex
        setBackground(with: colorIndex)
        
        let category = ud.string(forKey: Key.category)
        textFieldCategory.text = category
        
        textFieldCategory.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func changeAutoPlay(_ sender: UISwitch) {
        ud.set(sender.isOn, forKey: Key.autoplay)
        //ud.synchronize()
    }
    
    @IBAction func changeColors(_ sender: UISegmentedControl) {
        ud.set(sender.selectedSegmentIndex, forKey: Key.color)
        setBackground(with: sender.selectedSegmentIndex)
    }
    
    @IBAction func changeCategory(_ sender: UITextField) {
        saveCategory()
    }
    
    // MARK: - Methods
    private func saveCategory() {
        ud.set(textFieldCategory.text!, forKey: Key.category)
    }
    
    private func setBackground(with colorIndex: Int) {
        switch colorIndex {
        case 0:
            view.backgroundColor = .white
        case 1:
            view.backgroundColor = .orange
        case 2:
            view.backgroundColor = .blue
        default:
            view.backgroundColor = .white
        }
    }
    
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldCategory.resignFirstResponder()
        saveCategory()
        return true
    }
}
