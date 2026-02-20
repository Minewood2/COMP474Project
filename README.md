# COMP474Project

# Freshwater Aquarium Stocking Advisor:


# Knowledge Domain (D) Description:


Freshwater Aquarium Stocking Advisor:

In the domain of freshwater aquarium keeping, a knowledge domain (D) subset is fish selection. A variety of freshwater fish could be suitable for an aquarium based on tank size, tap water chemistry (pH, hardness), and behavioral traits (schooling or territorial species). 

As a hobbyist for over 15 years in freshwater tanks, we believe we are experts that can also reference readily available authoritative information on fish requirements (size, water chemistry). 


# Goal (G) Description:

Goal (G): Help users decide what fish to add to their new freshwater aquarium:

The goal is to develop a rules-based CLIPS system (advisor) that helps users (U) decide what fish to add to their new aquarium based on their tank size and tap water chemistry.

# SMART Goal:
Specific: System targets freshwater aquariums that have not yet been stocked with fish and suggests suitable species.

Measurable: System suggests a limited number of suitable fish compatible based on a limited list of readily available and popular species (15) in the freshwater hobby.

Achievable: System uses a set number of facts and rules to generate a list of suitable fish species (15 and 20 respectively).

Relevant: System is useful for novice hobbyists to help them choose fish species that will be least likely to perish in their new aquarium.

Time-bound: A user has a limited time to decide on what fish to add to their aquarium before the ammonia cycle breaks and must be repeated before considering stocking again. 




# User (U) Description:

Novice or beginner freshwater hobbyist:

The user (U) is a beginner or novice at freshwater aquarium keeping. Specifically, the user has never or has little experience in maintaining a freshwater aquarium. Additionally, the user has no or limited knowledge of the biological load of freshwater fish and their behavioral requirements. They are looking for advice on stocking their new small to medium aquarium (5 - 50 gallons) based on their tank size and tap water chemistry.



# Factbase (F):

Data structure (template):
	
1) Species Name
2) Suitable pH Range
3) Water Hardness Range (ppm)
4) Minimum tank size required (gallons)
5) Suitable Temperature Range (Celsius)
6) Temperament (peaceful, semi-aggressive, aggressive)
7) Behavior (schooling, territorial, or neither)
