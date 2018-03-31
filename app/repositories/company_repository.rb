class CompanyRepository
  def create(company)
    Company.create(field: company.field)
  end

  def find_by_id(id)
    Company.find_by_id(id)
  end
end
