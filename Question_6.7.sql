DROP FUNCTION IF EXISTS notif_bon_nom CASCADE;


CREATE FUNCTION notif_bon_nom ()

RETURNS TRIGGER AS $$
DECLARE
	nomBateau Bateau.nomB % TYPE;
	nomProprio Proprietaire.nomP % TYPE;


BEGIN
	nomBateau := NEW.nomB;
	SELECT DISTINCT INTO nomProprio nomP
	FROM Proprietaire
	WHERE idProprio = NEW.leProprio;

	IF (LOWER (nomBateau) = LOWER (nomProprio))
	THEN
		RAISE NOTICE E'Le bateau doit avoir un nom different de son proprietaire\nDonnee : %', nomBateau;
		RETURN NULL;
	ELSE
		RETURN NEW;
	END IF;
END;


$$ LANGUAGE 'plpgsql';


DROP TRIGGER IF EXISTS bon_nom
ON Bateau CASCADE;


CREATE TRIGGER bon_nom
BEFORE INSERT OR UPDATE OF nomB ON Bateau
FOR ROW

EXECUTE PROCEDURE notif_bon_nom ();

