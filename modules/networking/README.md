Problems encountered:
- After constructing a VPC and its subnets, I tried deploying my microservices in an EKS cluster.
- [PROBLEM] HOWEVER, my nodegroup was failing to deploy because I was deploying my nodegroup in a private subnet, yet the private subnet had no NAT gateway associated; hence, no Internet access
- [SOLUTION] 

Documentation:
- Create one route table for each tier of subnets: one for private, one for public. 
- VPC:
    - ClassicLink is a soon-to-be deprecated AWS service that connects EC2-Classic instances to a VPC.
    EC2-Classic launched with the original release of AWS' EC2 and allowed instances within it to be run on a single, flat network that would be shared
    with customers.
    - Tenancy is a concept tied to EC2 instances and defines how the instances are distributed across physical hardware, affecting pricing.
    Default is used, otehr options cost at least $2/hour.