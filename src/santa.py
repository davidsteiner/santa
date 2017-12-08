def find_first(sack):
    """ Find the ID of the first kid who gets allocated a present from the supplied sack. """
    return 1 if sack == 1 else int(sack ** 2 / 2)


def calculate_kid_id(sack, present):
    """ Find the ID of the kid receiving the supplied present in the sack """
    from_square = sack - 1 if sack % 2 == 1 and sack != 1 else sack
    to_square = from_square + present - 1
    sum_of_squares_after = (1 + to_square) * to_square // 2
    sum_of_squares_prior = (from_square + 1) * from_square // 2

    sign = 1 if (from_square + to_square) % 2 else -1

    s = sum_of_squares_after + sign * sum_of_squares_prior

    return s + (1 if present % 2 else -1) * find_first(sack)


def calculate_factors(x):
    """ Find all pairs of integers whose product equals x. """
    factors = [(sack, int(x / sack)) for sack in range(1, int(x ** 0.5) + 1) if (float(x) / sack).is_integer()]
    return factors + [(x[1], x[0]) for x in factors if x[0] != x[1]]


def calculate_allocation(n):
    """ Find the hash of the kid IDs for the provided input. """
    return [(factor, calculate_kid_id(*factor)) for factor in calculate_factors(n)]


def find_solution(n):
    """ Calculate the checksum as requested by Santa """
    return sum(a[1] for a in calculate_allocation(n)) % 100000000
