DROP FUNCTION IF EXISTS notif_bonne_longueur CASCADE;


CREATE FUNCTION notif_bonne_longueur ()

RETURNS TRIGGER AS $$
DECLARE
	

BEGIN
	IF (NEW.longueurB < 3)
	THEN
		RAISE NOTICE E'Le bateau doit être plus long que 3 m.\nDonnee : % m.', NEW.longueurB;
		RETURN NULL;
	ELSIF (NEW.longueurB > 20)
	THEN
		RAISE NOTICE E'Le bateau doit être moins long que 20 m.\nDonnee : % m.', NEW.longueurB;
		RETURN NULL;
	ELSE
		RETURN NEW;
	END IF;
END;


$$ LANGUAGE 'plpgsql';


DROP TRIGGER IF EXISTS bonne_longueur
ON Bateau CASCADE;


CREATE TRIGGER bonne_longueur
BEFORE INSERT OR UPDATE OF longueurB ON Bateau
FOR ROW

EXECUTE PROCEDURE notif_bonne_longueur ();

