# ios-practice
This repository is to host practice project so that we can learn cool iOS Stuff<br>
[![Tuist badge](https://img.shields.io/badge/Powered%20by-Tuist-blue)](https://tuist.io)

To generate project run following comman
```
tuist generate
```
The above command needs to be executed each time anything is added outside of Xcode or each time after pull or checkout.
However later can be easily avoided using below method.
<br><br><br>
We have defined `checkout` and `merge` githooks into `.githooks` directory.
To use them, run following command once,
```
git config --local core.hookspath .githooks/
```
  
