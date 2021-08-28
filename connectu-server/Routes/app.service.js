class AppServices {

        //Create 
        async CreateAppServices(req, res) {
            res.status(200).send({msg:"OK"})
        }
    
        //Fetch All
        async FetchAllAppServices(req, res) {
            res.status(200).send({msg:"OK"})
        }
    
        //Fetch SIngle 
        async FetchSingleAppServices(req, res) {
            res.status(200).send({msg:"OK"})
        }
    
        //Delete All Service
        async DeleteAllAppServices(req, res) {
            res.status(200).send({msg:"OK"})
        }
    
        //Delete Single Service
        async DeleteSingleAppServices(req, res) {
            res.status(200).send({msg:"OK"})
        }
    
        //Update Service
        async UpdateAppServices(req, res) {
            res.status(200).send({msg:"OK"})
        }
    }
    
    const appService = new AppServices();
    module.exports = appService;