//
//  ViewController.swift
//  ContainerDemo
//
//  Created by Rauf Aliyev on 30.01.22.
//

import UIKit


class MusicViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

class PodcastViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class ViewController: UIViewController {
    
    let container = Container()
    
    var musicItem: UIBarButtonItem!
    var podcastItem: UIBarButtonItem!
    
    
    let viewControllers : [UIViewController] = [HomeController(), HomeController()]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainer()
        setupNavBar()
        
    }
    
    func createNavItem(title: String, selector: Selector)-> UIBarButtonItem {
        let button = ReusableButton()
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
    
    func setupNavBar(){
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        musicItem = createNavItem(title: "Music", selector: #selector(musicTapped))
        musicItem.customView?.alpha = 1.0
        podcastItem = createNavItem(title: "Podcast", selector: #selector(podcastTapped))
        podcastItem.customView?.alpha = 0.5
        space.width = 30
        navigationItem.leftBarButtonItems = [musicItem, space, podcastItem]
    }
    
    @objc func musicTapped(){
        musicItem.customView?.alpha = 1.0
        podcastItem.customView?.alpha  = 0.5
        podcastItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], for: .normal)
        
        if container.children.first == viewControllers[0] {return}
        addVC(controller: viewControllers[0])
        
        animateTransition(fromVC: viewControllers[1], toVC: viewControllers[0]) { Bool in
            self.removeVC(controller: self.viewControllers[1])
        }
        
    }
    
    @objc func podcastTapped(){
        addVC(controller: viewControllers[1])
        animateTransition(fromVC: viewControllers[0], toVC: viewControllers[1]) { Bool in
            self.removeVC(controller: self.viewControllers[0])
        }
       
        podcastItem.customView?.alpha  = 1.0
        musicItem.customView?.alpha = 0.5
    }
    
    
    func setupContainer(){
        guard let containerView = container.view else {return}
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        addVC(controller: viewControllers[0])
    }
}

extension ViewController {
    
    func addVC(controller: UIViewController){
        container.addChild(controller)
        container.view.addSubview(controller.view)
    }
    
    func removeVC(controller: UIViewController){
        
        controller.willMove(toParent: nil)
        controller.removeFromParent()
        controller.view.removeFromSuperview()
    }
    
    func animateShifts() {
        guard let movingVC = viewControllers[0].view else {return}
        
        UIView.animate(withDuration: 0.5) {
            movingVC.frame = CGRect(x: -30, y: 0, width: 0, height: 0)
        } completion: { done in
        }
    }
    
    func animateTransition( fromVC : UIViewController, toVC: UIViewController, completion: @escaping((Bool)-> Void)){
        guard
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toView =  toVC.view,
            let toIndex = getIndex(forViewController: toVC)
        else {
            return
        }
        
        let frame = fromVC.view.frame
        var fromFrameEnd = frame
        var toFrameStart = frame
        
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x  - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        
        toView.frame = toFrameStart
        
        UIView.animate(withDuration: 0.5) {
            fromView.frame = fromFrameEnd
            toView.frame = frame
        } completion: { success in
            completion(success)
        }
    }
    
    func getIndex(forViewController vc: UIViewController)-> Int? {
        for (index, thisVC) in viewControllers.enumerated(){
            if thisVC == vc{return index}
        }
        return nil
    }
}
