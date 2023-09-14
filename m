Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE8A79F767
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 04:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjINCBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 22:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjINCA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:00:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4643C3D
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d814a1f7378so2791636276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656602; x=1695261402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XfRZ+8VXY/OEYZxaTO5L0PdI0q7LErIUsWDHkpQzw6o=;
        b=l3BonxJdDqv4PXjYVu3aUocYQ9/4wGlG3MVyAzuD+6hLcVpCWZJag+qi56/00dcABa
         qDPXZ+depM2SZ/ceR3ickjwo1cwyTHNtb+s2Q84/eH0bLnpDGQVdybyn51b96kUZbIqy
         4u/gLryerp5xCyYrXmcWItcDT74RFRFSiF84D6FKfUVcbLA/r/xjLPKTFkmF16mDmHzG
         5UXHHeToMIqfnBLGdTTkSUiCw43q+b+/kfr98ms/R7Hg8fzresYS/Ti0/MhENw0Pt0X5
         jr9ZuOrZT99AbU7R1Qm7d0kKeiZvS3RuDy/ikPqqdbEglG0rXjQbwmejyGNAt8LT1K7B
         nLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656602; x=1695261402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfRZ+8VXY/OEYZxaTO5L0PdI0q7LErIUsWDHkpQzw6o=;
        b=kiYzqozmMvcHURw04sdqBiGu4lL9IvgU4Pr+k0Fvm6W2/y7gNhrTXclYXO2wkAB0/r
         8yABKmr+2TZqsne0HPQoEjgnTFV6i9ZdEZA9MbB3xjpnnjR09UPjBch1r439tYhv64nC
         cMIv05WyJ6jHbTHlYOcGFr6pbfKPeJIHUBsp2BOyfWAxCzlHJ33sOlfj0x827kFMcMJ3
         J6r7ImSXCkGu0qBu5vkIYniO9AoYzDhfPBuIi7kn7VtkgB2odkIyQChbCOSBYBQVYIo0
         uBNmyCrwE/MMfDGmm+Y+21jfYhvG/+1KBK/YXDL6PcW+arIN9t24fyAArB9NdpPavXWy
         mW3g==
X-Gm-Message-State: AOJu0YywIpnW5P87ZuKhlTcgyeBsQYEfNI4pjaWdoomxJdCq9lb+giD/
        PmFlYDciRE2tfejsGKRpFFV6g0hPufY=
X-Google-Smtp-Source: AGHT+IGRS3O+T9+VVevze+Os2k+DiGR8L+K7fuRVrk/vVySDtGkT7cNTInKtJxs4EW7npy+OCmJw4oxYHnE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d141:0:b0:d77:fb00:b246 with SMTP id
 i62-20020a25d141000000b00d77fb00b246mr14108ybg.1.1694656602040; Wed, 13 Sep
 2023 18:56:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:31 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-34-seanjc@google.com>
Subject: [RFC PATCH v12 33/33] KVM: selftests: Test KVM exit behavior for
 private memory/access
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ackerley Tng <ackerleytng@google.com>

"Testing private access when memslot gets deleted" tests the behavior
of KVM when a private memslot gets deleted while the VM is using the
private memslot. When KVM looks up the deleted (slot = NULL) memslot,
KVM should exit to userspace with KVM_EXIT_MEMORY_FAULT.

In the second test, upon a private access to non-private memslot, KVM
should also exit to userspace with KVM_EXIT_MEMORY_FAULT.

sean: These testcases belong in set_memory_region_test.c, they're private
variants on existing testscases and aren't as robust, e.g. don't ensure
the vCPU is actually running and accessing memory when converting and
deleting.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/x86_64/private_mem_kvm_exits_test.c   | 121 ++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 2b1ef809d73a..f7fdd8244547 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -82,6 +82,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/nested_exceptions_test
 TEST_GEN_PROGS_x86_64 += x86_64/platform_info_test
 TEST_GEN_PROGS_x86_64 += x86_64/pmu_event_filter_test
 TEST_GEN_PROGS_x86_64 += x86_64/private_mem_conversions_test
+TEST_GEN_PROGS_x86_64 += x86_64/private_mem_kvm_exits_test
 TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
 TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
 TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
new file mode 100644
index 000000000000..1a61c51c2390
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022, Google LLC.
+ */
+#include <linux/kvm.h>
+#include <pthread.h>
+#include <stdint.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+/* Arbitrarily selected to avoid overlaps with anything else */
+#define EXITS_TEST_GVA 0xc0000000
+#define EXITS_TEST_GPA EXITS_TEST_GVA
+#define EXITS_TEST_NPAGES 1
+#define EXITS_TEST_SIZE (EXITS_TEST_NPAGES * PAGE_SIZE)
+#define EXITS_TEST_SLOT 10
+
+static uint64_t guest_repeatedly_read(void)
+{
+	volatile uint64_t value;
+
+	while (true)
+		value = *((uint64_t *) EXITS_TEST_GVA);
+
+	return value;
+}
+
+static uint32_t run_vcpu_get_exit_reason(struct kvm_vcpu *vcpu)
+{
+	int r;
+
+	r = _vcpu_run(vcpu);
+	if (r) {
+		TEST_ASSERT(errno == EFAULT, KVM_IOCTL_ERROR(KVM_RUN, r));
+		TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_MEMORY_FAULT);
+	}
+	return vcpu->run->exit_reason;
+}
+
+const struct vm_shape protected_vm_shape = {
+	.mode = VM_MODE_DEFAULT,
+	.type = KVM_X86_SW_PROTECTED_VM,
+};
+
+static void test_private_access_memslot_deleted(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	pthread_t vm_thread;
+	void *thread_return;
+	uint32_t exit_reason;
+
+	vm = vm_create_shape_with_one_vcpu(protected_vm_shape, &vcpu,
+					   guest_repeatedly_read);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    EXITS_TEST_GPA, EXITS_TEST_SLOT,
+				    EXITS_TEST_NPAGES,
+				    KVM_MEM_PRIVATE);
+
+	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
+
+	/* Request to access page privately */
+	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
+
+	pthread_create(&vm_thread, NULL,
+		       (void *(*)(void *))run_vcpu_get_exit_reason,
+		       (void *)vcpu);
+
+	vm_mem_region_delete(vm, EXITS_TEST_SLOT);
+
+	pthread_join(vm_thread, &thread_return);
+	exit_reason = (uint32_t)(uint64_t)thread_return;
+
+	TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
+	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
+	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
+
+	kvm_vm_free(vm);
+}
+
+static void test_private_access_memslot_not_private(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	uint32_t exit_reason;
+
+	vm = vm_create_shape_with_one_vcpu(protected_vm_shape, &vcpu,
+					   guest_repeatedly_read);
+
+	/* Add a non-private memslot (flags = 0) */
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    EXITS_TEST_GPA, EXITS_TEST_SLOT,
+				    EXITS_TEST_NPAGES, 0);
+
+	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
+
+	/* Request to access page privately */
+	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
+
+	exit_reason = run_vcpu_get_exit_reason(vcpu);
+
+	TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
+	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
+	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
+
+	test_private_access_memslot_deleted();
+	test_private_access_memslot_not_private();
+}
-- 
2.42.0.283.g2d96d420d3-goog

