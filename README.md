# Apex Logger
Library allowing logging and exposing logs from Apex to Salesforce Admins via custom object
which results in improving debuggability of production environments.

Latest version: **0.0.4**

![Apex Logger Example Usage](images/example_usage_1.png)

## Features
- single, standalone class with minimal logging overhead
- ready to use permission set "Apex Logs User"
- auto resolving of calling methods and classes (also nested, inner classes)
- writing logs into the standard logs `System.debug`
- logs batching
- limits logging
- removal of old logs
- 4 logging levels out of the box (DEBUG, INFO, WARN, ERROR)

##### NOTE: Apex Logger uses current transaction scope, which means if there will be unhandled error/exception, the whole transation will be rolled back along with issued logs. It does not apply to the standard `System.debug` logs.

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

### Instantiation
```apex
// creates logger which is unbuffered and outputs standard logs if enabled in Apex Log Settings
ApexLogger log = ApexLogger.create();

// creates logger which is buffered and outputs standard logs if enabled in Apex Log Settings
ApexLogger log = ApexLogger.create(true);

// creates logger which is buffered and does write standard logs regardless of Apex Log Settings
ApexLogger log = ApexLogger.create(true, true);
```

### Logging
```apex
LOG.debug('Just debug');
LOG.info('That is an info');
LOG.warn('You have been warned');
LOG.error('Wooops, an error occured');

LOG.log(ApexLogger.DEBUG, 'Just debug');
LOG.log(ApexLogger.INFO, 'That is an info');
LOG.log(ApexLogger.WARN, 'You have been warned');
LOG.log(ApexLogger.ERROR, 'Wooops, an error occured');
LOG.log('MY TAG', 'Yayyy logged my own tag!');

LOG.debug('Debug log');
LOG.debug(exception);
LOG.debug('Debug log with exception', exception);
LOG.debug('Debug {0}', new Object[] { 'message' });
LOG.debug('Debug log with {0}', new Object[] { 'exception' }, exception);

LOG.log(ApexLogger.DEBUG, 'Debug log');
LOG.log(ApexLogger.DEBUG, exception);
LOG.log(ApexLogger.DEBUG, 'Debug log with exception', exception);
LOG.log(ApexLogger.DEBUG, 'Debug {0}', new Object[] { 'message' });
LOG.log(ApexLogger.DEBUG, 'Debug log with {0}', new Object[] { 'exception' }, exception);

// override class and method names
LOG.log(ApexLogger.DEBUG, 'FakeClass', 'FakeMethod', 'Explicit log');
LOG.log(ApexLogger.DEBUG, 'FakeClass', 'FakeMethod', exception);
LOG.log(ApexLogger.DEBUG, 'FakeClass', 'FakeMethod', 'Explicit log with exception', exception);
LOG.log(ApexLogger.DEBUG, 'FakeClass', 'FakeMethod', 'Explicit {0}', new Object[] { 'log' });
LOG.log(ApexLogger.DEBUG, 'FakeClass', 'FakeMethod', 'Explicit {0} with {1}', new Object[] { 'log', 'exception' }, exception);
```

### Outputting `System.debug` logs
You can enable this behaviour by setting enabling checkbox in `Output System Debug Logs` in `Apex Log Setting` custom metadata.\
This setting can be overridden by APEX statements from below:
```apex
// creates unbuffered logger which outputs standard logs
ApexLogger log = ApexLogger.create(false, true);

// enables standard logs output
log.setOutputtingSystemDebugLogs(true);

// checks if logger outputs standard debug logs
log.isOutputtingSystemDebugLogs();
```

#### Limits
Allows to log current execution usage/limits
```apex
// just log limits with no specified message
LOG.limits();

// log limits with custom message 
LOG.limits('Custom limit message:');

// log limits with custom message with parameters
LOG.limits('Custom limit {0}', new Object[] { 'message' });
```

![Apex Logger Example Usage](images/example_usage_3.png)

### Batching
```apex
// creates new batched instance of logger
ApexLogger LOG = ApexLogger.create(true);

// all subsequent log calls will be batched
LOG.debug('I will go to the batch first ;c');

// saves all batched logs to the database
// NOTE: flush will do nothing if logger is not batched!
LOG.flush();
```

### Manual batching control
Manual batching controls overwrites configuration loaded from `Apex Log Setting` custom metadata.
```apex
// enables batching
LOG.setBatched(true);

// disables batching
LOG.setBatched(false);

// checks if logger is batched
LOG.isBatched();
```

### Logs removal
```apex
LOG.delete();

// deletes all logs from org
LOG.deleteAll();

// deletes all logs prior to datetime
LOG.deleteBeforeDate(Datetime.newInstance(2019, 06, 01));

// deletes all logs except 100 latest
LOG.deleteToLimit(100);
```

## Considerations
### Stacktrace is lost/malformed when using custom exceptions
Avoid using custom exceptions and wrapping common exceptions into custom exceptions.
There is issue opened on Salesforce Success Platform with status No Fix - no reason given.
https://success.salesforce.com/issues_view?id=a1p300000008dVIAAY

## Changelog
### v0.0.4
- Added `Apex Log Settings` custom metadata - allows to adjust logger settings during runtime without need to deploy the code
- Added standard system logging - optionally writes logs into the standard system logs `System.debug` -
this behaviour can be explicitly enabled by setting second parameter to true `ApexLogger.create(false, true)`
or calling `log.setOutputtingSystemDebugLogs(true)`
- Changed `flush` behaviour, now it will save buffered logs even if the logger is not buffered.

### v0.0.3
- Added `limits` method, allowing to log execution limits with optional message
- Renamed methods/fields `buffer` to `batch`
- Renamed method `deleteAllLogs` to `deleteAll`
- Renamed method `deleteLogsBefore` to `deleteBeforeDate`
- Renamed method `deleteLogsToLimit` to `deleteToLimit`
- Minor fixes

### v0.0.2
- Removed method `getInstance`, use `create` instead
- Minor fixes

### v0.0.1
- Initial version
