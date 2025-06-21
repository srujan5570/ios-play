## iOS Integrated Document

### Integration options

Supports:
iOS 13.0+, Xcode15.3+

#### SDK install
(1).Copy the unzipped CastarSDK.framework file to the project folder

(2)Select the TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content menus, add the CastarSDK.framework file, and set the Embed property to Embed & Sign to keep the SDK dynamic library consistent with the application signature. At this point, the SDK import is complete

(3)Reference the CastarSDK.framework file to the project

(4)Ensure that the Embed option of CastarSDK.framework in Frameworks, Libraries, and Embedded Content is set to Embed&Sign

(5)Add the header file "import CastarSDK" to the referenced files

(6)Set the ClientId and start the SDK

```swift
//Example: Your CliendId is "CSK****FHQlUQZ"

import UIKit
    import CastarSDK

    class ViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.

            // Set ClientId
            let key = "CSK****FHQlUQZ"
                
            // Create a Castar instance
            let result = Castar.createInstance(withDevKey: key)
            
            if let castarInstance = result {
                // The instance is created and started
                castarInstance.start()
                            
            }else {
                // Handle errors
                print("Failed to initialize Castar: \(error.localizedDescription)")
            
            }
        }
    }

```




#### Optional APIs

##### Start service
castarInstance.start()

##### Stop service
castarInstance.Stop()
