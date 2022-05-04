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
    
    @IBOutlet weak var redValueTF: UITextField! {
        didSet { redValueTF?.addDoneToolbar() }
    }
    @IBOutlet weak var greenValueTF: UITextField! {
        didSet { greenValueTF?.addDoneToolbar() }
    }
    @IBOutlet weak var blueValueTF: UITextField! {
        didSet { blueValueTF?.addDoneToolbar() }
    }
    
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
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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

extension ColorSettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFromTF = textField.text else { return }
        guard let numberFromTF = Float(textFromTF) else {
            let alert = UIAlertController(title: "Внимание!", message: "Введите верное значение цвета от 0 до 1", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alert.addAction(okBtn)
            present(alert, animated: true)
            return
        }
        
        if textField == redValueTF {
            redSlider.setValue(numberFromTF, animated: true)
            changeSlidersValue(redSlider)
        } else if textField == greenValueTF {
            greenSlider.setValue(numberFromTF, animated: true)
            changeSlidersValue(greenSlider)
        } else if textField == blueValueTF {
            blueSlider.setValue(numberFromTF, animated: true)
            changeSlidersValue(blueSlider)
        }
    }
}

extension UITextField {
    func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        self.resignFirstResponder()
    }
}
