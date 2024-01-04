Return-Path: <linux-fsdevel+bounces-7350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043AB823FE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 11:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831EA1F25134
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5562320DE9;
	Thu,  4 Jan 2024 10:51:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076A20DCD
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="123966560"
X-IronPort-AV: E=Sophos;i="6.04,330,1695654000"; 
   d="scan'208";a="123966560"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 19:50:01 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 54DA7D63DD
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 19:49:59 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 81953D5072
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 19:49:58 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 00B65202CAA52
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 19:49:58 +0900 (JST)
Received: from irides.. (unknown [10.167.234.230])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 2EB701A0071;
	Thu,  4 Jan 2024 18:49:57 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz
Subject: [PATCH] fsdax: cleanup tracepoints
Date: Thu,  4 Jan 2024 18:49:25 +0800
Message-Id: <20240104104925.3496797-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28098.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28098.006
X-TMASE-Result: 10-0.652800-10.000000
X-TMASE-MatchedRID: Dcq+tTLukTq9okcRaxJ3YLnHu4BcYSmtwTlc9CcHMZerwqxtE531VNnf
	JrUSEbFDw2hNqOkj1XDNgNCy/TBDFgnbQnr9fWNSGYJhRh6ssetYL/tox9XQkZ+9KccEt4MqZom
	pBzUjZLBzzWLzuR3HAoAy6p60ZV62fJ5/bZ6npdjGVuWouVipco55DTF7ZkLA8bCMMxUUqtDJ7C
	TvhQc24yYMggXRAcWXx0zGKiUHRKaz9VMvQYEoFMZVvuSPCNGrtq6qUnL4ZaKM29MZ1ZzavRFlt
	GxCTkwFQHVA+r1vGdZmQDEDCMiuswfP8fSSIvISoYC0cwOOST0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Restore the tracepoint that was accidentally deleted before, and rename
to dax_insert_entry().  Also, since we are using XArray, rename
'radix_entry' to 'xa_entry'.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c                      |  2 ++
 include/trace/events/fs_dax.h | 47 +++++++++++++++++------------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 3380b43cb6bb..7e7aabec91d8 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1684,6 +1684,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	if (dax_fault_is_synchronous(iter, vmf->vma))
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
+	trace_dax_insert_entry(iter->inode, vmf, *entry);
+
 	/* insert PMD pfn */
 	if (pmd)
 		return vmf_insert_pfn_pmd(vmf, pfn, write);
diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
index 97b09fcf7e52..2ec2dcc8f66a 100644
--- a/include/trace/events/fs_dax.h
+++ b/include/trace/events/fs_dax.h
@@ -62,15 +62,14 @@ DEFINE_PMD_FAULT_EVENT(dax_pmd_fault_done);
 
 DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
 	TP_PROTO(struct inode *inode, struct vm_fault *vmf,
-		struct page *zero_page,
-		void *radix_entry),
-	TP_ARGS(inode, vmf, zero_page, radix_entry),
+		struct page *zero_page, void *xa_entry),
+	TP_ARGS(inode, vmf, zero_page, xa_entry),
 	TP_STRUCT__entry(
 		__field(unsigned long, ino)
 		__field(unsigned long, vm_flags)
 		__field(unsigned long, address)
 		__field(struct page *, zero_page)
-		__field(void *, radix_entry)
+		__field(void *, xa_entry)
 		__field(dev_t, dev)
 	),
 	TP_fast_assign(
@@ -79,40 +78,40 @@ DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
 		__entry->vm_flags = vmf->vma->vm_flags;
 		__entry->address = vmf->address;
 		__entry->zero_page = zero_page;
-		__entry->radix_entry = radix_entry;
+		__entry->xa_entry = xa_entry;
 	),
 	TP_printk("dev %d:%d ino %#lx %s address %#lx zero_page %p "
-			"radix_entry %#lx",
+			"xa_entry %#lx",
 		MAJOR(__entry->dev),
 		MINOR(__entry->dev),
 		__entry->ino,
 		__entry->vm_flags & VM_SHARED ? "shared" : "private",
 		__entry->address,
 		__entry->zero_page,
-		(unsigned long)__entry->radix_entry
+		(unsigned long)__entry->xa_entry
 	)
 )
 
 #define DEFINE_PMD_LOAD_HOLE_EVENT(name) \
 DEFINE_EVENT(dax_pmd_load_hole_class, name, \
 	TP_PROTO(struct inode *inode, struct vm_fault *vmf, \
-		struct page *zero_page, void *radix_entry), \
-	TP_ARGS(inode, vmf, zero_page, radix_entry))
+		struct page *zero_page, void *xa_entry), \
+	TP_ARGS(inode, vmf, zero_page, xa_entry))
 
 DEFINE_PMD_LOAD_HOLE_EVENT(dax_pmd_load_hole);
 DEFINE_PMD_LOAD_HOLE_EVENT(dax_pmd_load_hole_fallback);
 
 DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 	TP_PROTO(struct inode *inode, struct vm_fault *vmf,
-		long length, pfn_t pfn, void *radix_entry),
-	TP_ARGS(inode, vmf, length, pfn, radix_entry),
+		long length, pfn_t pfn, void *xa_entry),
+	TP_ARGS(inode, vmf, length, pfn, xa_entry),
 	TP_STRUCT__entry(
 		__field(unsigned long, ino)
 		__field(unsigned long, vm_flags)
 		__field(unsigned long, address)
 		__field(long, length)
 		__field(u64, pfn_val)
-		__field(void *, radix_entry)
+		__field(void *, xa_entry)
 		__field(dev_t, dev)
 		__field(int, write)
 	),
