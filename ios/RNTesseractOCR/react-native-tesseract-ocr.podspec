Pod::Spec.new do |s|
  s.name             = "react-native-tesseract-ocr"
  s.version          = "0.0.1"
  s.summary          = "React Native OCR"
  s.license          = "MIT"
  s.author           = { "Dhananjoy Biswas" => "ebappa1971@gmail.com" }

  s.platform         = :ios, "9.0"
  s.requires_arc     = true

  s.source_files     = "RNTesseractOCRManager.{h,m}"

  s.dependency "React"
end
