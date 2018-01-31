package com.ckh.ssm;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * 2018/1/27 16:29
 *
 * @author CKH
 */
public class MainTest {
    public static void main(String[] args) {
            Logger logger = LogManager.getLogger(LogManager.ROOT_LOGGER_NAME);
            logger.trace("trace level");
            logger.debug("debug level");
            logger.info("info level");
            logger.warn("warn level");
            logger.error("error level");
            logger.fatal("fatal level");
    }
}
