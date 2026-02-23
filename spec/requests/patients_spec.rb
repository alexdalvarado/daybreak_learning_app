require 'rails_helper'

RSpec.describe "Patients API", type: :request do
  before do
    Patient.destroy_all
  end

  describe "GET /patients" do
    it "returns all patients" do
      Patient.create!(name: "Enzo", status: "Active")
      Patient.create!(name: "Alex", status: "Discharged")

      get "/patients"

      expect(response).to have_http_status(:ok)
      patients = JSON.parse(response.body)
      expect(patients.length).to eq(2)
    end

    it "returns an empty array when there are no patients" do
      get "/patients"

      expect(response).to have_http_status(:ok)
      patients = JSON.parse(response.body)
      expect(patients).to eq([])
    end

    it "returns patients sorted by priority (high first)" do
      Patient.create!(name: "Low", status: "Active", priority: "low")
      Patient.create!(name: "High", status: "Active", priority: "high")
      Patient.create!(name: "Normal", status: "Active", priority: "normal")

      get "/patients"

      patients = JSON.parse(response.body)
      priorities = patients.map { |p| p["priority"] }
      expect(priorities).to eq(%w[high normal low])
    end
  end

  describe "GET /patients/:name" do
    it "returns a single patient by name" do
      Patient.create!(name: "Enzo", status: "Active")

      get "/patients/Enzo"

      expect(response).to have_http_status(:ok)
      patient = JSON.parse(response.body)
      expect(patient["name"]).to eq("Enzo")
      expect(patient["status"]).to eq("Active")
    end

    it "updates last_seen when viewing a patient" do
      patient = Patient.create!(name: "Enzo", status: "Active")
      expect(patient.last_seen).to be_nil

      get "/patients/Enzo"

      patient.reload
      expect(patient.last_seen).not_to be_nil
    end

    it "returns an error when the patient is not found" do
      get "/patients/Nobody"

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["error"]).to eq("Patient not found")
    end
  end
end
