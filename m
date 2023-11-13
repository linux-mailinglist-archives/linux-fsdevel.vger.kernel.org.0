Return-Path: <linux-fsdevel+bounces-2791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCBA7E9C0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 13:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FF71F20F88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7270C1DA3D;
	Mon, 13 Nov 2023 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlvxRCSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F41D699
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 12:21:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F62D47
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 04:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699878093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zIHSrYUcQnxoKXdjZZpZq5jMd/3daIfiQKpFrLHTsdU=;
	b=FlvxRCSbov8rXM91fNKkRF9o8nuy8R4txs2FySiunWdxcYZ3q+jfMMQae+fNBUzDalBmrb
	5AidbILvCT8/TXDMHibhNOjp4bTAT/SnwMZAHlQBISdYx/g+csWmDXzcBh75WAJ1kfM8Au
	EOkfdce0hmnaU1LovkCB4SH3IX8aaxs=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Z4kf8mX3NZS3pcnrpl_F7A-1; Mon, 13 Nov 2023 07:21:32 -0500
X-MC-Unique: Z4kf8mX3NZS3pcnrpl_F7A-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7ba6bf56798so1559263241.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 04:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699878091; x=1700482891;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIHSrYUcQnxoKXdjZZpZq5jMd/3daIfiQKpFrLHTsdU=;
        b=vU+o65ZZDGdI0BMU4B7IoNmbGyzv1RvTctfOnQ8FY4WwsulHOKiCxNwfTiKTHhS6Gn
         d9e3mRQyBGnTVcEvvig3lfBTmnGwtQPdf7mbv6nwVfm8XhJUnZDG7Z5BYuEyympcDxc9
         WObgX13GN30/YFHaLAAESwXsHgyNSnQLvglRYNZq68Ox0HE6FqHDQs21aE9Ot13JhvcN
         lljR/hmygjKG94aw4Tlwyi0qcYP8B0xFLDmrWk0jTsNQoGU6nC0BHHf2Xj2UtG5ZebBO
         D/D9Qih3xlP3o4y6vLUJFHZ4xxC5yz6grJzUrdPuNirvpLWpDqvlM8ylJQ8csFHGrGeJ
         uVKA==
X-Gm-Message-State: AOJu0Yz+e/M69kSAsqWZYV+LvEoJ3oT/JHnYdug3fRTgUqk4OsCiBMmN
	Y805hLU2tfdCHN0oDv0Jnia/97JByn+QofCnaVorQ/j2NzY0ikKGQIwqnXKF6K1BvrC975ZCo3+
	87VjhQjqSgxt0eRsc5ZLe1BUd0w==
X-Received: by 2002:a67:f2c8:0:b0:457:670f:e2eb with SMTP id a8-20020a67f2c8000000b00457670fe2ebmr6417741vsn.20.1699878090974;
        Mon, 13 Nov 2023 04:21:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKSa6ruCnuzN9s2Ejc4l9S4h3ZVAauCQx41zE3qMS0kOL2lujOmHkFT5dC7rrBHQxe5Bi5+A==
X-Received: by 2002:a67:f2c8:0:b0:457:670f:e2eb with SMTP id a8-20020a67f2c8000000b00457670fe2ebmr6417723vsn.20.1699878090682;
        Mon, 13 Nov 2023 04:21:30 -0800 (PST)
Received: from [192.168.157.67] ([12.191.197.195])
        by smtp.googlemail.com with ESMTPSA id j22-20020ac874d6000000b00419801b1094sm1904299qtr.13.2023.11.13.04.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 04:21:29 -0800 (PST)
Message-ID: <d3071794-7c02-4ca1-850d-1d5242de4f98@redhat.com>
Date: Mon, 13 Nov 2023 13:21:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/34] KVM: guest_memfd() and per-page attributes
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Sean Christopherson <seanjc@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>,
 David Matlack <dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerley Tng <ackerleytng@google.com>,
 Maciej Szmigiero <mail@maciej.szmigiero.name>,
 David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>,
 Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>,
 Liam Merwick <liam.merwick@oracle.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20231105163040.14904-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/23 17:30, Paolo Bonzini wrote:
> The "development cycle" for this version is going to be very short;
> ideally, next week I will merge it as is in kvm/next, taking this through
> the KVM tree for 6.8 immediately after the end of the merge window.
> The series is still based on 6.6 (plus KVM changes for 6.7) so it
> will require a small fixup for changes to get_file_rcu() introduced in
> 6.7 by commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU").
> The fixup will be done as part of the merge commit, and most of the text
> above will become the commit message for the merge.

The changes from review are small enough and entirely in tests, so
I went ahead and pushed it to kvm/next, together with "selftests: kvm/s390x: use vm_create_barebones()" which also fixed testcase failures (similar to the aarch64/page_fault_test.c hunk below).

