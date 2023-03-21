//
//  CaculateView.swift
//  goodTipper
//
//  Created by Александра Кострова on 15.03.2023.
//

import UIKit

protocol CalculateViewDelegate: AnyObject {
    
    func calculateButtonPressed(button: UIButton)
    func tipButtonChanged(tipButton: UIButton)
    func stepperValueChanged(stepper: UIStepper)
}

final class CalculateView: UIView {
    
    private var myView = MyView()
    var delegate: CalculateViewDelegate?
    
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
        let stackView = myView.makeStackView(MyView.Constants.tipSVspacing,
                                             .horizontal, .fill, .fillEqually)
        
        [smallTip, middleTip, bigTip].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    private lazy var splitSV: UIStackView = {
        let stackView = myView.makeStackView(MyView.Constants.splitSVspacing,
                                             .horizontal, .fill, .fillEqually)
        
        [numberOfPeple, stepper].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    
    private let tipLabel = MyView().makeLabel("Select tip", .natural, .lightGray,
                                              MyView.Constants.lightGreyLabelFontSize)
    private let splitLabel = MyView().makeLabel("Choose split", .natural, .lightGray,
                                                MyView.Constants.lightGreyLabelFontSize)
    public let numberOfPeple = MyView().makeLabel("2", .center,
                                                  MyView.Constants.primaryTextColor,
                                                  MyView.Constants.buttonFontSize)
    private let billEnter = MyView().makeLabel("Enter total bill", .left,
                                               MyView.Constants.primaryTextColor,
                                               MyView.Constants.buttonFontSize)
    
    public lazy var billTF = MyView().makeTextField()
     
    private lazy var calculateButton: UIButton = {
        let button = myView.makeLargeButton("Calculate")
        button.addTarget(self, action: #selector(self.calculatePressed(button:)), for: .touchUpInside)
        return button
    }()
    public lazy var smallTip: UIButton = {
        let button = myView.makeTipButton("0%")
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setCalculateSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCalculateSubviews() {
        self.backgroundColor = .white
        self.stepper.value = 2.0
        self.stepper.stepValue = 1.0
        
        [self.secondView, self.topStackView, self.calculateButton].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            secondView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            secondView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 40.0),
            secondView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            secondView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            topStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            topStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
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
            
            numberOfPeple.heightAnchor.constraint(equalToConstant: 29.0),
            numberOfPeple.widthAnchor.constraint(equalToConstant: 93.0),
            
            stepper.heightAnchor.constraint(equalToConstant: 29.0),
            stepper.widthAnchor.constraint(equalToConstant: 94.0),
            
            billEnter.heightAnchor.constraint(equalToConstant: 30.0),
            billEnter.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor, constant: 50.0),
            billEnter.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor, constant: 50.0),
            
            billTF.heightAnchor.constraint(equalToConstant: 48.0),
            billTF.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor),
            billTF.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor),
            
            calculateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            calculateButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            calculateButton.heightAnchor.constraint(equalToConstant: 54.0),
            calculateButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200.0)
        ])
    }
    
    @objc func calculatePressed(button: UIButton) {
        self.delegate?.calculateButtonPressed(button: button)
    }
    @objc func tipChanged(tipButton: UIButton) {
        self.delegate?.tipButtonChanged(tipButton: tipButton)
    }
    @objc func stepperChanged(stepper: UIStepper) {
        self.delegate?.stepperValueChanged(stepper: stepper)
    }
}
