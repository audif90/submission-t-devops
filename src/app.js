'use strict'

const Hapi = require('@hapi/hapi')

const init = async () => {
    const server = Hapi.server({
        port: 8080,
        host: '0.0.0.0'
    })
// Routes

    server.route({

// Hello World : / 
        method: 'GET',
        path: '/',
        handler: (request, h) => {
            return 'Hello World!'
        }
    })

// Server start    
    await server.start();
    console.log('Server running on %s', server.info.uri)
}

// Error handling on Unhandled Rejections
process.on('unhandledRejection', (err) => {

    console.log(err)
    process.exit(1)
})

// Start the server
init()