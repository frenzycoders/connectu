const appController = require('express').Router();
    const {checkRequiredFields,checkRequiredHeaders,checkRequiredQueries} = require('../MiddleWares/MiddleWares');
    const AppServices = require('./app.service');
    
    //Get All Documents
    appController.get('/',AppServices.FetchAllAppServices)
    
    //Get By ID
    appController.get('/:id',AppServices.FetchSingleAppServices)
    
    
    //Create
    appController.post('/',AppServices.CreateAppServices)
    
    
    //Update by ID
    appController.patch('/:id',AppServices.UpdateAppServices)
    
    //DeleteAll
    appController.delete('/',AppServices.DeleteAllAppServices)
    
    //Delect by Id
    appController.delete('/:id',AppServices.DeleteSingleAppServices)
    
    module.exports = appController;