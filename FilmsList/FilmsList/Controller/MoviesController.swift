//
//  ViewController.swift
//  FilmsList
//
//  Created by Марат Маркосян on 31.08.2022.
//

import UIKit

class MoviesController: UIViewController {
    
    private lazy var titleTxt = UITextField()
    private lazy var yearTxt = UITextField()
    private lazy var addBtn = UIButton()
    private lazy var filmsTable = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubviews()
        setUpAutoLayout()
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(titleTxt)
        view.addSubview(yearTxt)
        view.addSubview(addBtn)
        view.addSubview(filmsTable)
        
        titleTxt.translatesAutoresizingMaskIntoConstraints = false
        yearTxt.translatesAutoresizingMaskIntoConstraints = false
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        filmsTable.translatesAutoresizingMaskIntoConstraints = false
        
        titleTxt.placeholder = "Title"
        yearTxt.placeholder = "Year"
        titleTxt.borderStyle = .roundedRect
        yearTxt.borderStyle = .roundedRect
        yearTxt.keyboardType = .numberPad
        
        addBtn.backgroundColor = .blue
        addBtn.setTitleColor(.white, for: .normal)
        addBtn.setTitle("Add", for: .normal)
        addBtn.layer.cornerRadius = 5
        addBtn.addTarget(self, action: #selector(addFilm), for: .touchUpInside)
        
        filmsTable.register(CustomCell.self, forCellReuseIdentifier: "Reuse")
        filmsTable.delegate = self
        filmsTable.dataSource = self
        
    }
    
    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            titleTxt.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleTxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTxt.heightAnchor.constraint(equalToConstant: 40),
            
            yearTxt.topAnchor.constraint(equalTo: titleTxt.bottomAnchor, constant: 20),
            yearTxt.leadingAnchor.constraint(equalTo: titleTxt.leadingAnchor),
            yearTxt.trailingAnchor.constraint(equalTo: titleTxt.trailingAnchor),
            yearTxt.heightAnchor.constraint(equalToConstant: 40),
            
            addBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addBtn.topAnchor.constraint(equalTo: yearTxt.bottomAnchor, constant: 30),
            addBtn.widthAnchor.constraint(equalToConstant: 50),
            
            filmsTable.topAnchor.constraint(equalTo: addBtn.bottomAnchor, constant: 30),
            filmsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            filmsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            filmsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func showError(descr: String) {
        let alert = UIAlertController(title: "Error", message: descr, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true)
        
    }
    
    func checkItems() -> Bool {
        if titleTxt.text == "" || yearTxt.text == "" {
            return false
        } else {
            return true
        }
    }
    
    func checkFilms() -> Bool {
        let films = Storage.instance.films
        let new = FilmModel(title: titleTxt.text!, year: Int(yearTxt.text!)!)
        for film in films {
            if film == new {
                return false
            }
        }
        return true
    }
    
    func loadNewFilm() {
        filmsTable.beginUpdates()
        filmsTable.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .none)
        filmsTable.endUpdates()
    }
    
    @objc private func addFilm() {
        if checkItems() {
            if checkFilms() {
                let film = FilmModel(title: titleTxt.text!, year: Int(yearTxt.text!)!)
                Storage.instance.films.append(film)
                titleTxt.text = ""
                yearTxt.text = ""
                loadNewFilm()
            } else {
                showError(descr: "There is almost this film")
            }
        } else {
            showError(descr: "Some field is empty")
        }
    }

}

extension MoviesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Storage.instance.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let films = Storage.instance.films
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse") as? CustomCell {
            cell.setFilmInfo(to: "\(films[indexPath.row].title) \(films[indexPath.row].year)")
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension MoviesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
