#include "param_db.h"
#include <fstream>
#include <iostream>
using json = nlohmann::json;

ParamDB::ParamDB(const std::string& file) : filename(file) {
  std::ifstream in(file);
  if (in) in >> db;
}

void ParamDB::addOrUpdate(int run, const std::map<std::string, std::string>& params) {
  std::string run_key = fmtRunNumber(run);
  for (const auto& [key, value] : params) {
      db[run_key][key] = value;
  }
}

void ParamDB::remove(int run) {
  db.erase(fmtRunNumber(run));
}

void ParamDB::save() const {
  std::ofstream out(filename);
  out << db.dump(4);
}

void ParamDB::print(int run) const {
  std::string run_key = fmtRunNumber(run);
  if (db.contains(run_key)) {
    for (const auto& [k, v] : db.at(run_key).items()) {
      std::cout << k << ": " << v << std::endl;
    }
  } else {
    std::cout << "Run " << run << " not found." << std::endl;
  }
}

std::string ParamDB::fmtRunNumber(int run) const {
  char buf[6];
  std::snprintf(buf, sizeof(buf), "%05d", run);
  return std::string(buf);
}
