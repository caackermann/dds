class ProjectConnectionsController < ApplicationController
  before_action :set_project_connection, only: [:show, :edit, :update, :destroy]

  # GET /project_connections
  # GET /project_connections.json
  def index
    @project_connections = ProjectConnection.all
  end

  # GET /project_connections/1
  # GET /project_connections/1.json
  def show
  end

  # GET /project_connections/new
  def new
    @project = Project.find(params[:project_id])
    @project_connection = ProjectConnection.new
    @project_connection.methodology_evaluations.build


  end

  # GET /project_connections/1/edit
  def edit
  end

  # POST /project_connections
  # POST /project_connections.json
  def create
    puts "PARAMS",project_connection_params
    @project = Project.find(params[:project_id])
    @project_connection = @project.build_project_connection(project_connection_params)
    @methodology_evaluation=@project_connection.methodology_evaluations.build(project_connection_params[:methodology_evaluations_attributes])


    puts @project_connection.inspect
    puts @methodology_evaluation.inspect
    respond_to do |format|
      if @project_connection.save
        puts "HECHO"
        format.html { redirect_to current_user, notice: 'Project connection was successfully created.' }
        format.json { render :show, status: :created, location: @project_connection }
      else
        puts "ERROR"
        format.html { render :new }
        format.json { render json: @project_connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_connections/1
  # PATCH/PUT /project_connections/1.json
  def update
    respond_to do |format|
      if @project_connection.update(project_connection_params)
        format.html { redirect_to @project_connection, notice: 'Project connection was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_connection }
      else
        format.html { render :edit }
        format.json { render json: @project_connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_connections/1
  # DELETE /project_connections/1.json
  def destroy
    @project_connection.destroy
    respond_to do |format|
      format.html { redirect_to project_connections_url, notice: 'Project connection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_connection
      @project_connection = ProjectConnection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_connection_params
      puts "AQUI", [:methodology_id, :reason, :utility,  :pertinence, :relevance]
      params.require(:project_connection).permit(
        :needs, :ideas, methodology_evaluation_attributes: [:methodology_id, :reason, :utility,  :pertinence, :relevance])
    end
end
