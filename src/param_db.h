#pragma once
#include <string>
#include <map>
#include <nlohmann/json.hpp>

class ParamDB {
  nlohmann::json db;
  std::string filename;

public:
  ParamDB(const std::string& file);
  void addOrUpdate(int run, const std::map<std::string, std::string>& params);
  void remove(int run);
  void save() const;
  void print(int run) const;

private:
  std::string fmtRunNumber(int run) const;
};
