const Hapi = require('@hapi/hapi')
const { ServiceBroker } = require('moleculer')

const service = require('./service')

const gateway = new Hapi.Server()

const broker = new ServiceBroker({
  metrics: false,
  logger: true,
  validation: true,
  async started () {
    broker.logger.warn('Broker started')
    await gateway.start()
  },
  stopped: async () => {
    broker.logger.warn('Broker stopped')
  }
})

const start = async () => {
  // create service
  await broker.createService(service)
  // start broker
  await broker.start()
}

start()
