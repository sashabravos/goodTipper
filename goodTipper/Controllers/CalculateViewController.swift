//
//  CalculateViewController.swift
//  goodTipper
//
//  Created by Александра Кострова on 04.03.2023.
//

import UIKit

final class CalculateViewController: UIViewController {
    
    private var myView = MyView()
    
    public lazy var tip = 0.10
    public lazy var people = 2
    public lazy var totalBillAsANumber = Double()
    public lazy var finalResult = "0.0"
    
    private lazy var secondView: UIView = {
        let view = myView.makeAnotherView()
        
        view.addSubview(middleStackView)
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var topStackView: UIStackView = {
        let stackView = myView.makeStackView(MyView.Constants.verticalSVSpacing,
                                             .vertical, .center, .fill)
        
        [billEnter, billTF].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    private lazy var middleStackView: UIStackView = {
        let stackView = myView.makeStackView(MyView.Constants.verticalSVSpacing,
                                             .vertical, .center, .fill)
        
        [tipLabel, tipSV, splitLabel, splitSV].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    private lazy var tipSV: UIStackView = {
        let stackView = myView.makeStackView(MyView.Constants.tipSVSpacing,
                                             .horizontal, .fill, .fillEqually)
        
        [smallTip, middleTip, bigTip].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    private lazy var splitSV: UIStackView = {
        let stackView = myView.makeStackView(MyView.Constants.splitSVSpacing,
                                             .horizontal, .fill, .fillEqually)
        
        [numberOfPeople, stepper].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    
    private lazy var tipLabel = myView.makeLabel("Select tip", .natural, .lightGray,
                                              MyView.Constants.lightGreyLabelFontSize)
    private lazy var splitLabel = myView.makeLabel("Choose split", .natural, .lightGray,
                                                MyView.Constants.lightGreyLabelFontSize)
    private lazy var numberOfPeople = myView.makeLabel("2", .center,
                                                       MyView.Constants.primaryTextColor,
                                                       MyView.Constants.buttonFontSize)
    private lazy var billEnter = myView.makeLabel("Enter total bill", .left,
                                               MyView.Constants.primaryTextColor,
                                               MyView.Constants.buttonFontSize)
    
    public lazy var billTF = myView.makeTextField()
    
    private lazy var calculateButton: UIButton = {
        let button = myView.makeLargeButton("Calculate")
        button.addTarget(self, action: #selector(self.calculatePressed(button:)), for: .touchUpInside)
        return button
    }()
    public lazy var smallTip: UIButton = {
        let button = myView.makeTipButton("5%")
        button.addTarget(self, action: #selector(tipChanged(tipButton:)), for: .touchUpInside)
        return button
    }()
    public lazy var middleTip: UIButton = {
        let button = myView.makeTipButton("10%")
        button.addTarget(self, action: #selector(tipChanged(tipButton:)), for: .touchUpInside)
        return button
    }()
    public lazy var bigTip: UIButton = {
        let button = myView.makeTipButton("20%")
        button.addTarget(self, action: #selector(tipChanged(tipButton:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var stepper: UIStepper = {
        let stepper = myView.makeStepper()
        stepper.addTarget(self, action: #selector(stepperChanged(stepper:)), for: .touchUpInside)
        return stepper
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCalculateSubviews()
    }
    
    private func setCalculateSubviews() {
        view.backgroundColor = .white
        stepper.value = 2.0
        stepper.stepValue = 1.0
        
        [secondView, topStackView, calculateButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            secondView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            secondView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 40.0),
            secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            topStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            middleStackView.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 20.0),
            middleStackView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20.0),
            secondView.trailingAnchor.constraint(equalTo: middleStackView.trailingAnchor, constant: 20.0),
            
            tipLabel.heightAnchor.constraint(equalToConstant: 30.0),
            tipLabel.leadingAnchor.constraint(equalTo: middleStackView.leadingAnchor, constant: 30.0),
            middleStackView.trailingAnchor.constraint(equalTo: tipLabel.trailingAnchor, constant: 30.0),
            
            splitLabel.leadingAnchor.constraint(equalTo: middleStackView.leadingAnchor, constant: 30.0),
            splitLabel.trailingAnchor.constraint(equalTo: middleStackView.trailingAnchor, constant: 30.0),
            splitLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            tipSV.trailingAnchor.constraint(equalTo: middleStackView.trailingAnchor),
            tipSV.leadingAnchor.constraint(equalTo: middleStackView.leadingAnchor),
            tipSV.heightAnchor.constraint(equalToConstant: 40.0),
            
            smallTip.heightAnchor.constraint(equalToConstant: MyView.Constants.tipButtonHeight),
            smallTip.widthAnchor.constraint(greaterThanOrEqualToConstant: 60.0),
            middleTip.heightAnchor.constraint(equalToConstant: MyView.Constants.tipButtonHeight),
            bigTip.heightAnchor.constraint(equalToConstant: MyView.Constants.tipButtonHeight),
            bigTip.widthAnchor.constraint(equalTo: smallTip.widthAnchor),
            
            numberOfPeople.heightAnchor.constraint(equalToConstant: 29.0),
            numberOfPeople.widthAnchor.constraint(equalToConstant: 93.0),
            
            stepper.heightAnchor.constraint(equalToConstant: 29.0),
            stepper.widthAnchor.constraint(equalToConstant: 94.0),
            
            billEnter.heightAnchor.constraint(equalToConstant: 30.0),
            billEnter.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor, constant: 50.0),
            billEnter.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor, constant: 50.0),
            
            billTF.heightAnchor.constraint(equalToConstant: 48.0),
            billTF.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor),
            billTF.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor),
            
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            calculateButton.heightAnchor.constraint(equalToConstant: 54.0),
            calculateButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200.0)
        ])
    }
    
    @objc func tipChanged(tipButton: UIButton) {
        billTF.endEditing(true)
        
        [ smallTip, middleTip, bigTip ].forEach {
            $0.isSelected = false
            $0.backgroundColor = .clear
        }
        
        tipButton.isSelected = true
        tipButton.backgroundColor = MyView.Constants.primaryTextColor
        
        let buttonTitle = tipButton.currentTitle!
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        tip = buttonTitleAsANumber / 100
    }
    
    @objc func stepperChanged(stepper: UIStepper) {
        people = Int(stepper.value)
        numberOfPeople.text = String(people)
    }
    
    @objc func calculatePressed(button: UIButton) {
        let bill = billTF.text!
        if bill != "" {
            totalBillAsANumber = Double(bill)!
            let result = totalBillAsANumber * tip / Double(people)
            finalResult = String(format: "%.2f", result)
        }
        
        let resultVC = ResultViewController()
        resultVC.result = finalResult
        resultVC.people = people
        resultVC.tip = tip
        
        present(resultVC, animated: true, completion: nil)
    }
}
