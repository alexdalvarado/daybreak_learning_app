class PatientsController < ApplicationController
  def index
    patients = Patient.all
    render json: patients
  end

  def create
    patient = Patient.new(patient_params)

    if patient.save
      render json: patient, status: :created
    else
      render json: { errors: patient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def active
    patients = Patient.where(status: "Active")
    render json: patients
  end

  def show
    patient = Patient.find_by(name: params[:name])

    if patient
      render json: patient
    else
      render json: { error: "Patient not found" }
    end
  end

  private

  def patient_params
    params.expect(patient: [:name, :status])
  end
end
