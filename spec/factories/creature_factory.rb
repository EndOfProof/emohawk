FactoryGirl.define do
	factory :creature do
		name "eric"
		age 10
		gender :male
		factory :creature_too_old_to_breed do
			age 31
		end
		factory :creature_too_young_to_breed do
			age 5
		end
		factory :creature_male do
			gender :male
		end
		factory :creature_female do
			gender :female
		end
	end
end
