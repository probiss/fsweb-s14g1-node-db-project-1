const stillShabby = require("./accounts-model");
const yup = require("yup");

//yup ile yaparsak:
const accountSchema = yup.object().shape({
  name: yup
    .string()
    .required("name and budget are required")
    .min(3, "name of account must be between 3 and 100")
    .max(100, "name of account must be between 3 and 100"),
  budget: yup
    .number("budget of account must be a number")
    .required("name and budget are required")
    .min(0, "budget of account is too large or too small")
    .max(1000000, "budget of account is too large or too small"),
});

exports.checkAccountPayload = (req, res, next) => {
  //yup ile yaparsak:(async ile yaptık)
  // try {
  //   await accountSchema.validate(req.body);
  //   req.account=req.body
  // } catch (error) {
  //   res.status(400).json({mesaage:error.mesaage || "Hata oluştu"})
  // }
  const { name, budget } = req.body;
  if (!name || budget === undefined) {
    res.status(400).json({ message: "name and budget are required" });
  } else if (name.trim().length < 3 || name.trim().length > 100) {
    res
      .status(400)
      .json({ message: "name of account must be between 3 and 100" });
  } else if (typeof budget !== "number") {
    res.status(400).json({ message: "budget of account must be a number" });
  } else if (budget < 0 || budget > 1000000) {
    res
      .status(400)
      .json({ message: "budget of account is too large or too small" });
  }
  next();
};

exports.checkAccountNameUnique = async (req, res, next) => {
  try {
    req.body.name = req.body.name.trim();
    let allStillShabby = await stillShabby.getAll();
    let isFound = false;
    for (let i = 0; i < allStillShabby.length; i++) {
      if (allStillShabby[i].name == req.body.name) {
        isFound = true;
        break;
      }
    }
    if (isFound) {
      res.status(400).json({ message: "that name is taken" });
    }
  } catch (error) {
    next(error);
  }
  next();
};

exports.checkAccountId = async (req, res, next) => {
  try {
    const account = await stillShabby.getById(req.params.id);
    if (!account) {
      res.status(404).json({ message: "account not found" });
    } else {
      req.account = account;
      next();
    }
  } catch (error) {
    next(error);
  }
};
