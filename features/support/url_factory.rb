module UrlFactory
  
  def loginpage
    ENV['base_url'] + '/login.jspa'
  end

  def homepage
    ENV['base_url'] + '/activity'
  end

  def welcomepage
    ENV['base_url'] + '/welcome'
  end

  def activitypage
    ENV['base_url'] + '/activity'
  end
  
  def contentpage
    ENV['base_url'] + '/content'
  end

  def blogposteditpage
    ENV['base_url'] + "/blog/update-post#{/.*/}"
  end

  def blogpostpage
    /#{ENV['base_url']}\/blog\/create\-post\.jspa\?sr\=cmenu\&containerType\=\d+\&containerID\=\d+/
  end

  def blogpostpdfpage
    /#{ENV['base_url']}\/people\S+.pdf/
  end

  def blogpostsummarypage
    ENV['base_url'] + "/people/#{/.*/}"
  end

  def discussioneditpage
    ENV['base_url'] + "/message/#{/.*/}/edit"
  end

  def discussionpage
    /#{ENV['base_url']}\/discussion\/create\.jspa\?sr\=cmenu\&containerType=\d+&containerID\=\d+/
  end

  def discussionpdfpage
    /#{ENV['base_url']}\/thread\S\d+.pdf/
  end

  def discussionsummarypage
    ENV['base_url'] + "/thread/#{/.*/}"
  end

  def grouppage
    ENV['base_url'] + '/create-group!input.jspa?sr=cmenu'
  end

  def cannotcreategrouppage
    ENV['base_url'] + '/edit-place.jspa?sr=cmenu&containerType=700'
  end

  def incidentreporteditpage
    ENV['base_url'] + '/incidentreports/<%=params[:id]%>/edit'
  end

  def incidentreportpage
    /#{ENV['base_url']}\/create-incidentreport\!input\.jspa\?containerType\=\d+\&containerID\=\d+/
  end

  def incidentreportpdfpage
    /#{ENV['base_url']}\/incidentreports\S\d+.pdf/
  end

  def incidentreportsummarypage
    /#{ENV['base_url']}\/view\-incidentreport\.jspa\?incidentReportID\=\d+/
  end

  def incidentreportsummaryparampage
    ENV['base_url'] + '/view-incidentreport.jspa?incidentReportID='
  end

  def polleditpage
    "#{ENV['base_url']}/poll/edit#{/.*/}"
  end

  def pollpage
    /#{ENV['base_url']}\/poll\/create\.jspa\?sr\=cmenu\&containerType\=\d+\&containerID\=\d+/
  end

  def preferencespage
    ENV['base_url'] + '/user-preferences!input.jspa'
  end

  def searchpage
    ENV['base_url'] + '/search'
  end

  def searchresultpage
    "#{ENV['base_url']}/search.jspa?q=#{/.*/}"
  end

  def viewdiscussionpage
    /#{ENV['base_url']}thread\/\d+/
  end

  def viewincidentreportpage
    /#{ENV['base_url']}view\-incidentreport\.jspa\?incidentReportID\=\d+/
  end

end
