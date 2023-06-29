//
//  ViewController.swift
//  UnlimintDemo
//
//  Created by Romesh Bansal on 29/06/23.
//

import UIKit

class ViewController: UIViewController {
    let presenter = JokePresenter(service: APIService())
    
    weak var timer: Timer?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(JokesTableViewCell.self,
                           forCellReuseIdentifier: JokesTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private var jokesArray = [Joke]()
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        setTableView()
        checkIfDataAlreadyExist()
    }
    
    func checkIfDataAlreadyExist(){
        if let data = userDefaults.data(forKey: Constant.dataStoringKey) {
            let jokes = try! PropertyListDecoder().decode([Joke].self, from: data)
            if jokes.count > 0{
                self.jokesArray.removeAll()
                self.jokesArray.append(contentsOf: jokes)
                self.tableView.reloadData()
            }
        }
        startTimer()
    }
    
    func startTimer() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: Constant.jokeFetchDuration, repeats: true) { [weak self] _ in
            self?.presenter.getJoke()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    private func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    deinit {
        if let data = try? PropertyListEncoder().encode(self.jokesArray) {
            UserDefaults.standard.set(data, forKey: Constant.dataStoringKey)
        }
        stopTimer()
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: JokesTableViewCell.reuseIdentifier, for: indexPath)  as? JokesTableViewCell
        else {
            return UITableViewCell()
        }
        cell.lblJoke.text = jokesArray[indexPath.row].joke
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokesArray.count
    }
}

extension ViewController: JokeView{
    func addJoke(joke: Joke) {
        if jokesArray.count < Constant.maximumJokeCount{
            self.jokesArray.insert(joke, at: 0)
        }else{
            self.jokesArray.removeLast()
            self.jokesArray.insert(joke, at: 0)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func apiErrorDescription(error: String) {
        print(error)
    }
}

