//
//  ResultView.swift
//  goodTipper
//
//  Created by Александра Кострова on 15.03.2023.
//

import UIKit

protocol ResultViewDelegate: AnyObject {
    func recalculateButtonPressed(button: UIButton!)
}

final class ResultView: UIView {
    
    private var myView = MyView()
    var delegate: ResultViewDelegate?
    var calculateVC = CalculateViewController()
    
    var result = String()
    var tip = Int()
    var people = Int()
    
    private lazy var secondView: UIView = {
        let view = myView.makeAnotherView()
        [resultLabel, titleLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return view
    }()
    
    private let titleLabel = MyView().makeLabel("Total pur person",
                                                .center, .lightGray,
                                                MyView.Constants.titleLabelFontSize)
    
    public let resultLabel = MyView().makeLabel("", .center,
                                                 MyView.Constants.primaryTextColor,
                                                 MyView.Constants.resultLabelFontSize)
    public let commentLabel = MyView().makeLabel("",
                                                  .center, .lightGray,
                                                  MyView.Constants.titleLabelFontSize)
    public lazy var recalculateButton: UIButton = {
        let button = MyView().makeLargeButton("Recalculate")
        button.addTarget(self, action: #selector(recalculatePressed(button:)), for: .touchUpInside)
        return button
    }()
    
    init(calculateVC: CalculateViewController) {
            super.init(frame: .zero)
    
            self.setResultSubviews()
        self.resultLabel.text = result
        self.commentLabel.text = "Split between \(people) people, with \((tip) * 100)% tip"
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setResultSubviews() {
        
        self.backgroundColor = .white
        [self.secondView, self.recalculateButton, self.commentLabel].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            self.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: commentLabel.trailingAnchor, constant: 50.0),
            
            secondView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            secondView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            secondView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
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
            commentLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50.0),
            
            recalculateButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            recalculateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            recalculateButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200.0),
            recalculateButton.heightAnchor.constraint(equalToConstant: 54.0)
        ])
    }
    
    @objc func recalculatePressed(button: UIButton!) {
        
        self.delegate?.recalculateButtonPressed(button: recalculateButton)
    }
}
