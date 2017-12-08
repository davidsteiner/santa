from timeit import default_timer as timer


def find_first(sack):
    """ Find the ID of the first kid who gets allocated a present from the supplied sack. """
    return 1 if sack == 1 else int(sack ** 2 / 2)


def find_kid(sack, present):
    """ Find the ID of the kid who receives the supplied number of present from the input sack. """
    kid = find_first(sack)
    offset = 0 if sack == 1 else sack % 2

    for last_present in range(1, present):
        kid = ((sack + last_present - offset) ** 2) - kid

    return kid


def find_kid2(sack, present):

    if present == 1:
        return find_first(sack)

    sack_base = sack - 1 if sack % 2 == 1 and sack != 1 else sack

    # If present is odd, then we want to add the base and subtract the initial number
    if present % 2 == 0:
        base = (sack_base + 1) ** 2
        summed = (2 * sack_base + (present + 1)) * (present - 2) // 2
        return round(summed + base - find_first(sack))

    # When present is even, we add the initial number and just sum the rest of the sequence
    else:
        summed = (2 * sack_base + present) * (present - 1) // 2
        return round(summed + find_first(sack))


def find_factors(x):
    """ Find all pairs of integers whose product equals x. """
    factors = [(sack, int(x / sack)) for sack in range(1, int(x ** 0.5) + 1) if (float(x) / sack).is_integer()]
    return factors + [(x[1], x[0]) for x in factors if x[0] != x[1]]


def calculate_allocation(n):
    """ Find the hash of the kid IDs for the provided input. """
    return [(factor, find_kid2(*factor)) for factor in find_factors(n)]


def calculate_checksum(n):
    """ Calculate the checksum as requested by Santa """
    return sum(a[1] for a in calculate_allocation(n))


def write_results(results):
    with open('./results_python', 'w') as f:
        for r in results:
            f.write('{} {} {}\n'.format(r[0][0], r[0][1], r[1]))


def load_results(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()
        results = [l.split() for l in lines]
        return [((int(r[0]), int(r[1])), int(r[2])) for r in results]


if __name__ == '__main__':
    #import sys
    #n = int(sys.argv[1]) if len(sys.argv) > 1 else 100
    #write_results(find_solution(n))
    haskell_results = load_results('./santa_results')
    python_results = calculate_allocation(6300000000)
    for h, p in zip( haskell_results, python_results):
        if h != p:
            print('Inconsistent results, haskell = {} while python = {}'.format(h, p))
