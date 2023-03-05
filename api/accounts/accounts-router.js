const router = require("express").Router();
const Shabby = require("./accounts-model");
const partner = require("./accounts-middleware");

router.get("/", (req, res, next) => {
  Shabby.getAll()
    .then((account) => {
      res.json(account);
    })
    .catch((err) => {
      res.json([]);
    });
});

router.get("/:id", partner.checkAccountId, async (req, res, next) => {
  try {
    res.json(req.account);
  } catch (error) {
    next(error);
  }
});

router.post("/",partner.checkAccountPayload,partner.checkAccountNameUnique,async (req, res, next) => {
    try {
      let insertData = await Shabby.create(req.body);
      res.status(201).json(insertData);
    } catch (error) {
      next(error);
    }
  }
);

router.put("/:id",partner.checkAccountId,partner.checkAccountPayload,async (req, res, next) => {
    try {
      const updateAccount = await Shabby.updateById(req.params.id, req.body);
      res.json(updateAccount);
    } 
    catch (error) {
      next(error);
    }
  }
);

router.delete("/:id", partner.checkAccountId, async (req, res, next) => {
  try 
  {
    await Shabby.deleteById(req.params.id);
    res.json(req.account);
  } 
  catch (error) 
  {
    next(error);
  }
});

router.use((err, req, res, next) => {
  res.status(err.status || 400).json({
    customMessage: "Bi zara 100 bin verdin,dikkat...",
    message: err.message,
  });
});

module.exports = router;