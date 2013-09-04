apex-nest
=========

nesting sObjects a la d3.nest

introduction
------------

    Nest.er categorizedAmount = new Nest.er()
        .key( Nest.Key.field( 'Account.Region' ) )
        .key( Nest.Key.field( 'Account.Type' ) )
        .key( Nest.Key.field( Opportunity.StageName ) )
        .rollup( Nest.Sum.field( Opportunity.Amount ) );

    Object julyReport = categorizedAmount.doMap( Trigger.new );

    Nest.er topOpportunities = new Nest.er()
        .key( Nest.Key.field( 'Account.Region' ) )
        .sort( Nest.Sort.field( Opportunity.Amount ).desc() )
        .limit( 10 );

    Nest.er earningsReport = new Nest.er()
        .key( Nest.Key.field( 'Account.Region' ) )
        .rollup( Nest.Max.field( Opportunity.Amount ) )
        .key( Nest.Key.field( 'Account.Type' ) )
        .key( Nest.Key.field( Opportunity.StageName ) )
        .rollup( Nest.Sum.field( Opportunity.Amount ) )
        .rollup( Nest.Sum.field( Opportunity.ForecastAmount ) )
        .rollup( Nest.Count.records() );

    Nest.er byContactId = Nest.er()
                .key( Nest.Key.field( 'Contact__c' ) );

    try
    {
        update relatedContacts;
    }
    catch( DmlException ex )
    {
        Map<Object, Object> recordsByContactId =
            byContactId.doMap( originalRecords );
        ...
    }
