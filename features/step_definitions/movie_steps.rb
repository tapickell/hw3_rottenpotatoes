# Add a declarative step here for populating the DB with movies.
# ??? need to use seeds.rb to populate the db before testing / migrate db:seeds


Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(", ") # split string
  ratings.each do |rating| # iterate over list
    if uncheck
      uncheck("ratings_#{rating}")
    else
      check("ratings_#{rating}")
    end
  end

end

When /^I press (.*)$/ do |press|
  click_button(press)
end

When /^I follow (.*)$/ do |press|
  click_link(press)
end

Then /I should see all the movies/ do
  if page.respond_to? :should
    page.should have_content(Movie.all)
  end
end

Then /I should not see any movies/ do
  if page.respond_to? :should
    page.should have_no_content(Movie.all)
  end
end

Then /I should see: (.*)/ do |title_list|
  titles = title_list.split(", ")
  titles.each do |title|
    if page.respond_to? :should
      page.should have_content(title)
    end
  end
end

Then /I should not see: (.*)/ do |title_list|
  titles = title_list.split(", ")
  titles.each do |title|
    if page.respond_to? :should_not
      page.should have_no_content(title)
    end
  end
end

Then /I should see movies sorted alphabetically/ do
  if page.respond_to? :should
    page.should have_content(Movie.order('title'))
  end
end

Then /I should see movies sorted by release date in ascending order/ do
  if page.respond_to? :should
    page.should have_content(Movie.order('release_date'))
  end
end

