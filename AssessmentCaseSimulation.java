package com.ichwan.message;

import io.gatling.javaapi.core.*;
import io.gatling.javaapi.http.*;

import static io.gatling.javaapi.core.CoreDsl.*;
import static io.gatling.javaapi.http.HttpDsl.*;

public class AssessmentCaseSimulation extends Simulation {

    private static final String ACCESS_TOKEN = "TOKEN";

    private static final String INSTANCE_URL = "INSTANCE";

    private static final String API_ENDPOINT = "/services/data/v61.0/sobjects/Case/";

    HttpProtocolBuilder httpProtocol = http
            .baseUrl(INSTANCE_URL)
            .header("Authorization", "Bearer " + ACCESS_TOKEN)
            .header("Content-Type", "application/json")
            .header("Accept", "application/json");

    // ============================
    // SCENARIO: INSERT ACCOUNT
    // ============================

    ScenarioBuilder insertAccountScenario = scenario("Insert Bulk Cases")
            .exec(
                    http("Create Case")
                            .post(API_ENDPOINT)
                            .body(StringBody(
                                    "{\n" +
                                            "  \"ContactId\": \"ID\",\n" +
                                            "  \"RecordTypeId\": \"ID\",\n" +
                                            "  \"Status\": \"New\",\n" +
                                            "  \"Type\": \"Request\",\n" +
                                            "  \"Origin\": \"Email\",\n" +
                                            "  \"Subject\": \"Testing\",\n" +
                                            "  \"Description\": \"Testing From Postman 2\",\n" +
                                            "  \"Priority\": \"Medium\",\n" +
                                            "  \"OwnerId\": \"ID\",\n" +
                                            "  \"Case_Type__c\": \"Case_Type\",\n" +
                                            "  \"Case_Type_Config__c\": \"Case_Type\",\n" +
                                            "  \"Related_Department__c\": \"CCC\",\n" +
                                            "  \"PIC_Department_LU__c\": \"ID\"\n" +
                                            "}"
                            )).asJson()
                            .check(status().is(201))
                            .check(jsonPath("$.id").saveAs("caseId"))
            )
            .pause(1)
            .exec(session -> {
                System.out.println("✅ Created Case ID: " + session.get("caseId"));
                return session;
            });

    // ============================
    // SETUP
    // ============================

    {
        setUp(
                insertAccountScenario.injectOpen(
                        rampUsers(100).during(30)
                )
        ).protocols(httpProtocol);
    }

}
