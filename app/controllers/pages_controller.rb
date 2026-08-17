class PagesController < ApplicationController
  before_action :set_page_content, except: :contact_submit

  def home; end

  def services; end

  def about; end

  def contact; end

  def contact_submit
    enquiry = params.permit(:name, :email, :phone, :company, :service, :message)
    name = enquiry[:name].presence || "there"
    service = enquiry[:service].presence

    ContactMailer.enquiry(enquiry.to_h).deliver_later

    response = [ "Thanks #{name}, your enquiry has been received." ]
    response << "We'll follow up about #{service.downcase} shortly." if service.present?
    response << "A BoostZone consultant in NSW will be in touch soon."

    redirect_to contact_path, notice: response.join(" ")
  end

  private

  def set_page_content
    @services = services_catalog
    @featured_services = featured_services
    @stats = [
      { value: "100+", label: "Projects Delivered" },
      { value: "50+", label: "Happy Clients" },
      { value: "5+", label: "Years Experience" }
    ]
    @benefits = [
      {
        title: "Local NSW Experts",
        description: "Work with a responsive team that understands local business expectations, compliance, and delivery realities.",
        icon: :local
      },
      {
        title: "End-to-End Solutions",
        description: "From strategy to deployment and support, we manage the full lifecycle so you can focus on growth.",
        icon: :solutions
      },
      {
        title: "Transparent Pricing",
        description: "Clear scopes, honest advice, and practical packages built for small and medium businesses.",
        icon: :pricing
      },
      {
        title: "Ongoing Support",
        description: "We stay involved after launch with maintenance, reporting, optimisation, and expert guidance.",
        icon: :support
      }
    ]
    @testimonials = [
      {
        quote: "BoostZone modernised our website and streamlined our customer enquiries with a chatbot. We saw faster response times within weeks.",
        name: "Sarah Nguyen",
        company: "Harbour Wellness Clinic, Sydney"
      },
      {
        quote: "Their team handled deployment, vendor coordination, and ongoing support without the usual tech headaches. Highly professional from start to finish.",
        name: "Michael Turner",
        company: "Blue Ridge Property Group, Newcastle"
      },
      {
        quote: "We needed dependable IT guidance without hiring a full internal team. BoostZone gave us exactly that, plus clear communication and practical advice.",
        name: "Priya Patel",
        company: "Coastal Legal Services, Wollongong"
      }
    ]
    @values = [
      {
        title: "Purpose-Driven Delivery",
        description: "We focus on solutions that make measurable improvements to service, efficiency, and growth.",
        icon: :mission
      },
      {
        title: "Integrity in Advice",
        description: "We recommend what your business truly needs, not what creates unnecessary complexity or cost.",
        icon: :integrity
      },
      {
        title: "Innovation That Fits",
        description: "We bring modern tools, automation, and cloud thinking into businesses at a pace that works.",
        icon: :innovation
      },
      {
        title: "Long-Term Partnership",
        description: "Our team builds lasting relationships through dependable support and consistent outcomes.",
        icon: :growth
      }
    ]
    @nsw_reasons = [
      {
        title: "Built for growing businesses",
        description: "We tailor delivery for small and mid-sized organisations that need strategic capability without enterprise overhead.",
        icon: :people
      },
      {
        title: "Practical communication",
        description: "Stakeholders get clear updates, transparent timelines, and straight answers throughout each engagement.",
        icon: :support
      },
      {
        title: "Australian business context",
        description: "From service expectations to compliance and privacy considerations, our approach is grounded in the local market.",
        icon: :local
      }
    ]
    @service_options = @services.map { |service| service[:title] }
  end

  def featured_services
    featured_slugs = %w[
      chatbot-development
      website-design-development
      app-deployment-devops
      qa-software-testing
      it-support-small-businesses
      third-party-contract-management
    ]

    featured_slugs.filter_map do |slug|
      @services.find { |service| service[:slug] == slug }
    end
  end

  def services_catalog
    [
      {
        slug: "chatbot-development",
        title: "Chatbot Development",
        summary: "AI-driven customer conversations for websites, support workflows, and WhatsApp channels.",
        description: "We design, build, and deploy chatbots that improve customer support, qualify leads, and automate repetitive enquiries across digital channels.",
        features: [
          "AI chatbot strategy and conversation design",
          "Customer support automation and lead capture",
          "WhatsApp, website, and help desk integration"
        ],
        icon: :chatbot
      },
      {
        slug: "website-design-development",
        title: "Website Design & Development",
        summary: "Modern websites built for trust, performance, and conversion across every device.",
        description: "From brand-new builds to complete digital refreshes, we create fast, mobile-responsive websites that showcase your business and support marketing goals.",
        features: [
          "New websites and redesign projects",
          "Mobile-responsive UX and conversion-focused layouts",
          "SEO-ready builds with clean technical foundations"
        ],
        icon: :website
      },
      {
        slug: "website-upgrades-maintenance",
        title: "Website Upgrades & Maintenance",
        summary: "Reliable updates, improvements, and preventative care that keep your website secure and effective.",
        description: "We keep business websites current with structured maintenance, bug fixes, content updates, performance tuning, and proactive security care.",
        features: [
          "Feature updates and content enhancements",
          "Security patches and plugin or dependency maintenance",
          "Performance optimisation and monthly support plans"
        ],
        icon: :maintenance
      },
      {
        slug: "app-deployment-devops",
        title: "App Deployment & DevOps",
        summary: "Stable release pipelines and cloud environments that help teams ship with confidence.",
        description: "We streamline delivery with modern DevOps practices, infrastructure automation, environment setup, and release management for web and software products.",
        features: [
          "CI/CD pipeline design and implementation",
          "Staging and production environment setup",
          "AWS, Azure, GCP, and Docker containerisation"
        ],
        icon: :devops
      },
      {
        slug: "qa-software-testing",
        title: "QA & Software Testing",
        summary: "Quality assurance services that reduce defects and protect every release.",
        description: "Our QA specialists help teams validate software before launch through structured test planning, execution, documentation, and stakeholder support.",
        features: [
          "Manual, automated, and regression testing",
          "Test case design and release readiness checks",
          "UAT support and quality reporting"
        ],
        icon: :testing
      },
      {
        slug: "it-support-small-businesses",
        title: "IT Support for Small Businesses",
        summary: "Flexible day-to-day support for teams that need dependable technology without a full internal IT department.",
        description: "We provide responsive support for small businesses needing help desk assistance, setup services, troubleshooting, and practical guidance for staff.",
        features: [
          "Help desk support and issue resolution",
          "Software setup, rollout assistance, and device configuration",
          "Staff training and on-demand IT support"
        ],
        icon: :support
      },
      {
        slug: "third-party-contract-management",
        title: "Third-Party Contract Management",
        summary: "Independent coordination between vendors, suppliers, and stakeholders to keep technology contracts on track.",
        description: "We help businesses manage outsourced technology relationships, monitor service levels, and mediate outcomes when delivery or communication falls short.",
        features: [
          "Buyer and supplier mediation support",
          "SLA monitoring and vendor performance reviews",
          "Coordination, escalation, and dispute resolution"
        ],
        icon: :contracts
      },
      {
        slug: "cloud-infrastructure",
        title: "Cloud Infrastructure",
        summary: "Scalable cloud environments designed for resilience, cost control, and future growth.",
        description: "We architect and manage cloud foundations for applications and internal systems, helping businesses migrate, optimise, and operate securely.",
        features: [
          "AWS, Azure, and GCP setup",
          "Cloud migration planning and execution",
          "Cost optimisation, monitoring, and governance"
        ],
        icon: :cloud
      },
      {
        slug: "api-integrations",
        title: "API Integrations",
        summary: "Connected systems that eliminate manual work and move data where your business needs it.",
        description: "We integrate business platforms, customer systems, and internal tools to create smoother operations and better visibility across teams.",
        features: [
          "Business tool and SaaS platform integrations",
          "Payment gateway, CRM, and ERP connectivity",
          "Custom API workflows and automation"
        ],
        icon: :api
      },
      {
        slug: "cybersecurity-audits",
        title: "Cybersecurity Audits",
        summary: "Security reviews that identify gaps, reduce risk, and strengthen business confidence.",
        description: "Our cybersecurity audit service helps businesses understand vulnerabilities, prioritise remediation, and improve alignment with Australian privacy expectations.",
        features: [
          "Vulnerability assessments and risk reviews",
          "Security hardening recommendations and remediation planning",
          "Compliance guidance aligned to the Australian Privacy Act"
        ],
        icon: :security
      },
      {
        slug: "ecommerce-solutions",
        title: "E-commerce Solutions",
        summary: "Online stores built for growth, operational efficiency, and customer trust.",
        description: "We help businesses launch and improve e-commerce platforms, from Shopify and WooCommerce stores to tailored Ruby on Rails solutions.",
        features: [
          "Shopify and WooCommerce implementations",
          "Custom Rails commerce experiences",
          "Checkout optimisation, integrations, and maintenance"
        ],
        icon: :ecommerce
      },
      {
        slug: "it-consulting-digital-transformation",
        title: "IT Consulting & Digital Transformation",
        summary: "Strategic guidance to modernise systems, improve processes, and align technology investment with business outcomes.",
        description: "We partner with leadership teams to evaluate current systems, define practical roadmaps, and deliver change with confidence.",
        features: [
          "Technology assessments and opportunity mapping",
          "Digital roadmaps and transformation planning",
          "Change management and delivery advisory"
        ],
        icon: :consulting
      }
    ]
  end
end
