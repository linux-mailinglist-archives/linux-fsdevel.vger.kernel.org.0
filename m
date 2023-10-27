Return-Path: <linux-fsdevel+bounces-1414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347307D9FD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570DE1C210EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BE33C6BB;
	Fri, 27 Oct 2023 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GS3mY6IA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C5358AE
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:22:30 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73289192
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:22:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5af9b0850fdso9975767b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698430945; x=1699035745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUZ5ENGgmRmdtlmB4O/zxFZAY6wVMss4e0CPBbiQKYo=;
        b=GS3mY6IAmnrMJ09G5tzoPvh7RWwLoFnnm/xelS6/LFfSbplv5yLqS9arT8xQI71Jc7
         zKhpJ7q7Q8u9zwK5ZZzT3Cuex0HbOlptaiEHOIYZFDf74mbUFWKiMK3UN3Ja0Dfrcycp
         GhpnhbFwiQ4JojpRB3N0gQN9LIdYqtgWFXRXNyTBLXur8E9wdAVmw52rIm2rA8ZdNjtr
         PGgUzPjTfFXfaHpKFkbsEnxwJswbxnDozdUOs0+le34qEmuhRGGI46ipExl0n5igrg4f
         hse5L7Wtt5LTwRiQEAyAUDonq+Z3r+B1Vgzxi+dD7g00eq9woqP1xOVdaxBAXlB/8e61
         Ex5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698430945; x=1699035745;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fUZ5ENGgmRmdtlmB4O/zxFZAY6wVMss4e0CPBbiQKYo=;
        b=WJ55lvmaRUOLR6drioMe16H6aY+44EB8PX2ptGJM5h/kaJBobFVlREsqMNSvB9x7oT
         Pm9EglUF8rJ2EiQFeX7dVz89+nPZU3tqNQ1/eT7v3Kuq+anR8QwqHFHF5mBTYOZsSePs
         fCx+kyaNMYwpI64JTI3am7El5BTw7JzxMRYLO/LZsxMtzOlbJw5lpEg9pGniN2ry+NiE
         T+rHk/Pjzt7eenPX5lQw6k7/VJ7WvMfuDiIbLJ7yN2AnrWW5TMnbzeP43uWJ3kSOVVbc
         gPLKBrb5sCuj3ibmPtGFIJ/NzZyDHqmzVSpXn/70BXrUxB6jefDrTshOQBcq9FaSczm+
         tpLw==
X-Gm-Message-State: AOJu0Yz+0VhP9YgirddJT6AQE682I3+Q4W21O2vQJNqg5U/oaELy6aFi
	ldtaCxolrPZWvsS563A6VZiyD/ZLpMg=
X-Google-Smtp-Source: AGHT+IGTik1l5+MoAT0aZ1l3D7LvoGlEGGN/NmlkhnDMNOMyyxG0/NfMrOpUoSzppBt5u8UnrWOecHFs6SQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d601:0:b0:d9a:6b49:433d with SMTP id
 n1-20020a25d601000000b00d9a6b49433dmr66158ybg.6.1698430945618; Fri, 27 Oct
 2023 11:22:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 27 Oct 2023 11:21:42 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027182217.3615211-1-seanjc@google.com>
Subject: [PATCH v13 00/35] KVM: guest_memfd() and per-page attributes
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Sean Christopherson <seanjc@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>, 
	David Matlack <dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Maciej Szmigiero <mail@maciej.szmigiero.name>, David Hildenbrand <david@redhat.com>, 
	Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Non-KVM people, please take a gander at two small-ish patches buried in the
middle of this series:

  fs: Export anon_inode_getfile_secure() for use by KVM
  mm: Add AS_UNMOVABLE to mark mapping as completely unmovable

Our plan/hope is to take this through the KVM tree for 6.8, reviews (and ac=
ks!)
would be much appreciated.  Note, adding AS_UNMOVABLE isn't strictly requir=
ed as
it's "just" an optimization, but we'd prefer to have it in place straightaw=
ay.

Reviews on all the KVM changes, especially the guest_memfd.c implementation=
, are
also most definitely welcome.

The "what and why" at the very bottom is hopefully old news for most reader=
s.  My
plan is to copy the blurb into a tag when this is merged (today's word of t=
he day
is: optimism), e.g. so that the big picture and why we're doing this is cap=
tured
in the git history.

Note, the v13 changelog below captures only changes that were not posted an=
d
applied to the v12+ development branch.  Those changes can be found in comm=
its
46c10adeda81..74a4d3b6a284 at
=20
    https://github.com/kvm-x86/linux.git tags/kvm-x86-guest_memfd-v12

