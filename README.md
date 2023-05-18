# ios-practice
This repository is to host practice project so that we can learn cool iOS Stuff<br>
[![Tuist badge](https://img.shields.io/badge/Powered%20by-Tuist-blue)](https://tuist.io)

To modify configuration of project run following command
```
tuist edit
```
It wraps the configuration in a macOS application to easily understand project structure.
<br><br>
To generate project run following command
```
tuist generate
```
The above command needs to be executed each time anything is added outside of Xcode or each time after pull or checkout.
However later can be easily avoided using below method.
<br><br><br>
We have defined `checkout` and `merge` githooks into `.githooks` directory. <br>
To use them, run following command ONLY once,
```
git config --local core.hookspath .githooks/
```
  
