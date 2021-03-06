# Helper methods defined here can be accessed in any controller or view in the application

module Tod
  class App
    module ProposalHelper

      def validate_fields_size(a_field, min_size = 3)
        if a_field.length < min_size
          raise ("The value " + a_field + " should have more than " +
                    min_size.to_s + " characters."
                )
        end
      end

      def field_length_enough?(a_field, min_size = 3)
        a_field.length >= min_size
      end

      def words_enough?(a_field, min_size = 3)
        a_field.split.size >= min_size
      end

      def user_register(usuario)
         user=User.all(:name => usuario)
         if user.nil?
           user= User.new
           user.name= author
           user.save!
         end
        user
      end

      def check_mail?(mail)
        (mail =~ /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*) @([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z])+$/)==0
      end

      def notify_error(msg)
        flash.now[:danger] = msg
      end
      def notify_new_proposal_mail_misspelled
         notify_error t('proposal.error.mail_error')
      end

      def notify_on_field_too_short(event, field, minAmount)
        notify_error(
            t(event,
              field: t(field),
              cant: minAmount
            )
        )
      end

      def notify_new_proposal_field_too_short(field, minAmount)
        notify_on_field_too_short(
            'proposal.new.result.field_too_short',
            field,
            minAmount
        )
      end

      def notify_comment_field_too_short(field, minAmount)
        notify_on_field_too_short(
          'proposal.detail.comment_result.field_too_short',
          field,
          minAmount
        )
      end

      def search (query)
        text = query.to_s.downcase.strip.split.uniq
        if text.include?("+") && text.size > 1 then
          text.delete("+")
          first_word = text.delete_at(0)
          title_tag_search = Proposal.all(:title.like => "%#{first_word}%") |
          Proposal.all(:frozen_tag_list.like => "%#{first_word}%")
          text.each do |word|
            title_tag_search = title_tag_search &
            (Proposal.all(:title.like => "%#{word}%") |
            Proposal.all(:frozen_tag_list.like => "%#{word}%"))
          end
        else
          title_tag_search = []
          text.each do |word|
            title_tag_search = title_tag_search |
            (Proposal.all(:title.like => "%#{word}%") |
            Proposal.all(:frozen_tag_list.like => "%#{word}%"))
          end
        end
        title_tag_search
      end

      def search_tag (query)

        text = query.to_s.downcase.strip.split.uniq
        if text.include?("+") && text.size > 1 then
          text.delete("+")
          first_word = text.delete_at(0)
          title_tag_search = Proposal.all(:frozen_tag_list.like => "%#{first_word}%")
          text.each do |word|
            title_tag_search = title_tag_search & Proposal.all(:frozen_tag_list.like => "%#{word}%")
          end
        else
          title_tag_search = []
          text.each do |word|
            title_tag_search = title_tag_search |
                    Proposal.all(:frozen_tag_list.like => "%#{word}%")
          end
        end
        if title_tag_search.size== 0
          title_tag_search= Proposal.all
        end
        title_tag_search
      end


      def current_translations
        @translations ||= I18n.backend.send(:translations)
        @translations[I18n.locale].with_indifferent_access
      end
    end
    helpers ProposalHelper
  end
end
