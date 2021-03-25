require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    let!(:user) { create(:user) }       # A exclamação quer dizer que o objeto user será criado 
                                        # nesse ponto e não no primeiro uso. O create cria no BD, enquanto
                                        # que o build só cria a instância em memória
    let(:user_id) { user.id }  
    
    before { host! 'api.qualquerdominio.test' }

    describe 'GET /users/:id' do
        before do
            headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
            get "/users/#{user_id}", params: {}, headers: headers    # define a URL, o corpo em branco, headers do get
                                                                    # para se concatenar variável não se pode utilizar aspas simples
        end

        context 'when the user exists' do
            it 'returns the user' do
                user_response = JSON.parse(response.body)
                expect(user_response['id']).to eq(user_id)  # texta se o id retornado é igual ao user_id
            end

            it 'returns status code 200' do  # 200=OK https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
                expect(response).to have_http_status(200)
            end

        context 'when the user does not exist' do
            let(:user_id) { 10000 }    # sobrescrevo user_id com um valor inexistente
            it 'returns status code 404' do  # 404=not foung
                expect(response).to have_http_status(404)
            end
        end
            
        end
    end
end
