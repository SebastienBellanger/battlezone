class Sphere
	constructor: (@position, @radius) ->

	intersects: (otherSphere) ->
		rad_sum_sqrd = @radius + otherSphere.radius
		rad_sum_sqrd *= rad_sum_sqrd

		to_other = @position.sub otherSphere.position
		len_sqrd = to_other.lengthSquared()

		return len_sqrd < rad_sum_sqrd