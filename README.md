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

We will be working with these 2 externally developed applications:

* https://github.com/spring-petclinic/spring-petclinic-angular
* https://github.com/spring-petclinic/spring-petclinic-rest

The **spring-petclinic-angular** serves as a front-end client using _AngularJS_, whilst the **spring-petclinic-rest** serves as an _API_ using _Java_.

The applicaion should be deployed considering the following:
* Multiple Environment support: How can a developer test their new features on an environment before merging their changes to the main branch?
* Automation: How can changes on the GitHub repository automatically build and deploy to testing and live environments?
* Running costs: What are your monthly estimates? How could they be improved?

## Metrics/Performance Standards:

- Agile workflow
- Thorough project tracking
- Equal participation/contribution
- Justification for decisions

## Team Organization and Project Management 

Our team adopted an Agile approach to the project management, organizng the project into sprints, assigning scrum roles and providing a product a backlog. For project tracking we used a Trello board. Backlog Items were assigned story points, acceptance criteria and MoSCoW prioritisation, and moved from project backlog, to sprint backlog, to review and then complete as the project progressed. 
At the begining, the state of the Trello board was:

![](images/trello1.PNG)
![](images/trello2.PNG)

During the project, we had to do a few changes to the board, as you can see below:


At the end, we were able to complete all the sprints and tasks:
![]()

The Trello board can be accessed [here](https://trello.com/b/LcCodeyy/group-project) 

## CI/CD Pipeline

This prject leans heavily on automated processes in the form of CI/CD, which models all parts of our integration workflow such as build, test, package and deploy stages. 

- **Jenkins**: With the CI/CD pipeline configured and enabled, each developer completes de feature development and commits to the main integration branch and the CI/CD pipeline is triggered to perform each of the individual integration stages. 

![](images/jenkins.PNG)

## Tools Used 

The majority of decisions were made based on familiarity and confidence with the tools, in order for us to be able to work efficiently.

- Kanban: We used the **Trello** board because it's and easy-to-use add-on power-ups that can help to assign members tasks, and set priority, and due dates.
- Version Control System (VCS): We used **Git & GitHub** because its a VCS tools that we have been most exposed to and we are most familiar with. 
- Database: **MySQL** - we will need to change from an in-memory database and onboard it to the cloud. MySQL is an easy-to-use database. 
- Continuous Integration / Continuous Deployment (CI/CD): **Jenkins**. This helps automate the parts of software development related to building, testing, and deploying, facilitating continuous integration and continuous delivery.
- IaC & Config Management: **Terraform** and **Ansible**. These tools are very powerful, widely adapted, and work with most cloud infrastructures.
- Cloud: **AWS** - Our training was focused on AWS. We already have some level of experience with it. 
- Reverse Proxy: **NGINX** - Nginx is a web server that can also be used as a reverse proxy, load balancer, mail proxy, and HTTP cache. We are also familiar with NGINX.
- Containerisation: **Docker** - Docker is the most popular in market share, familiarity and ease of use are key. It also comes with a large library of images that can be customized.
- Orchestration Tool: **Docker Swarm**. Our training plan had changed and the Kubernetes module has been pushed after the final project. Swarm is a container orchestration tool built into Docker that allows us to run a network of containers across multiple host machines. 

## Risk Assessment 

A risk assessment was designed to evaluate potential scenarios that may impact the project in a negative way. These measures could be implemented in the app such that these risks are less likely to occur. This initial risk assessment is shown below:

![]()

Some of the control measures implemented in the project to reduce the likelihood of a risk occurring are as follows:


## Testing

Testing is a crucial part of software development. 


