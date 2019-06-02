/*
 * MIT License
 *
 * Copyright (c) 2019 Michał Woźniak @ purplishdev/apex-logger-library
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
/**
 * Library allowing logging and exposing log messages from Apex to Salesforce Admins
 * which results in improving debuggability of production environments.
 *
 * @version 0.0.3
 */
public without sharing class ApexLogger {
	
	public static final String DEBUG    = 'DEBUG';
	public static final String INFO     = 'INFO';
	public static final String WARN     = 'WARN';
	public static final String ERROR    = 'ERROR';

	private static final String TIMESTAMP_FORMAT = 'yyyy-MM-dd HH:mm:ss';
	private static final IllegalUsageException BLANK_EXCEPTION = new IllegalUsageException();
	private static final Reflector REFLECTOR = new Reflector(ApexLogger.class.getName());

	private Boolean batched;

	private List<Apex_Log__c> batch;

	@TestVisible
	private ApexLogger(Boolean batched) {
		this.batched = batched;
		this.batch = new List<Apex_Log__c>();
	}

	/**
	 * Creates new ApexLogger instance with batched flag set to false
	 *
	 * @see ApexLogger#create(Boolean batched)
	 */
	public static ApexLogger create() {
		return ApexLogger.create(false);
	}
	
	/**
	 * Creates new ApexLogger instance
	 *
	 * @param batched flag indicating if logs should be batched before committing
	 *
	 * @return new ApexLogger
	 */
	public static ApexLogger create(Boolean batched) {
		return new ApexLogger(batched);
	}

	public Boolean isBatched() {
		return this.batched;
	}

	public void setBatched(Boolean batched) {
		this.batched = batched;
	}

    /* DEBUG */

	public void debug(String message) {
		this.debug(message, BLANK_EXCEPTION);
	}
	
	public void debug(Exception thrownException) {
		this.debug(null, thrownException);
	}
	
	public void debug(String messageFormat, Object[] arguments) {
		this.debug(messageFormat, arguments, BLANK_EXCEPTION);
	}
	
	public void debug(String messageFormat, Object[] arguments, Exception thrownException) {
		this.debug(String.format(messageFormat, arguments), thrownException);
	}
	
	public void debug(String message, Exception thrownException) {
		this.log(ApexLogger.DEBUG, message, thrownException);
	}

    /* INFO */

	public void info(String message) {
		this.info(message, BLANK_EXCEPTION);
	}
	
	public void info(Exception thrownException) {
		this.info(null, thrownException);
	}
	
	public void info(String messageFormat, Object[] arguments) {
		this.info(messageFormat, arguments, BLANK_EXCEPTION);
	}
	
	public void info(String messageFormat, Object[] arguments, Exception thrownException) {
		this.info(String.format(messageFormat, arguments), thrownException);
	}
	
	public void info(String message, Exception thrownException) {
		this.log(ApexLogger.INFO, message, thrownException);
	}

    /* WARN */

	public void warn(String message) {
		this.warn(message, BLANK_EXCEPTION);
	}
	
	public void warn(Exception thrownException) {
		this.warn(null, thrownException);
	}
	
	public void warn(String messageFormat, Object[] arguments) {
		this.warn(messageFormat, arguments, BLANK_EXCEPTION);
	}
	
	public void warn(String messageFormat, Object[] arguments, Exception thrownException) {
		this.warn(String.format(messageFormat, arguments), thrownException);
	}
	
	public void warn(String message, Exception thrownException) {
		this.log(ApexLogger.WARN, message, thrownException);
	}

    /* ERROR */

	public void error(String message) {
		this.error(message, BLANK_EXCEPTION);
	}
	
	public void error(Exception thrownException) {
		this.error(null, thrownException);
	}
	
	public void error(String messageFormat, Object[] arguments) {
		this.error(messageFormat, arguments, BLANK_EXCEPTION);
	}
	
	public void error(String messageFormat, Object[] arguments, Exception thrownException) {
		this.error(String.format(messageFormat, arguments), thrownException);
	}
	
	public void error(String message, Exception thrownException) {
		this.log(ApexLogger.ERROR, message, thrownException);
	}

    /* LIMITS */

    public void limits() {
        this.limits(null);
    }

    public void limits(String messageFormat, Object[] arguments) {
        this.limits(String.format(messageFormat, arguments));
    }

    public void limits(String message) {
        if (message == null) {
            message = buildLimitsMessage();
        } else {
            message += '\n\n' + buildLimitsMessage();
        }
        this.log('LIMITS', message);
    }

    /* LOG */

	public void log(String severity, String message) {
		this.log(severity, message, BLANK_EXCEPTION);
	}

	public void log(String severity, Exception thrownException) {
		this.log(severity, null, thrownException);
	}
	
	/**
	 * Creates log with given parameters and saves the log either to the database or to the batch
	 *
	 * Calling class and method names are automatically assumed from the internal stacktrace
	 *
	 * @param severity level of the log
	 * @param message embedded into the log
	 * @param thrownException message and stacktrace embedded into the log
	 */
	public void log(String severity, String message, Exception thrownException) {
		Caller caller = REFLECTOR.getCaller();
        String className = caller.className;
        String methodName = caller.methodName;
        this.log(severity, className, methodName, message, thrownException);
	}
	
	public void log(String severity, String formatMessage, Object[] arguments) {
		this.log(severity, formatMessage, arguments, BLANK_EXCEPTION);
	}
	
	public void log(String severity, String formatMessage, Object[] arguments, Exception thrownException) {
		this.log(severity, String.format(formatMessage, arguments), thrownException);
	}
	
	public void log(String severity, String className, String methodName, Exception thrownException) {
		this.log(severity, className, methodName, null, thrownException);
	}

	public void log(String severity, String className, String methodName, String message) {
		this.log(severity, className, methodName, message, BLANK_EXCEPTION);
	}
	
	public void log(String severity, String className, String methodName, String formatMessage, Object[] arguments) {
		this.log(severity, className, methodName, formatMessage, arguments, BLANK_EXCEPTION);
	}

	public void log(String severity, String className, String methodName, String formatMessage, Object[] arguments, Exception thrownException) {
		this.log(severity, className, methodName, String.format(formatMessage, arguments), thrownException);
	}
	
	/**
	 * Creates log with given parameters and saves the log either to the database or to the batch
	 *
	 * @param severity level of the log
	 * @param className of statement calling the log
	 * @param methodName of statement calling the log
	 * @param message embedded into the log
	 * @param thrownException message and stacktrace embedded into the log
	 */
	public void log(String severity, String className, String methodName, String message, Exception thrownException) {
		Apex_Log__c log = new Apex_Log__c(
			Severity__c = severity,
			Class__c = className,
			Method__c = methodName,
			Message__c = this.buildLogMessage(message, thrownException),
			Exception__c = this.buildExceptionMessage(thrownException),
			WithException__c = (thrownException == BLANK_EXCEPTION) ? false : true
		);
		this.save(log);
	}

	/**
	 * If batched, saves logs into database using 1 DML statement and clears the batch, otherwise does nothing.
	 */
	public void flush() {
		if (this.batched && !this.batch.isEmpty()) {
			insert this.batch;
			this.batch.clear();
		}
	}
	
	/**
	 * Deletes all logs from database using 1 DML statement
	 */
	public void deleteAll() {
        delete [SELECT Id FROM Apex_Log__c];
	}

	/**
	 * Deletes all logs from database prior to given datetime using 1 DML statement
	 *
	 * @param dt
	 */
	public void deleteBeforeDate(Datetime dt) {
		delete [SELECT Id FROM Apex_Log__c WHERE Timestamp__c < :dt];
	}

	/**
	 * Removes oldest logs to the given limit using 2 DML statements. If logs count is less than the limit, does nothing.
	 * Example: if there are 150 logs in database and log limit is set to 100, the 50 oldest logs are removed.
	 *
	 * @param logsLimit to which logs count will be adjusted
	 */
	public void deleteToLimit(Integer logsLimit) {
		Integer logsCount = [SELECT COUNT() FROM Apex_Log__c];
		if (logsCount > logsLimit) {
			delete [SELECT Id FROM Apex_Log__c ORDER BY Timestamp__c ASC LIMIT :(logsCount - logsLimit)];
		}
	}

	private String buildLogMessage(String message, Exception thrownException) {
		if (String.isBlank(message)) {
			message = 'Exception thrown: ' + thrownException.getTypeName();
		}
		return message;
	}
	
	private String buildExceptionMessage(Exception thrownException) {
		String message = '';
		while (thrownException != BLANK_EXCEPTION && thrownException != null) {
			message += thrownException.getTypeName() + ': ' + thrownException.getMessage() + '\n';
			message += thrownException.getStackTraceString() + '\n\n';
			thrownException = thrownException.getCause();
		}
		return message;
	}

    private String buildLimitsMessage() {
        return String.format(
                'CPU Time: {0} / {1} ms\nDB Time: {2} / {3} ms\nHeap: {4} / {5} bytes\n' +
                        'DML queries: {6} / {7}\nDML rows: {8} / {9}\n' +
                        'SOQL queries: {10} / {11}\nSOSL queries: {12} / {13}',
                new Object[] {
                        Limits.getCpuTime(), Limits.getLimitCpuTime(),
                        Limits.getDatabaseTime(), Limits.getLimitDatabaseTime(),
                        Limits.getHeapSize(), Limits.getLimitHeapSize(),
                        Limits.getDmlStatements(), Limits.getLimitDmlStatements(),
                        Limits.getDmlRows(), Limits.getLimitDmlRows(),
                        Limits.getQueries(), Limits.getLimitQueries(),
                        Limits.getSoslQueries(), Limits.getLimitSoslQueries()
                }
        );
    }

	private void save(Apex_Log__c log) {
		Datetime now = System.now();
		log.Timestamp__c = now;
		log.Time__c = now.format(TIMESTAMP_FORMAT);
		
		if (this.batched) {
			this.batch.add(log);
		} else {
			insert log;
		}
	}

	private class Reflector {
        private final Caller anonymousCaller = new Caller('AnonymousApex', 'AnonymousApex');
		private final Pattern callerPattern = Pattern.compile('\\.(.+):');
		private final String ignoredClass;
		
		public Reflector(String ignoredClass) {
			this.ignoredClass = ignoredClass;
		}

		public Caller getCaller() {
			final String stacktrace = new NullPointerException().getStackTraceString();
			final Matcher matcher = callerPattern.matcher(stacktrace);

			while (matcher.find()) {
				final List<String> haystack = matcher.group(1).split('\\.');
				if (haystack[0] == ignoredClass) {
					continue;
				}
				Caller caller = new Caller();
				caller.methodName = haystack.remove(haystack.size() - 1);
				caller.className = String.join(haystack, '.');
                return caller;
			}
            // reaches where when logger is executed in Anonymous Apex
            return anonymousCaller;
		}
	}
	
	private class Caller {
		public String className { get; set; }
		public String methodName { get; set; }
        public Caller() { }
        public Caller(String className, String methodName) {
            this.className = className;
            this.methodName = methodName;
        }
	}
	
	public class IllegalUsageException extends Exception { }
}
