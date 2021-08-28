const mongoose = require('mongoose');

const UserContactSchema = new mongoose.Schema({
    activeContacts: [{
        name: {
            type: String,
        },
        id: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User"
        },
        number: {
            type: String
        }
    }],
    deactiveContacts: [{
        name: {
            type: String,
        },
        number: {
            type: String
        }
    }],
    blockedContacts: [{
        name: {
            type: String
        },
        id: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User"
        },
        number: {
            type: String
        }
    }]
});
