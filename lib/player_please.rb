require 'logger'

module PlayerPlease
  def log(message)
    logger.debug(message)
  end
  
  def logger
    @logger ||= Logger.new('cheeky.log')
  end
end