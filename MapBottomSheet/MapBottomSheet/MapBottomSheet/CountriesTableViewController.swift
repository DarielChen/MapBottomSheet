//
//  CountriesTableViewController.swift
//  MapBottomSheet
//
//  Created by Dariel on 2018/8/25.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

private let maxVisibleContentHeight: CGFloat = UIScreen.main.bounds.size.height - 300

private let numberOfCountries = 30
private let countries = Locale.isoRegionCodes.suffix(numberOfCountries).map(Locale.current.localizedString(forRegionCode:))
private let reuseIdentifier = "cell"

class CountriesTableViewController: UITableViewController, BottomSheet {
    
    var bottomSheetDelegate: BottomSheetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.contentInset.top = maxVisibleContentHeight
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bottomSheetDelegate?.bottomSheet(self, didScrollTo: tableView.contentOffset)
        
        if tableView.contentSize.height < tableView.bounds.height {
            tableView.contentSize.height = tableView.bounds.height
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
        cell.textLabel?.text = countries[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Scroll view delegate
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetOffset = targetContentOffset.pointee.y
        let pulledUpOffset: CGFloat = 0
        let pulledDownOffset: CGFloat = -maxVisibleContentHeight
        
        if (pulledDownOffset...pulledUpOffset).contains(targetOffset) {
            if velocity.y < 0 {
                targetContentOffset.pointee.y = pulledDownOffset
            } else {
                targetContentOffset.pointee.y = pulledUpOffset
            }
        }
    }
}
