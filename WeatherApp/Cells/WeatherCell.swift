//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Akan on 2/21/21.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    let infoView = InfoView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(infoView)
        infoView.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(15)
            $0.top.bottom.equalToSuperview().inset(7.5)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
