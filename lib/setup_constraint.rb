class SetupConstraint
  def matches?(request)
    Setup.first.present?
  end
end
