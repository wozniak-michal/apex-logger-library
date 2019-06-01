# Apex Logger
Library allowing logging and exposing logs from Apex to Salesforce Admins via custom object
which results in improving debuggability of production environments.

Latest version: **0.0.2**

![Apex Logger Example Usage](images/example_usage_1.png)

## Features
- single, standalone class with minimal logging overhead
- ready to use permission set "Apex Logs User"
- auto resolving of calling methods and classes (also nested, inner classes)
- logs batching/buffering
- removal of old logs
- 4 logging levels out of the box (DEBUG, INFO, WARN, ERROR)
- 100% code coverage by tests

## Example Usage
```apex
public class AccountService {

	// creates logger instance
	private static final ApexLogger LOG = ApexLogger.create();
	
	public void createAccount(String name) {
		try {
			methodThrowingException(name);
		} catch (Exception e) {
			// logs directly into database
			LOG.debug('Unable to create user ' + name, e);
		}
	}
}
```
Class and methods names are automatically resolved and exception stacktrace included

![Apex Logger Example Usage](images/example_usage_2.png)

### Logging
```apex
logger.debug('Just debug');
logger.info('That is an info');
logger.warn('You have been warned');
logger.error('Wooops, an error occured');

logger.log(ApexLogger.DEBUG, 'Just debug');
logger.log(ApexLogger.INFO, 'That is an info');
logger.log(ApexLogger.WARN, 'You have been warned');
logger.log(ApexLogger.ERROR, 'Wooops, an error occured');

logger.debug('Debug log');
logger.debug(exception);
logger.debug('Debug log with exception', exception);
logger.debug('Debug {0}', new Object[] { 'message' });
logger.debug('Debug log with {0}', new Object[] { 'exception' }, exception);

logger.log(ApexLogger.DEBUG, 'Debug log');
logger.log(ApexLogger.DEBUG, exception);
logger.log(ApexLogger.DEBUG, 'Debug log with exception', exception);
logger.log(ApexLogger.DEBUG, 'Debug {0}', new Object[] { 'message' });
logger.log(ApexLogger.DEBUG, 'Debug log with {0}', new Object[] { 'exception' }, exception);

// override class and method names
logger.log(ApexLogger.DEBUG, 'FakeClass', 'FakeMethod', 'Explicit log');
logger.log(ApexLogger.DEBUG, 'FakeClass', 'FakeMethod', exception);
logger.log(ApexLogger.DEBUG, 'FakeClass', 'FakeMethod', 'Explicit log with exception', exception);
logger.log(ApexLogger.DEBUG, 'FakeClass', 'FakeMethod', 'Explicit {0}', new Object[] { 'log' });
logger.log(ApexLogger.DEBUG, 'FakeClass', 'FakeMethod', 'Explicit {0} with {1}', new Object[] { 'log', 'exception' }, exception);
```


### Batching/Buffering
```apex
// creates new buffering instance of logger
ApexLogger logger = ApexLogger.create(true);

// all subsequent log calls will be batched/buffered
logger.debug('I will go to the buffer first ;c');

// saves all logs to the database
// NOTE: flush will do nothing if logger is not buffered!
logger.flush();
```

Manual buffering control
```apex
// enables buffering
logger.setBuffered(true);

// disables buffering
logger.setBuffered(false);
```

### Logs removal
```apex
ApexLogger logger = ApexLogger.create();

// deletes all logs from org
logger.deleteAllLogs();

// deletes all logs prior to datetime
logger.deleteLogsBefore(datetime);

// deletes all logs except 100 latest
logger.deleteLogsToLimit(100);
```

## Considerations
### Stacktrace is lost/malformed when using custom exceptions
Avoid using custom exceptions and wrapping common exceptions into custom exceptions.
There is issue opened on Salesforce Success Platform with status No Fix - no reason given.
https://success.salesforce.com/issues_view?id=a1p300000008dVIAAY

## Changelog
### v0.0.2
- Removed `ApexLogger.getInstance()` method
- Minor fixes

### v0.0.1
- Initial version
