Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649B3724C85
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbjFFTIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbjFFTHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:07:04 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D521FFB
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:05:10 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-659bb123ccfso2697818b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078288; x=1688670288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CCEiTTKrsebxDoXfSRZP/CN+WTuYdz3sOeWxyKUUyPY=;
        b=KFM+d/JKzgYvN5OR6kU44o+ZYxe7Q/H7MNTOnP/z0cxW3//uRTJeZxZ8dFp8Jit4Gf
         YquLlWVy9xCdFnBGp+gPFhLtGo2w3F50cPqXWf8JFYlZ/OGxawmSMJJ/jIE184rG6FHp
         ixTL8P/2ovgE/QdCx/NLmyiW9xL5hbY3itkmDOuPi4r2D/Bp6z5cypKETkTA5IN3CsDs
         1vhuCHFDhZuON8z8NNnBNoq7He9ZNsDe7Xmjzq9wK+9M2GgIoXw9C4JhNu7KegBFAMS3
         MULic01j2ol2uU6vWbv87Xaf10SomC0FL9lq9TfMGxJn5DnDmpEo+KEOdrVPsgYMpseZ
         BMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078288; x=1688670288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCEiTTKrsebxDoXfSRZP/CN+WTuYdz3sOeWxyKUUyPY=;
        b=jKhDDHKCpKLcnMHlGSAD2ghosHzPGyfExYv4NFsd7ajuOQ812kJpghxziRZZo+XnNK
         E9Par/prgqzij3BrKLDo2Hbn+MA6I5j0yvoeYrEqbnbWNy36Pg9jtlg2Z1nMclxDd2kU
         xwRYxR/VhnRgeKzO/M5nZLIF05lm2PiAwQmx+Q9KQIex0ZQcziFBOqLd8Z6XthcDjRMg
         V6cHVMM/FJfxDBTEFsFWnfCL2H7KsUD1lB2wSfLqfPUIFGZBZUWer4Up9DqxbEVFNnrg
         KolcCbF6sXol+eENVjoPHdCdwaZmUKOB52YAOovBnKEkreIG62/xq5+fNhTgK/7IrRsr
         NSow==
X-Gm-Message-State: AC+VfDwOqMsusCqmJSUw9qYoCnzOj/2EgwFObs3je8Cgo0g6FYpOCvgU
        YohznOw/PSWPXAATb3GQkoNfhJ6axeXzyDnxMg==
X-Google-Smtp-Source: ACHHUZ5UZgVYlUWSYfljNriuMM/SFMypamtYGG6ajWbl9pU1XKFK+BBOu36l6aAPASb6U7Gvlg5sOoRl6fqEbUEr5Q==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:13a6:b0:657:f26e:b025 with
 SMTP id t38-20020a056a0013a600b00657f26eb025mr1318192pfg.6.1686078288430;
 Tue, 06 Jun 2023 12:04:48 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:04:04 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <3ae2d02c45c5fb91b490b1674165c733efb871d6.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 19/19] KVM: selftests: Update test for various private
 memory backing source types
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, willy@infradead.org
Cc:     brauner@kernel.org, chao.p.peng@linux.intel.com,
        coltonlewis@google.com, david@redhat.com, dhildenb@redhat.com,
        dmatlack@google.com, erdemaktas@google.com, hughd@google.com,
        isaku.yamahata@gmail.com, jarkko@kernel.org, jmattson@google.com,
        joro@8bytes.org, jthoughton@google.com, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        qperret@google.com, rientjes@google.com, rppt@kernel.org,
        steven.price@arm.com, tabba@google.com, vannapurve@google.com,
        vbabka@suse.cz, vipinsh@google.com, vkuznets@redhat.com,
        wei.w.wang@intel.com, yu.c.zhang@linux.intel.com,
        kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, x86@kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update private_mem_conversions_test for various private memory backing
source types

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/x86_64/private_mem_conversions_test.c | 38 ++++++++++++++-----
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
index 6a353cf64f52..27a7e5099b7b 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
@@ -240,14 +240,15 @@ static void *__test_mem_conversions(void *__vcpu)
 	}
 }
 
