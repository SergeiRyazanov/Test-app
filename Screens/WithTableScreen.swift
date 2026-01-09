import UIKit

class WithTableScreen: UIViewController {
    
    var forReturnButton = UIButton()
    lazy var returnButton = UIBarButtonItem(customView: forReturnButton)
    
    //тут начинается таблица
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WithImageCell.self, forCellReuseIdentifier: WithImageCell.reuseID)
        tableView.register(WithButtonCell.self, forCellReuseIdentifier: WithButtonCell.reuseID)
        tableView.dataSource = self
        return tableView
    }()
    
    var colorFirstCell: UIColor = .lightGray
        
    lazy var dataSourceWithImageCell =
    [DataSourceForWithImageCell(name: "Кобра", image: "cobra"),
    DataSourceForWithImageCell(name: "Горилла", image: "gorilla"),
    DataSourceForWithImageCell(name: "Леопард", image: "leopard"),
    DataSourceForWithImageCell(name: "Макака", image: "makaka")]
    
    lazy var dataSourceWithButtonCell = [DataSourceForWithButtonCell(title: "Я могу менять цвет",
                                                       
                                            returnBackHandler: { [weak self] in
        
        self?.navigationController?.popViewController(animated: true)
    },
                                                       
                                            changeColorCellHandler: { [weak self] in
        
        self?.colorFirstCell = ColorForCellWithButton.allCases.randomElement()?.uiColor ?? .lightGray
        let indexPath = IndexPath(row: 0, section: 0)
        self?.tableView.reloadRows(at: [indexPath], with: .automatic)
    })]
    //тут закончилась
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //кнопка возврата на первый экран
        forReturnButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        forReturnButton.tintColor = .systemBlue
        forReturnButton.addTarget(self, action: #selector(returnToFirstPage), for: .touchUpInside)
        navigationItem.leftBarButtonItem = returnButton
        
        //таблица
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        //таблица
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func returnToFirstPage() {
        
        navigationController?.popViewController(animated: true)
    }
}

extension WithTableScreen: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        dataSourceWithImageCell.count + dataSourceWithButtonCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: WithButtonCell.reuseID, for: indexPath) as! WithButtonCell
            let withButtonCell = dataSourceWithButtonCell[indexPath.row]
            cell.setupCell(post: withButtonCell)
            cell.backgroundColor = colorFirstCell
            return cell

        } else {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: WithImageCell.reuseID, for: indexPath) as! WithImageCell
            let withImageCell = dataSourceWithImageCell[indexPath.row - 1]
            cell.setupCell(post: withImageCell)
            cell.openNewScreenHandler = { [weak self] in
                let page = PageAboutCell()
                page.titleText = withImageCell.name
                page.imageName = withImageCell.image
                self?.navigationController?.pushViewController(page, animated: true)
            }

            return cell
        }
    }
}
