DROP FUNCTION IF EXISTS notif_passe CASCADE;


CREATE FUNCTION notif_passe ()

RETURNS TRIGGER AS $$
DECLARE
	place Emplacement.longueur % TYPE;
	longueurBateau Bateau.longueurB % TYPE;


BEGIN
	SELECT DISTINCT INTO place longueur
	FROM Emplacement
	WHERE noEmpl = NEW.lEmplacement;

	SELECT DISTINCT INTO longueurBateau longueurB
	FROM Bateau
	WHERE noImm = NEW.leBateau;

	IF (longueurBateau > place)
	THEN
		RAISE NOTICE 'Le bateau doit pouvoir rentrer dans l emplacement pour pouvoir y etre reserve';
		RAISE NOTICE 'Longueur : %', longueurBateau;
		RAISE NOTICE 'Place : %', place;
		RETURN NULL;
	ELSE
		RETURN NEW;
	END IF;
END;


$$ LANGUAGE 'plpgsql';


DROP TRIGGER IF EXISTS passe
ON Reservation CASCADE;


CREATE TRIGGER passe
BEFORE INSERT OR UPDATE OF lEmplacement ON Reservation
FOR ROW
WHEN (NEW.lEmplacement IS NOT NULL)

EXECUTE PROCEDURE notif_passe ();

