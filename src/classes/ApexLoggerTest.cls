@IsTest
private class ApexLoggerTest {

	@IsTest
	static void debugMessage() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.debug('Message');
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.DEBUG, logs[0].Severity__c);
		System.assertEquals('Message', logs[0].Message__c);
		System.assertEquals('debugMessage', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(false, logs[0].WithException__c);
		System.assertEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void debugMessageWithArguments() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.debug('Message {0} {1}', new Object[] { 'with', 'arguments' });
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.DEBUG, logs[0].Severity__c);
		System.assertEquals('Message with arguments', logs[0].Message__c);
		System.assertEquals('debugMessageWithArguments', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(false, logs[0].WithException__c);
		System.assertEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void debugException() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.debug(new TestException('Message'));
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.DEBUG, logs[0].Severity__c);
		System.assertEquals('Exception thrown: ApexLoggerTest.TestException', logs[0].Message__c);
		System.assertEquals('debugException', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(true, logs[0].WithException__c);
		System.assertNotEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void infoMessage() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.info('Message');
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.INFO, logs[0].Severity__c);
		System.assertEquals('Message', logs[0].Message__c);
		System.assertEquals('infoMessage', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(false, logs[0].WithException__c);
		System.assertEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void infoMessageWithArguments() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.info('Message {0} {1}', new Object[] { 'with', 'arguments' });
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.INFO, logs[0].Severity__c);
		System.assertEquals('Message with arguments', logs[0].Message__c);
		System.assertEquals('infoMessageWithArguments', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(false, logs[0].WithException__c);
		System.assertEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void infoException() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.info(new TestException('Message'));
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.INFO, logs[0].Severity__c);
		System.assertEquals('Exception thrown: ApexLoggerTest.TestException', logs[0].Message__c);
		System.assertEquals('infoException', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(true, logs[0].WithException__c);
		System.assertNotEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void warnMessage() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.warn('Message');
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.WARN, logs[0].Severity__c);
		System.assertEquals('Message', logs[0].Message__c);
		System.assertEquals('warnMessage', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(false, logs[0].WithException__c);
		System.assertEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void warnMessageWithArguments() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.warn('Message {0} {1}', new Object[] { 'with', 'arguments' });
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.WARN, logs[0].Severity__c);
		System.assertEquals('Message with arguments', logs[0].Message__c);
		System.assertEquals('warnMessageWithArguments', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(false, logs[0].WithException__c);
		System.assertEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void warnException() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.warn(new TestException('Message'));
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.WARN, logs[0].Severity__c);
		System.assertEquals('Exception thrown: ApexLoggerTest.TestException', logs[0].Message__c);
		System.assertEquals('warnException', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(true, logs[0].WithException__c);
		System.assertNotEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void errorMessage() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.error('Message');
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.ERROR, logs[0].Severity__c);
		System.assertEquals('Message', logs[0].Message__c);
		System.assertEquals('errorMessage', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(false, logs[0].WithException__c);
		System.assertEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void errorMessageWithArguments() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.error('Message {0} {1}', new Object[] { 'with', 'arguments' });
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.ERROR, logs[0].Severity__c);
		System.assertEquals('Message with arguments', logs[0].Message__c);
		System.assertEquals('errorMessageWithArguments', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(false, logs[0].WithException__c);
		System.assertEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void errorException() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.error(new TestException('Message'));
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.ERROR, logs[0].Severity__c);
		System.assertEquals('Exception thrown: ApexLoggerTest.TestException', logs[0].Message__c);
		System.assertEquals('errorException', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(true, logs[0].WithException__c);
		System.assertNotEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void logMessage() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.log(ApexLogger.DEBUG, 'Message');
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.DEBUG, logs[0].Severity__c);
		System.assertEquals('Message', logs[0].Message__c);
		System.assertEquals('logMessage', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(false, logs[0].WithException__c);
		System.assertEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void logMessageWithArguments() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.log(ApexLogger.DEBUG, 'Message {0} {1}', new Object[] { 'with', 'arguments' });
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.DEBUG, logs[0].Severity__c);
		System.assertEquals('Message with arguments', logs[0].Message__c);
		System.assertEquals('logMessageWithArguments', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(false, logs[0].WithException__c);
		System.assertEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void logException() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.log(ApexLogger.DEBUG, new TestException('Message'));
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.DEBUG, logs[0].Severity__c);
		System.assertEquals('Exception thrown: ApexLoggerTest.TestException', logs[0].Message__c);
		System.assertEquals('logException', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest', logs[0].Class__c);
		System.assertEquals(true, logs[0].WithException__c);
		System.assertNotEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void customLogMessage() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.log(ApexLogger.ERROR, 'CustomClass', 'CustomLogMethod', 'Message');
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.ERROR, logs[0].Severity__c);
		System.assertEquals('Message', logs[0].Message__c);
		System.assertEquals('CustomLogMethod', logs[0].Method__c);
		System.assertEquals('CustomClass', logs[0].Class__c);
		System.assertEquals(false, logs[0].WithException__c);
		System.assertEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void customLogMessageWithArguments() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.log(ApexLogger.ERROR, 'CustomClass', 'CustomLogMethod', 'Message {0} {1}', new Object[] { 'with', 'arguments' });
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.ERROR, logs[0].Severity__c);
		System.assertEquals('Message with arguments', logs[0].Message__c);
		System.assertEquals('CustomLogMethod', logs[0].Method__c);
		System.assertEquals('CustomClass', logs[0].Class__c);
		System.assertEquals(false, logs[0].WithException__c);
		System.assertEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

	@IsTest
	static void customLogException() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		logger.log(ApexLogger.ERROR, 'CustomClass', 'CustomLogMethod', new TestException('Message'));
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(ApexLogger.ERROR, logs[0].Severity__c);
		System.assertEquals('Exception thrown: ApexLoggerTest.TestException', logs[0].Message__c);
		System.assertEquals('CustomLogMethod', logs[0].Method__c);
		System.assertEquals('CustomClass', logs[0].Class__c);
		System.assertEquals(true, logs[0].WithException__c);
		System.assertNotEquals(null, logs[0].Exception__c);
		System.assertNotEquals(null, logs[0].Timestamp__c);
		System.assertNotEquals(null, logs[0].Time__c);
	}

    @IsTest
    static void limits() {
        // given
        ApexLogger logger = ApexLogger.create();

        // when
        Test.startTest();
        logger.limits();
        Test.stopTest();

        // then
        List<Apex_Log__c> logs = getAllLogs();
        System.assertEquals(1, logs.size());
        System.assertEquals('LIMITS', logs[0].Severity__c);
        System.assert(logs[0].Message__c.startsWith('CPU Time'));
        System.assertEquals('limits', logs[0].Method__c);
        System.assertEquals('ApexLoggerTest', logs[0].Class__c);
        System.assertEquals(false, logs[0].WithException__c);
        System.assertEquals(null, logs[0].Exception__c);
        System.assertNotEquals(null, logs[0].Timestamp__c);
        System.assertNotEquals(null, logs[0].Time__c);
    }

    @IsTest
    static void limitsMessage() {
        // given
        ApexLogger logger = ApexLogger.create();

        // when
        Test.startTest();
        logger.limits('Message {0} {1}', new Object[] { 'with', 'arguments' });
        Test.stopTest();

        // then
        List<Apex_Log__c> logs = getAllLogs();
        System.assertEquals(1, logs.size());
        System.assertEquals('LIMITS', logs[0].Severity__c);
        System.assert(logs[0].Message__c.startsWith('Message with arguments\n\n'));
        System.assertEquals('limitsMessage', logs[0].Method__c);
        System.assertEquals('ApexLoggerTest', logs[0].Class__c);
        System.assertEquals(false, logs[0].WithException__c);
        System.assertEquals(null, logs[0].Exception__c);
        System.assertNotEquals(null, logs[0].Timestamp__c);
        System.assertNotEquals(null, logs[0].Time__c);
    }

	@IsTest
	static void nestedLog() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		Test.startTest();
		new InnerTestClass().innerTestMethod(logger);
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals('inner message', logs[0].Message__c);
		System.assertEquals('innerTestMethod', logs[0].Method__c);
		System.assertEquals('ApexLoggerTest.InnerTestClass', logs[0].Class__c);
	}

	@IsTest
	static void batchedLog() {
		// given
		ApexLogger logger = ApexLogger.create(true);

		// when
		logger.debug('One');
		logger.debug('Two');
		logger.debug('Three');
		logger.debug('Four');
		logger.debug('Five');

		// then
		System.assertEquals(true, logger.isBatched());
		System.assertEquals(0, getAllLogs().size());

		logger.flush();
		System.assertEquals(1, Limits.getDmlStatements());
		System.assertEquals(5, getAllLogs().size());
	}

	@IsTest
	static void unbatchedLog() {
		// given
		ApexLogger logger = ApexLogger.create();

		// when
		logger.debug('One');
		logger.debug('Two');
		logger.debug('Three');
		logger.debug('Four');
		logger.debug('Five');

		// then
        System.assertEquals(false, logger.isBatched());
        System.assertEquals(5, Limits.getDmlStatements());
        System.assertEquals(5, getAllLogs().size());
	}

    @IsTest
    static void batchControlLog() {
        // given
        ApexLogger logger = ApexLogger.create();

        // when
        logger.debug('One');

        // then
        System.assertEquals(false, logger.isBatched());
        System.assertEquals(1, Limits.getDmlStatements());
        System.assertEquals(1, getAllLogs().size());

        // and when
        logger.setBatched(true);
        logger.debug('Two');
        logger.debug('Three');
        logger.debug('Four');
        logger.debug('Five');

        // then
        System.assertEquals(true, logger.isBatched());
        System.assertEquals(1, Limits.getDmlStatements());
        System.assertEquals(1, getAllLogs().size());

        // and when
        logger.flush();

        // then
        System.assertEquals(2, Limits.getDmlStatements());
        System.assertEquals(5, getAllLogs().size());
    }

	@IsTest
	static void deleteAll() {
		// given
		ApexLogger logger = ApexLogger.create();
		logger.debug('One');
		logger.debug('Two');
		logger.debug('Three');

		// when
		Test.startTest();
		logger.deleteAll();
		Test.stopTest();

		// then
		System.assertEquals(0, getAllLogs().size());
	}

	@IsTest
	static void deleteBeforeDate() {
		// given
		ApexLogger logger = ApexLogger.create();
		Datetime now = System.now();
		insert new List<Apex_Log__c> {
			new Apex_Log__c(Timestamp__c = now),
			new Apex_Log__c(Timestamp__c = now.addDays(-5)),
			new Apex_Log__c(Timestamp__c = now.addDays(-10))
		};

		// when
		Test.startTest();
		logger.deleteBeforeDate(System.now().addDays(-5));
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(2, logs.size());
		System.assertEquals(now, logs[0].Timestamp__c);
		System.assertEquals(now.addDays(-5), logs[1].Timestamp__c);
	}

	@IsTest
	static void deleteToLimit() {
		// given
		ApexLogger logger = ApexLogger.create();
		Datetime now = System.now();
		insert new List<Apex_Log__c> {
				new Apex_Log__c(Timestamp__c = now),
				new Apex_Log__c(Timestamp__c = now.addDays(-5)),
				new Apex_Log__c(Timestamp__c = now.addDays(-10))
		};

		// when
		Test.startTest();
		logger.deleteToLimit(1);
		Test.stopTest();

		// then
		List<Apex_Log__c> logs = getAllLogs();
		System.assertEquals(1, logs.size());
		System.assertEquals(now, logs[0].Timestamp__c);
	}

    @IsTest
    static void ignoreLogsOnDeleteToLimit() {
        // given
        ApexLogger logger = ApexLogger.create();
        Datetime now = System.now();
        insert new List<Apex_Log__c> {
                new Apex_Log__c(Timestamp__c = now),
                new Apex_Log__c(Timestamp__c = now.addDays(-5)),
                new Apex_Log__c(Timestamp__c = now.addDays(-10))
        };

        // when
        Test.startTest();
        logger.deleteToLimit(10);
        Test.stopTest();

        // then
        System.assertEquals(3, getAllLogs().size());
    }

	private static List<Apex_Log__c> getAllLogs() {
		return [
			SELECT Time__c, Severity__c, Class__c, Method__c, Message__c, WithException__c, Exception__c, Timestamp__c
			FROM Apex_Log__c
            ORDER BY Timestamp__c DESC
		];
	}

	private class InnerTestClass {
		public void innerTestMethod(ApexLogger logger) {
			logger.info('inner message');
		}
	}

	public class TestException extends Exception { }
}
