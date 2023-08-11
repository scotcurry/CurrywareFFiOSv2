# Overview - Updated 8/11/2023

## Known Issue
- There is a bug in the 2.0 version of the library.  It is manifested in the [DatabaseAPIHandler class](https://github.com/scotcurry/CurrywareFFiOSv2/blob/main/CurrywareFFiOS/Classes/DatabaseAPIHandler.swift).  Currently it is required that you explicitly import the DatadogInternal package.  We shouldn't need this internal class.  The call to HTTPHeadersWriter will at some point be public.  This is needed for distributed tracing.

## TODO
- Implement Session Replay.  **Note** SwiftUI is not currently supported.  Support should be avaiable soon.  Session replay will work but the screens won't be rendered.

## Datadog iOS SDK Project

The project uses the iOS SDK 2.0 version of the libraries.  Key callouts of the code are:

- **AppDelegate** - In SwiftUI projects, the AppDelegate class is not added by default.  In this project that code just calls **DatadogRUMHandler** to [initialize the Datadog agent](https://docs.datadoghq.com/real_user_monitoring/ios/?tab=swiftpackagemanagerspm#initialize-the-library).
- **LoggingHandler** - A centralized location for all [Datadog logging](https://docs.datadoghq.com/logs/log_collection/ios/?tab=swiftpackagemanagerspm#overview).  There is a static method *createLogEntry* for generating all logging information.
- **Distributed Tracing** - Tracing gets enabled in the **DatadogRumHandler** class.  It is first implemented in the **SalesTaxListObservable** class with the following code:
```
        let tracer = Tracer.shared()
        let span = tracer.startRootSpan(operationName: "getSalesTaxList", tags: ["env": "prod"], startTime: nil)
        let spanContext = span.context
        
        let databaseHandler = DatabaseAPIHandler()
        print("Getting getSalesTaxList()")
        LoggingHandler.createLogEntry(message: "Getting getSalesTaxList()")
        do {
            let fetchSalesTaxEntries = try await databaseHandler.makeDatabaseAPICall(rootSpan: span)
        
        ...
        
        span.finish()
```
spanContext is passed to the **DatabaseAPIHandler** class.  Key code in that class is:
```
    func makeDatabaseAPICall(rootSpan: OTSpan) async throws -> [SalesTaxEntry] {
        
        let tracer = Tracer.shared()
        let responseSpan = tracer.startSpan(operationName: "makeDatabaseAPICall", childOf: rootSpan.context)
        
        // Datadog functionality.  Build out the headers
        let span = tracer.startSpan(operationName: "makeDatabaseAPICall", childOf: rootSpan.context)
        LoggingHandler.createLogEntry(message: "Trying makeDatabaseAPICallSpan")
        let headerWriter = HTTPHeadersWriter(samplingRate: 100)
        tracer.inject(spanContext: rootSpan.context, writer: headerWriter)
        
        let databaseURL = BundleHandler.getDatabaseAPIURL()
        if let databaseURL = URL(string: databaseURL) {
            var request = URLRequest(url: databaseURL)
            for (headerField, value) in headerWriter.traceHeaderFields {
                request.addValue(value, forHTTPHeaderField: headerField)
            }
            
            ...
            
            span.finish()
```

## Key iOS Async UI Concurrency

### ObservableState Object in View
- The View has a reference to a class.  That class **SalesTaxListObservable()** is going to @Publish a property in this case *salesTaxListItem* that gets cycled through to build the list.   That property gets updated by a call to the *getSalesTaxList()* method on the class.

**Database API View**
```
struct DatabaseAPIView: View {
    
    @StateObject private var stateTaxListIdentifiable = SalesTaxListObservable()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(stateTaxListIdentifiable.salesTaxListItems) {item in
                    Text(item.stateName)
                }
                
                ...
                .refreshable {
                    await stateTaxListIdentifiable.getSalesTaxList()
                }
            }
            .task {
                await stateTaxListIdentifiable.getSalesTaxList()
            }
```

**SalesTaxListObservable** - Should be more straight forward.  All of the crap in the middle is because for a list to be observable it needs to have a UUID and I didn't build a UUID into the datbase call.  Just match up the @Published property and the method name which are called in the view. **Important Note:** you need to add the @MainActor attribute to the class, it isn't there by default.
```
@MainActor
class SalesTaxListObservable: ObservableObject {
    
    @Published private(set) var salesTaxListItems: [SaleTaxEntryIdentifiable] = []
    
    func getSalesTaxList() async {
    
        ...
        
                tempSalesTaxList.append(salesTaxEntryIdentifiable)
            }
            print("Tax Entries: \(tempSalesTaxList.count)")
            LoggingHandler.createLogEntry(message: "Tax Entries: \(tempSalesTaxList.count)")
            salesTaxListItems = tempSalesTaxList
```
