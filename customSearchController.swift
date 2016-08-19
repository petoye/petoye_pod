//
//  customSearchController.swift
//  PetOye
//
//  Created by Ameya Vichare on 19/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

protocol CustomSearchControllerDelegate {
    func didStartSearching()
    
    func didTapOnSearchButton()
    
    func didTapOnCancelButton()
    
    func didChangeSearchText(searchText: String)
}


class customSearchController: UISearchController,UISearchBarDelegate {
    
    var CustomSearchBar: customSearchBar!
    var customDelegate: CustomSearchControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init(searchResultsController: UIViewController!, searchBarFrame: CGRect, searchBarFont: UIFont, searchBarTextColor: UIColor, searchBarTintColor: UIColor) {
        super.init(searchResultsController: searchResultsController)
        
        configureSearchBar(searchBarFrame, font: searchBarFont, textColor: searchBarTextColor, bgColor: searchBarTintColor)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func configureSearchBar(frame: CGRect, font: UIFont, textColor: UIColor, bgColor: UIColor) {
        CustomSearchBar = customSearchBar(frame: frame, font: font , textColor: textColor)
        
        CustomSearchBar.barTintColor = bgColor
        CustomSearchBar.tintColor = textColor
        CustomSearchBar.showsBookmarkButton = false
        CustomSearchBar.showsCancelButton = true
        CustomSearchBar.delegate = self
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        customDelegate.didStartSearching()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        CustomSearchBar.resignFirstResponder()
        customDelegate.didTapOnSearchButton()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        CustomSearchBar.resignFirstResponder()
        customDelegate.didTapOnCancelButton()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        customDelegate.didChangeSearchText(searchText)
    }
    
    

}
