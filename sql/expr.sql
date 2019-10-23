LOAD 'agensgraph';
SET search_path TO ag_catalog;

--
-- map literal
--

-- empty map
SELECT * FROM cypher($$RETURN {}$$) AS r(c agtype);

-- map of scalar values
SELECT * FROM cypher($$
RETURN {s: 's', i: 1, f: 1.0, b: true, z: null}
$$) AS r(c agtype);

-- nested maps
SELECT * FROM cypher($$
RETURN {s: {s: 's'}, t: {i: 1, e: {f: 1.0}, s: {a: {b: true}}}, z: null}
$$) AS r(c agtype);

--
-- list literal
--

-- empty list
SELECT * FROM cypher($$RETURN []$$) AS r(c agtype);

-- list of scalar values
SELECT * FROM cypher($$RETURN ['str', 1, 1.0, true, null]$$) AS r(c agtype);

-- nested lists
SELECT * FROM cypher($$RETURN [['str'], [1, [1.0], [[true]]], null]$$) AS r(c agtype);

--
-- Test transform logic for operators
--
SELECT * FROM cypher(
$$ RETURN (-(3 * 2 - 4.0) ^ ((10 / 5) + 1)) % -3 $$
)
AS r(result agtype);

--
-- Test transform logic for comparison operators
--
SELECT * FROM cypher(
$$ RETURN 1 = 1.0 $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN 1 > -1.0 $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN -1.0 < 1 $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN "aaa" < "z" $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN "z" > "aaa" $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN false = false $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN ("string" < true) $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN true < 1 $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN (1 + 1.0) = (7 % 5) $$
)
AS r(result boolean);

--
-- Test transform logic for IS NULL & IS NOT NULL
--
SELECT * FROM cypher(
$$ RETURN null IS NULL $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN 1 IS NULL $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN 1 IS NOT NULL $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN null IS NOT NULL $$
)
AS r(result boolean);

--
-- Test transform logic for AND, OR, and NOT
--
SELECT * FROM cypher(
$$ RETURN NOT false $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN NOT true $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN true AND true $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN true AND false $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN false AND true $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN false AND false $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN true OR true $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN true OR false $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN false OR true $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN false OR false $$
)
AS r(result boolean);

SELECT * FROM cypher(
$$ RETURN NOT ((true OR false) AND (false OR true)) $$
)
AS r(result boolean);

--
-- End of tests
--
