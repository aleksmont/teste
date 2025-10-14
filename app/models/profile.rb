class Profile < ApplicationRecord

  #
  # Validations
  #

  validates :name, presence: true
  validates :github_url, presence: true, uniqueness: true

  #
  # Lifecycle
  #

  # before_create :email_valid?, :password_valid?
  before_create :complete_info, :short_github_url

  def short_github_url
    self.github_url = RailsUrlShortener::Url.generate(self.github_url).key
  end

  def complete_info

    info = Scraper::search(self.github_url)

    self.github_username = info[:github_username]
    self.github_followers_number = info[:github_followers_number]
    self.github_following_number = info[:github_following_number]
    self.github_starts_number = info[:github_starts_number]
    self.github_last_year_contributions_number = 1
    self.github_profile_image_url = info[:github_profile_image_url]
    self.github_organization = info[:github_organization]
    self.github_location = info[:github_location]
  end

  def reload_info
    self.complete_info
    self.save
  end

  def email_valid?
    # formato local-part@domain, sendo que: ○
    # local-part:
    #   máximo de 64 caracteres,
    #   formado por dígitos (0-9), letras maiúsculas # (A-Z) ou minúsculas (a-z), caracteres especiais (!#$%&'*+-/=?^_`{|}~) ou ponto (.)
    # domain:
    #   máximo de 128 caracteres,
    #   formado por dígitos (0-9), letras maiúsculas (A-Z) ou minúsculas (a-z), ponto (.) ou hífen (-).

    # Dividir o email em parte local e domínio
    partes = email.split('@')
    unless partes.length == 2
      errors.add(:email, 'Email must be valid')
      throw :abort
    end

    local_part, domain = partes

    # Verificar comprimento da parte local e do domínio
    unless local_part.length <= 64 && domain.length <= 128
      errors.add(:email, 'Email must be valid - invalid length')
      throw :abort
    end

    # Validar parte local
    local_regex = /\A[0-9A-Za-z!#$%&'*+=?^_`{|}~.]+\z/
    unless local_part.match?(local_regex)
      errors.add(:email, '- local-part must be valid. HINT: #   máximo de 64 caracteres,
    #   formado por dígitos (0-9), letras maiúsculas # (A-Z) ou minúsculas (a-z), caracteres especiais (!#$%&*+-/=?^_`{|}~) ou ponto (.)')
      throw :abort
    end

    # Validar domínio
    domain_regex = /\A[0-9A-Za-z.-]+\z/
    unless domain.match?(domain_regex)
      errors.add(:email, 'Email - domain must be valid. HINT: #   máximo de 128 caracteres,
    #   formado por dígitos (0-9), letras maiúsculas (A-Z) ou minúsculas (a-z), ponto (.) ou hífen (-).')
      throw :abort
    end

    # Verificar que o domínio não começa ou termina com ponto ou hífen
    if domain.start_with?('.') || domain.start_with?('-') || domain.end_with?('.') || domain.end_with?('-')
      errors.add(:email, 'Email must be valid')
      throw :abort
    end

    true
  end

  def password_valid?
    # mínimo de 10 caracteres e máximo de 72
    # mínimo de 2 dígitos (0-9)
    # mínimo de 2 caracteres especiais
    # mínimo de 2 letras maiúsculas (A-Z)
    # mínimo de 2 letras minúsculas (a-z)

    # Verifica o comprimento da senha
    unless password.length.between?(10, 72)
      errors.add(:password, "must be between 10 and 72 characters")
      throw :abort
    end

    # Contadores para os critérios
    digitos = password.scan(/[0-9]/).count
    caracteres_especiais = password.scan(/[!@#$%^&*(),.?":{}|<>]/).count
    maiusculas = password.scan(/[A-Z]/).count
    minusculas = password.scan(/[a-z]/).count

    # Verifica os critérios
    unless (digitos >= 2 && caracteres_especiais >= 2 && maiusculas >= 2 && minusculas >= 2)
      errors.add(:password, 'invalid password format - Hint:   # mínimo de 10 caracteres e máximo de 72
    # mínimo de 2 dígitos (0-9)
    # mínimo de 2 caracteres especiais
    # mínimo de 2 letras maiúsculas (A-Z)
    # mínimo de 2 letras minúsculas (a-z)')
      throw :abort
    end
  end

end
