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

import 'package:hive/hive.dart';

import '/domain/model_type_id.dart';
import '/util/new_type.dart';
import 'gallery_item.dart';
import 'precise_date_time/precise_date_time.dart';

part 'image_gallery_item.g.dart';

// TODO: Implement `GalleryItem`.
/// Gallery item representing an image.
@HiveType(typeId: ModelTypeId.imageGalleryItem)
class ImageGalleryItem extends HiveObject {
  /// Unique ID of this [ImageGalleryItem].
  @HiveField(0)
  GalleryItemId id;

  /// [PreciseDateTime] when this [ImageGalleryItem] was added.
  @HiveField(1)
  PreciseDateTime addedAt;

  /// Path on a files storage to the original file representing this
  /// [ImageGalleryItem].
  @HiveField(2)
  Original original;

  /// Path on a files storage to a square [ImageGalleryItem]'s view of
  /// 85px`x`85px size.
  @HiveField(3)
  Square square;

  ImageGalleryItem({
    required this.id,
    required this.addedAt,
    required this.original,
    required this.square,
  });
}

/// Path on a files storage to the original file representing an
/// [ImageGalleryItem].
@HiveType(typeId: ModelTypeId.original)
class Original extends NewType<String> {
  const Original(String val) : super(val);
}

/// Path on a files storage to the file representing an
/// [ImageGalleryItem.square] view.
@HiveType(typeId: ModelTypeId.square)
class Square extends NewType<String> {
  const Square(String val) : super(val);
}
