CREATE TABLE parents AS
  SELECT "ace" AS parent, "bella" AS child UNION
  SELECT "ace"          , "charlie"        UNION
  SELECT "daisy"        , "hank"           UNION
  SELECT "finn"         , "ace"            UNION
  SELECT "finn"         , "daisy"          UNION
  SELECT "finn"         , "ginger"         UNION
  SELECT "ellie"        , "finn";

CREATE TABLE dogs AS
  SELECT "ace" AS name, "long" AS fur, 26 AS height UNION
  SELECT "bella"      , "short"      , 52           UNION
  SELECT "charlie"    , "long"       , 47           UNION
  SELECT "daisy"      , "long"       , 46           UNION
  SELECT "ellie"      , "short"      , 35           UNION
  SELECT "finn"       , "curly"      , 32           UNION
  SELECT "ginger"     , "short"      , 28           UNION
  SELECT "hank"       , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT p.child 
  FROM parents AS p, dogs AS d 
  WHERE p.parent = d.name 
  ORDER BY d.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name AS name, s.size AS size
  FROM dogs AS d, sizes AS s
  WHERE d.height > s.min AND d.height <= s.max;


-- [Optional] Filling out this helper table is recommended
CREATE TABLE siblings AS
  SELECT p1.child AS dog1, p2.child AS dog2, s1.size AS size1, s2.size AS size2
  FROM parents AS p1, parents AS p2, size_of_dogs AS s1, size_of_dogs AS s2
  WHERE p1.parent = p2.parent
    AND p1.child < p2.child
    AND p1.child = s1.name
    AND p2.child = s2.name;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || dog1 || " and " || dog2 || ", have the same size: " || size1
  FROM siblings
  WHERE size1 = size2;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur, MAX(height) - MIN(height)
  FROM dogs
  GROUP BY fur
  HAVING MIN(height) >= 0.7 * AVG(height) 
     AND MAX(height) <= 1.3 * AVG(height);

