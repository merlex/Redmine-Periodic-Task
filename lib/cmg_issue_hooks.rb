class CmgIssueHooks < Redmine::Hook::Listener

    def controller_issues_edit_before_save(context = {})

      if context[:params] && context[:params][:issue]

        if context[:issue].status_id == 3 && !Issue.find_by_root_id(context[:issue].id).nil?
          context[:issue].done_ratio = 100
        end

      end

      return ''

    end

    #alias_method :controller_issues_new_before_save, :controller_issues_edit_before_save
    alias_method :controller_issues_bulk_edit_before_save, :controller_issues_edit_before_save

end