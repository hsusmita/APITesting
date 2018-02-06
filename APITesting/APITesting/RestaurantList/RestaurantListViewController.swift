//
//  ViewController.swift
//  APITesting
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class RestaurantListViewController: UIViewController {
	@IBOutlet var tableView: UITableView!
	private var viewModel = RestaurantListViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureTableView()
		self.reactive.makeBindingTarget { (controller, isExecuting) in
			UIApplication.shared.isNetworkActivityIndicatorVisible = isExecuting
		} <~ viewModel.isExecuting

		self.reactive.makeBindingTarget { controller, _  in
			controller.tableView.reloadData()
		} <~ viewModel.restaurantViewModels.producer.map { _ in () }

		viewModel.fetchRestaurants()
	}

	private func configureTableView() {
		let nib = UINib(nibName: "RestaurantTableViewCell", bundle: Bundle.main)
		self.tableView.register(nib, forCellReuseIdentifier: "RestaurantTableViewCell")
		self.tableView.dataSource = self
		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 150.0
	}
}

extension RestaurantListViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.restaurantViewModels.value.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
		cell.configure(model: self.viewModel.restaurantViewModels.value[indexPath.row])
		return cell
	}
}
