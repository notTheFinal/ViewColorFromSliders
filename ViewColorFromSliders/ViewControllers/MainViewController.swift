//
//  MainViewController.swift
//  ViewColorFromSliders
//
//  Created by Александр on 03.05.2022.
//

import UIKit

protocol ColorSettingsViewControllerDelegate {
    func setNewVCColor(for viewColor: UIColor)
}

class MainViewController: UIViewController {
    
    @IBOutlet var mainVC: UIView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorSettingsVC = segue.destination as? ColorSettingsViewController else { return }
        colorSettingsVC.delegate = self
        colorSettingsVC.mainVCColor = mainVC.backgroundColor
    }
    
}

extension MainViewController: ColorSettingsViewControllerDelegate {
    func setNewVCColor(for viewColor: UIColor) {
        mainVC.backgroundColor = viewColor
    }
}
