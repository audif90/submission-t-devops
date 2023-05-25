'use strict'
require('dotenv').config()
const Hapi = require('@hapi/hapi')
const { options } = require('nodemon/lib/config')
const Joi = require('@hapi/joi')
Joi.objectId = require('joi-objectid')(Joi)
const url = `mongodb://${process.env.MONGO_URL}:${process.env.MONGO_PORT}/${process.env.MONGO_DB}`

const init = async () => {
    const server = Hapi.server({
        port: 8080,
        host: '0.0.0.0'
    })
// Register mongo plugin
    await server.register({
        plugin: require('hapi-mongodb'),
        options: {
            url: url,
            settings: {
                useUnifiedTopology: true
            },
            decorate: true
        }
    })
// Routes
    server.route(
        // Hello World : / 
        {
        method: 'GET',
        path: '/',
        handler: (request, h) => {
            console.log('base method hit')
            return 'Hello World!'
        }
    })
    // Mongo CRUD
    
    server.route({
        method: 'GET',  
        path: '/contact',
        handler: async (request, h) => {
            console.log('GET contacts method hit')
            try {
                const data = await request.mongo.db.collection(process.env.MONGO_COLLECTION)
                .find({})
                .toArray()
                const response = h.response({
                    status: 'success',
                    message: 'Get Contacts Successfully',
                    data: {
                      data
                    },
                  });
                  response.code(201);
                  return response;
                
            } catch (error) {
                console.error(error)

                const response = h.response({
                    status: 'error',
                    message: 'An error has occured!',
                  })
                  response.code(500)
                  return response
            }
        }   
    })

    server.route({
        method: 'GET',
        path: '/contact/{contactNumber}',
        handler: async (request, h) => {
            console.log('GET contact method hit')
            const { contactNumber } = request.params
            try {
                const data = await request.mongo.db.collection(process.env.MONGO_COLLECTION)
                .findOne({Contact_Number: parseInt(contactNumber)})
                const response = h.response({
                    status: 'success',
                    message: 'Get Contact Successfully',
                    data: {
                      data
                    },
                  });
                  response.code(201);
                  return response;
                
            } catch (error) {
                console.error(error)

                const response = h.response({
                    status: 'error',
                    message: 'An error has occured!',
                  })
                  response.code(500)
                  return response
            }
            
        }   
    })
    server.route({
        method: 'POST',
        path: '/contact',
        handler: async (request, h) => {
            console.log('POST method hit!')
            let { contactNumber, contactName } = request.payload
            contactNumber = parseInt(contactNumber)
            try {
                const data = await request.mongo.db.collection(process.env.MONGO_COLLECTION)
                .insertOne({
                    _id: contactNumber,
                    Contact_Number: contactNumber,
                    Contact_Name:   contactName
                })
                const response = h.response({
                    status: 'success',
                    message: 'Added Contact Successfully',
                    data: {
                      data
                    },  
                  });
                  response.code(201);
                  return response;
            } catch (error) {
                console.error(error)

                const response = h.response({
                    status: 'error',
                    message: 'An error has occured!',
                  })
                  response.code(500)
                  return response
            }
        }     
    }), 
    server.route({
        method: 'PUT',
        path: '/contact/{contactNumber}',
        options: {
            validate: {
                params: Joi.object({
                    contactNumber: Joi.required()
                }),
                failAction: async (request, h, err) => {
                      // During development, log and respond with the full error.
                      console.error(err);
                      throw err;
                    }
            }
        },
        handler: async (request, h) => {
            const { contactNumber } = request.params
            const { contactName } = request.payload
            const updatedData = {
                Contact_Number: parseInt(contactNumber),
                Contact_Name: contactName
            }
            try {
                const data = await request.mongo.db.collection(process.env.MONGO_COLLECTION)
                            .updateOne({Contact_Number: parseInt(contactNumber)}, {$set: updatedData})
                const response = h.response({
                    status: 'success',
                    message: 'Updated Contact Successfully',
                    data: {
                      data
                    },  
                  });
                  response.code(201);
                  return response;
                
            } catch (error) {
                console.error(error)

                const response = h.response({
                    status: 'error',
                    message: 'An error has occured!',
                  })
                  response.code(500)
                  return response
            }
        }   
    }),
    server.route({
        method: 'DELETE',
        path: '/contact/{contactNumber}',
        handler: async (request, h) => {
            console.log('DELETE method hit')
            const { contactNumber } = request.params
            try {
                const data = await request.mongo.db.collection(process.env.MONGO_COLLECTION)
                    .deleteOne({
                        Contact_Number: parseInt(contactNumber)
                    })
                const response = h.response({
                    status: 'success',
                    message: 'Delete Contacts Successfully',
                    data: {
                      data
                    },
                  });
                  response.code(201);
                  return response;
                
            } catch (error) {
                console.error(error)

                const response = h.response({
                    status: 'error',
                    message: 'An error has occured!',
                  })
                  response.code(500)
                  return response
            }
        }   
    })

// Server start    
    await server.start();
    console.log('Server running on %s', server.info.uri)
}

// Error handling on Unhandled Rejections
process.on('unhandledRejection', (err) => {

    console.error(err)
    process.exit(1)
})

// Start the server
init()