@@ -124,10 +123,10 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 		__entry->write = vmf->flags & FAULT_FLAG_WRITE;
 		__entry->length = length;
 		__entry->pfn_val = pfn.val;
-		__entry->radix_entry = radix_entry;
+		__entry->xa_entry = xa_entry;
 	),
 	TP_printk("dev %d:%d ino %#lx %s %s address %#lx length %#lx "
-			"pfn %#llx %s radix_entry %#lx",
+			"pfn %#llx %s xa_entry %#lx",
 		MAJOR(__entry->dev),
 		MINOR(__entry->dev),
 		__entry->ino,
@@ -138,15 +137,15 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 		__entry->pfn_val & ~PFN_FLAGS_MASK,
 		__print_flags_u64(__entry->pfn_val & PFN_FLAGS_MASK, "|",
 			PFN_FLAGS_TRACE),
-		(unsigned long)__entry->radix_entry
+		(unsigned long)__entry->xa_entry
 	)
 )
 
 #define DEFINE_PMD_INSERT_MAPPING_EVENT(name) \
 DEFINE_EVENT(dax_pmd_insert_mapping_class, name, \
 	TP_PROTO(struct inode *inode, struct vm_fault *vmf, \
-		long length, pfn_t pfn, void *radix_entry), \
-	TP_ARGS(inode, vmf, length, pfn, radix_entry))
+		long length, pfn_t pfn, void *xa_entry), \
+	TP_ARGS(inode, vmf, length, pfn, xa_entry))
 
 DEFINE_PMD_INSERT_MAPPING_EVENT(dax_pmd_insert_mapping);
 
@@ -194,14 +193,14 @@ DEFINE_PTE_FAULT_EVENT(dax_load_hole);
 DEFINE_PTE_FAULT_EVENT(dax_insert_pfn_mkwrite_no_entry);
 DEFINE_PTE_FAULT_EVENT(dax_insert_pfn_mkwrite);
 
-TRACE_EVENT(dax_insert_mapping,
-	TP_PROTO(struct inode *inode, struct vm_fault *vmf, void *radix_entry),
-	TP_ARGS(inode, vmf, radix_entry),
+TRACE_EVENT(dax_insert_entry,
+	TP_PROTO(struct inode *inode, struct vm_fault *vmf, void *xa_entry),
+	TP_ARGS(inode, vmf, xa_entry),
 	TP_STRUCT__entry(
 		__field(unsigned long, ino)
 		__field(unsigned long, vm_flags)
 		__field(unsigned long, address)
-		__field(void *, radix_entry)
+		__field(void *, xa_entry)
 		__field(dev_t, dev)
 		__field(int, write)
 	),
@@ -211,16 +210,16 @@ TRACE_EVENT(dax_insert_mapping,
 		__entry->vm_flags = vmf->vma->vm_flags;
 		__entry->address = vmf->address;
 		__entry->write = vmf->flags & FAULT_FLAG_WRITE;
-		__entry->radix_entry = radix_entry;
+		__entry->xa_entry = xa_entry;
 	),
-	TP_printk("dev %d:%d ino %#lx %s %s address %#lx radix_entry %#lx",
+	TP_printk("dev %d:%d ino %#lx %s %s address %#lx xa_entry %#lx",
 		MAJOR(__entry->dev),
 		MINOR(__entry->dev),
 		__entry->ino,
 		__entry->vm_flags & VM_SHARED ? "shared" : "private",
 		__entry->write ? "write" : "read",
 		__entry->address,
-		(unsigned long)__entry->radix_entry
+		(unsigned long)__entry->xa_entry
 	)
 )
 
-- 
2.34.1


