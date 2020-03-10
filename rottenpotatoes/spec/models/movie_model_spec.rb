require 'rails_helper'
describe Movie do
    describe "Scenarios - should " do
        it "find movie with same director" do
            movie=Movie.create(director: 'Director1')
            movie2=Movie.create(director: 'Director1')
            expect(movie.similar_movies).to include(movie2)
        end
        it "find movie with different director" do
            movie=Movie.create(director: 'Director3')
            movie2=Movie.create(director: 'Director4')
            expect(movie.similar_movies).not_to include(movie2)
        end
        it "not find similar movies if we don't know director" do
            movie = Movie.create(title: 'Title1')
            expect(movie.similar_movies.size).to eq(0)
        end
        it "add director to existing movie" do
            movie = Movie.create(title: 'Title2')
            movie.update(director: 'Director5')
            expect(movie.similar_movies).to include(movie)
        end
end
end