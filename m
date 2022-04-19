Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE71506395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 06:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348576AbiDSEzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 00:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbiDSEzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:55:19 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4ABF36319;
        Mon, 18 Apr 2022 21:50:55 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3ADhHhqKzrkICJ1ftxu856t+dcxyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDhxhTECnDZNWWmHPfqKZTfzKN1xYdm19h9Q6J7Xx9FkHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmj/nSHuOkUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhhc14zs5c85K2U?=
 =?us-ascii?q?hsBMLDOmfgGTl9TFCQW0ahuoeWcfyfm7pHOp6HBWz62qxl0N2k6NJMZ9s55G2Z?=
 =?us-ascii?q?L8uYSKSxLZReG78q2y7KTS+9inM0vIcDneoQFtRlIwTjfS/RgXpHHR6TD4MRw3?=
 =?us-ascii?q?TEsi8QIFvHbD+IVayVoahvoYBBVPFoTTpUkk4+Agnj5bi0drVe9prQ+6GuVyxZ?=
 =?us-ascii?q?+uJDrLtbUf9miQcROgl3eomPA4nS/DhwEXPSdwDyItHmsm8fIhyrwXI9UH7q9n?=
 =?us-ascii?q?tZugVuO1ikdExEbS1a/iee2h1T4WN9FLUEQvC00osAa8E2tU8m4XBCipnOAlgA?=
 =?us-ascii?q?TVsAWEOAg7gyJjK3O7G6xAmkCUy4EeNI9nNE5SCZs1VKTmd7tQzt1v9Wopdi1n?=
 =?us-ascii?q?luPhWrqf3FLcilZPmlZJTbpKuLL+Okb5i8jhP4/eEJtsuDIJA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AVhgD2qsl01+mpSgAOUvrBqzl7skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123671755"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Apr 2022 12:50:54 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 527914D17177;
        Tue, 19 Apr 2022 12:50:52 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 19 Apr 2022 12:50:53 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 19 Apr 2022 12:50:50 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v13 7/7] fsdax: set a CoW flag when associate reflink mappings
Date:   Tue, 19 Apr 2022 12:50:45 +0800
Message-ID: <20220419045045.1664996-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 527914D17177.AE269
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a PAGE_MAPPING_DAX_COW flag to support association with CoW file
mappings.  In this case, since the dax-rmap has already took the
responsibility to look up for shared files by given dax page,
the page->mapping is no longer to used for rmap but for marking that
this dax page is shared.  And to make sure disassociation works fine, we
use page->index as refcount, and clear page->mapping to the initial
state when page->index is decreased to 0.

With the help of this new flag, it is able to distinguish normal case
and CoW case, and keep the warning in normal case.

==
PS: The @cow added for dax_associate_entry(), is used to let it know
whether the entry is to be shared during iomap operation.  It is decided
by iomap,srcmap's flag, and will be used in another patchset(
fsdax,xfs: Add reflink&dedupe support for fsdax[1]).

In this patch, we set @cow always false for now.

[1] https://lore.kernel.org/linux-xfs/20210928062311.4012070-1-ruansy.fnst@fujitsu.com/
==

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c                   | 50 +++++++++++++++++++++++++++++++-------
 include/linux/page-flags.h |  6 +++++
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 57efd3f73655..4d3dfc8bee33 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -334,13 +334,35 @@ static unsigned long dax_end_pfn(void *entry)
 	for (pfn = dax_to_pfn(entry); \
 			pfn < dax_end_pfn(entry); pfn++)
 
+static inline bool dax_mapping_is_cow(struct address_space *mapping)
+{
+	return (unsigned long)mapping == PAGE_MAPPING_DAX_COW;
+}
+
 /*
- * TODO: for reflink+dax we need a way to associate a single page with
- * multiple address_space instances at different linear_page_index()
- * offsets.
+ * Set the page->mapping with FS_DAX_MAPPING_COW flag, increase the refcount.
+ */
+static inline void dax_mapping_set_cow(struct page *page)
+{
+	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_COW) {
+		/*
+		 * Reset the index if the page was already mapped
+		 * regularly before.
+		 */
+		if (page->mapping)
+			page->index = 1;
+		page->mapping = (void *)PAGE_MAPPING_DAX_COW;
+	}
+	page->index++;
+}
+
+/*
+ * When it is called in dax_insert_entry(), the cow flag will indicate that
+ * whether this entry is shared by multiple files.  If so, set the page->mapping
+ * FS_DAX_MAPPING_COW, and use page->index as refcount.
  */
 static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address)
+		struct vm_area_struct *vma, unsigned long address, bool cow)
 {
 	unsigned long size = dax_entry_size(entry), pfn, index;
 	int i = 0;
@@ -352,9 +374,13 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		WARN_ON_ONCE(page->mapping);
-		page->mapping = mapping;
-		page->index = index + i++;
+		if (cow) {
+			dax_mapping_set_cow(page);
+		} else {
+			WARN_ON_ONCE(page->mapping);
+			page->mapping = mapping;
+			page->index = index + i++;
+		}
 	}
 }
 
@@ -370,7 +396,12 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		struct page *page = pfn_to_page(pfn);
 
 		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
+		if (dax_mapping_is_cow(page->mapping)) {
+			/* keep the CoW flag if this page is still shared */
+			if (page->index-- > 0)
+				continue;
+		} else
+			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
 		page->mapping = NULL;
 		page->index = 0;
 	}
@@ -829,7 +860,8 @@ static void *dax_insert_entry(struct xa_state *xas,
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
+		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
+				false);
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d725a2d17806..5b601e375773 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -650,6 +650,12 @@ __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
 #define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 #define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 
+/*
+ * Different with flags above, this flag is used only for fsdax mode.  It
+ * indicates that this page->mapping is now under reflink case.
+ */
+#define PAGE_MAPPING_DAX_COW	0x1
+
 static __always_inline int PageMappingFlags(struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
-- 
2.35.1



