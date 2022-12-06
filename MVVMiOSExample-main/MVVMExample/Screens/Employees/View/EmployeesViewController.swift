//
//  EmployeesViewController.swift
//  MVVMExample
//
//  Created by John Codeos on 06/19/20.
//

import UIKit

class EmployeesViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var searching = false
    var filteredIndices = [Int]()
    var countryList = [String]()
    
    lazy var viewModel = {
        EmployeesViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
        
        self.searchBar.delegate = self
        
        // Change the Tint Color
        self.searchBar.barTintColor = UIColor.colorFromHex("#BC214B")
        self.searchBar.tintColor = UIColor.white
        // Show/Hide Cancel Button
        self.searchBar.showsCancelButton = true
        // Change TextField Colors
        let searchTextField = self.searchBar.searchTextField
        searchTextField.textColor = UIColor.white
        searchTextField.clearButtonMode = .never
        searchTextField.backgroundColor = UIColor.colorFromHex("#9E1C40")
        // Change Glass Icon Color
        let glassIconView = searchTextField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = UIColor.colorFromHex("#BC214B")
        
        
        self.searchBar.keyboardAppearance = .dark
    }
    
    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        tableView.register(EmployeeCell.nib, forCellReuseIdentifier: EmployeeCell.identifier)
    }
    
    func initViewModel() {
        // Get employees data
        viewModel.getEmployees()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension EmployeesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

// MARK: - UITableViewDataSource

extension EmployeesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return  filteredIndices.count
        } else {
            return viewModel.employeeCellViewModels.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as? EmployeeCell else { fatalError("xib does not exists") }
        var cellVM = EmployeeCellViewModel(id: "", name: "", salary: "", age: "")
        if searching {
            cellVM = viewModel.getCellViewModel(at:filteredIndices[indexPath.row])
            cell.cellViewModel = cellVM
            
        }else{
            cellVM = viewModel.getCellViewModel(at:indexPath.row)
            cell.cellViewModel = cellVM
        }
        
        return cell
    }
}

extension EmployeesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        countryList.removeAll()
        for item in viewModel.employeeCellViewModels.enumerated() {
            countryList.append(item.element.name)
            
        }
        filteredIndices = countryList.indices.filter { countryList[$0].lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
