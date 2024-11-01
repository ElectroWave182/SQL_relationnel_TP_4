DROP FUNCTION IF EXISTS notif_reserve CASCADE;


CREATE FUNCTION notif_reserve ()

RETURNS TRIGGER AS $$
DECLARE
	res Reservation.leBateau % TYPE;
	clefBat Emplacement.leBateau % TYPE;
	clefEmpl Emplacement.noEmpl % TYPE;


BEGIN
	clefBat := NEW.leBateau;
	clefEmpl := NEW.noEmpl;

	SELECT DISTINCT INTO res leBateau
	FROM Reservation
	WHERE Reservation.leBateau = clefBat
	AND lEmplacement = clefEmpl;

	IF (res IS NULL)
	THEN
		RAISE NOTICE 'Le bateau n a pas ete reserve avec un emplacement';
		RAISE NOTICE 'Bateau : %', clefBat;
		RAISE NOTICE 'Emplacement : %', clefEmpl;
		RETURN NULL;
	ELSE
		RETURN NEW;
	END IF;
END;


$$ LANGUAGE 'plpgsql';


DROP TRIGGER IF EXISTS reserve
ON Emplacement CASCADE;


CREATE TRIGGER reserve
BEFORE INSERT OR UPDATE OF leBateau ON Emplacement
FOR ROW
WHEN (NEW.leBateau IS NOT NULL)

EXECUTE PROCEDURE notif_reserve ();

