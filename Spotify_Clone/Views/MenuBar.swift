//
//  MenuBar.swift
//  Spotify_Clone
//
//  Created by Rauf Aliyev on 13.02.22.
//

import Foundation
//
//  MenuBar.swift
//  ContainerDemo
//
//  Created by Rauf Aliyev on 10.02.22.
//

import Foundation
import UIKit


protocol MenuBarDelegate {
    func didSelectItemAt(index: Int)
    
}


class MenuBar: UIView {
    
    
    
    var playlistButton: UIButton!
    var artistButton: UIButton!
    var albumsButton: UIButton!
    var buttons: [UIButton]!
    
     var delegate: MenuBarDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        playlistButton = makeButton(withText: "Playlist")
        artistButton = makeButton(withText: "Artist")
        albumsButton = makeButton(withText: "Albums")
        buttons = [playlistButton, artistButton ,artistButton]
        
        playlistButton.addTarget(self, action: #selector(playlistButtonTapped), for: .primaryActionTriggered)
        artistButton.addTarget(self, action: #selector(artistButtonTapped), for: .primaryActionTriggered)
        albumsButton.addTarget(self, action: #selector(albumsButtonTapped), for: .primaryActionTriggered)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        addSubview(playlistButton)
        addSubview(artistButton)
        addSubview(albumsButton)
        
        NSLayoutConstraint.activate([
            playlistButton.topAnchor.constraint(equalTo: topAnchor),
            playlistButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            artistButton.topAnchor.constraint(equalTo: topAnchor),
            artistButton.leadingAnchor.constraint(equalTo: playlistButton.trailingAnchor, constant: 36),
            
            albumsButton.topAnchor.constraint(equalTo: topAnchor),
            albumsButton.leadingAnchor.constraint(equalTo: artistButton.trailingAnchor, constant: 36)
        
        ])
        playlistButton.alpha = 1
        artistButton.alpha = 0.5
        albumsButton.alpha = 0.5
    }
}

func makeButton(withText text: String)->UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    return button
}

extension MenuBar {
    @objc func playlistButtonTapped(){
        delegate?.didSelectItemAt(index: 0)
    }
    
    @objc func artistButtonTapped(){
        delegate?.didSelectItemAt(index: 1)
    }
    
    @objc func albumsButtonTapped(){
        delegate?.didSelectItemAt(index: 2)
    }
    
    
    func selectItem(at: Int){
        
        switch at {
        case 0:
            playlistButton.alpha = 1
            artistButton.alpha = 0.5
            albumsButton.alpha = 0.5
        case 1:
            playlistButton.alpha = 0.5
            artistButton.alpha = 1
            albumsButton.alpha = 0.5
        case 2:
            playlistButton.alpha = 0.5
            artistButton.alpha = 0.5
            albumsButton.alpha = 1
        default:
            playlistButton.alpha = 1
            artistButton.alpha = 0.5
            albumsButton.alpha = 0.5
        }
    }
}
