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
    var mainVCColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainVCColors()
        refreshLabelsAndTF(redSlider.value, greenSlider.value, blueSlider.value)
        setColorView()
    }
    
    @IBAction func changeSlidersValue(_ sender: UISlider) {
        setColorView()
        refreshLabelsAndTF(redSlider.value, greenSlider.value, blueSlider.value)
    }
    
    @IBAction func doneButton() {
        guard let viewColor = colorfulView.backgroundColor else { return }
        delegate.setNewVCColor(for: viewColor)
        dismiss(animated: true)
    }
    
    func setMainVCColors() {
        let ciColor = CIColor(color: mainVCColor)
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    func setColorView() {
        colorfulView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                               green: CGFloat(greenSlider.value),
                                               blue: CGFloat(blueSlider.value),
                                               alpha: 1)
    }
    func refreshLabelsAndTF(_ red: Float, _ green: Float, _ blue: Float) {
        redValueLabel.text = String(format: "%.2f", red)
        greenValueLabel.text = String(format: "%.2f", green)
        blueValueLabel.text = String(format: "%.2f", blue)
        
        redValueTF.text = String(format: "%.2f", red)
        greenValueTF.text = String(format: "%.2f", green)
        blueValueTF.text = String(format: "%.2f", blue)
    }
}
