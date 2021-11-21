//
//  DetailsViewController.swift
//  Movie
//
//  Created by hafied Khalifatul ash.shiddiqi on 19/11/21.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var labelCrew: UILabel!
    @IBOutlet weak var sipnosisText: UITextView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelRanking: UILabel!
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var labelJudul: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    var id = ""
    var sipnosis = ""
    var crew = ""
    var date = ""
    var rating = ""
    var rank = ""
    var image = ""
    var judul = ""
    var urlString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Detail Movie"
        labelCrew.text = crew
        labelJudul.text = judul
        labelRanking.text = rank
        labelRating.text = "\(rating) (IMDb)"
        detailAPI()
        self.urlString = "\(image)"
        imageDetail.contentMode = UIView.ContentMode.scaleAspectFill
        imageDetail.sd_setImage(with: URL(string: urlString),
                              placeholderImage: UIImage(systemName: "photo"),
                              options: .continueInBackground,
                              completed: nil)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

    }
    

    
    func detailAPI() {
        guard let gitUrl = URL(string: "https://imdb-api.com/en/API/Title/k_lpfgd3f9/\(id)") else { return }
        let request = URLRequest(url: gitUrl)
            
        URLSession.shared.dataTask(with: request) { (data, respone, error) in
                
        guard let data = data else {return}
            do{
                let decoder = JSONDecoder()
                let data = try decoder.decode(Detail.self, from: data)
                DispatchQueue.main.async {
                    self.sipnosisText.text = data.plot
                    self.labelDate.text = data.releaseDate
                    self.labelDuration.text = "\(data.runtimeMins) Minutes"

                }

                
                }catch let err{
                    print("Error", err)
                }
            }.resume()
            
        }

}

