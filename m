Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645094C5AF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 13:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiB0MI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 07:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiB0MIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:08:51 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E598528E00;
        Sun, 27 Feb 2022 04:08:00 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3A4j2jDauzODUaO+FBMuImfPNe+OfnVD1fMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3y2ZJDGjSP62MZmfyet4nbNu+805Q65DdzNRqSgc4qiBgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuCmULS?=
 =?us-ascii?q?cY3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm65bLlBKYIiGEL/JGSRte0Zcj0up+H2B?=
 =?us-ascii?q?C3fICLzUKdBqCm6S9x7fTYulnhuwiKsfxNY8Ss30myivWZd4qSJaFQePV5Ntc3?=
 =?us-ascii?q?T41nehPG+rTY4wSbj8HRBjCfBpJNX8UBYg4kePugWPwGxVcqVSIte8y5kDQ0gV?=
 =?us-ascii?q?60/7qKtW9UtqUScRQm26cp3na5CL9AxcHJJqTxCTt2nClgOKJliPmcIUIHba8+?=
 =?us-ascii?q?7hhh1j77mgSDgAGEFWgrfSnh0qWRd1SMQoX9zAooKx081akJvH5XhulsDuHswQ?=
 =?us-ascii?q?aVt54DeI38keOx7DS7gLfAXILJhZFado7pIomSycCyFCEhZXqCCZpvbnTTmiSn?=
 =?us-ascii?q?op4Bxva1TM9dDdEPHFbC1BepYSLnW36tTqXJv4LLUJ/poCd9enM/g23?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Afuy85KxFnFvUUnyZOe4MKrPxAeskLtp133Aq?=
 =?us-ascii?q?2lEZdPULSKGlfpGV9sjziyWetN9wYh4dcLG7Sc29qBbnmaKdjrNhWItKMDOW2l?=
 =?us-ascii?q?dAT7sSlbcKoQeQYhEWn9Q1vckAT0EXMqyXMbEQt6bHCWeDYrUdKI7tytHOuQ6S?=
 =?us-ascii?q?9QYccShaL4VbqytpAAeSFUN7ACFAGJoCDZKZou5KvSCpd3g7ZtmyQiBtZZmwm/?=
 =?us-ascii?q?T70LbdJTIWDR8u7weDyRuu9b7BChCdmjMTSSlGz7sO+XXM1yb5+qKgmfemzQK0?=
 =?us-ascii?q?7R6h071m3P/ajvdTDs2FjcYYbh/2jByzWYhnU7qe+BgoveCG8j8R4a/xiiZlG/?=
 =?us-ascii?q?42x2Laf2mzrxeo8RLnyiwS53jrzkLdqWf/oPb+WCkxB6N69PVkmyPimgIdVexH?=
 =?us-ascii?q?oel2NzrzjescMfqAplWI2zHwbWAiqqLuykBS3NL6jBRkIPQjgfFq3MAiFXhuYe?=
 =?us-ascii?q?099RLBmfsa+dZVfbzhDdZtAC2nhiPizxhSKOLFZAVOIv7BeDl2hvCo?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122037692"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Feb 2022 20:07:58 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 1CD814D169F3;
        Sun, 27 Feb 2022 20:07:54 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 27 Feb 2022 20:07:54 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 27 Feb 2022 20:07:55 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 27 Feb 2022 20:07:53 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v11 8/8] fsdax: set a CoW flag when associate reflink mappings
Date:   Sun, 27 Feb 2022 20:07:47 +0800
Message-ID: <20220227120747.711169-9-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1CD814D169F3.A15FC
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
 fs/dax.c                   | 65 ++++++++++++++++++++++++++++++++------
 include/linux/page-flags.h |  6 ++++
 2 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index f164cf64c611..b97106a0a0b1 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -334,13 +334,46 @@ static unsigned long dax_end_pfn(void *entry)
 	for (pfn = dax_to_pfn(entry); \
 			pfn < dax_end_pfn(entry); pfn++)
 
+static inline void dax_mapping_set_cow_flag(struct address_space *mapping)
+{
+	mapping = (struct address_space *)PAGE_MAPPING_DAX_COW;
+}
+
+static inline bool dax_mapping_is_cow(struct address_space *mapping)
+{
+	return (unsigned long)mapping == PAGE_MAPPING_DAX_COW;
+}
+
 /*
- * TODO: for reflink+dax we need a way to associate a single page with
- * multiple address_space instances at different linear_page_index()
- * offsets.
+ * Set or Update the page->mapping with FS_DAX_MAPPING_COW flag.
+ * Return true if it is an Update.
+ */
+static inline bool dax_mapping_set_cow(struct page *page)
+{
+	if (page->mapping) {
+		/* flag already set */
+		if (dax_mapping_is_cow(page->mapping))
+			return false;
+
+		/*
+		 * This page has been mapped even before it is shared, just
+		 * need to set this FS_DAX_MAPPING_COW flag.
+		 */
+		dax_mapping_set_cow_flag(page->mapping);
+		return true;
+	}
+	/* Newly associate CoW mapping */
+	dax_mapping_set_cow_flag(page->mapping);
+	return false;
+}
+
+/*
+ * When it is called in dax_insert_entry(), the cow flag will indicate that
+ * whether this entry is shared by multiple files.  If so, set the page->mapping
+ * to be FS_DAX_MAPPING_COW, and use page->index as refcount.
  */
 static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address)
+		struct vm_area_struct *vma, unsigned long address, bool cow)
 {
 	unsigned long size = dax_entry_size(entry), pfn, index;
 	int i = 0;
@@ -352,9 +385,17 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		WARN_ON_ONCE(page->mapping);
-		page->mapping = mapping;
-		page->index = index + i++;
+		if (cow) {
+			if (dax_mapping_set_cow(page)) {
+				/* Was normal, now updated to CoW */
+				page->index = 2;
+			} else
+				page->index++;
+		} else {
+			WARN_ON_ONCE(page->mapping);
+			page->mapping = mapping;
+			page->index = index + i++;
+		}
 	}
 }
 
@@ -370,7 +411,12 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		struct page *page = pfn_to_page(pfn);
 
 		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
+		if (!dax_mapping_is_cow(page->mapping)) {
+			/* keep the CoW flag if this page is still shared */
+			if (page->index-- > 0)
+				continue;
+		} else
+			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
 		page->mapping = NULL;
 		page->index = 0;
 	}
@@ -829,7 +875,8 @@ static void *dax_insert_entry(struct xa_state *xas,
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
+		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
+				false);
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c3b6e5c8bfd..6370d279795a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -572,6 +572,12 @@ __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
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



