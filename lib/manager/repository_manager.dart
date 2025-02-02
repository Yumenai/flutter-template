import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/datasource/configuration_datasource_data.dart';

class RepositoryManager {
  static RepositoryManager of(final BuildContext context) {
    return Provider.of<RepositoryManager>(context, listen: false);
  }

  ConfigurationDatasourceData get configuration {
    return ConfigurationDatasourceData();
  }
}

extension RepositoryManagerExtension on BuildContext {
  RepositoryManager get repository => RepositoryManager.of(this);
}
