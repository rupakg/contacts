class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.xml

  def index
    #@contacts = Contact.all
    from = params[:from]
    range_length = params[:length]

    respond_to do |format|
      #contacts = @contacts.map {|contact| json_for_contact(contact) }
	  contacts = Contact.all(:offset => from.to_i, :limit => range_length.to_i).map { |contact| json_for_contact(contact) }
      format.json { render :json => { :content => contacts } }
      format.html
      format.xml  { render :xml => @contact }
    end
	
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
      format.json do
        render :json => {
          :content => json_for_contact(@contact),
          :location => contact_path(@contact)
        }
      end

    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        flash[:notice] = 'Contact was successfully created.'
        format.json do
          render :json => { :content => json_for_contact(@contact) }, :status => :created,
                            :location => contact_path(@contact)
        end
        format.html { redirect_to(@contact) }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        flash[:notice] = 'Contact was successfully updated.'
        format.json do
          render :json => { :content => json_for_contact(@contact) }, :location => contact_path(@contact)
        end
        format.html { redirect_to(@contact) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.json { head :ok }
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end

  protected
  def json_for_contact(contact)
    { :guid => contact_path(contact),
      :fname => contact.fname,
      :lname => contact.lname,
      :dob => contact.dob
    }
  end

end
