class PatientsController < ApplicationController
  def index
    patients = [
      { name: "Enzo", status: "Active" },
      { name: "Alex", status: "Discharged" },
      { name: "Liv", status: "Active" }
    ]

    render json: patients
  end
  
 def show
  patients = [
    { name: "Enzo", status: "Active" },
    { name: "Alex", status: "Discharged" },
    { name: "Liv", status: "Active" }
  ]

  found = nil
  patients.each do |patient|
    if patient[:name] == params[:name]
      found = patient
    end
  end

  if found
    render json: found
  else
    render json: { error: "Patient not found" }
  end
end 

end
