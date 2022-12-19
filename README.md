# 은행창구 매니저 
> 예금 은행원 2명, 대출 은행원을 1명으로 설정하여 작업이 진행되도록 하였습니다.

- CommandLine으로 진행되었던 프로젝트의 UI를 구현하였습니다.
- DispatchQueue로 스레드 작업하던 부분을 `OperationQueue`로 `Refactoring` 하였습니다.


## 📱 실행화면
|BankView|
|:--:|
|<img src="https://user-images.githubusercontent.com/74251593/167122730-5fcc11a1-2299-4f3b-9c2c-5193475e49a5.gif" width="200" height="350">|
|스케쥴을 저장합니다.|

## 🗂 폴더 구조

```

└── BankManagerUIApp
    ├── Application
    │   ├── AppDelegate
    │   └── SceneDelegate
    ├── Presentation
    │   ├── CustomView
    │   │   ├── BankTaskTableViewCell
    │   │   └── BankCustomView
    │   └── BankViewController
    ├── Domain
    │   └── Model
    │       ├── Client
    │       │   ├── ClientQueueGenerator
    │       │   ├── Client
    │       │   └── Request
    │       ├── Queue
    │       │   ├── Protocol
    │       │   │   └── QueueProtocl
    │       │   ├── Node
    │       │   ├── LinkedList
    │       │   └── ClientQueue
    │       └── Bank
    │           ├── Protocol
    │           │   └── BankManagerable
    │           ├── Bank
    │           ├── BankManager
    │           └── BankRecord
    └── Extension
        └── Int+Extensions

```
