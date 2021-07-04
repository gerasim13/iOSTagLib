Pod::Spec.new do |s|
  s.name                 = 'iOSTagLib'
  s.version              = '1.0.0'
  s.license              = { :type => 'MPL' }
  s.homepage             = 'https://github.com/gerasim13/iostaglib'
  s.authors              = { 'Pavel Litvinenko' => 'gerasim13@gmail.com' }
  s.summary              = 'TagLib Audio Metadata Library'
  s.framework            = 'Foundation'
  s.platform             = :ios, '10.0'
  s.source               = { :git => 'https://github.com/gerasim13/iOSTagLib.git', :submodules => true }
  s.source_files         = [
    '*.{h,m,cpp}',
    'taglib/taglib/**/*.{h,cpp,tcc}',
    'taglib/3rdparty/**/*.{h,cpp}',
    'taglib/bindings/**/*.{h,cpp}'
  ]
  s.module_map = 'iOSTagLib.modulemap'
  s.public_header_files  = [
    'NSURL+TagLib.h',
    'iOSTagLib-umbrella.h',
    'taglib/bindings/**/*.h',
  ]
  s.private_header_files = [
    'TagLib+CoverArt.h',
  ]
  s.xcconfig             = {
    'CLANG_WARN_DOCUMENTATION_COMMENTS' => 'NO',
    'USE_HEADERMAP' => 'NO',
    # 'ALWAYS_SEARCH_USER_PATHS' => 'NO',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++14',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'OTHER_LINK_FLAG' => '$(inherited) -ObjC -lc++',
    'USER_HEADER_SEARCH_PATHS' => [
      '$(inherited)',
      '$(PODS_ROOT)/iOSTagLib/**',
      '$(PODS_ROOT)/iOSTagLib/taglib/taglib/**',
      '$(PODS_ROOT)/iOSTagLib/taglib/taglib/toolkit/**',
      '$(PODS_ROOT)/iOSTagLib/taglib/taglib/ogg/**',
    ],
    'HEADER_SEARCH_PATHS' => [
      '$(inherited)',
      '$(PODS_ROOT)/iOSTagLib/taglib/taglib/**',
      '$(PODS_ROOT)/iOSTagLib/taglib/3rdparty/**',
    ],
  }
  s.static_framework = true
  s.library          = 'c++'
end