-static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t nr_vcpus,
-				 uint32_t nr_memslots)
+static void test_mem_conversions(enum vm_mem_backing_src_type src_type,
+				 enum vm_pmem_backing_src_type pmem_src_type,
+				 uint32_t nr_vcpus, uint32_t nr_memslots)
 {
-	const size_t memfd_size = PER_CPU_DATA_SIZE * nr_vcpus;
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t threads[KVM_MAX_VCPUS];
 	struct kvm_vm *vm;
 	int memfd, i, r;
+	size_t pmem_aligned_size, memfd_size;
 	size_t test_unit_size;
 
 	const struct vm_shape shape = {
@@ -270,21 +271,32 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 		 * Allocate enough memory so that each vCPU's chunk of memory can be
 		 * naturally aligned with respect to the size of the backing store.
 		 */
-		test_unit_size = align_up(PER_CPU_DATA_SIZE, get_backing_src_pagesz(src_type));
+		test_unit_size = align_up(PER_CPU_DATA_SIZE,
+					  max(get_backing_src_pagesz(src_type),
+					      get_pmem_backing_src_pagesz(pmem_src_type)));
 	}
 
-	memfd = vm_create_guest_memfd(vm, memfd_size, 0);
+	pmem_aligned_size = PER_CPU_DATA_SIZE;
+	if (nr_memslots > 1) {
+		pmem_aligned_size = align_up(PER_CPU_DATA_SIZE,
+					     get_pmem_backing_src_pagesz(pmem_src_type));
+	}
+
+	memfd_size = pmem_aligned_size * nr_vcpus;
+	memfd = vm_create_guest_memfd(vm, memfd_size,
+				      vm_pmem_backing_src_alias(pmem_src_type)->flag);
 	for (i = 0; i < nr_memslots; i++) {
 		uint64_t gpa =  BASE_DATA_GPA + i * test_unit_size;
-		uint64_t npages = PER_CPU_DATA_SIZE / vm->page_size;
+		uint64_t npages = pmem_aligned_size / vm->page_size;
 
 		/* Make sure the memslot is large enough for all the test units */
 		if (nr_memslots == 1)
 			npages *= nr_vcpus;
 
+		/* Offsets must be aligned to private mem's page size */
 		vm_mem_add(vm, src_type, gpa,
 			   BASE_DATA_SLOT + i, npages,
-			   KVM_MEM_PRIVATE, memfd, PER_CPU_DATA_SIZE * i);
+			   KVM_MEM_PRIVATE, memfd, pmem_aligned_size * i);
 	}
 
 	for (i = 0; i < nr_vcpus; i++) {
@@ -324,10 +336,12 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 static void usage(const char *cmd)
 {
 	puts("");
-	printf("usage: %s [-h] [-m] [-s mem_type] [-n nr_vcpus]\n", cmd);
+	printf("usage: %s [-h] [-m] [-s mem_type] [-p pmem_type] [-n nr_vcpus]\n", cmd);
 	puts("");
 	backing_src_help("-s");
 	puts("");
+	pmem_backing_src_help("-p");
+	puts("");
 	puts(" -n: specify the number of vcpus (default: 1)");
 	puts("");
 	puts(" -m: use multiple memslots (default: 1)");
@@ -337,6 +351,7 @@ static void usage(const char *cmd)
 int main(int argc, char *argv[])
 {
 	enum vm_mem_backing_src_type src_type = DEFAULT_VM_MEM_SRC;
+	enum vm_pmem_backing_src_type pmem_src_type = DEFAULT_VM_PMEM_SRC;
 	bool use_multiple_memslots = false;
 	uint32_t nr_vcpus = 1;
 	uint32_t nr_memslots;
@@ -345,11 +360,14 @@ int main(int argc, char *argv[])
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXIT_HYPERCALL));
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_PROTECTED_VM));
 
-	while ((opt = getopt(argc, argv, "hms:n:")) != -1) {
+	while ((opt = getopt(argc, argv, "hms:p:n:")) != -1) {
 		switch (opt) {
 		case 's':
 			src_type = parse_backing_src_type(optarg);
 			break;
+		case 'p':
+			pmem_src_type = parse_pmem_backing_src_type(optarg);
+			break;
 		case 'n':
 			nr_vcpus = atoi_positive("nr_vcpus", optarg);
 			break;
@@ -365,7 +383,7 @@ int main(int argc, char *argv[])
 
 	nr_memslots = use_multiple_memslots ? nr_vcpus : 1;
 
-	test_mem_conversions(src_type, nr_vcpus, nr_memslots);
+	test_mem_conversions(src_type, pmem_src_type, nr_vcpus, nr_memslots);
 
 	return 0;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

