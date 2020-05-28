//
//  MovieAdditionViewController.swift
//  MoviesLib
//
//  Created by Ygor Duarte Lemos Pereira on 25/05/20.
//  Copyright © 2020 Ygor Duarte Lemos Pereira. All rights reserved.
//

import UIKit

class MovieAdditionViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldRating: UITextField!
    @IBOutlet weak var textFieldDuration: UITextField!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var textViewSummary: UITextView!
    @IBOutlet weak var buttonAddEdit: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelCategories: UILabel!
    
    // MARK: - Properties
    var movie: Movie!
    var selectedCategories: Set<Category> = [] {
        didSet {
            if selectedCategories.count > 0 {
                labelCategories.text = selectedCategories.compactMap({$0.name}).joined(separator: " | ")
            } else {
                labelCategories.text = "Categorias"
            }
        }
    }
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        if movie != nil {
            title = "Edição"
            textFieldTitle.text = movie.title
            textFieldRating.text = "\(movie.rating)"
            textFieldDuration.text = movie.duration
            textViewSummary.text = movie.summary
            imageViewPoster.image = movie.poster
            if let categories = movie.categories as? Set<Category>, categories.count > 0 {
                selectedCategories = categories
            }
            buttonAddEdit.setTitle("Alterar", for: .normal)
        }
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.height, height: 46))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing(_:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        textViewSummary.inputAccessoryView = toolbar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CategoriesTableViewController {
            vc.delegate = self
            vc.selectedCategories = selectedCategories
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let userInfo = notification.userInfo,
            let frameInfo  = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardFrame = frameInfo.cgRectValue
        
        scrollView.contentInset.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
          
    }
    
  
    // MARK: - IBActions
    @IBAction func selectImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar poster", message: "De onde você deseja escolher o poster?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { (_) in
                self.selectPictureFrom(source: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default){ (_) in
            self.selectPictureFrom(source: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photoAction = UIAlertAction(title: "Álbum de fotos", style: .default){ (_) in
            self.selectPictureFrom(source: .savedPhotosAlbum)
        }
        alert.addAction(photoAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func selectPictureFrom(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = source
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addUpdateMovie(_ sender: UIButton) {
        if movie == nil {
            movie = Movie(context: context)
        }
        
        movie.title = textFieldTitle.text
        movie.duration = textFieldDuration.text
        movie.summary = textViewSummary.text
        let rating = Double(textFieldRating.text!) ?? 0
        movie.rating = max(0, min(rating, 10))
        movie.image = imageViewPoster.image?.jpegData(compressionQuality: 0.8)
        movie.categories = selectedCategories as NSSet?
        
        do {
            try context.save()
            view.endEditing(true)
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
        
    }
}

extension MovieAdditionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textFieldTitle:
            textFieldRating.becomeFirstResponder()
        case textFieldRating:
            textFieldDuration.becomeFirstResponder()
        case textFieldDuration:
            textViewSummary.becomeFirstResponder()
        default:
            break
        }
        return true
    }
}

extension MovieAdditionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageViewPoster.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension MovieAdditionViewController: CategoriesDelegate {
    func setSelectedCategories(_ categories: Set<Category>) {
        selectedCategories = categories
    }
}

