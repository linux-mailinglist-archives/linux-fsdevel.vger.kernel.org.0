Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB19724C7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbjFFTHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239332AbjFFTHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:07:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF431FEB
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:05:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bad475920a8so16488086276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078286; x=1688670286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3QY+GjjNY/B/LKbvEsBmmion/NMqJeuEYcwlsx1w+c=;
        b=ga7yY2wFSjsTCtNYT2NMM1yjmokiEXDaCTuXNhL4QFIjeFOGWXP9m4xRNkNarZKOBt
         me9uyDk1llgo74NsZn/+85xOGgk1JymFHYuOx2vpupSEs8KBznt7C4GK7pW1At3io3MV
         omuLB1jzJaLc4Zg0yimBb4CzacnWix8fdVSxMBPt8YeYd8UktVq4LjjSoaTbCwhO+eXy
         EZa5FIg//RusZW7f2NgtTOFoqGNu6khof2qQQ8vk0r6gz2il2XRm/VN/dp/gxWzndj0K
         LOfFsFQnLTJrS+CT3R61MXxoPNTsaAUuUv0u7TZgtSvuJTPRds1QGGcjrMoDqzJSrIHy
         9Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078286; x=1688670286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3QY+GjjNY/B/LKbvEsBmmion/NMqJeuEYcwlsx1w+c=;
        b=PSPFWWupTM2FaM9vCCGgx1rt5Un+jLkHHzulwBFLMuTOZZ8zeFY5Aex29vvXvzS/bM
         TbBjMVcUqNXR4ytzzjbqxjSEEuV37ir0FV30W6t2iUDPK4LeK9lZBMYbtMHpbTseSzOO
         IKNZGHz9ONauVFgv5C8UCtlK9KNB73EpNLkSlsCesgYECe7JkCZb+MKZy4bvisvJ/o22
         GJB7CQ70v9f2XOYVGqz5Wn3PeWDbKgnEZpQOcIEEhvbgU9COiBiwBP5iAQEZJPd16cmU
         vKMOWUg3mS4qfDYHypbgZ7Eeorqneugn1MHsJuXpQODF3em3btHLvOlYlcYC2KzWCtvZ
         BMbg==
X-Gm-Message-State: AC+VfDw3SQd+kDxPXq/Z9NbWO/6AkPraQfYOgL0AVL+PMn0BtFwkfJ/o
        1RE9mpHKA3VcIpAS0pyxoskRPCb4EsrZ13iETA==
X-Google-Smtp-Source: ACHHUZ7zyWkKPX7nW+eqyXqGuqnjfZMxWtQ7sqNr3g3ix//f4WlCF2yUeIoJ+N8uNLRa6EBYQO+4YPcXyNwMiHRgqA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:aea3:0:b0:bb3:9b99:f3f5 with SMTP
 id b35-20020a25aea3000000b00bb39b99f3f5mr1433391ybj.4.1686078286504; Tue, 06
 Jun 2023 12:04:46 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:04:03 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <5f0d27ce06c03761974264bd8a890614ea7ecb32.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 18/19] KVM: selftests: Support various types of backing
 sources for private memory
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

Adds support for various type of backing sources for private
memory (in the sense of confidential computing), similar to the
backing sources available for shared memory.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/include/test_util.h | 14 ++++
 tools/testing/selftests/kvm/lib/test_util.c   | 74 +++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a6e9f215ce70..899ea15ca8a9 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -122,6 +122,16 @@ struct vm_mem_backing_src_alias {
 	uint32_t flag;
 };
 
+enum vm_pmem_backing_src_type {
+	VM_PMEM_SRC_GMEM,
+	VM_PMEM_SRC_HUGETLB,  /* Use kernel default page size for hugetlb pages */
+	VM_PMEM_SRC_HUGETLB_2MB,
+	VM_PMEM_SRC_HUGETLB_1GB,
+	NUM_PMEM_SRC_TYPES,
+};
+
+#define DEFAULT_VM_PMEM_SRC VM_PMEM_SRC_GMEM
+
 #define MIN_RUN_DELAY_NS	200000UL
 
 bool thp_configured(void);
@@ -132,6 +142,10 @@ size_t get_backing_src_pagesz(uint32_t i);
 bool is_backing_src_hugetlb(uint32_t i);
 void backing_src_help(const char *flag);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
