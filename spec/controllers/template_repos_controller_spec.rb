require 'spec_helper'

describe TemplateReposController do

  describe 'GET #index' do

    let(:template_repos) { [TemplateRepo.new] }

    before do
      TemplateRepo.stub(:all).and_return(template_repos)
    end

    it 'renders the index view' do
      get :index
      expect(response).to render_template :index
    end

    it 'retrieves all template repos' do
      get :index
      expect(assigns(:template_repos)).to eq template_repos
    end
  end

  describe 'POST #create' do

    let(:fake_template_repo) { [TemplateRepo.new] }

    before do
      TemplateRepo.stub(:create).and_return(fake_template_repo)
    end

    it 'assigns the template repo' do
      post :create, template_repo: { name: 'user/repo' }
      expect(assigns(:template_repo)).to eq fake_template_repo
    end

    it 'creates a template repo with a sanitized name' do
      expect(TemplateRepo).to receive(:create).with(name: 'user/repo')
      post :create, template_repo: { name: 'user/repo' }
    end

  end

  describe 'POST #reload' do

    let(:template_repo) { double(:template_repo, post: true) }

    before do
      TemplateRepo.stub(:new).with({ id: '1' }, persisted = true).and_return(template_repo)
    end

    it 'reloads the template repo' do
      expect(template_repo).to receive(:post).with(:reload)
      post :reload, id: '1'
    end

    it 'redirects to template repos index path' do
      post :reload, id: '1'
      expect(response).to redirect_to template_repos_path
    end

  end

  describe 'DELETE #destroy' do

    let(:template_repo) { double(:template_repo, destroy: true) }

    before do
      TemplateRepo.stub(:new).with({ id: '1' }, persisted = true).and_return(template_repo)
    end

    it 'destroys the template repo' do
      expect(template_repo).to receive(:destroy)
      delete :destroy, id: '1'
    end

  end

end
