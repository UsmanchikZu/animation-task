//
//  ViewController.swift
//  animation
//
//  Created by aeroclub on 07.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private var allView = UIView()
    
    private var squareView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .purple
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        
        slider.addTarget(self, action: #selector(rotation), for: .valueChanged)
        slider.addTarget(self, action: #selector(end), for: [.touchUpInside, .touchUpOutside])
        slider.minimumValue = 0
        slider.maximumValue = 1
        
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        setup()
    }
    
    private func setup() {
        view.addSubview(allView)
        allView.addSubview(squareView)
        view.addSubview(slider)
        
        allView.translatesAutoresizingMaskIntoConstraints = false
        squareView.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        squareView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        NSLayoutConstraint.activate([
            
            allView.leftAnchor.constraint(equalTo:view.layoutMarginsGuide.leftAnchor),
            allView.rightAnchor.constraint (equalTo: view.layoutMarginsGuide .rightAnchor) ,
            allView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            allView.heightAnchor.constraint(equalToConstant: 200),
            
            slider.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            slider.rightAnchor.constraint(equalTo:view.layoutMarginsGuide.rightAnchor),
            slider.topAnchor.constraint(equalTo: allView.bottomAnchor,constant: 50)
        ])
    }
    
    
    private func gestures (sliderValue: Float) {
        let gestures = CGFloat(sliderValue) * (allView.frame.width - squareView.frame.width) + squareView.frame.width / 2
        squareView.center.x = gestures
    }
    
    private func changeView(sliderValue: Float) {
        let scale = 1 + CGFloat(sliderValue / 2)
        squareView.transform = CGAffineTransformRotate(
            CGAffineTransform(scaleX: scale, y: scale),
            CGFloat(sliderValue) * CGFloat.pi / 2
        )
    }
    
    @objc
    private func rotation(_ slider: UISlider) {
        changeView(sliderValue:slider.value)
        gestures(sliderValue: slider.value)
    }
    
    @objc
    private func end(_ slider: UISlider) {
        let maximumValue = slider.maximumValue
        
        UIView.animate(withDuration: TimeInterval(1 - slider.value)) {
            self.changeView(sliderValue: maximumValue)
            
            self.gestures(sliderValue: maximumValue)
            self.slider.setValue (maximumValue, animated: true)
        }
    }
}
