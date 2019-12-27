const { ServiceBroker } = require('moleculer')
const ApiService = require('moleculer-web')

const configuration = {
  moleculer: {
    metrics: false,
    logger: true,
    validation: true,
    transporter: {
      type: 'AMQP',
      options: {
        url: 'amqp://infra:infra@rabbitmq.docker.localhost:5672',
        eventTimeToLive: 5000,
        prefetch: 1,
        // If true, queues will be autodeleted once service is stopped, i.e., queue listener is removed
        autoDeleteQueues: true
      }
    }
  }
}

const broker = new ServiceBroker({
  ...configuration.moleculer,
  async started () {
    broker.logger.warn('Broker started')
  },
  stopped: async () => {
    broker.logger.warn('Broker stopped')
  }
})

const start = async () => {
  // Load API Gateway
  broker.createService({
    mixins: [ApiService]
  })
  // Load all domains as services
  await broker.loadServices('./domains/dummy')
  await broker.start()
}

start()
