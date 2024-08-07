// See tests for GNU_PROPERTY_AARCH64_FEATURE_PAUTH in aarch64-feature-pauth.s

// RUN: llvm-mc -filetype=obj -triple aarch64-linux-gnu %s -o %t
// RUN: llvm-readelf --notes %t | FileCheck %s --check-prefix=GNU
// RUN: llvm-readobj --notes %t | FileCheck %s --check-prefix=LLVM

// GNU: Displaying notes found in: .note.gnu.property
// GNU-NEXT:   Owner                 Data size	Description
// GNU-NEXT:   GNU                   0x00000010	NT_GNU_PROPERTY_TYPE_0 (property note)
// GNU-NEXT:     Properties:    aarch64 feature: BTI, PAC, GCS

// LLVM:      NoteSections [
// LLVM-NEXT:   NoteSection {
// LLVM-NEXT:     Name: .note.gnu.property
// LLVM-NEXT:     Offset: 0x40
// LLVM-NEXT:     Size: 0x20
// LLVM-NEXT:     Notes [
// LLVM-NEXT:     {
// LLVM-NEXT:       Owner: GNU
// LLVM-NEXT:       Data size: 0x10
// LLVM-NEXT:       Type: NT_GNU_PROPERTY_TYPE_0 (property note)
// LLVM-NEXT:       Property [
// LLVM-NEXT:         aarch64 feature: BTI, PAC, GCS
// LLVM-NEXT:       ]
// LLVM-NEXT:     }
// LLVM-NEXT:	 ]
// LLVM-NEXT:   }
// LLVM-NEXT: ]

.section ".note.gnu.property", "a"
  .long 4           /* Name length is always 4 ("GNU") */
  .long end - begin /* Data length */
  .long 5           /* Type: NT_GNU_PROPERTY_TYPE_0 */
  .asciz "GNU"      /* Name */
  .p2align 3
begin:
  /* BTI, PAC, and GCS property note */
  .long 0xc0000000  /* Type: GNU_PROPERTY_AARCH64_FEATURE_1_AND */
  .long 4           /* Data size */
  .long 7           /* BTI, PAC, GCS */
  .p2align 3        /* Align to 8 byte for 64 bit */
end:
