require 'rails_helper'

RSpec.describe Patient, type: :model do
  it "can be created with a name and status" do
    patient = Patient.create(name: "Enzo", status: "Active")
    expect(patient.name).to eq("Enzo")
    expect(patient.status).to eq("Active")
  end

  it "starts with no patients in database" do
    Patient.destroy_all
    expect(Patient.count).to eq(0)
  end

  it "can find patients by status" do
    Patient.destroy_all
    Patient.create(name: "Enzo", status: "Active")
    Patient.create(name: "Alex", status: "Discharged")
    
    active = Patient.where(status: "Active")
    expect(active.count).to eq(1)
    expect(active.first.name).to eq("Enzo")
  end
end