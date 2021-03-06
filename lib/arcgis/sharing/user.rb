module Arcgis
  module Sharing
    # API Docs: http://www.arcgis.com/apidocs/rest/user.html
    module User
      include Arcgis::Base

      def user_url
        "users/"
      end

      # TODO add SubResource methods for Invitations, Notifications
      # TODO is this better as a const or a method? - ajturner
      USER_METHODS = {
        :content => {
          :get => ["items", ""],
          :post => ["deleteItems", "addRelationship", "deleteRelationship", 
            "publishItem", "exportItem", "shareItems", "unshareItems", "moveItems", "deleteItems"]
        },
        :community => {
          :get => ["", "notifications","tags","invitations"],
          :post => %w{update delete}
        }
      }

      extend_api(self.name.split("::").last.downcase,USER_METHODS)

      # simple placeholder for getting users.
      def user(options)
        user_community(options)
      end

      def user_createFolder(options)
        username = options.delete(:username) || "%username%"
        post("content/users/#{username}/createFolder",options)
      end

      def user_deleteFolder(options)
        username = options.delete(:username) || "%username%"
        post("content/users/#{username}/#{options[:id]}/delete",options)
      end
      # # http://www.arcgis.com/apidocs/rest/usersearch.html
      # # http://www.arcgis.com/apidocs/rest/commonparams.html#commonparameters
      # def user_search(options = {})
      #   get("/community/users",options)
      # end
      #
      # def user(options = {})
      #   get("/community/users/#{options[:user]}")
      # end
      #
      # # http://www.arcgis.com/apidocs/rest/updateuser.html
      # # Parameters:
      # #  - http://www.arcgis.com/apidocs/rest/commonparams.html#commonparameters
      # #  - http://www.arcgis.com/apidocs/rest/commonparams.html#user
      # def user_update(options = {})
      #   post("/community/users/#{options[:user]}/update",options)
      # end
      #
      # # http://www.arcgis.com/apidocs/rest/commonparams.html
      # # Parameters:
      # #  - http://www.arcgis.com/apidocs/rest/commonparams.html#commonparameters
      # def user_delete(options = {})
      #   post("/community/users/#{options[:user]}/delete",options)
      # end
      #
      # # http://www.arcgis.com/apidocs/rest/usercontent.html
      # def user_items(options = {})
      #   url = "/content/users/#{options[:user]}"
      #   url << "/#{options[:folder]}" if options.include?(:folder)
      #   get(url)
      # end
    end
  end
end
