//
//  HomePageViewController.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 8/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

protocol HomePageDelegate {
    
    func pageSwitchedTo(index : Int)
}

class HomePageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var currentPageIndex = 0
    
    lazy var homeViewControllers : [BackgroundImageViewController] = {
       
        return [self.VControllerInstance(name: "backgroundImageVC"), self.VControllerInstance(name: "backgroundImageVC"), self.VControllerInstance(name: "backgroundImageVC"), self.VControllerInstance(name: "backgroundImageVC"), self.VControllerInstance(name: "backgroundImageVC")]
    }()
    
    var homeDelegate : HomePageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        
        if let firstVC = homeViewControllers.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        self.navigationController?.viewControllers[1].automaticallyAdjustsScrollViewInsets = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print("Will transition")
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        for index in 0...homeViewControllers.count-1{
            if (self.viewControllers?.first!.isEqual(homeViewControllers[index]))!{
                print("\(index)Is equal")
                
                if completed {
                    self.currentPageIndex = 0
                    self.homeDelegate?.pageSwitchedTo(index: index)
                    
                }
            }
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = homeViewControllers.index(of: viewController as! BackgroundImageViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return homeViewControllers.last
        }
        guard homeViewControllers.count > previousIndex else {
            return nil
        }
        
        
        return homeViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = homeViewControllers.index(of: viewController as! BackgroundImageViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < homeViewControllers.count else {
            return homeViewControllers.first
        }
        guard homeViewControllers.count > nextIndex else {
            return nil
        }
        return homeViewControllers[nextIndex]
        
    }
    
    
    
    // MARK: - Page View Controller Delegate
    
    
    
    // MARK: - Other Methods
    
    //Returns an instance of a UIViewController that has been drawn up using Storyboard.
    private func VControllerInstance(name: String) -> BackgroundImageViewController {
        
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name) as! BackgroundImageViewController
    }
    
    
    func jumptoPage(index : Int) {
        
        let vc = self.homeViewControllers[index]
        let direction : UIPageViewControllerNavigationDirection!
        
        if self.currentPageIndex < index {
            direction = UIPageViewControllerNavigationDirection.forward
        }
        else {
            direction = UIPageViewControllerNavigationDirection.reverse
        }
        
        if (self.currentPageIndex < index) {
            for i in 0...index-1 {
                if (i == index) {
                    self.setViewControllers([vc], direction: direction, animated: true, completion: nil)
                }
                else {
                    self.setViewControllers([homeViewControllers[i]], direction: direction, animated: false, completion: nil)
                }
            }
        }
        else {
            for i in self.currentPageIndex...index {
                if i == index {
                    self.setViewControllers([vc], direction: direction, animated: true, completion: nil)
                }
                else {
                    self.setViewControllers([homeViewControllers[i]], direction: direction, animated: false, completion: nil)
                }
            }
        }
        self.currentPageIndex = index
    }
    

}
