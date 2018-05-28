/**
 * Created by gh on 2018/3/26.
 */
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/demo";

// insert data
function insertCollection (dbName, collectionName, myobj) {
    MongoClient.connect(url, function (err, client) {
        if (err) throw err;

        var db = client.db(dbName);

        db.collection(collectionName).insertOne(myobj, function(err, res) {
            if (err) throw err;
            console.log("insert successfully");
            client.close();
        });
    });
}


// find data
function findOne(dbName, collectionName, whereStr) {
    MongoClient.connect(url, function(err, db) {
        if (err) throw err;
        var dbo = db.db(dbName);
        //var whereStr = {"name":'èœé¸Ÿæ•™ç¨‹'};  // æŸ¥è¯¢æ¡ä»¶
        dbo.collection(collectionName).find(whereStr).toArray(function(err, result) {
            if (err) throw err;
            // print reuslt
            // console.log(result);
            // var tmp = result;
            db.close();
            res.render('',{});
            // console.log(result);
            return result;
        });
    });
}

// find all data
function findAll(dbName, collectionName){
    MongoClient.connect(url, function(err, db) {
        if (err) throw err;
        var dbo = db.db(dbName);

        dbo.collection(collectionName). find({}).toArray(function(err, result) {
            // è¿”å›žé›†åˆä¸­æ‰€æœ‰æ•°æ®
            if (err) throw err;
            console.log(result);
            db.close();
            return result;
        });
    });
}


// below are the testing code

var dbName = "test";
var collectionName = "site";
var myobj = {"name": "zhangxingshi", "password": "xxxxxxxxx" };

var whereStr = {"name": 'zhangxingshi'};

// test three API

insertCollection(dbName, collectionName, myobj);

// var result = findOne(dbName, collectionName, whereStr);
// console.log(result.password);

// here couldn't print cause in the findOne(), it can't return the result
// findOne(dbName, collectionName, whereStr);

// findAll(dbName, collectionName);