The guestmemfd branch on kvm.git was force-pushed, and can be used for further
development if you don't want to run 6.7-rc1 for whatever reason.

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 38882263278d..926241e23aeb 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1359,7 +1359,6 @@ yet and must be cleared on entry.
  	__u64 guest_phys_addr;
  	__u64 memory_size; /* bytes */
  	__u64 userspace_addr; /* start of the userspace allocated memory */
-	__u64 pad[16];
    };
  
    /* for kvm_userspace_memory_region::flags */
diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
index eb4217b7c768..08a5ca5bed56 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -705,7 +705,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
  
  	print_test_banner(mode, p);
  
-	vm = ____vm_create(mode);
+	vm = ____vm_create(VM_SHAPE(mode));
  	setup_memslots(vm, p);
  	kvm_vm_elf_load(vm, program_invocation_name);
  	setup_ucall(vm);
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index ea0ae7e25330..fd389663c49b 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -6,14 +6,6 @@
   */
  
  #define _GNU_SOURCE
-#include "test_util.h"
-#include "kvm_util_base.h"
-#include <linux/bitmap.h>
-#include <linux/falloc.h>
-#include <sys/mman.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-
  #include <stdlib.h>
  #include <string.h>
  #include <unistd.h>
@@ -21,6 +13,15 @@
  #include <stdio.h>
  #include <fcntl.h>
  
+#include <linux/bitmap.h>
+#include <linux/falloc.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include "test_util.h"
+#include "kvm_util_base.h"
+
  static void test_file_read_write(int fd)
  {
  	char buf[64];
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index e4d2cd9218b2..1b58f943562f 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -819,6 +819,7 @@ static inline struct kvm_vm *vm_create_barebones(void)
  	return ____vm_create(VM_SHAPE_DEFAULT);
  }
  
+#ifdef __x86_64__
  static inline struct kvm_vm *vm_create_barebones_protected_vm(void)
  {
  	const struct vm_shape shape = {
@@ -828,6 +829,7 @@ static inline struct kvm_vm *vm_create_barebones_protected_vm(void)
  
  	return ____vm_create(shape);
  }
+#endif
  
  static inline struct kvm_vm *vm_create(uint32_t nr_runnable_vcpus)
  {
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index d05d95cc3693..9b29cbf49476 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1214,7 +1214,7 @@ void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t base, uint64_t size,
  		TEST_ASSERT(region && region->region.flags & KVM_MEM_GUEST_MEMFD,
  			    "Private memory region not found for GPA 0x%lx", gpa);
  
-		offset = (gpa - region->region.guest_phys_addr);
+		offset = gpa - region->region.guest_phys_addr;
  		fd_offset = region->region.guest_memfd_offset + offset;
  		len = min_t(uint64_t, end - gpa, region->region.memory_size - offset);
  
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 343e807043e1..1efee1cfcff0 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -433,6 +433,7 @@ static void test_add_max_memory_regions(void)
  }
  
  
+#ifdef __x86_64__
  static void test_invalid_guest_memfd(struct kvm_vm *vm, int memfd,
  				     size_t offset, const char *msg)
  {
@@ -523,14 +524,13 @@ static void test_add_overlapping_private_memory_regions(void)
  	close(memfd);
  	kvm_vm_free(vm);
  }
+#endif
  
  int main(int argc, char *argv[])
  {
  #ifdef __x86_64__
  	int i, loops;
-#endif
  
-#ifdef __x86_64__
  	/*
  	 * FIXME: the zero-memslot test fails on aarch64 and s390x because
  	 * KVM_RUN fails with ENOEXEC or EFAULT.
@@ -542,6 +542,7 @@ int main(int argc, char *argv[])
  
  	test_add_max_memory_regions();
  
+#ifdef __x86_64__
  	if (kvm_has_cap(KVM_CAP_GUEST_MEMFD) &&
  	    (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))) {
  		test_add_private_memory_region();
@@ -550,7 +551,6 @@ int main(int argc, char *argv[])
  		pr_info("Skipping tests for KVM_MEM_GUEST_MEMFD memory regions\n");
  	}
  
-#ifdef __x86_64__
  	if (argc > 1)
  		loops = atoi_positive("Number of iterations", argv[1]);
  	else
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
index 2f02f6128482..13e72fcec8dd 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
@@ -1,6 +1,6 @@
  // SPDX-License-Identifier: GPL-2.0-only
  /*
- * Copyright (C) 2022, Google LLC.
+ * Copyright (C) 2023, Google LLC.
   */
  #include <linux/kvm.h>
  #include <pthread.h>

Paolo


