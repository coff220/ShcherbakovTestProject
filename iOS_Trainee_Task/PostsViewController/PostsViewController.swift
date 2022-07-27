//
//  ViewController.swift
//  iOS_Trainee_Task
//
//  Created by Slava on 20.07.2022.
//

import UIKit

protocol PostsViewControllerProtocol: AnyObject {
    func reloadData()
}

class PostsViewController: UIViewController, PostsViewControllerProtocol {
    @IBOutlet weak var mainTableView: UITableView!
    var presenter: PostsPresenterProtocol = PostsPresenter()
    lazy var expdanded = Array.init(repeating: false, count: presenter.countItems())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Posts"

        presenter.view = self
        presenter.viewDidLoad()
        
        mainTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        self.mainTableView.estimatedRowHeight = 80 // or any other number that makes sense for your cells
        self.mainTableView.rowHeight = UITableView.automaticDimension
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    
    @IBAction func sort() {
        presenter.pressedSort()
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.countItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell
        let post = presenter.itemAt(indexPath.row)
        cell?.update(post, expanded: expdanded[indexPath.row])
        
        cell?.buttonTapped = { [weak self] in
            self?.expdanded[indexPath.row].toggle()
            self?.mainTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
        
        var presenter: PostPresenterProtocol = PostPresenter(postID: presenter.itemAt(indexPath.row).id)
        presenter.view = vc
        vc.presenter = presenter
        navigationController?.pushViewController(vc, animated: true)
    } 
}
