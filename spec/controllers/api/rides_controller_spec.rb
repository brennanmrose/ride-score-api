# frozen_string_literal: true

RSpec.describe Api::RidesController, type: :controller do
  describe 'GET #index' do
    context 'when driver exists' do
      let(:driver) { create(:driver) }

      before do
        allow(Driver).to receive(:find_by).with(id: driver.id).and_return(driver)
        allow(driver).to receive(:available_rides).and_return(available_rides)
      end

      context 'always' do
        before { get :index, params: { driver_id: driver.id } }

        it 'returns content_type json' do
          expect(response.content_type).to include('application/json')
        end
      end

      context 'with pagination' do
        let(:per_page) { 2 }

        before { get :index, params: { driver_id: driver.id, page: 1, per_page: per_page } }

        it 'returns paginated rides' do
          expect(JSON.parse(response.body).count).to eq(per_page)
        end

        it 'returns status :ok' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'without pagination' do
        before { get :index, params: { driver_id: driver.id } }

        it 'returns all rides' do
          expect(JSON.parse(response.body).count).to eq(available_rides.count)
        end

        it 'returns status :ok' do
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when driver does not exist' do
      before { get :index, params: { driver_id: 999 } }

      it 'returns not found error' do
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Driver not found' })
      end

      it 'returns status :not_found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  private

  def available_rides
    [
      {
        'id': 15,
        'start_address': '616 Masselin Ave, Los Angeles, CA',
        'destination_address': '905 E El Segundo Blvd, Los Angeles, CA',
        'driver_data': {
          'driver_id': driver.id,
          'driver_home_address': driver.home_address
        },
        'commute_distance': 0.8,
        'commute_duration': 0.058611111111111114,
        'ride_distance': 17.8,
        'ride_duration': 0.5408333333333334,
        'ride_earnings': 31.4,
        'score': 52.381835032437436
      },
      {
        'id': 16,
        'start_address': '2800 E Observatory Rd, Los Angeles, CA',
        'destination_address': '634 S Spring St #910, Los Angeles, CA',
        'driver_data': {
          'driver_id': driver.id,
          'driver_home_address': driver.home_address
        },
        'commute_distance': 8.2,
        'commute_duration': 0.5011111111111111,
        'ride_distance': 9.8,
        'ride_duration': 0.41555555555555557,
        'ride_earnings': 19.32,
        'score': 21.076363636363638
      },
      {
        'id': 17,
        'start_address': '100 N Toluca St, Los Angeles, CA',
        'destination_address': '3575 Wilshire Blvd, Los Angeles, CA',
        'driver_data': {
          'driver_id': driver.id,
          'driver_home_address': driver.home_address
        },
        'commute_distance': 6,
        'commute_duration': 0.38555555555555554,
        'ride_distance': 3.5,
        'ride_duration': 0.2436111111111111,
        'ride_earnings': 12,
        'score': 19.072847682119207
      }
    ]
  end
end
