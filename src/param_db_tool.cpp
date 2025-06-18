#include "param_db.h"
#include <iostream>
#include <vector>
#include <sstream>

int main(int argc, char* argv[]) {
  if (argc < 3) {
    std::cerr << "Usage:\n"
              << "  add <run> KEY=VALUE ...\n"
              << "  print <run>\n"
              << "  remove <run>\n";
    return 1;
  }

  std::string cmd = argv[1];
  int run = std::stoi(argv[2]);
  ParamDB db("run_conf.json");

  if (cmd == "add") {
    std::map<std::string, std::string> params;
    for (int i = 3; i < argc; ++i) {
      std::string arg = argv[i];
      auto pos = arg.find('=');
      if (pos == std::string::npos) continue;
      std::string key = arg.substr(0, pos);
      std::string value = arg.substr(pos + 1);
      params[key] = value;
    }
    db.addOrUpdate(run, params);
    db.save();
  } else if (cmd == "print") {
    db.print(run);
  } else if (cmd == "remove") {
    db.remove(run);
    db.save();
  } else {
    std::cerr << "Unknown command.\n";
    return 1;
  }

  return 0;
}
