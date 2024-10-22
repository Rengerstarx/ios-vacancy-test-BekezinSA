//
//  GistListView.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 22.10.2024.
//

import UIKit
import TinyConstraints

class GistListView: UIView {
    
    private let gistsTableView = ViewsFactory.defaultTableView()
    private var gistsList = [GistListItemModel]()
    private let refreshControl = UIRefreshControl()

    var completion: ((String) -> Void)?
    var onRefresh: (() -> Void)?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayouts()
        setupView()
    }
        
    private func setupView() {
        backgroundColor = .appMainBackground
        gistsTableView.delegate = self
        gistsTableView.dataSource = self
        gistsTableView.register(GistListTableViewCell.self, forCellReuseIdentifier: "GistCell")
        gistsTableView.layer.cornerRadius = 15
        gistsTableView.clipsToBounds = true
        gistsTableView.showsVerticalScrollIndicator = false
        gistsTableView.backgroundColor = .appMainTableCell
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        gistsTableView.refreshControl = refreshControl
        
        addSubview(gistsTableView)
    }
    
    private func setupLayouts() {
        gistsTableView.edgesToSuperview(insets: TinyEdgeInsets(top: 20, left: 15, bottom: 20, right: 15), usingSafeArea: true)
    }
    
    func updateGists(with gists: [GistListItemModel]) {
        self.gistsList = gists
        gistsTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Pull to Refresh Handler
    @objc private func handleRefresh() {
        onRefresh?()
    }
}

// MARK: - UITableViewDataSource

extension GistListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gistsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GistCell", for: indexPath) as? GistListTableViewCell else {
            return UITableViewCell()
        }
        let gist = gistsList[indexPath.row]
        cell.configure(with: gist)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension GistListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let gist = gistsList[indexPath.row]
        completion?(gist.gistName)
    }
}
