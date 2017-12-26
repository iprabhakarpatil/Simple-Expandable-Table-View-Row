//
//  ViewController.swift
//  Simple Expanding TableView
//
//  Created by Prabhakar Mac on 12/26/17.
//  Copyright © 2017 prabhakar. All rights reserved.
//

import UIKit


/// Protocol for Reuse Identifier
protocol PrototypeCellReuseIdentifier {
    static var reusableCellIdentifier : String{get}
}

class ViewController: UIViewController, PrototypeCellReuseIdentifier {

    static var reusableCellIdentifier: String {get {return "cell"} }


    let titleArray = ["A", "B", "C", "D"]
    let subtitleText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    let normalHeight = 45.0
    let expandedHeight = UITableViewAutomaticDimension //This will help to adjust the height of the row according to the content size in the row.
    var indexPathForExpandingRow: IndexPath? //Will maintain the IndexPath for the currently selected row.

    @IBOutlet weak var _tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        _tableView.tableFooterView = UIView() //Hides the separator lines for the empty rows.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.reusableCellIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = titleArray[indexPath.row]

        if indexPathForExpandingRow == indexPath {
            cell.detailTextLabel?.text = subtitleText
            cell.detailTextLabel?.isHidden = false
        } else {
            cell.detailTextLabel?.text = ""
            cell.detailTextLabel?.isHidden = true
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if (tableView.cellForRow(at: indexPath)?.detailTextLabel?.isHidden)! {
            indexPathForExpandingRow = indexPath
        } else {
            indexPathForExpandingRow = nil
        }

        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath == indexPathForExpandingRow {
            return expandedHeight
        }
        tableView.cellForRow(at: indexPath)?.detailTextLabel?.isHidden = true
        return CGFloat(normalHeight)
    }
}
