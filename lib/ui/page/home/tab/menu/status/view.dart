// Copyright © 2022-2023 IT ENGINEERING MANAGEMENT INC,
//                       <https://github.com/team113>
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/api/backend/schema.dart' show Presence;
import '/l10n/l10n.dart';
import '/themes.dart';
import '/ui/page/home/page/my_profile/controller.dart';
import '/ui/page/home/page/my_profile/widget/field_button.dart';
import '/ui/widget/modal_popup.dart';
import '/ui/widget/svg/svg.dart';
import '/ui/widget/text_field.dart';

import 'controller.dart';

/// View for changing [MyUser.status] and/or [MyUser.presence].
///
/// Intended to be displayed with the [show] method.
class StatusView extends StatelessWidget {
  const StatusView({super.key, this.expanded = true});

  /// Indicator whether this [StatusView] should contain [MyUser.status] field
  /// as well as [MyUser.presence], or [MyUser.presence] only otherwise.
  final bool expanded;

  /// Displays a [StatusView] wrapped in a [ModalPopup].
  static Future<T?> show<T>(BuildContext context, {bool expanded = true}) {
    return ModalPopup.show(
      context: context,
      child: StatusView(expanded: expanded),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? thin =
        Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black);
    final Style style = Theme.of(context).extension<Style>()!;

    return GetBuilder(
      init: StatusController(Get.find()),
      builder: (StatusController c) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ModalPopupHeader(
              header: Center(
                child: Text(
                  expanded ? 'label_status'.l10n : 'label_presence'.l10n,
                  style: thin?.copyWith(fontSize: 18),
                ),
              ),
            ),
            Flexible(
              child: ListView(
                padding: ModalPopup.padding(context),
                shrinkWrap: true,
                children: [
                  if (expanded) ...[
                    _padding(
                      ReactiveTextField(
                        key: const Key('StatusField'),
                        state: c.status,
                        label: 'label_status'.l10n,
                        filled: true,
                        onSuffixPressed: c.status.text.isEmpty
                            ? null
                            : () {
                                Clipboard.setData(
                                  ClipboardData(text: c.status.text),
                                );
                              },
                        trailing: c.status.text.isEmpty
                            ? null
                            : Transform.translate(
                                offset: const Offset(0, -1),
                                child: Transform.scale(
                                  scale: 1.15,
                                  child: SvgLoader.asset(
                                    'assets/icons/copy.svg',
                                    height: 15,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 18),
                      child: Center(
                        child: Text(
                          'label_presence'.l10n,
                          style: style.systemMessageStyle
                              .copyWith(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                  ...[Presence.present, Presence.away].map((e) {
                    return Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: FieldButton(
                          onPressed: () => c.presence.value = e,
                          text: e.localizedString(),
                          trailing: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircleAvatar(
                              backgroundColor: e.getColor(),
                              radius: 12,
                              child: AnimatedSwitcher(
                                duration: 200.milliseconds,
                                child: c.presence.value == e
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12,
                                      )
                                    : const SizedBox(key: Key('None')),
                              ),
                            ),
                          ),
                          fillColor: c.presence.value == e
                              ? style.cardSelectedColor
                              : Colors.white,
                        ),
                      );
                    });
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  /// Basic [Padding] wrapper.
  Widget _padding(Widget child) =>
      Padding(padding: const EdgeInsets.all(8), child: child);
}