This series can be found at

    https://github.com/kvm-x86/linux.git guest_memfd

kvm-x86/guest_memfd is also now being fed into kvm-x86/next, i.e. will be g=
etting
coverage in linux-next as of the next build.

Similar to the v12 "development cycle", any changes needed will be applied =
on
top of v13, and squashed prior to sending v14 (if needed) or merging (optim=
ism!).

KVM folks, ***LOOK HERE***.  v13 has several breaking userspace changes rel=
ative
to v12.  Some were "necessary" (removal of a pointless ioctl), others were
opportunistic and opinionated (renaming kvm_userspace_memory_region2 fields=
 to
use guest_memfd instead of gmem).  I didn't post changes as I found the "is=
sues"
very late (when writing documentation) and didn't want to delay v13.

Here's a diff of the linux/include/uapi/linux/kvm.h changes that will break
userspace developed for v12.

@@ -102,8 +102,8 @@ struct kvm_userspace_memory_region2 {
        __u64 guest_phys_addr;
        __u64 memory_size;
        __u64 userspace_addr;
-       __u64 gmem_offset;
-       __u32 gmem_fd;
+       __u64 guest_memfd_offset;
+       __u32 guest_memfd;
        __u32 pad1;
        __u64 pad2[14];
 };

@@ -1231,9 +1215,10 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
 #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
 #define KVM_CAP_USER_MEMORY2 230
-#define KVM_CAP_MEMORY_ATTRIBUTES 231
-#define KVM_CAP_GUEST_MEMFD 232
-#define KVM_CAP_VM_TYPES 233
+#define KVM_CAP_MEMORY_FAULT_INFO 231
+#define KVM_CAP_MEMORY_ATTRIBUTES 232
+#define KVM_CAP_GUEST_MEMFD 233
+#define KVM_CAP_VM_TYPES 234
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -2301,8 +2286,7 @@ struct kvm_s390_zpci_op {
 #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
=20
 /* Available with KVM_CAP_MEMORY_ATTRIBUTES */
-#define KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES    _IOR(KVMIO,  0xd2, __u64)
-#define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd3, struct k=
vm_memory_attributes)
+#define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd2, struct k=
vm_memory_attributes)
=20
v13:
 - Drop KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES, have KVM_CAP_MEMORY_ATTRIBUTES
   return the supported attributes.
 - Add KVM_CAP_MEMORY_FAULT_INFO to report support for KVM_EXIT_MEMORY_FAUL=
T,
   and shift capability numbers accordingly.
 - Do s/gmem/guest_memfd (roughly) in userspace-facing APIs, i.e. use guest=
_memfd
   as the formal name.  Going off of various internal conversations, "gmem"=
 isn't
   at all intuitive, whereas "guest_memfd" gives readers/listeners a rough =
idea
   of what's going on.  If you don't like the rename, then next time volunt=
