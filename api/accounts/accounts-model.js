const db = require("../../data/db-config");

const getAll = () => {
  //select * from accounts
  return db("accounts");
};

const getById = (id) => {
  //select * from accounts where id=id
  // return db("accounts").where({id}).first();
  return db("accounts").where("id", id).first();
};

const create = (account) => {
  //inset into account values (id,name,budget)
  const insertedAccount = db("accounts")
    .insert(account)
    .then((id) => {
      return getById(id[0]);
    });
  return insertedAccount;
};

const updateById = (id, account) => {
  // update accounts name=account.name, budget=account.budget where id=id
  return db("accounts")
    .where("id", id)
    .update(account)
    .then((rows) => {
      return getById(id);
    });
};

const deleteById = (id) => {
  // delete from accounts where id=id
  return db("accounts").where("id", id).del();
};

module.exports = {
  getAll,
  getById,
  create,
  updateById,
  deleteById,
};
