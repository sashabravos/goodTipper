//
//  ResultViewController.swift
//  goodTipper
//
//  Created by Александра Кострова on 04.03.2023.
//

import UIKit

final class ResultViewController: UIViewController {

    private var resultView: ResultView!
    var calculateVC: CalculateViewController

    init(calculateVC: CalculateViewController) {
        self.calculateVC = calculateVC
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setSubviews()
    }

    private func setSubviews() {
        self.resultView = ResultView(calculateVC: CalculateViewController())
        self.resultView.delegate = self
        print(resultView.result, resultView.tip, resultView.people, "2nd VC")
        view.addSubview(resultView)
        resultView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.resultView.topAnchor.constraint(equalTo: view.topAnchor),
            self.resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.resultView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ResultViewController: ResultViewDelegate {
    func recalculateButtonPressed(button: UIButton!) {
//        print(resultView.result, resultView.tip, resultView.people, "2nd VC")
        self.dismiss(animated: true)
    }
}
