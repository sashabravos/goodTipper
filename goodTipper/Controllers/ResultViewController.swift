//
//  ResultViewController.swift
//  goodTipper
//
//  Created by Александра Кострова on 04.03.2023.
//

import UIKit

final class ResultViewController: UIViewController {
    
    private var myView = MyView()
    var calculateVC: CalculateViewController!
    
    public var result = "0.0"
    public var people = 2
    public var tip = 0.10

    private lazy var secondView: UIView = {
        let view = myView.makeAnotherView()
        [resultLabel, titleLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return view
    }()
    
    private lazy var titleLabel = myView.makeLabel("Total per person",
                                                   .center, .lightGray,
                                                   MyView.Constants.titleLabelFontSize)
    
    public lazy var resultLabel = myView.makeLabel(result, .center,
                                                   MyView.Constants.primaryTextColor,
                                                   MyView.Constants.resultLabelFontSize)
    public lazy var commentLabel = myView.makeLabel("Split between \(people) people, with \(Int(tip * 100))% tip",
                                                    .center, .lightGray,
                                                    MyView.Constants.titleLabelFontSize)
    public lazy var recalculateButton: UIButton = {
        let button = myView.makeLargeButton("Recalculate")
        button.addTarget(self, action: #selector(recalculatePressed(button:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setResultSubviews()
    }
    
    private func setResultSubviews() {
        view.backgroundColor = .white
                
        [secondView, recalculateButton, commentLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: commentLabel.trailingAnchor, constant: 50.0),
            
            secondView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            secondView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            secondView.heightAnchor.constraint(equalToConstant: 300.0),
            
            titleLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: secondView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 36.0),
            
            secondView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            secondView.trailingAnchor.constraint(equalTo: resultLabel.trailingAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 100.0),
            
            commentLabel.heightAnchor.constraint(equalToConstant: 117.0),
            commentLabel.topAnchor.constraint(equalTo: secondView.bottomAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50.0),
            
            recalculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            recalculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recalculateButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200.0),
            recalculateButton.heightAnchor.constraint(equalToConstant: 54.0)
        ])
    }
    
    @objc func recalculatePressed(button: UIButton!) {
        result = "0.0"
        people = 2
        tip = 0.10
        self.dismiss(animated: true)
    }
}
