var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/demo";

// insert data
function insertCollection (dbName, collectionName, myobj) {
    MongoClient.connect(url, function (err, client) {
        if (err) throw err;

        var db = client.db(dbName);

        db.collection(collectionName).insertOne(myobj, function(err, res) {
            if (err) throw err;
            console.log("æ–‡æ¡£æ’å…¥æˆåŠŸ");
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
            // return result
            console.log(JSON.stringify(result));
            return JSON.stringify(result);
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


var myobj = {"name": "zhuboshi", "password": "xxx" };

var whereStr = {"name": 'zhuboshi'};



// test three API

// insertCollection(dbName, collectionName, myobj);

// var result = findOne(dbName, collectionName, whereStr);
// console.log(result.password);

// here couldn't print cause in the findOne(), it can't return the result
// console.log(findOne(dbName, collectionName, whereStr));

// findAll(dbName, collectionName);


// var collectionName2 = "user";


// var user1 = {"name": "adam", "password": "xxx", "meta": "0x8cdaf0cd259887258bc13a92c0a6da92698644c0", "seller": "0xf17f52151ebef6c7334fad080c5704d77216b732", "buyer": "0x9bC1169Ca09555bf2721A5C9eC6D69c8073bfeB4"};
// var user2 = {"name": "yunqiu", "password": "xxx", "meta": "0xb9a219631aed55ebc3d998f17c3840b7ec39c0cc", "seller": "0x2e2d10b41b7c8ddb995568a87185428d9a513ead", "buyer": "0x0E79EDbD6A727CfeE09A2b1d0A59F7752d5bf7C9"};
// var user3 = {"name": "zhu", "password": "xxx", "meta": "0x2e2d10b41b7c8ddb995568a87185428d9a513ead", "seller": "0xc5fdf4076b8f3a5357c5e395ab970b5b54098fef", "buyer": "0xc449a27B106BE1120Bd1Fd62F8166A2F61588eb9"};
// var user4 = {"name": "stone", "password": "xxx", "meta": "0x471c92f915ae766c4964eedc300e5b8ff41e443c", "seller": "0x821aea9a577a9b44299b9c15c88cf3087f3b5544", "buyer": "0xF24AE9CE9B62d83059BD849b9F36d3f4792F5081"};

// insertCollection(dbName, collectionName2, user1);
// insertCollection(dbName, collectionName2, user2);
// insertCollection(dbName, collectionName2, user3);
// insertCollection(dbName, collectionName2, user4);

var dbName = "test";
var collectionName3 = "shopping";

var item1 = {"buyerMetaAddr": "", "buyerContraAddr": "","sellerMetaAddr": "", "sellerContraAddr": "", "modelIndSeller": "", "name":"", "des": "","price":"", "time":""};

var item1 = {"buyerMetaAddr": "0x8cdaf0cd259887258bc13a92c0a6da92698644c0", "buyerContraAddr": "0x534af0cd259887258bc13a92c0a6da92698644c0","sellerMetaAddr": "0xf17f52151ebef6c7334fad080c5704d77216b732", "sellerContraAddr": "0x9bC1169Ca09555bf2721A5C9eC6D69c8073bfeB4", "modelIndSeller": "1", "name":"huffman", "des": "0x9bC1169Ca09555bf2721A5C9eC6D69c8073bfeB4","price":"324", "time":"123"};
var item2 = {"buyerMetaAddr": "0xb9a219631aed55ebc3d998f17c3840b7ec39c0cc", "buyerContraAddr": "0x45gaf0cd259887258bc13a92c0a6da92698644c0","sellerMetaAddr": "0x2e2d10b41b7c8ddb995568a87185428d9a513ead", "sellerContraAddr": "0x0E79EDbD6A727CfeE09A2b1d0A59F7752d5bf7C9", "modelIndSeller": "1", "name":"ai", "des": "0x9bC1169Ca09555bf2721A5C9eC6D69c8073bfeB4","price":"234", "time":"123"};

insertCollection(dbName, collectionName3, item1);
insertCollection(dbName, collectionName3, item2);

