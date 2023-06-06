Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65501724C6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbjFFTHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbjFFTGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:06:03 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C2C1FD4
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:04:56 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b03f9dfd52so25771955ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078280; x=1688670280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qPbJS0NeJm0ebjWuWAGTg4zHB+jUkimTjx0FXzxIc84=;
        b=08oQhpNB5bPsCTiYZb6zzITcl3NrY7Nrj0gHP7CL4wEm89iCZHqEqZvXMnagv03rkn
         GPexWIBMA+li5aiwDX4ihlFm6cVZOeax1+AHpQmOU2YD/QwBli/TC1j7FXVthdfotrbj
         ohAd8tgwk7CZ9llZkCvOzoa+H0uBPFBXEcWSK2TcUhtWGacdRDhynTXSQrFRtxSj03ll
         +4JVjB3yWPlWCPldFPbqjqq8D3jeR9j4nRL0TBHcuQBOxSh7kt2ZiDSE77C+EmED3XTt
         Cx6sMOv8frrdr7pYnwu4yVAynavbLFmrX0Dakhf26NBqNaaItWBILzjwUpL7K2OiHx+L
         mttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078280; x=1688670280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPbJS0NeJm0ebjWuWAGTg4zHB+jUkimTjx0FXzxIc84=;
        b=MI80zQlM3T8vzgRv2k2YaU+t0DHmN3vzJDJkEsxXihp4k2aRenZNzJ01Ia0r7ah5Rp
         DuG/HTBrFxObupWNbNxvVHoguZXban19kljFSzGeUSmgLfQ6nSplZhI0amJ+QLPDbuu8
         Ai5FMxG+G2sIkbURXOMoD3kK31fduhRYME6/BvGj1SLU6mlX96inZVECwu5CAlmKIIKf
         L7Z399cHwyj5N4umebmx0TcLtCTtTZpGASyuouQNycP3SQzdcVu2qmrdPVAxAlMjynDj
         BDgyesirp6p5+94qIsYwubVzKo9wPWVYYbHCSUknRxH1XvmigazqE5NeZOsBZJnnlRVj
         7Ttg==
X-Gm-Message-State: AC+VfDyRzjHPW02BecrZG1wDQ/ziRy1/xceWeSR2VyqXQkhbmdz6/7ae
        yUGCK44DEZkNTeimmAm4XxqqomC8n33VAKr6/g==
X-Google-Smtp-Source: ACHHUZ7+W5XWqHy7WGLlye5fNuolaabE941Ydb/Msxa478YJYlgHnPlrM8+Gzs9sRjg5WLNJlGVtgTPDm/CmJ9Gc2A==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:da8c:b0:1b0:4b1d:26e1 with
 SMTP id j12-20020a170902da8c00b001b04b1d26e1mr956600plx.8.1686078280564; Tue,
 06 Jun 2023 12:04:40 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:04:00 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <f8354b118e7f630c1340a9d651258606bf8d9400.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 15/19] KVM: guest_mem: hugetlb: initialization and cleanup
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

First stage of hugetlb support: add initialization and cleanup
routines

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/uapi/linux/kvm.h | 25 ++++++++++++
 virt/kvm/guest_mem.c     | 88 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 0fa665e8862a..1df0c802c29f 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -13,6 +13,7 @@
 #include <linux/compiler.h>
 #include <linux/ioctl.h>
 #include <asm/kvm.h>
+#include <asm-generic/hugetlb_encode.h>
 
 #define KVM_API_VERSION 12
 
