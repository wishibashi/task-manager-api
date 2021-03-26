require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    let!(:user) { create(:user) }       # A exclamação quer dizer que o objeto user será criado 
                                        # nesse ponto e não no primeiro uso. O create cria no BD, enquanto
                                        # que o build só cria a instância em memória
    let(:user_id) { user.id }  
    
    let(:headers) do
        {
            'Accept' => 'application/vnd.taskmanager.v1',
            'Content-Type' => Mime[:json].to_s              # as info enviadas nas operações devem todos ter formato json
        }
    end

    before { host! 'api.qualquerdominio.test' }

    describe 'GET /users/:id' do
        before do
             get "/users/#{user_id}", params: {}.to_json, headers: headers    # define a URL, o corpo em branco, headers do get
                                                                    # para se concatenar variável não se pode utilizar aspas simples
        end

        context 'when the user exists' do
            it 'returns the user' do
                expect(json_body[:id]).to eq(user_id)  # texta se o id retornado é igual ao user_id
            end

            it 'returns status code 200' do  # 200=OK https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
                expect(response).to have_http_status(200)
            end
        end 

        context 'when the user does not exist' do
            let(:user_id) { 10000 }    # sobrescrevo user_id com um valor inexistente
            it 'returns status code 404' do  # 404=not foung
                expect(response).to have_http_status(404)
            end
        end
    end

    describe 'POST /users' do
        before do
            # user_params = { email: 'teste@email.com', password: '123456', password_confirmation: '123456' }
            post '/users', params: { user: user_params }.to_json, headers: headers
        end
        
        context 'when the request param are valid' do
            let(:user_params) { FactoryGirl.attributes_for(:user) }     # o FactoryGirl monta um hash com todos os 
                                                                        # atributos definidos /spec/factories
            it 'return status code 201' do
                expect(response).to have_http_status(201)               # 201=request has been fulfilled
            end

            it 'returns json data for the created user' do
                expect(json_body[:email]).to eq(user_params[:email])   
            end
        end
   
        context 'when the request param are invalid' do
            let(:user_params) { FactoryGirl.attributes_for(:user, email: 'invalid_email@') }  # sobrescrevendo email do FactoryGirl
     
            it 'return status code 422' do
                expect(response).to have_http_status(422)               # 422=Unprocessable Entity
            end
        
            it 'returns json data for the error' do
                expect(json_body).to have_key(:errors)
            end
        end
   
    end

    describe 'PUT /users/:id' do
        before do
             put "/users/#{user_id}", params: { user: user_params }.to_json, headers: headers
        end
        
        context 'when the request param are valid' do
            let(:user_params) { { email: 'new_email@taskmanger.com' } }  # apenas o item (email) que vamos alterar

            it 'return status code 200' do
                expect(response).to have_http_status(200)               # 200=OK
            end

            it 'returns json data for the updated user' do
                expect(json_body[:email]).to eq(user_params[:email])   
            end
        end
   
        context 'when the request param are invalid' do
            let(:user_params) { { email: 'invalid_email@' } }  # apenas o item (email) que vamos alterar

            it 'return status code 422' do
                expect(response).to have_http_status(422)      # 422=Unprocessable Entity
            end

            it 'returns json data for the error' do
                expect(json_body).to have_key(:errors)
            end
        end
   
    end

    describe 'DELETE /users/:id' do
        before do
             delete "/users/#{user_id}", params: {}.to_json, headers: headers    # define a URL, o corpo em branco, headers do get
                                                                       # para se concatenar variável não se pode utilizar aspas simples
        end
       
        it 'returns status code 204' do  
            expect(response).to have_http_status(204)       # 204=Successful: No Content
        end

        it 'removes the user from database' do
            expect( User.find_by(id: user.id) ).to be_nil  # User.find daria erro por não encontrar, User.find_by 
                                                    # simplesmente retorna nil
        end
        
    end

end
