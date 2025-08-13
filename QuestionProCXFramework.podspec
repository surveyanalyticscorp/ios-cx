Pod::Spec.new do |spec|
    spec.name          = 'QuestionProCXFramework'
    spec.version       = '2.1'
    spec.summary       = 'Core Library'
    spec.description   = 'This is QuestionPro`s CX Survey library.'
    spec.homepage      = 'https://www.questionpro.com'
    spec.author        = { 'QuestionPro' => 'mobile@questionpro.com' }
    spec.license       = { :type => 'MIT', :file => 'LICENSE' }
    spec.source        = { :git => 'https://github.com/surveyanalyticscorp/ios-cx.git', :tag => spec.version }
    spec.swift_version = '6.0'
    spec.ios.deployment_target = '14'
    spec.vendored_frameworks = [
      "QuestionProCXFramework.xcframework"
    ]
  end
