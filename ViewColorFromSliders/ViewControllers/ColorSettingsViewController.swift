//
//  ViewController.swift
//  ViewColorFromSliders
//
//  Created by Александр on 29.03.2022.
//

import UIKit

class ColorSettingsViewController: UIViewController {
    @IBOutlet weak var colorfulView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redValueTF: UITextField!
    @IBOutlet weak var greenValueTF: UITextField!
    @IBOutlet weak var blueValueTF: UITextField!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var delegate: ColorSettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshLabels(redSlider.value, greenSlider.value, blueSlider.value)
        
        setColorView()
    }
    
    @IBAction func changeSlidersValue(_ sender: UISlider) {
        setColorView()
        refreshLabels(redSlider.value, greenSlider.value, blueSlider.value)
    }
    
    @IBAction func doneButton() {
        guard let viewColor = colorfulView.backgroundColor else { return }
        delegate.setNewVCColor(for: viewColor)
        dismiss(animated: true)
    }
    
    func setColorView() {
        colorfulView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                               green: CGFloat(greenSlider.value),
                                               blue: CGFloat(blueSlider.value),
                                               alpha: 1)
    }
    func refreshLabels(_ red: Float, _ green: Float, _ blue: Float) {
        redValueLabel.text = String(format: "%.2f", red)
        greenValueLabel.text = String(format: "%.2f", green)
        blueValueLabel.text = String(format: "%.2f", blue)
    }
}
