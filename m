Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317E17589A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 01:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjGRXxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 19:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjGRXws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:52:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA08C3599
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:50:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5706641dda9so55252457b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724161; x=1692316161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=v06h+ALMtOOYf7fX/Ew5y3Hfc7UGMHCjlt3bjyKHsv0=;
        b=YRRA1+3rdyppDplfs3XH3aJvhxtsAMd7YC9o1tjP/IyjupywaQyvKq+rps81DQn6n1
         IfT/9T8MBfb/05cpg+uFjPqU9WMKZxQ9fzOPBnRI+m2vIHPLSV2s/3KQGxo5DIXUHwOZ
         GdmSnQGPnvE14OEYqjCx4Fm+ABerxK8mDpsKlW+8NItJ+M4Kcnqzj3n4Y+k+3R/C1UBu
         wvL5E8Pm7bjCuwRxFwoKwRUML3nMWrNZ+3vwOtoXEZiYJEJR64OEqgs5nwKpwCN2Ct+r
         TXr64pWKwZcTWMIuNy53NUZP6UdwEiJkjqYQFxPcJ5UQJleLQ7qGIFzyDTx8Cn3NQNJC
         aywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724161; x=1692316161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v06h+ALMtOOYf7fX/Ew5y3Hfc7UGMHCjlt3bjyKHsv0=;
        b=aZXQNlWIAdis/lmpUUvjNepG9ZXk3bOZMaDsbS/5kPY1kPAmjMvROJFo/w6fKIiffi
         gL6F1zqZGFhVb6Y6B1zPdCY6OSsNYN59+sqBaONOMW786Giwry4cKAzd6NmkEE/ObjoE
         dYYvzMBHJE8PgHnl05sHgdV3QgZt2zR/TkKKWJow6e8c0+Xi4orhKvLsIEpW09NTOcQa
         EcAaKA87aXqEzZL4A/2/GcYbxuwfbb+yq35qOcyIdrzThKWt5Y9+tBppTqoYMSdJQf0Z
         cpRa3lgDCgan4g1RcnKlAXB2l0KmunT/Hc9BJ3Z97dRlygqNl87hY+9tce6QZua+xI9N
         cAGw==
X-Gm-Message-State: ABy/qLa6Yu9L1iqugxcBZgwiCag/IKkjdSYeSXs6k6NCl2hpw8N19Ls3
        5ByyTd/FhNIwZ2VIfSOEsmOI43L4Q4Q=
X-Google-Smtp-Source: APBJJlHpdLxbHGSEDlhfQMIka8AkYqbvfykkp39Gd8+LzOAP/g6chkA545wiuNlxw+N3wiN86qnMnz3hgbE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b306:0:b0:56c:fce1:7d8d with SMTP id
 r6-20020a81b306000000b0056cfce17d8dmr185110ywh.6.1689724161668; Tue, 18 Jul
 2023 16:49:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:45:09 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-27-seanjc@google.com>
Subject: [RFC PATCH v11 26/29] KVM: selftests: Add KVM_SET_USER_MEMORY_REGION2 helper
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
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

From: Chao Peng <chao.p.peng@linux.intel.com>

Provide a raw version as well as an assert-success version to reduce
the amount of boilerplate code need for basic usage.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  7 +++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 29 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 856440294013..334df27a6f43 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -492,6 +492,13 @@ void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 			       uint64_t gpa, uint64_t size, void *hva);
 int __vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 				uint64_t gpa, uint64_t size, void *hva);
+void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot,
+				uint32_t flags, uint64_t gpa, uint64_t size,
+				void *hva, uint32_t gmem_fd, uint64_t gmem_offset);
+int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot,
+				 uint32_t flags, uint64_t gpa, uint64_t size,
+				 void *hva, uint32_t gmem_fd, uint64_t gmem_offset);
+
 void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	enum vm_mem_backing_src_type src_type,
 	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 64221c320389..f7b8b5eb3e8f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -868,6 +868,35 @@ void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 		    errno, strerror(errno));
 }
 
+int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot,
+				 uint32_t flags, uint64_t gpa, uint64_t size,
+				 void *hva, uint32_t gmem_fd, uint64_t gmem_offset)
+{
+	struct kvm_userspace_memory_region2 region = {
+		.slot = slot,
+		.flags = flags,
+		.guest_phys_addr = gpa,
+		.memory_size = size,
+		.userspace_addr = (uintptr_t)hva,
+		.gmem_fd = gmem_fd,
+		.gmem_offset = gmem_offset,
+	};
+
+	return ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION2, &region);
+}
+
+void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot,
+				uint32_t flags, uint64_t gpa, uint64_t size,
+				void *hva, uint32_t gmem_fd, uint64_t gmem_offset)
+{
+	int ret = __vm_set_user_memory_region2(vm, slot, flags, gpa, size, hva,
+					       gmem_fd, gmem_offset);
+
+	TEST_ASSERT(!ret, "KVM_SET_USER_MEMORY_REGION2 failed, errno = %d (%s)",
+		    errno, strerror(errno));
+}
+
+
 /* FIXME: This thing needs to be ripped apart and rewritten. */
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
-- 
2.41.0.255.g8b1d071c50-goog

