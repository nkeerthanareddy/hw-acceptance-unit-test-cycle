require 'rails_helper'
describe MoviesController do
    describe "Scenarios - should " do
        it "create a movie" do
            @movie = double(title: 'title1')
            expect(Movie).to receive(:create!).with({title: 'title1',director: 'director1'}).and_return(@movie)
            get :create, {id: '1', movie: {title: 'title1',director: 'director1'} }
        end
        it "delete a movie" do
            @movie = double(title: 'title1')
            expect(Movie).to receive(:find).with('1').and_return(@movie)
            expect(@movie).to receive(:destroy).and_return(nil)
            get :destroy, {id: '1'}
        end
        it "update the movie properties" do
            @movie = double(title: 'title1')
            expect(Movie).to receive(:find).with('1').and_return(@movie)
            expect(@movie).to receive(:update_attributes!).and_return(nil)
            get :update, {id: '1', movie: {title: 'title1',rating: 'G', director: 'director1'}}
        end
        it "be able to edit the movie properties" do
            @movie = double(id: '1')
            expect(Movie).to receive(:find).with('1').and_return(@movie)
            get :edit, {id: '1'}
        end
        it "display movie properties" do
            @movie = double(title: 'title1')
            expect(Movie).to receive(:find).with('1').and_return(@movie)
            get :show, {id: '1'}
        end
        it "render the view" do
            @movie = double()
            @ratings = %w(G PG PG-13 NC-17 R)
            expect(Movie).to receive(:where).with(rating: Hash[@ratings.map {|rating| [rating, rating]}].keys).and_return(@movie)
            expect(@movie).to receive(:order).with(nil).and_return(['movie1'])
            get :index, {}
            expect(response).to render_template(:index)
        end
        it "be able to go to home page" do
            @movie=double().as_null_object
            expect(Movie).to receive(:find).with('1').and_return(@movie)
            get :director, {id: '1'}
            expect(response).to redirect_to(movies_path)
        end
    end
end