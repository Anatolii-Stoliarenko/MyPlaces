
import UIKit

class NewPlaceViewController: UITableViewController {

    var newPlace: Place? //создаем новую переменную структуры Place, чтобы можно было через нее заполнять наш массив
    var imageIsChanged = false
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var placeImage: UIImageView! //чтобы присвоить placeImage новое изображение, нужно реализорвать метод UIImagePickerContollerDelegate
    
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var placeType: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView() //заменяем низ TVC на VC. Избавляемся от линий снизу
        saveButton.isEnabled = false //отключаем по умолчанию кнопку и будем отслеживать в реальном времени заполнение placeName
        
        //отслеживаем редактирование текста placeName в реальном времени. Выполняем данный метод NewPlaceViewController(self)
        //метод textFieldChanged будет вызываться при редактированиие текста (.editingChanged) - event
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }

    //MARK: - Table View Delegate
    
    //этот метод определает на какую ячейку было нажато благодаря параметру indexPath
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { //реализовываем меню выбора картинки
            
           // let cameraIcon = #imageLiteral(resourceName: "cameraIco") // = image literal и выбираем картирнку
           //let photoIcon = #imageLiteral(resourceName: "cameraIco")
            
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            //определяем три пользовательских действия camera / photo / cancel
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                                      
                self.choosImagePicker(source: .camera) //вызываем функцию choosImagePicker и передаем ей параметр .camera
            }
            //camera.setValue(cameraIcon, forKey: "image") //вставляем картинку для кнопки camera. Нужно иметь картирки 2х и 3х
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment") //переносим надпись camera в лево
            
            let photo = UIAlertAction(title: "Photo", style: .default) {_ in
            
                self.choosImagePicker(source: .photoLibrary) //вызываем функцию choosImagePicker и передаем ей параметр .photoLibrary

            }
            //photo.setValue(photoIcon, forKey: "image") //вставляем картинку для кнопки photo. Нужно иметь картирки 2х и 3х
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment") //переносим надпись photo в лево
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) //destructive выделяет красный / cancel отделяет отдельным блоком

            actionSheet.addAction(camera) //вызываем UIAlertController и передаем ему UIAlertAction в виде camera
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
            
        } else {
            view.endEditing(true) //метод скрывает клавиатуру если была выбрана ячейка не 0
        }
    }
    
    func saveNewPlace() {
        
        var image: UIImage?
        
        if imageIsChanged {
            image = placeImage.image
        } else {
            image = #imageLiteral(resourceName: "defaultImage")
        }
        
        newPlace = Place(name: placeName.text!,
                         location: placeLocation.text,
                         type: placeType.text,
                         image: image,
                         restaurantImage: nil)
    }
    
    //segue кнопки Cancel. При нажатии закрываем окно и высвобождаем память
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
   
}

//чтобы можно было поработать с клавиатурой, подписываемся под протоколо

//MARK: - Text field delegate

extension NewPlaceViewController: UITextFieldDelegate {
    
    //скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    //проверяем placeName на пустоту или заполненость. Соответственно меняем свойство saveButton. Метод вызывается placeName.addTarget
    @objc private func textFieldChanged() {
        
        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

//MARK: - Work with image

//UIImagePickerControllerDelegate позаоляет присвоить актлету изображения новое изображение
extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //этот метод вызывает сам класс NewPlaceViewController в зависситости что выбирает пользователь в Alert
    func choosImagePicker(source: UIImagePickerController.SourceType) {
        
        //проверяем какой параметр нам придет, чтобы знать что открыкать: галерею или камеру
        if UIImagePickerController.isSourceTypeAvailable(source) { //проверяем на доступность параметра source
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self //imagePicker назначает делегата сам класс NewPlaceViewController (тот, кто выполняет)
            imagePicker.allowsEditing = true //позволяем пользователю редактировать выбранное изображение. Например масштабировать
            imagePicker.sourceType = source //присваиваем sourceType свойство source. Этот параметр зависит от быбора пользователя. camera, photo, cancel
            //imagePicker является VC. Чтобы его отобразить, то его нужно вызвать
            present(imagePicker, animated: true)
        }
    }
    
    //в этом методе реализовываем присвоение imagePicker  новое изображение. Он выполняется автоматически при нажатии кнопки choose в окне выбора картирнки
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        placeImage.image = info[.editedImage] as? UIImage //присваиваем imageOfPlace отредактированное изображение используя ключ editedImage. Их там много :)
        placeImage.contentMode = .scaleToFill //позволяет масштабировать изображение по содержимому UIImage
        placeImage.clipsToBounds = true //обрезка по границе
        imageIsChanged = true //меняем значение проверки добавлял пользователь фото или нет
        dismiss(animated: true) //отключает выбор фото
        //теперь нужно назначить делегатора(тот, кто делегирует обязанности UIImagePickerController) и делегата(выполняет данный метод)
    }
}
