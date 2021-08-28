
const { checkRequiredFields, checkRequiredHeaders, checkRequiredQueries } = require('../../MiddleWares/MiddleWares');
const UserController = require('express').Router();
const { UserService } = require('./user.service');
const { isUserAuthenticated } = require('./../../MiddleWares/isUserAuthenticated.js')

UserController.post('/join-user', checkRequiredFields(['countryCode', 'number']), UserService.joinUserService)
UserController.post('/verify/:number/:id', checkRequiredFields(['otp']), UserService.verifyUserOTP);
UserController.patch('/update-profile', checkRequiredHeaders(['x-user']), isUserAuthenticated, UserService.updateUserProfile)
UserController.post('/resend-otp/:number', UserService.resendOtp);

module.exports = UserController;