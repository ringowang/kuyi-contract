FactoryGirl.define do
  factory :renting_phase do
    start_date "2017-10-05"
    end_date "2017-12-10"
    price "3650"
    cycles 1
    association :contract
  end
end
