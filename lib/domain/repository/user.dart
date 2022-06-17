// Copyright © 2022 IT ENGINEERING MANAGEMENT INC, <https://github.com/team113>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License v3.0 as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License v3.0 for
// more details.
//
// You should have received a copy of the GNU Affero General Public License v3.0
// along with this program. If not, see
// <https://www.gnu.org/licenses/agpl-3.0.html>.

import 'dart:async';

import 'package:get/get.dart';

import '../model/user.dart';

/// [User]s repository interface.
abstract class AbstractUserRepository {
  /// Returns reactive map of [User]s.
  RxMap<UserId, Rx<User>> get users;

  /// Indicates whether this repository was initialized and [users] can be
  /// used.
  RxBool get isReady;

  /// Initializes this repository.
  Future<void> init();

  /// Disposes this repository.
  void dispose();

  /// Clears the stored [users].
  Future<void> clearCache();

  /// Searches [User]s by the provided [UserNum].
  ///
  /// This is an exact match search.
  Future<List<Rx<User>>> searchByNum(UserNum num);

  /// Searches [User]s by the provided [UserLogin].
  ///
  /// This is an exact match search.
  Future<List<Rx<User>>> searchByLogin(UserLogin login);

  /// Searches [User]s by the provided [UserName].
  ///
  /// This is a fuzzy search.
  Future<List<Rx<User>>> searchByName(UserName name);

  /// Searches [User]s by the provided [ChatDirectLinkSlug].
  ///
  /// This is an exact match search.
  Future<List<Rx<User>>> searchByLink(ChatDirectLinkSlug link);

  /// Returns an [User] by the provided [id].
  Future<Rx<User>?> get(UserId id);
}
