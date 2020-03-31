
import UIKit

class NewPlaceViewController: UITableViewController {

    
    @IBOutlet weak var imageOfPlace: UIImageView! //чтобы присвоить imageOfPlace новое изображение, нужно реализорвать метод UIImagePickerContollerDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView() //заменяем низ TVC на VC. Избавляемся от линий снизу 

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
   
}

//чтобы можно было поработать с клавиатурой, подписываемся под протоколо

//MARK: - Text field delegate

extension NewPlaceViewController: UITextFieldDelegate {
    
    //скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}

//MARK: - Work with image

//UIImagePickerControllerDelegate позаоляет присвоить актлету изображения новое изображение
extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func choosImagePicker(source: UIImagePickerController.SourceType) {
        
        //проверяем какой параметр нам придет, чтобы знать открыкать галерею или камеру
        if UIImagePickerController.isSourceTypeAvailable(source) { //проверяем на доступность параметра source
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self //imagePicker назначает делегата сам класс NewPlaceViewController (тот, кто выполняет)
            imagePicker.allowsEditing = true //позволяем пользователю редактировать выбранное изображение. Например масштабировать
            imagePicker.sourceType = source //присваиваем sourceType свойство source. Этот параметр зависит от быбора пользователя. camera, photo, cancel
            //imagePicker является VC. Чтобы его отобразить, то его нужно вызвать
            present(imagePicker, animated: true)
        }
    }
    
    //в этом методе реализовываем присвоение imagePicker  новое изображение
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageOfPlace.image = info[.editedImage] as? UIImage //присваиваем imageOfPlace отредактированное изображение используя ключ editedImage. Их там много :)
        imageOfPlace.contentMode = .scaleToFill //позволяет масштабировать изображение по содержимому UIImage
        imageOfPlace.clipsToBounds = true //обрезка по границе
        dismiss(animated: true) //отключает выбор фото
        //теперь нужно назначить делегатора(тот, кто делегирует обязанности UIImagePickerController) и делегата(выполняет данный метод)
    }
}
