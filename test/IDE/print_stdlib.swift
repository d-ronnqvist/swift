// Make sure we don't crash while printing the standard library.
//
// RUN: %swift-ide-test -print-module -module-to-print=Swift -source-filename %s -skip-private-stdlib-decls -fully-qualified-types-if-ambiguous -synthesize-sugar-on-types > %t.txt
// RUN: FileCheck -input-file %t.txt %s
// RUN: %swift-ide-test -print-module -module-to-print=Swift -source-filename %s -module-print-submodules | FileCheck %s

// CHECK: var C_ARGC: CInt

// RUN: FileCheck -check-prefix=CHECK-IMPORT -input-file %t.txt %s
// CHECK-IMPORT-NOT: {{^}}import

// RUN: FileCheck -check-prefix=CHECK-TRANSPARENT -input-file %t.txt %s
// CHECK-TRANSPARENT-NOT: @transparent

// RUN: FileCheck -check-prefix=CHECK-PRIVATE1 -input-file %t.txt %s
// CHECK-PRIVATE1-NOT: _Double

// RUN: FileCheck -check-prefix=CHECK-PRIVATE2 -input-file %t.txt %s
// CHECK-PRIVATE2-NOT: _StringBuffer

// RUN: FileCheck -check-prefix=CHECK-PRIVATE3 -input-file %t.txt %s
// CHECK-PRIVATE3-NOT: _StringCore

// RUN: FileCheck -check-prefix=CHECK-PRIVATE4 -input-file %t.txt %s
// CHECK-PRIVATE4-NOT: _ArrayBody

// RUN: FileCheck -check-prefix=CHECK-PRIVATE5 -input-file %t.txt %s
// CHECK-PRIVATE5-NOT: ~>

// RUN: FileCheck -check-prefix=CHECK-PRIVATE6 -input-file %t.txt %s
// CHECK-PRIVATE6-NOT: Builtin.

// RUN: FileCheck -check-prefix=CHECK-PRIVATE7 -input-file %t.txt %s
// CHECK-PRIVATE7-NOT: RawPointer

// RUN: FileCheck -check-prefix=CHECK-ARRAY-SUGAR -input-file %t.txt %s
// CHECK-ARRAY-SUGAR-NOT: extension [

// RUN: FileCheck -check-prefix=CHECK-OPTIONAL-SUGAR -input-file %t.txt %s
// CHECK-OPTIONAL-SUGAR-NOT: extension {{.*}}?

// RUN: FileCheck -check-prefix=CHECK-IUO-SUGAR -input-file %t.txt %s
// CHECK-IUO-SUGAR-NOT: extension {{.*}}!

// RUN: FileCheck -check-prefix=CHECK-SUGAR -input-file %t.txt %s
// CHECK-SUGAR: extension Array :
// CHECK-SUGAR: extension ImplicitlyUnwrappedOptional :
// CHECK-SUGAR: extension Optional :
