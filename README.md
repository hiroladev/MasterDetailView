# Simple Master-Detail-View for macOS

![image](https://user-images.githubusercontent.com/48058062/119538182-242d8980-bd8b-11eb-8698-eec4445bec87.png)

This project can be used to develop an app with master-detail view for macOS with storyboard and AppKit (Xcode).


## Usage

The entries for the navigation are in the file "NavigationItems.json". The attribute "title" represents the navigation menu entry.
Each view controller is loaded with the storyboard id and can be designed with the help of storyboard.

```
[
    {
        "title": "Login",
        "storyboardID": "LoginViewController"
    },
    {
        "title": "Logs",
        "storyboardID": "LogViewController"
    },
    {
        "title": "Feedbacks",
        "storyboardID": "FeedbackViewController"
    },
    {
        "title": "Settings",
        "storyboardID": "SettingsViewController"
    },
    {
        "title": "About",
        "storyboardID": "AboutViewController"
    }
]

```

![image](https://user-images.githubusercontent.com/48058062/119540082-49bb9280-bd8d-11eb-9c87-c52282b21831.png)


## Contributing

I'm always grateful for tips and suggestions for improvement.


## License
[MIT](https://choosealicense.com/licenses/mit/)

## Note

Sorry for the bad english. I'm a native german speaker. :-)

