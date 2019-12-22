const { ServiceBroker } = require('moleculer')

module.exports = async (event, context) => {
  try {
    // declare broker
    const broker = new ServiceBroker({
      metrics: false,
      logger: true
    })
    // create service / action
    await broker.createService({
      name: 'OPENFAAS',
      actions: {
        AnalysisOrderCommand: {
          handler: function async () {
            return { done: true }
          }
        }
      }
    })
    // start broker
    await broker.start()
    // call action
    const result = await broker.call('OPENFAAS.AnalysisOrderCommand', event.payload)
    // return
    return context.status(200).succeed(result)
  } catch (e) {
    return context.status(400).fail(e.message)
  }
}
