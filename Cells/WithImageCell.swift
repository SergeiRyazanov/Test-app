import UIKit

class WithImageCell: UITableViewCell {
        
    static var reuseID = "WithImageCell"
    
    //кнопка для открытия нового экрана
    var openNewScreenButton: UIButton = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    var openNewScreenHandler: (() -> Void)?
    
    //фон ячейки
    var cellColor: UIView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .lightGray
        return $0
    }(UIView())
    
    //изображение
    var cellImage: UIImageView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 240).isActive = true
        $0.layer.cornerRadius = 30
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    //название текста
    var cellName: UILabel = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 20)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellColor)
        cellColor.addSubview(cellImage)
        cellColor.addSubview(cellName)
        contentView.addSubview(openNewScreenButton)
        openNewScreenButton.addTarget(self, action: #selector(openNewScreen), for: .touchUpInside)
        
        setupConstraints()
    }
    
    func setupCell(post: DataSourceForWithImageCell) {
       
       cellImage.image = UIImage(named: post.image)
       cellName.text = post.name
       openNewScreenHandler = post.openNewScreenHadler
   }
   
   @objc private func openNewScreen() {
       
       openNewScreenHandler?()
   }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            //фон
            cellColor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cellColor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            cellColor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            cellColor.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            //кнопка
            openNewScreenButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            openNewScreenButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            openNewScreenButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            openNewScreenButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            //картинка
            cellImage.topAnchor.constraint(equalTo: cellColor.topAnchor, constant: 20),
            cellImage.trailingAnchor.constraint(equalTo: cellColor.trailingAnchor, constant: -20),
            cellImage.leadingAnchor.constraint(equalTo: cellColor.leadingAnchor, constant: 20),
            
            //название
            cellName.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 20),
            cellName.leadingAnchor.constraint(equalTo: cellImage.leadingAnchor, constant: 10),
            cellName.trailingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: -10),
            cellName.bottomAnchor.constraint(equalTo: cellColor.bottomAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