+void pmem_backing_src_help(const char *flag);
+enum vm_pmem_backing_src_type parse_pmem_backing_src_type(const char *type_name);
+const struct vm_mem_backing_src_alias *vm_pmem_backing_src_alias(uint32_t i);
+size_t get_pmem_backing_src_pagesz(uint32_t i);
 long get_run_delay(void);
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index b772193f6c18..62efb7b8ba51 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -8,6 +8,7 @@
 #include <assert.h>
 #include <ctype.h>
 #include <limits.h>
+#include <linux/kvm.h>
 #include <stdlib.h>
 #include <time.h>
 #include <sys/stat.h>
@@ -287,6 +288,34 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 	return &aliases[i];
 }
 
+const struct vm_mem_backing_src_alias *vm_pmem_backing_src_alias(uint32_t i)
+{
+	static const struct vm_mem_backing_src_alias aliases[] = {
+		[VM_PMEM_SRC_GMEM] = {
+			.name = "pmem_gmem",
+			.flag = 0,
+		},
+		[VM_PMEM_SRC_HUGETLB] = {
+			.name = "pmem_hugetlb",
+			.flag = KVM_GUEST_MEMFD_HUGETLB,
+		},
+		[VM_PMEM_SRC_HUGETLB_2MB] = {
+			.name = "pmem_hugetlb_2mb",
+			.flag = KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_2MB,
+		},
+		[VM_PMEM_SRC_HUGETLB_1GB] = {
+			.name = "pmem_hugetlb_1gb",
+			.flag = KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_1GB,
+		},
+	};
+	_Static_assert(ARRAY_SIZE(aliases) == NUM_PMEM_SRC_TYPES,
+		       "Missing new backing private mem src types?");
+
+	TEST_ASSERT(i < NUM_PMEM_SRC_TYPES, "Private mem backing src type ID %d too big", i);
+
+	return &aliases[i];
+}
+
 #define MAP_HUGE_PAGE_SIZE(x) (1ULL << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
 
 size_t get_backing_src_pagesz(uint32_t i)
@@ -307,6 +336,20 @@ size_t get_backing_src_pagesz(uint32_t i)
 	}
 }
 
+size_t get_pmem_backing_src_pagesz(uint32_t i)
+{
+	uint32_t flag = vm_pmem_backing_src_alias(i)->flag;
+
+	switch (i) {
+	case VM_PMEM_SRC_GMEM:
+		return getpagesize();
+	case VM_PMEM_SRC_HUGETLB:
+		return get_def_hugetlb_pagesz();
+	default:
+		return MAP_HUGE_PAGE_SIZE(flag);
+	}
+}
+
 bool is_backing_src_hugetlb(uint32_t i)
 {
 	return !!(vm_mem_backing_src_alias(i)->flag & MAP_HUGETLB);
@@ -343,6 +386,37 @@ enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name)
 	return -1;
 }
 
+static void print_available_pmem_backing_src_types(const char *prefix)
+{
+	int i;
+
+	printf("%sAvailable private mem backing src types:\n", prefix);
+
+	for (i = 0; i < NUM_PMEM_SRC_TYPES; i++)
+		printf("%s    %s\n", prefix, vm_pmem_backing_src_alias(i)->name);
+}
+
+void pmem_backing_src_help(const char *flag)
+{
+	printf(" %s: specify the type of memory that should be used to\n"
+	       "     back guest private memory. (default: %s)\n",
+	       flag, vm_pmem_backing_src_alias(DEFAULT_VM_MEM_SRC)->name);
+	print_available_pmem_backing_src_types("     ");
+}
+
+enum vm_pmem_backing_src_type parse_pmem_backing_src_type(const char *type_name)
+{
+	int i;
+
+	for (i = 0; i < NUM_SRC_TYPES; i++)
+		if (!strcmp(type_name, vm_pmem_backing_src_alias(i)->name))
+			return i;
+
+	print_available_pmem_backing_src_types("");
+	TEST_FAIL("Unknown private mem backing src type: %s", type_name);
+	return -1;
+}
+
 long get_run_delay(void)
 {
 	char path[64];
-- 
2.41.0.rc0.172.g3f132b7071-goog

