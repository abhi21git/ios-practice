# ios-practice
This repository is to host practice project so that we can learn cool iOS Stuff<br>
[![Tuist badge](https://img.shields.io/badge/Powered%20by-Tuist-blue)](https://tuist.io)
[![iOS Practice workflow](https://github.com/abhi21git/ios-practice/actions/workflows/ios_practice_workflow.yml/badge.svg)](https://github.com/abhi21git/ios-practice/actions/workflows/ios_practice_workflow.yml)

### Setup
Before proceeding making sure you have tuist installed in your system<br>
  - Install mise (if not already, alternative methods [here](https://mise.jdx.dev/getting-started.html#alternate-installation-methods)):
```
  brew tap tuist/tuist
```  
  - Install (alternative methods [here](https://docs.tuist.io/guide/introduction/installation)):
```
  brew install --formula tuist
```
  - Uninstall:
```
  brew uninstall tuist
```
### Edit
To modify configuration of project run following command
```
tuist edit
```
<sup> It wraps the configuration in a macOS application to easily understand project structure.</sup> 
### Generate
To generate project run following command
```
tuist generate
```
<sup> The above command needs to be executed each time anything is added outside of Xcode or each time after pull or checkout.<br>
However it can be easily avoided using below method.</sup> 
### Automate
We have defined `checkout` and `merge` githooks into `.githooks` directory. <br>
To use them, run following command **ONLY** once,
```
git config --local core.hookspath .githooks/
```