eer
   to write the documentation.  :-)
 - Rename a leftover "out_restricted" label to "out_unbind".
 - Write and clean up changelogs.
 - Write and clean up documentation.
 - Move "memory_fault" to the standard exit reasons union (requires userspa=
ce to
   rebuild, but shouldn't require code changes).
 - Fix intermediate build issues (hidden behind unselectable Kconfigs)
 - KVM_CAP_GUEST_MEMFD and KVM_CREATE_GUEST_MEMFD under the same #ifdefs.
 - Fix a bug in kvm_mmu_invalidate_range_add() where adding multiple ranges=
 in a
   single invalidation would captured only the last range. [Xu Yilun]

v12: https://lore.kernel.org/all/20230914015531.1419405-1-seanjc@google.com
v11: https://lore.kernel.org/all/20230718234512.1690985-1-seanjc@google.com
v10: https://lore.kernel.org/all/20221202061347.1070246-1-chao.p.peng@linux=
.intel.coms

Fodder for a merge tag:
---
Introduce several new KVM uAPIs to ultimately create a guest-first memory
subsystem within KVM, a.k.a. guest_memfd.  Guest-first memory allows KVM to
provide features, enhancements, and optimizations that are kludgly or outri=
ght
impossible to implement in a generic memory subsystem.

The core KVM ioctl() for guest_memfd is KVM_CREATE_GUEST_MEMFD, which simil=
ar
to the generic memfd_create(), creates an anonymous file and returns a file
descriptor that refers to it.  Again like "regular" memfd files, guest_memf=
d
files live in RAM, have volatile storage, and are automatically released wh=
en
the last reference is dropped.  The key differences between memfd files (an=
d
every other memory subystem) is that guest_memfd files are bound to their o=
wning
virtual machine, cannot be mapped, read, or written by userspace, and canno=
t be
resized (guest_memfd files do however support PUNCH_HOLE).

A second KVM ioctl(), KVM_SET_MEMORY_ATTRIBUTES, allows userspace to specif=
y
attributes for a given page of guest memory, e.g. in the long term, it will
likely be extended to allow userspace to specify per-gfn RWX protections.

The immediate and driving use case for guest_memfd are Confidential (CoCo) =
VMs,
specifically AMD's SEV-SNP, Intel's TDX, and KVM's own pKVM.  For KVM CoCo =
use
cases, being able to map memory into KVM guests without requireming said me=
mory
to be mapped into the host is a hard requirement.  While SEV+ and TDX preve=
nt
untrusted software from reading guest private data by encrypting guest memo=
ry,
pKVM provides confidentiality and integrity *without* relying on memory
encryption.  And with SEV-SNP and TDX, accessing guest private memory can b=
e
fatal to the host, i.e. KVM must be prevent host userspace from accessing g=
uest
memory irrespective of hardware behavior.

Long term, guest_memfd provides KVM line-of-sight to use cases beyond CoCo =
VMs,
e.g. KVM currently doesn't support mapping memory as writable in the guest
without it also being writable in host userspace, as KVM's ABI uses userspa=
ce
VMA protections to define the allow guest protection (with an exception gra=
nted
to mapping guest memory executable).

Similarly, KVM currently requires the guest mapping size to be a strict sub=
set
of the host userspace mapping size, e.g. KVM doesn=E2=80=99t support creati=
ng a 1GiB
guest mapping unless userspace also has a 1GiB guest mapping.  Decoupling t=
he
mappings sizes would allow userspace to precisely map only what is needed
without impacting guest performance, e.g. to again harden against unintenti=
onal
accesses to guest memory.

A guest-first memory subsystem also provides clearer line of sight to thing=
s
like a dedicated memory pool (for slice-of-hardware VMs) and elimination of
"struct page" (for offload setups where userspace _never_ needs to mmap() g=
uest
memory).

guest_memfd is the result of 3+ years of development and exploration; takin=
g on
memory management responsibilities in KVM was not the first, second, or eve=
n
third choice for supporting CoCo VMs.  But after many failed attempts to av=
oid
KVM-specific backing memory, and looking at where things ended up, it is qu=
ite
clear that of all approaches tried, guest_memfd is the simplest, most robus=
t,
and most extensible, and the right thing to do for KVM and the kernel at-la=
rge.
---

Ackerley Tng (1):
  KVM: selftests: Test KVM exit behavior for private memory/access

Chao Peng (8):
  KVM: Use gfn instead of hva for mmu_notifier_retry
  KVM: Add KVM_EXIT_MEMORY_FAULT exit to report faults to userspace
  KVM: Introduce per-page memory attributes
  KVM: x86: Disallow hugepages when memory attributes are mixed
  KVM: x86/mmu: Handle page fault for private memory
  KVM: selftests: Add KVM_SET_USER_MEMORY_REGION2 helper
  KVM: selftests: Expand set_memory_region_test to validate
    guest_memfd()
  KVM: selftests: Add basic selftest for guest_memfd()

Sean Christopherson (23):
  KVM: Tweak kvm_hva_range and hva_handler_t to allow reusing for gfn
    ranges
  KVM: Assert that mmu_invalidate_in_progress *never* goes negative
  KVM: WARN if there are dangling MMU invalidations at VM destruction
  KVM: PPC: Drop dead code related to KVM_ARCH_WANT_MMU_NOTIFIER
  KVM: PPC: Return '1' unconditionally for KVM_CAP_SYNC_MMU
  KVM: Convert KVM_ARCH_WANT_MMU_NOTIFIER to
    CONFIG_KVM_GENERIC_MMU_NOTIFIER
  KVM: Introduce KVM_SET_USER_MEMORY_REGION2
  KVM: Add a dedicated mmu_notifier flag for reclaiming freed memory
  KVM: Drop .on_unlock() mmu_notifier hook
  KVM: Prepare for handling only shared mappings in mmu_notifier events
  mm: Add AS_UNMOVABLE to mark mapping as completely unmovable
  fs: Export anon_inode_getfile_secure() for use by KVM
  KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing
    memory
  KVM: Add transparent hugepage support for dedicated guest memory
  KVM: x86: "Reset" vcpu->run->exit_reason early in KVM_RUN
  KVM: Drop superfluous __KVM_VCPU_MULTIPLE_ADDRESS_SPACE macro
  KVM: Allow arch code to track number of memslot address spaces per VM
  KVM: x86: Add support for "protected VMs" that can utilize private
    memory
  KVM: selftests: Drop unused kvm_userspace_memory_region_find() helper
  KVM: selftests: Convert lib's mem regions to
    KVM_SET_USER_MEMORY_REGION2
  KVM: selftests: Add support for creating private memslots
  KVM: selftests: Introduce VM "shape" to allow tests to specify the VM
    type
  KVM: selftests: Add GUEST_SYNC[1-6] macros for synchronizing more data

Vishal Annapurve (3):
  KVM: selftests: Add helpers to convert guest memory b/w private and
    shared
  KVM: selftests: Add helpers to do KVM_HC_MAP_GPA_RANGE hypercalls
    (x86)
  KVM: selftests: Add x86-only selftest for private memory conversions

 Documentation/virt/kvm/api.rst                | 208 ++++++
 arch/arm64/include/asm/kvm_host.h             |   2 -
 arch/arm64/kvm/Kconfig                        |   2 +-
 arch/mips/include/asm/kvm_host.h              |   2 -
 arch/mips/kvm/Kconfig                         |   2 +-
 arch/powerpc/include/asm/kvm_host.h           |   2 -
 arch/powerpc/kvm/Kconfig                      |   8 +-
 arch/powerpc/kvm/book3s_hv.c                  |   2 +-
 arch/powerpc/kvm/powerpc.c                    |   7 +-
 arch/riscv/include/asm/kvm_host.h             |   2 -
 arch/riscv/kvm/Kconfig                        |   2 +-
 arch/x86/include/asm/kvm_host.h               |  17 +-
 arch/x86/include/uapi/asm/kvm.h               |   3 +
 arch/x86/kvm/Kconfig                          |  14 +-
 arch/x86/kvm/debugfs.c                        |   2 +-
 arch/x86/kvm/mmu/mmu.c                        | 271 +++++++-
 arch/x86/kvm/mmu/mmu_internal.h               |   2 +
 arch/x86/kvm/vmx/vmx.c                        |  11 +-
 arch/x86/kvm/x86.c                            |  26 +-
 fs/anon_inodes.c                              |   1 +
 include/linux/kvm_host.h                      | 143 ++++-
 include/linux/kvm_types.h                     |   1 +
 include/linux/pagemap.h                       |  19 +-
 include/uapi/linux/kvm.h                      |  51 ++
 mm/compaction.c                               |  43 +-
 mm/migrate.c                                  |   2 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 tools/testing/selftests/kvm/dirty_log_test.c  |   2 +-
 .../testing/selftests/kvm/guest_memfd_test.c  | 221 +++++++
 .../selftests/kvm/include/kvm_util_base.h     | 148 ++++-
 .../testing/selftests/kvm/include/test_util.h |   5 +
 .../selftests/kvm/include/ucall_common.h      |  11 +
 .../selftests/kvm/include/x86_64/processor.h  |  15 +
 .../selftests/kvm/kvm_page_table_test.c       |   2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 233 ++++---
 tools/testing/selftests/kvm/lib/memstress.c   |   3 +-
 .../selftests/kvm/set_memory_region_test.c    | 100 +++
 .../kvm/x86_64/private_mem_conversions_test.c | 487 ++++++++++++++
 .../kvm/x86_64/private_mem_kvm_exits_test.c   | 120 ++++
 .../kvm/x86_64/ucna_injection_test.c          |   2 +-
 virt/kvm/Kconfig                              |  17 +
 virt/kvm/Makefile.kvm                         |   1 +
 virt/kvm/dirty_ring.c                         |   2 +-
 virt/kvm/guest_memfd.c                        | 607 ++++++++++++++++++
 virt/kvm/kvm_main.c                           | 505 ++++++++++++---
 virt/kvm/kvm_mm.h                             |  26 +
 46 files changed, 3083 insertions(+), 272 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_conversi=
ons_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_kvm_exit=
s_test.c
 create mode 100644 virt/kvm/guest_memfd.c


base-commit: 2b3f2325e71f09098723727d665e2e8003d455dc
--=20
2.42.0.820.g83a721a137-goog


