//
//  ViewController.swift
//  Movie
//
//  Created by hafied Khalifatul ash.shiddiqi on 18/11/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let parser = Parser()
    var result = [Item]()
    var resultRight = [Item]()
    var resultLeft = [Item]()
    @IBOutlet weak var tableViewRight: UITableView!
    var urlString: String = ""
    @IBOutlet weak var tableViewDown: UITableView!
    @IBOutlet weak var collectionViewUp: UICollectionView!
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.tableViewRight.deselectSelectedRow(animated: true)
        self.tableViewDown.deselectSelectedRow(animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parser.parse {
            data in
            self.result = data
            DispatchQueue.main.async { [self] in
                for _ in 11...250 {
                    self.result.remove(at: 10)
                }
                self.collectionViewUp.reloadData()
            }
        }
        parser.parse {
            data in
            self.resultLeft = data
            DispatchQueue.main.async { [self] in
                for _ in 21...250 {
                    self.resultLeft.remove(at: 20)
                }
                for _ in 1...10 {
                    self.resultLeft.remove(at: 0)
                }
                for i in 0...4 {
                    self.resultLeft.remove(at: i)
                }
                self.tableViewDown.reloadData()
            }
        }
        parser.parse {
            data in
            self.resultRight = data
            DispatchQueue.main.async { [self] in
                for _ in 21...250 {
                    self.resultRight.remove(at: 20)
                }
                for _ in 1...10 {
                    self.resultRight.remove(at: 0)
                }
                for i in 1...5 {
                    self.resultRight.remove(at: i)
                }
                self.tableViewRight.reloadData()
            }
        }
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        tableViewDown.dataSource = self
        tableViewDown.delegate = self

        tableViewRight.dataSource = self
        tableViewRight.delegate = self


    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        switch tableView {
        case tableViewDown:
            numberOfRow = resultLeft.count
        case tableViewRight:
            numberOfRow = resultRight.count
        default:
            print("something error")
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()

        switch tableView {
        case tableViewRight:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellRight", for: indexPath) as? BottomRightTableViewCell
//            cell.textLabel?.text = "kami"
            cell!.labelRight.text = "\(resultRight[indexPath.row].fullTitle)"
            self.urlString = "\(resultRight[indexPath.row].image)"
            cell!.imageRight.contentMode = UIView.ContentMode.scaleToFill
            cell!.imageRight.sd_setImage(with: URL(string: urlString),
                                  placeholderImage: UIImage(systemName: "photo"),
                                  options: .continueInBackground,
                                  completed: nil)
            cellToReturn = cell!
        case tableViewDown:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellDown", for: indexPath) as! BottomTableViewCell
            cell.labelLeft.text = "\(resultLeft[indexPath.row].fullTitle)"
            self.urlString = "\(resultLeft[indexPath.row].image)"
            cell.imageDown.contentMode = UIView.ContentMode.scaleToFill
            cell.imageDown.sd_setImage(with: URL(string: urlString),
                                  placeholderImage: UIImage(systemName: "photo"),
                                  options: .continueInBackground,
                                  completed: nil)
            cellToReturn = cell
        default:
            print("error")
        }
        return cellToReturn       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController
        switch tableView {
        case tableViewDown:
            detail?.id = "\(resultLeft[indexPath.row].id)"
            detail?.crew = "\(resultLeft[indexPath.row].crew)"
            detail?.date = "\(resultLeft[indexPath.row].year)"
            detail?.judul = "\(resultLeft[indexPath.row].fullTitle)"
            detail?.rating = "\(resultLeft[indexPath.row].imDBRating)"
            detail?.rank = "\(resultLeft[indexPath.row].rank)"
            detail?.image = "\(resultLeft[indexPath.row].image)"
        case tableViewRight:
            detail?.id = "\(resultRight[indexPath.row].id)"
            detail?.crew = "\(resultRight[indexPath.row].crew)"
            detail?.date = "\(resultRight[indexPath.row].year)"
            detail?.judul = "\(resultRight[indexPath.row].fullTitle)"
            detail?.rating = "\(resultRight[indexPath.row].imDBRating)"
            detail?.rank = "\(resultRight[indexPath.row].rank)"
            detail?.image = "\(resultRight[indexPath.row].image)"
        default:
            print("something error")
        }
        self.navigationController?.pushViewController(detail!, animated: true)
    }

}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellUp", for: indexPath) as! TrendingCollectionViewCell
        cell.imageUp.layer.cornerRadius = 10
        cell.titleUp.text = "\(result[indexPath.row].fullTitle)"
        self.urlString = "\(result[indexPath.row].image)"
        cell.imageUp.contentMode = UIView.ContentMode.scaleToFill
        cell.imageUp.sd_setImage(with: URL(string: urlString),
                              placeholderImage: UIImage(systemName: "photo"),
                              options: .continueInBackground,
                              completed: nil)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController
        self.navigationController?.pushViewController(detail!, animated: true)
        detail?.id = "\(result[indexPath.row].id)"
        detail?.crew = "\(result[indexPath.row].crew)"
        detail?.date = "\(result[indexPath.row].year)"
        detail?.judul = "\(result[indexPath.row].fullTitle)"
        detail?.rating = "\(result[indexPath.row].imDBRating)"
        detail?.rank = "\(result[indexPath.row].rank)"
        detail?.image = "\(result[indexPath.row].image)"
    }
}
extension UITableView {

    func deselectSelectedRow(animated: Bool)
    {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }

}

