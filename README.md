# Decentralized Algorithm Trading Platform

+ More details can be found at document
+ You can also watch demos on our project web page: https://sites.google.com/view/playingwithmud

## 1. Setup and Configuration
+ Folders:
    + tomcat_test: a simple test to check whether server runs correctly
    + model_and_test_code: sample models and test code
    + original_contracts: original contracts in Solidify, for modification and extension
    + project_final: major part
+ Dependencies:
    + Java & JDK : 1.8
    + Apache Tomcat : 7.0.56 or 7.0.82
    + MongoDB : 3.6
    + Solidity : 0.4.20
    + Web3JS : 0.14.0
    + Ganache : 1.0.0
    + OS : Ubuntu 16.04LTS, Mac OS, Windows 7 & 10 (some paths need to
be changed)
    + IntelliJ IDEA : Ultimate
    + NodeJS and Python : general version
+ Steps for configuration:
    + Copy all `.jar` files in `project_final/lib` to Tomcat’s library, e.g. /opt/apache-tomcat-7.0.56/lib
    + If `tomcat_test` can not run after this operation, do not copy jsp.jar. Currently this issue happens on Ubuntu only.
    + Open `project_final/lib` with IntelliJ, and check the project structure is similar as Figure 26-29 in document
    + Choose a server and edit the configuration, as shown in Figure 28 and Figure 29 in document
    + Run this server, this will take several seconds to depoly
    + Open Ganache

## 2. Use the Platform
+ Some demos can be found at [project webpage](https://sites.google.com/view/playingwithmud) 

## 3. Restore the Platform
+ Delete all submissions in `out/artifacts/web2_war_exploded/upload`
+ Run MongoDB on command line, then delete database
```
mongo
use test
db.dropDatabase()
exit
```
+ Restart Ganache and server

## 4. Extension (Take seller as example)
+ If the original contract is modified, it should be re-compiled, this can also be done on Remix
```
solcjs --abi Seller_submit.sol
solcjs --bin Seller_submit.sol
```
+ Modify the format of ABIs and BINs to `SellerABI.js`, `Seller_submit_sol_Seller_abi.js` and `Seller_submit_sol_Seller_bin.js`
+ Replace the old .js files
