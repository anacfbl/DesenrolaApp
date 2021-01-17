//
//  OnboardingViewController.swift
//  DesenrolaApp
//
//  Created by Xanda on 17/01/21.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var slides:[OnboardingSlide] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)

    }
    
    func createSlides() -> [OnboardingSlide] {

        let slide1:OnboardingSlide = Bundle.main.loadNibNamed("OnboardingSlide", owner: self, options: nil)?.first as! OnboardingSlide
        slide1.OBImage.image = UIImage(named: "ic_onboarding_1")
        slide1.OBBigLabel.text = "A real-life bear"
        slide1.OBText.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide2:OnboardingSlide = Bundle.main.loadNibNamed("OnboardingSlide", owner: self, options: nil)?.first as! OnboardingSlide
        slide2.OBImage.image = UIImage(named: "ic_onboarding_2")
        slide2.OBBigLabel.text = "A real-life bear"
        slide2.OBText.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide3:OnboardingSlide = Bundle.main.loadNibNamed("OnboardingSlide", owner: self, options: nil)?.first as! OnboardingSlide
        slide3.OBImage.image = UIImage(named: "ic_onboarding_2")
        slide3.OBBigLabel.text = "A real-life bear"
        slide3.OBText.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
  
        return [slide1, slide2, slide3]
    }
    
    func setupSlideScrollView(slides : [OnboardingSlide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
            pageControl.currentPage = Int(pageIndex)
            
            let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
            let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
            
            // vertical
            let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
            let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
            
            let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
            let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
            
            
            /*
             * below code changes the background color of view on paging the scrollview
             */
    //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
            
        
            /*
             * below code scales the imageview on paging the scrollview
             */
            let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
            
            if(percentOffset.x > 0 && percentOffset.x <= 0.5) {
                
                slides[0].OBImage.transform = CGAffineTransform(scaleX: (0.5-percentOffset.x)/0.5, y: (0.5-percentOffset.x)/0.5)
                slides[1].OBImage.transform = CGAffineTransform(scaleX: percentOffset.x/0.5, y: percentOffset.x/0.5)
                
            } else if(percentOffset.x > 0.5 && percentOffset.x <= 0.50) {
                slides[1].OBImage.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.5, y: (1-percentOffset.x)/0.5)
                slides[2].OBImage.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
                
            }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
