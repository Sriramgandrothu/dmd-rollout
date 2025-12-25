namespace sap.capire.dmd_rollout;

type WaveStatus : String enum {
    YET_TO_START;
    IN_PROGRESS;
    COMPLETED;
    ON_HOLD;
}

type RAG        : String enum {
    R;
    A;
    G;
}

entity Rollouts {
    key id                : Integer;
        waveId            : Integer;
        name              : String(30);
        status            : WaveStatus;
        rag               : RAG;
        completionPercent : Integer;
        startDate         : Date;
        endDate           : Date;
        actualStartDate   : Date;
        actualEndDate     : Date;
        golivePlannedDate : Date;
        goliveEndDate     : Date;
        reason            : String(100);
        openblockers      : String(100);
        createdAt         : Timestamp;
        createdBy         : String(12);
        lastModifiedAt    : Timestamp;
        lastModifiedBy    : String(12);
        totalMocks        : Integer;
        currentmock       : String(100);
        mocks             : Composition of many Mocks
                                on mocks.rolloutID = $self;
}

entity Mocks {
    key ID                : Integer;
        rolloutID         : Association to Rollouts;
        name              : String(10);
        owner             : String(12);
        startDate         : Date;
        endDate           : Date;
        actualStartDate   : Date;
        actualEndDate     : Date;
        status            : WaveStatus;
        rag               : RAG;
        completionPercent : Integer;
        createdAt         : Timestamp;
        createdBy         : String(12);
        lastModifiedAt    : Timestamp;
        lastModifiedBy    : String(12);
}


entity RolloutStatus {
    key Status : String(20);
}
