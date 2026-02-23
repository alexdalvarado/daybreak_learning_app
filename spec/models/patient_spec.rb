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

  describe "priority" do
    it "defaults to normal" do
      patient = Patient.create!(name: "Test", status: "Active")
      expect(patient.priority).to eq("normal")
    end

    it "accepts valid priority values" do
      %w[high normal low].each do |priority|
        patient = Patient.new(name: "Test", status: "Active", priority: priority)
        expect(patient).to be_valid
      end
    end

    it "rejects invalid priority values" do
      patient = Patient.new(name: "Test", status: "Active", priority: "urgent")
      expect(patient).not_to be_valid
    end

    it "orders by priority with by_priority scope" do
      Patient.destroy_all
      Patient.create!(name: "Low", status: "Active", priority: "low")
      Patient.create!(name: "High", status: "Active", priority: "high")
      Patient.create!(name: "Normal", status: "Active", priority: "normal")

      names = Patient.by_priority.pluck(:name)
      expect(names).to eq(%w[High Normal Low])
    end
  end
end