//
//  UIViews.swift
//  goodTipper
//
//  Created by Александра Кострова on 07.03.2023.
//

import UIKit

final class MyView: UIView {
    
    public func makeAnotherView() -> UIView {
        let view = UIView()
        view.backgroundColor = Constants.secondViewBackgroundColor
        view.contentMode = .scaleToFill
        return view
    }
    
    public func makeStackView(_ spacing: CGFloat,
                              _ axis: NSLayoutConstraint.Axis,
                              _ alignment: UIStackView.Alignment,
                              _ distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.spacing = spacing
        return stackView
    }
    
    public func makeTipButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.titleLabel!.numberOfLines = 0
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.setTitleColor(Constants.primaryTextColor, for: .normal)
        button.tintColor = Constants.primaryTextColor
        button.contentMode = .scaleAspectFill
        return button
    }
    
    public func makeLargeButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.titleLabel!.numberOfLines = 0
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .blue .withAlphaComponent(0.5)
        button.setTitleColor(.white, for: .normal)
        return button
    }
    
    public func makeLabel(_ title: String,
                          _ textAlignment: NSTextAlignment,
                          _ textColor: UIColor,
                          _ fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.textColor = textColor
        label.font = .systemFont(ofSize: fontSize, weight: .regular)
        label.textAlignment = textAlignment
        label.isEnabled = true
        return label
    }
    
    public func makeStepper() -> UIStepper {
        let stepper = UIStepper()
        stepper.minimumValue = 2.0
        stepper.maximumValue = 25.0
        stepper.autorepeat = true
        stepper.isContinuous = true
        stepper.contentHorizontalAlignment = .center
        stepper.contentVerticalAlignment = .center
        stepper.tintColor = .red
        return stepper
    }
    
    public func makeTextField() -> UITextField {
        let bill = UITextField()
        bill.textColor = Constants.primaryTextColor
        bill.font = .systemFont(ofSize: Constants.textFieldFontSize)
        bill.placeholder = "123.56 RUB"
        bill.textAlignment = .center
        bill.contentHorizontalAlignment = .left
        bill.contentVerticalAlignment = .center
        bill.clearButtonMode = .whileEditing
        bill.returnKeyType = .done
        bill.keyboardType = .default
        return bill
    }
    public enum Constants {
        static let secondViewBackgroundColor: UIColor = .blue .withAlphaComponent(0.1)
        static let buttonFontSize: CGFloat = 35.0
        static let buttonCornerRadius: CGFloat = 5.0
        static let tipButtonHeight: CGFloat = 54.0
        static let primaryTextColor: UIColor = .blue .withAlphaComponent(0.6)
        static let lightGreyLabelFontSize: CGFloat = 25.0
        static let titleLabelFontSize: CGFloat = 30.0
        static let resultLabelFontSize: CGFloat = 45.0
        static let textFieldFontSize: CGFloat = 40.0
        static let verticalSVSpacing: CGFloat = 26.0
        static let tipSVspacing: CGFloat = 50.0
        static let splitSVspacing: CGFloat = 27.0
    }
}
