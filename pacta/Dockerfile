FROM 2dii/r-packages:latest
LABEL maintainer='Mauro Lepore'

COPY PACTA_analysis /bound
COPY create_interactive_report /create_interactive_report
COPY pacta-data /pacta-data
COPY StressTestingModelDev /StressTestingModelDev

RUN chmod -R a+rwX /bound
RUN chmod -R a+rwX /create_interactive_report
RUN chmod -R a+rwX /pacta-data
RUN chmod -R a+rwX /StressTestingModelDev

RUN exit 0
