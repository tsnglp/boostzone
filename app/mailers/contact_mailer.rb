class ContactMailer < ApplicationMailer
  def enquiry(enquiry)
    @enquiry = enquiry

    mail(
      to: "info@boostzone.com.au",
      reply_to: @enquiry[:email].presence,
      subject: enquiry_subject
    )
  end

  private

  def enquiry_subject
    service = @enquiry[:service].presence
    name = @enquiry[:name].presence || "a prospective client"

    if service
      "New #{service} enquiry from #{name}"
    else
      "New website enquiry from #{name}"
    end
  end
end
