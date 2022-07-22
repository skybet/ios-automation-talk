//
//  FilterViewController.swift
//  AutomationAnimals
//
//  Created by Matthew Glover on 22/07/2022.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func viewController(_: FilterViewController, didChangeSelectedTags: [String])
}

class FilterViewController: UIViewController {
    
    weak var delegate: FilterViewControllerDelegate?
    
    private var tags: [String] = []
    private var selectedTags: [String] = []
    
    private var tableview: UITableView = UITableView(frame: .zero)
    private var clearAllButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupTableView()
        setupNavigationItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for selectedTag in selectedTags {
            if let indexForSelectedTag = tags.firstIndex(of: selectedTag) {
                tableview.selectRow(at: IndexPath(row: indexForSelectedTag, section: 0), animated: false, scrollPosition: .none)
            }
        }
    }
    
    private func setupTableView() {
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "FilterCell")
        tableview.allowsMultipleSelection = true
        tableview.dataSource = self
        tableview.delegate = self
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationItems() {
        clearAllButton = UIBarButtonItem(title: "Clear All", style: .plain, target: self, action: #selector(clearAllButtonTapped(_:)))
        navigationItem.leftBarButtonItem = clearAllButton
        updateClearAllButton()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped(_:)))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configure(withTags tags: [String], selectedTags: [String]) {
        self.tags = tags
        self.selectedTags = selectedTags
        updateClearAllButton()
    }
    
    private func updateClearAllButton() {
        clearAllButton?.isEnabled = !selectedTags.isEmpty
    }
    
    @objc private func clearAllButtonTapped(_ sender: UIBarButtonItem) {
        for selectedIndexPath in tableview.indexPathsForSelectedRows ?? [] {
            tableview.deselectRow(at: selectedIndexPath, animated: false)
        }
        selectionUpdated()
    }
    
    @objc private func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        
        cell.textLabel?.text = tags[indexPath.row]
                    
        return cell
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionUpdated()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectionUpdated()
    }
    
    private func selectionUpdated() {
        selectedTags.removeAll()
        
        for selectedIndexPath in tableview.indexPathsForSelectedRows ?? [] {
            let tag = self.tags[selectedIndexPath.row]
            selectedTags.append(tag)
        }
        updateClearAllButton()
        delegate?.viewController(self, didChangeSelectedTags: selectedTags)
    }
}