@@ -2280,6 +2281,30 @@ struct kvm_memory_attributes {
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
 
 #define KVM_GUEST_MEMFD_HUGE_PMD		(1ULL << 0)
+#define KVM_GUEST_MEMFD_HUGETLB			(1ULL << 1)
+
+/*
+ * Huge page size encoding when KVM_GUEST_MEMFD_HUGETLB is specified, and a huge
+ * page size other than the default is desired.  See hugetlb_encode.h.  All
+ * known huge page size encodings are provided here.  It is the responsibility
+ * of the application to know which sizes are supported on the running system.
+ * See mmap(2) man page for details.
+ */
+#define KVM_GUEST_MEMFD_HUGE_SHIFT	HUGETLB_FLAG_ENCODE_SHIFT
+#define KVM_GUEST_MEMFD_HUGE_MASK	HUGETLB_FLAG_ENCODE_MASK
+
+#define KVM_GUEST_MEMFD_HUGE_64KB	HUGETLB_FLAG_ENCODE_64KB
+#define KVM_GUEST_MEMFD_HUGE_512KB	HUGETLB_FLAG_ENCODE_512KB
+#define KVM_GUEST_MEMFD_HUGE_1MB	HUGETLB_FLAG_ENCODE_1MB
+#define KVM_GUEST_MEMFD_HUGE_2MB	HUGETLB_FLAG_ENCODE_2MB
+#define KVM_GUEST_MEMFD_HUGE_8MB	HUGETLB_FLAG_ENCODE_8MB
+#define KVM_GUEST_MEMFD_HUGE_16MB	HUGETLB_FLAG_ENCODE_16MB
+#define KVM_GUEST_MEMFD_HUGE_32MB	HUGETLB_FLAG_ENCODE_32MB
+#define KVM_GUEST_MEMFD_HUGE_256MB	HUGETLB_FLAG_ENCODE_256MB
+#define KVM_GUEST_MEMFD_HUGE_512MB	HUGETLB_FLAG_ENCODE_512MB
+#define KVM_GUEST_MEMFD_HUGE_1GB	HUGETLB_FLAG_ENCODE_1GB
+#define KVM_GUEST_MEMFD_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
+#define KVM_GUEST_MEMFD_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
 
 struct kvm_create_guest_memfd {
 	__u64 size;
diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index 13253af40be6..b533143e2878 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -19,6 +19,7 @@
 #include <linux/secretmem.h>
 #include <linux/set_memory.h>
 #include <linux/sched/signal.h>
+#include <linux/hugetlb.h>
 
 #include <uapi/linux/magic.h>
 
@@ -30,6 +31,11 @@ struct kvm_gmem {
 	struct kvm *kvm;
 	u64 flags;
 	struct xarray bindings;
+	struct {
+		struct hstate *h;
+		struct hugepage_subpool *spool;
+		struct resv_map *resv_map;
+	} hugetlb;
 };
 
 static loff_t kvm_gmem_get_size(struct file *file)
@@ -346,6 +352,46 @@ static const struct inode_operations kvm_gmem_iops = {
 	.setattr	= kvm_gmem_setattr,
 };
 
+static int kvm_gmem_hugetlb_setup(struct inode *inode, struct kvm_gmem *gmem,
+				  loff_t size, u64 flags)
+{
+	int page_size_log;
+	int hstate_idx;
+	long hpages;
+	struct resv_map *resv_map;
+	struct hugepage_subpool *spool;
+	struct hstate *h;
+
+	page_size_log = (flags >> KVM_GUEST_MEMFD_HUGE_SHIFT) & KVM_GUEST_MEMFD_HUGE_MASK;
+	hstate_idx = get_hstate_idx(page_size_log);
+	if (hstate_idx < 0)
+		return -ENOENT;
+
+	h = &hstates[hstate_idx];
+	/* Round up to accommodate size requests that don't align with huge pages */
+	hpages = round_up(size, huge_page_size(h)) >> huge_page_shift(h);
+	spool = hugepage_new_subpool(h, hpages, hpages);
+	if (!spool)
+		goto out;
+
+	resv_map = resv_map_alloc();
+	if (!resv_map)
+		goto out_subpool;
+
+	inode->i_blkbits = huge_page_shift(h);
+
+	gmem->hugetlb.h = h;
+	gmem->hugetlb.spool = spool;
+	gmem->hugetlb.resv_map = resv_map;
+
+	return 0;
+
+out_subpool:
+	kfree(spool);
+out:
+	return -ENOMEM;
+}
+
 static struct inode *kvm_gmem_create_inode(struct kvm *kvm, loff_t size, u64 flags,
 					   struct vfsmount *mnt)
 {
@@ -368,6 +414,12 @@ static struct inode *kvm_gmem_create_inode(struct kvm *kvm, loff_t size, u64 fla
 	if (!gmem)
 		goto err_inode;
 
+	if (flags & KVM_GUEST_MEMFD_HUGETLB) {
+		err = kvm_gmem_hugetlb_setup(inode, gmem, size, flags);
+		if (err)
+			goto err_gmem;
+	}
+
 	xa_init(&gmem->bindings);
 
 	kvm_get_kvm(kvm);
@@ -385,6 +437,8 @@ static struct inode *kvm_gmem_create_inode(struct kvm *kvm, loff_t size, u64 fla
 
 	return inode;
 
+err_gmem:
+	kfree(gmem);
 err_inode:
 	iput(inode);
 	return ERR_PTR(err);
@@ -414,6 +468,8 @@ static struct file *kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags
 	return file;
 }
 
+#define KVM_GUEST_MEMFD_ALL_FLAGS (KVM_GUEST_MEMFD_HUGE_PMD | KVM_GUEST_MEMFD_HUGETLB)
+
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *gmem)
 {
 	int fd;
@@ -424,8 +480,15 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *gmem)
 	if (size < 0 || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
-	if (flags & ~KVM_GUEST_MEMFD_HUGE_PMD)
-		return -EINVAL;
+	if (!(flags & KVM_GUEST_MEMFD_HUGETLB)) {
+		if (flags & ~(unsigned int)KVM_GUEST_MEMFD_ALL_FLAGS)
+			return -EINVAL;
+	} else {
+		/* Allow huge page size encoding in flags. */
+		if (flags & ~(unsigned int)(KVM_GUEST_MEMFD_ALL_FLAGS |
+				(KVM_GUEST_MEMFD_HUGE_MASK << KVM_GUEST_MEMFD_HUGE_SHIFT)))
+			return -EINVAL;
+	}
 
 	if (flags & KVM_GUEST_MEMFD_HUGE_PMD) {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -610,7 +673,17 @@ static void kvm_gmem_evict_inode(struct inode *inode)
 	 * pointed at this file.
 	 */
 	kvm_gmem_invalidate_begin(kvm, gmem, 0, -1ul);
-	truncate_inode_pages_final(inode->i_mapping);
+	if (gmem->flags & KVM_GUEST_MEMFD_HUGETLB) {
+		truncate_inode_pages_final_prepare(inode->i_mapping);
+		remove_mapping_hugepages(
+			inode->i_mapping, gmem->hugetlb.h, gmem->hugetlb.spool,
+			gmem->hugetlb.resv_map, inode, 0, LLONG_MAX);
+
+		resv_map_release(&gmem->hugetlb.resv_map->refs);
+		hugepage_put_subpool(gmem->hugetlb.spool);
+	} else {
+		truncate_inode_pages_final(inode->i_mapping);
+	}
 	kvm_gmem_invalidate_end(kvm, gmem, 0, -1ul);
 
 	mutex_unlock(&kvm->slots_lock);
@@ -688,10 +761,15 @@ bool kvm_gmem_check_alignment(const struct kvm_userspace_memory_region2 *mem)
 {
 	size_t page_size;
 
-	if (mem->flags & KVM_GUEST_MEMFD_HUGE_PMD)
+	if (mem->flags & KVM_GUEST_MEMFD_HUGETLB) {
+		size_t page_size_log = ((mem->flags >> KVM_GUEST_MEMFD_HUGE_SHIFT)
+					& KVM_GUEST_MEMFD_HUGE_MASK);
+		page_size = 1UL << page_size_log;
+	} else if (mem->flags & KVM_GUEST_MEMFD_HUGE_PMD) {
 		page_size = HPAGE_PMD_SIZE;
-	else
+	} else {
 		page_size = PAGE_SIZE;
+	}
 
 	return (IS_ALIGNED(mem->gmem_offset, page_size) &&
 		IS_ALIGNED(mem->memory_size, page_size));
-- 
2.41.0.rc0.172.g3f132b7071-goog

