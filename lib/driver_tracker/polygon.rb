module DriverTracker
  class Polygon
    def initialize(points)
      @polygon = Geokit::Polygon.new(
        points.map { |point| Geokit::LatLng.new(*point) }
      )
    end

    def contains?(point)
      @polygon.contains?(Geokit::LatLng.new(*point))
    end
  end
end
