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
        let newX = CGFloat(sliderValue) * (allView.frame.width - squareView.frame.width) + squareView.frame.width / 2
        squareView.center.x = newX
        }

        private func changeView(sliderValue: Float) {
            let scale = 5 + CGFloat(sliderValue / 1)
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
    
    // Целевой метод для слайдера
    //    @objc func sliderValueChanged() {
    //        // Получаем значение слайдера
    ////        let sliderValue = slider.value
    //
    //        // Создаем анимацию для вьюхи
    //        UIView.animate(withDuration: 0.5, animations: {
    //            // Смещаем вьюху вправо
    //            self.squareView.transform = CGAffineTransform(translationX: self.view.frame.width - self.squareView.frame.width - 20, y: 0)
    //
    //            // Увеличиваем размер вьюхи
    //            self.squareView.transform = self.squareView.transform.scaledBy(x: 1.5, y: 1.5)
    //
    //            // Поворачиваем вьюху
    //            self.squareView.transform = self.squareView.transform.rotated(by: CGFloat.pi / 2)
    //        })
    //    }
//    private func gestures (_ sender: UISlider) {
//        let progress = CGFloat(sender.value)
//        
////        let sliderValue = CGFloat(slider.value)
////        let newX = CGFloat(sliderValue) * (allView.frame.width - squareView.frame.width) + squareView.frame.width / 2
//        //        squareView.center.x = newX
//        squareView.transform = CGAffineTransform(rotationAngle: sliderValue * CGFloat.pi / 2)
//
//                // Увеличение
//                squareView.transform = squareView.transform.scaledBy(x: 1 + sliderValue * 0.5, y: 1 + sliderValue * 0.5)
//
//                // Перемещение
//                let offsetX = sliderValue * squareView.frame.width * 1.5 - (sliderValue * squareView.frame.width * 0.5)
//                squareView.frame.origin.x = offsetX
//
//
//    }
//    
//    private func changeView(sliderValue: Float) {
//        let scale = 1 + CGFloat(sliderValue / 2)
//        squareView.transform = CGAffineTransformRotate(
//            CGAffineTransform(scaleX: scale, y: scale),
//            CGFloat(sliderValue) * CGFloat.pi / 2
//        )
//    }
//    
//    @objc
//    private func rotation(_ slider: UISlider) {
//        changeView(sliderValue:slider.value)
//        gestures(sliderValue: slider.value)
//    }
//    
//    @objc
//    private func end(_ slider: UISlider) {
//        let maximumValue = slider.maximumValue
//        
//        UIView.animate(withDuration: TimeInterval(1 - slider.value)) {
//            self.changeView(sliderValue: maximumValue)
//            
//            self.gestures(sliderValue: maximumValue)
//            self.slider.setValue (maximumValue, animated: true)
//        }
//    }
    
//    @objc func sliderValueChanged() {
//        
//        let maximumValue = slider.maximumValue
//        
//        UIView.animate(withDuration: TimeInterval(1 - slider.value)) {
//            self.changeView(sliderValue: maximumValue)
//            
//            self.gestures(sliderValue: maximumValue)
//            self.slider.setValue (maximumValue, animated: true)
//        }
//        let sliderValue = CGFloat(slider.value)
//        
//        squareView.transform = CGAffineTransform(translationX: sliderValue * (view.frame.width - squareView.frame.width - 20), y: 0)
//            .scaledBy(x: 1 + sliderValue * 0.5, y: 1 + sliderValue * 0.5)
//            .rotated(by: CGFloat.pi / 2 * sliderValue)

    
//    @objc func sliderValueEnded() {
//
//        UIView.animate(withDuration: 0.5, animations: {
//
//            self.squareView.transform = CGAffineTransform(translationX: self.view.frame.width - self.squareView.frame.width - 20, y: 0)
//
//            self.squareView.transform = self.squareView.transform.scaledBy(x: 1.5, y: 1.5)
//
//            self.squareView.transform = self.squareView.transform.rotated(by: CGFloat.pi / 2)
//        })
//    }
    
    //        }
    
    
    

