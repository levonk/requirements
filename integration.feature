Feature: System Integration

    Data needs to mvoe between many systems.   There are a lot of benefits if integration is done successfully.
    The following scenarios are met via http://www.confluent.io/

  @NonFunctional
  Scenario: Messages should be easily replicated to other queues
    Given Queue "X" is set up in a Virtual Private Cloud (VPC)
    When data is submitted into "X"
    Then it should be simple and cost effective to bridge queues into another cluster in another VPC.
  
  @NonFunctional
  Scenario: Messages should be stored
    Given Queue "X" is set up in a Virtual Private Cloud (VPC)
    When data is submitted into "X"
    Then a subscriber should be able to consume the events and persist them in partitioned files (e.g. Avro by day) for archival in low cost storage.
  
  @NonFunctional
  Scenario: Segment data by security
    Given Data has multiple levels of secuirty
    And data with less strict requirements can be sent via channels designed for higher levels of security
    When data is submitted into the lowest level queue
    Then the data can be replicated to the higher level queues.

  @NonFunctional
  Scenario: Inexpesive solution
    Given that it is difficult to negotiate, budget for, approve technology
    When a need for a new queue arises
    Then there should be no licensing, negotiation, scalability restrictions to deploy more queues

  @NonFunctional
  Scenario: Highly scalable
    Given Queue "X" is set up in a Virtual Private Cloud (VPC)
    When some segment generates many data packets
    Then the system should be horizontally scalable in a cost effective and unencumbered manner
  
  @NonFunctional
  Scenario: Strict Schema
    Given that the data flowing through the system can be any blob
    When data is put into the system
    Then the data should be validated against a schema

  @NonFunctional
  Scenario: Low latency
    Given A queue "X" is set up
    And A topic "T" exists
    And A publisher "Y" exists publishing events to "T"
    And A subscriber "Z" subscribes to topic "T"
    And "X", "Y" and "Z" all are in the same VPC
    When "Y" publishes data "A" into "T"
    Then "Z" receives "A" within 100ms

  @NonFunctional
  Scenario: System independance
    Given A queue "X" is set up
    And a topic "T" exists
    And a publisher "Y" exists publishing events to "T"
    And a subscriber "Z" subscribes to topic "T"
    And "X", "Y" and "Z" all are in the same VPC
    And "Z" is successfully consuming events from "Y" via "X"
    When "Y" is swapped out for a new system "Y'"
    And "Y'" is emitting the same events
    Then "X" should not require any changes
    And "Z" should not require any changes.
  
  @NonFunctional
  Scenario: Keep It Simple Silly - K.I.S.S
    Given A queue "X" is set up
    And a publisher "Y" want to publish data
    When the publisher "Y" does not directly support integrating with "X"
    Then a new integration must be created
    But "X" shuold not support functionality to bridge or transform data on behalf of "Y"

  @Question
  Scenario: Work around for Transaction Support
    Given An event "T" is published
    When the event needs transactional support
    Then event "T" is a complex document (as opposed to a normalized item) that is published as a single unit.
  
  @Question
  Scenaior: Preserving ordered delivery
    Given many events
    When the velocity and bandwidth of events do not surpass the capability of a single machine (partition)
    Then ordered delivery can be preseved
    But ordered delivery must be supported outside of the queue if the data must be partitioned.
  
  @Question
  Scenario: Number of Transactions per second
    Given there are several business units
    And the transactions per second are not easy to estimate
    Then the system must be horizontally scalable
  
  @Question
  Scenario: Discover capabilities about who/where publishers
    Given that the systems should be loosely coupled
    Then the data shoudl reside in the event about the publisher and where they are from
  
  #@Question
  #Scenario: Data (schema) they're publishing or is it need to know (lineage)?
    # Not sure about what is being asked here
    # Yes data should have a schema, but it should be kept in an external system (like SchemaRegistry) and validated on the client side
    # Yes there should be auditing, but it should be kept in an external system (like Secor)
    # Re: Delivery guarentee; systems should continue where they left off
    # Re: Secuirty; should be done via seperate VPCs
    # Re: different levels of data should be done by seperate queues (e.g. a Confidential/PII queue and an internal use only queue)
  
  #@Question
  #Scenario: Complex data message routing to consumers
    # Not sure what's being asked here
    # if there needs to be something complex (like a transform) then something can be built outside of the queue to transform that data, all consumers/subscribers should strive to standardize on a single format (e.g. Avro)

  @Question
  Scenario: Work around for per message receipt acknowledgement
    Given that the system needs to maintain optimum performance
    And receipt acknowledgement is performance heavy
    Then a seperate system should be set up that can have the responsiblity for monitoring delivery
  
  @Question
  Scenario: message replay
    Given: the cluster can be configured to store the message queue for arbitrary lengths
    Then any consumer should be able to ask for any offset to continue from
  
  @Question
  Scenario: filter on messages
    Given that a consumer needs filtered messages
    Then a seperate system should subscribe to the raw top and republish a dervied or aggregated topic for the benefit of the consumers that need the refined data
  
  @Question
  Scenario: Query on messages
    Given that a consumer needs to query on messages
    Then a seperate and queryable persistant store can be set up to allow query functionality if a seperate and refined topic doesn't already exist in the queue.
