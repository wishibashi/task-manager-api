require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) }

  # USANDO shoulda-matches
  # it { expect(user).to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('teste@dominio.com').for(:email) }
      
  end

  # APRENDIZADO 1:

  # # FactoryGirl.build cria um usuário de forma aleatória
  # before { @user = FactoryGirl.build(:user) }

  # it { expect(@user).to respond_to(:email) }
  # it { expect(@user).to respond_to(:name) }
  # it { expect(@user).to respond_to(:password) }
  # it { expect(@user).to respond_to(:password_confirmation) }
  # it { expect(@user).to be_valid }

  # APRENDIZADO 2:

  # subject é uma instância da classe em teste (User)
  # Estou definindo que o subject deve ser criado usando o FactoryGirl
  # subject { FactoryGirl.build(:user) }

  # No rails_helper.rb tem uma linha que pemite que nós não precisemos 
  # definir FactoryGirl para chamar o build 
  # subject { build(:user) }

  # it { expect(subject).to respond_to(:email) }
  # it { expect(subject).to respond_to(:name) }
  # it { expect(subject).to respond_to(:password) }
  # it { expect(subject).to respond_to(:password_confirmation) }
  # it { expect(subject).to be_valid }

  # APRENDIZADO 3:

  # it { is_expected.to respond_to(:email) }
  # it { is_expected.to respond_to(:name) }
  # it { is_expected.to respond_to(:password) }
  # it { is_expected.to respond_to(:password_confirmation) }
  # it { is_expected.to be_valid }

   # APRENDIZADO 4:

  # Preferido pelo instrutor pois usa o nome do objeto (user)
  # Tem a vantagem do let só criar o objeto na hora que é invocado pelo it  
  # let(:user) { build(:user) }

  # it { expect(user).to respond_to(:email) }
  # it { expect(user).to respond_to(:name) }
  # it { expect(user).to respond_to(:password) }
  # it { expect(user).to respond_to(:password_confirmation) }
  # it { expect(user).to be_valid }

  # APRENDIZADO 5:

  # let(:user) { build(:user) }

  # it { expect(user).to respond_to(:email) }
  
  # context 'when name is blank' do
  #   before { user.name = ' ' }

  #   it { expect(user).not_to be_valid}
  # end

  # context 'when name is nil' do
  #   before { user.name = nil }

  #   it { expect(user).not_to be_valid}
  # end

  # APRENDIZADO 6: shoulda-matchers

#   let(:user) { build(:user) }

#   it { expect(user).to respond_to(:email) }

#   it { expect(user).to validate_presence_of(:name) }
#   # it { expect(user).to validate_numericality_of(:age) }    # se tivesse o atributo age


# end
