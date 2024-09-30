//
//  DemoScrollViewController.swift
//  DemoScrollView
//
//  Created by O M A R on 30/09/2024.
//

import UIKit
import RxSwift

protocol ScrollViewModelProtocol {
    var state1Observer: PublishSubject<Void> { get }
    var state2Observer: PublishSubject<Void> { get }
    var state3Observer: PublishSubject<Void> { get }
    func callAPI()
}

class ScrollViewModel: ScrollViewModelProtocol {
    enum State {
        case case1
        case case2
        case case3
    }
    var currentState: State = .case1
    var state1Observer = PublishSubject<Void>()
    var state2Observer = PublishSubject<Void>()
    var state3Observer = PublishSubject<Void>()
    
    init(currentState: State) {
        self.currentState = currentState
    }
    
    func callAPI() {
        switch currentState {
        case .case1:
            state1Observer.onNext(())
        case .case2:
            state2Observer.onNext(())
        case .case3:
            state3Observer.onNext(())
        }
    }
}

class DemoScrollViewController: UIViewController {
    
    @IBOutlet weak var dynamicSection: UIView!
    
    let viewModel: ScrollViewModelProtocol
    let disposeBag = DisposeBag()
    
    lazy var view1: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "State 1"
        view.backgroundColor = .systemOrange
        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return view
    }()
    
    lazy var view2: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "State 2"
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return view
    }()
    
    lazy var view3: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "State 3"
        view.backgroundColor = .systemMint
        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return view
    }()
    
    init(viewModel: ScrollViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        viewModel.callAPI()
    }
    
    /// Our height will be dynamic depend on our constrains not fixed.
    /// These fixed values is just for demo to prove is view will fit any height.
    func bind() {
        viewModel.state1Observer.subscribe { _ in
            self.dynamicSection.addSubview(self.view1)
            NSLayoutConstraint.activate([
                self.view1.heightAnchor.constraint(equalToConstant: 100),
                self.view1.leadingAnchor.constraint(equalTo: self.dynamicSection.leadingAnchor),
                self.view1.trailingAnchor.constraint(equalTo: self.dynamicSection.trailingAnchor),
                self.view1.topAnchor.constraint(equalTo: self.dynamicSection.topAnchor),
                self.view1.bottomAnchor.constraint(equalTo: self.dynamicSection.bottomAnchor),
            ])
        }.disposed(by: disposeBag)
        
        viewModel.state2Observer.subscribe { _ in
            self.dynamicSection.addSubview(self.view2)
            NSLayoutConstraint.activate([
                self.view2.heightAnchor.constraint(equalToConstant: 250),
                self.view2.leadingAnchor.constraint(equalTo: self.dynamicSection.leadingAnchor),
                self.view2.trailingAnchor.constraint(equalTo: self.dynamicSection.trailingAnchor),
                self.view2.topAnchor.constraint(equalTo: self.dynamicSection.topAnchor),
                self.view2.bottomAnchor.constraint(equalTo: self.dynamicSection.bottomAnchor),
            ])
        }.disposed(by: disposeBag)
        
        viewModel.state3Observer.subscribe { _ in
            self.dynamicSection.addSubview(self.view3)
            NSLayoutConstraint.activate([
                self.view3.heightAnchor.constraint(equalToConstant: 450),
                self.view3.leadingAnchor.constraint(equalTo: self.dynamicSection.leadingAnchor),
                self.view3.trailingAnchor.constraint(equalTo: self.dynamicSection.trailingAnchor),
                self.view3.topAnchor.constraint(equalTo: self.dynamicSection.topAnchor),
                self.view3.bottomAnchor.constraint(equalTo: self.dynamicSection.bottomAnchor),
            ])
        }.disposed(by: disposeBag)
    }
}
