# DevOps - Final Project

## Introduction

The purpose of this project is to design and implement a solution for automating the development workflows and deployments of the **Spring Pet Clinic** application, using tools that encapsulates concepts of all core modules covered during the training. 

The Project involves:

* Agile & Project Management
* Databases & Cloud Fundamentals
* Programming & Testing Fundamentals
* Continuous Integration
* Infrastructure as Code & Configuration Management
* Containerisation & Orchestration
* Cloud Configuration and Management

## Scope 

We worked with these 2 externally developed applications:

* https://github.com/spring-petclinic/spring-petclinic-angular
* https://github.com/spring-petclinic/spring-petclinic-rest

The **spring-petclinic-angular** serves as a front-end client using _AngularJS_, whilst the **spring-petclinic-rest** serves as an _API_ using _Java_.

The applicaion should be deployed considering the following:
* Multiple Environment support - test new features on an environment before merging their changes to the main branch
* Automation - changes on the GitHub repository automatically build and deploy to testing and live environments
* Running costs: the cost to develop the application and how they can be improved

## Metrics/Performance Standards:

- Agile workflow
- Thorough project tracking
- Equal participation/contribution
- Justification for decisions

## Team Organization and Project Management 

Our team adopted an Agile approach to the project management, organizng the project into sprints, assigning scrum roles and providing a product a backlog. For project tracking we used a Trello board. Backlog Items were assigned story points, acceptance criteria and _MoSCoW_ prioritisation, and moved from project _backlog_, to _sprint_ backlog, to -doing_, _reviewing_ and then _done_ as the project progressed. 
At the begining, the state of the Trello board was:

![](images/trello1.PNG)
![](images/trello2.PNG)

During the project, we had to do a few changes to the deadline, as you can see below:

![](images/trello3.PNG)
![](images/trello4.PNG)

At the end, we were able to complete all the sprints and tasks:
![]()

The Trello board can be accessed [here](https://trello.com/b/LcCodeyy/group-project) 

## Tools Used 

This prject leans heavily on automated processes in the form of CI/CD, which models all parts of our integration workflow such as build, test, package and deploy stages. The majority of decisions were made based on familiarity and confidence with the tools, in order for us to be able to work efficiently.

- We used **VSCode** as a development environment to access a **Ubuntu** virtual machine hosted on AWS.

- Kanban: We used the **Trello** board because it's and easy-to-use add-on power-ups that can help to assign members tasks, and set priority, and due dates.

- Version Control System (VCS): **Git** was used for version control and all memebers of the team had their repositories hoted on **GitHub**. Each developer created a different branch to isolate from the main version of the apllication. The main branch also contained a **development** to integrate the different branches code to test. The structure of the branches lokk as follow:
 ![](images/github.PNG)

- Database: **MySQL** - we will need to change from an in-memory database and onboard it to the cloud. MySQL is an easy-to-use database. 

- Continuous Integration / Continuous Deployment (CI/CD): **Jenkins**. This helps automate the parts of software development related to building, testing, and deploying, facilitating continuous integration and continuous delivery.
With the CI/CD pipeline configured and enabled, each developer completes the feature development and commits to the main integration branch and the CI/CD pipeline is triggered to perform each of the individual integration stages. 

![](images/jenkins.PNG)

- IaC & Config Management: **Terraform** and **Ansible**. These tools are very powerful, widely adapted, and work with most cloud infrastructures.

- Cloud: **AWS** - We created and deployed our instances using AWS cloud provider. We already have some level of experience with it. 

- Reverse Proxy: **NGINX** - Nginx is a web server that can also be used as a reverse proxy, load balancer, mail proxy, and HTTP cache. We are also familiar with NGINX.

- Containerisation: **Docker** - Docker was used to containerize the Spring app to simplify and accelerate the workflow. The _Eclipse Temurin_ which has a built-in JDK was used to define the base image. The image's application code was stored in the _app_ directory. The instructions from the Maeven and pom.xml were copied from the host machine into the /app directory. We run the command to install the dependencies into the image. Then the source code was add into the image. At the end, we specify which command we want to run when the image is executed inside a container. 

- Orchestration Tool: **Docker Swarm**. Our training plan had changed and the Kubernetes module has been pushed after the final project. Swarm is a container orchestration tool built into Docker that allows us to run a network of containers across multiple host machines. 

## Risk Assessment 

During the project, a risk assessment was designed to evaluate potential scenarios that may impact the project in a negative way. This initial risk assessment is shown below:

![]()

Some of the control measures implemented in the project to reduce the likelihood of a risk occurring are as follows:


## Testing

Testing is a crucial part of software development. 


