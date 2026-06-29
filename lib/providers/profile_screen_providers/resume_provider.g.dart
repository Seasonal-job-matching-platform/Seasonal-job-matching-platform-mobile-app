// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResumeNotifier)
const resumeProvider = ResumeNotifierProvider._();

final class ResumeNotifierProvider
    extends $AsyncNotifierProvider<ResumeNotifier, ResumeModel?> {
  const ResumeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumeNotifierHash();

  @$internal
  @override
  ResumeNotifier create() => ResumeNotifier();
}

String _$resumeNotifierHash() => r'483b9ee96f827ad1adc7acd2de743affb2d6b352';

abstract class _$ResumeNotifier extends $AsyncNotifier<ResumeModel?> {
  FutureOr<ResumeModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ResumeModel?>, ResumeModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ResumeModel?>, ResumeModel?>,
              AsyncValue<ResumeModel?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
