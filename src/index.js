const AWS = require("aws-sdk");
const s3 = new AWS.S3();
const targetbucket = process.env.targetbucket;
const sourcebucket = process.env.sourcebucket;

exports.handler = async function index(event, context) {
    try {
      console.log('event:' + JSON.stringify(event));
      
      var objectkey = event.Records[0].s3.object.key;
      var copysource = encodeURI(sourcebucket + "/" + objectkey);
      var copyParams = { Bucket: targetbucket, CopySource: copysource, Key: objectkey};

      await s3.copyObject(copyParams, function(err, data) {
        if (err) console.log(err, err.stack); // an error occurred
        else     console.log(data);           // successful response
        
        
      });

      
    } catch (error) {
      console.error(error);
      await handleError(error, context);
    } 
};