Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4B249E28E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 13:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbiA0MlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 07:41:24 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35621 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241269AbiA0MlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:41:13 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AGu77Sq1qpoBzEfTk4vbD5bhwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ1TtwgTQCnDMYWzzXOK6OZWCmf9ogOorl9RsAupGBy9c2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfjSGeKlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfoueWeCPl75P7I0ruNiGEL+9VJE0/I4wU0uhtBmR?=
 =?us-ascii?q?J7/YZNHYGaRXrr+K9wJq6TOd2j8guJcWtO5kQ0llsxDefD7A5QJTHQqzP/vdZ2?=
 =?us-ascii?q?is9goZFGvO2T8Ybdj1pYzzDbgdJN1NRD4gx9M+sh3/iY3hdrXqWu6M84C7U1gM?=
 =?us-ascii?q?Z+L7zPNvQf/SORN5JhQCcp2Tb7yL1Dw9yHN6WzzfD+XKxrujVlCj/VcQZE7jQ3?=
 =?us-ascii?q?vprhkCDg2IIBBAIWF+Tv/a0kAi9VshZJkhS/TAhxYA29Uq2Xpz+Uge+rXqsoBE?=
 =?us-ascii?q?RQZxTHvc85QXLzbDbiy6dB24ZXntRZscOqsA7X3op20WPktevAiZg2IB541r1G?=
 =?us-ascii?q?qy89Gv0YHZKazRZI3JscOfM2PG7yKlbs/4FZowL/HaJs+DI?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AXDcdwq9o3AciuZzctHtuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,320,1635177600"; 
   d="scan'208";a="120913267"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Jan 2022 20:41:07 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1958D4D169CC;
        Thu, 27 Jan 2022 20:41:06 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 27 Jan 2022 20:41:06 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 27 Jan 2022 20:41:06 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 27 Jan 2022 20:41:03 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v10 9/9] fsdax: set a CoW flag when associate reflink mappings
Date:   Thu, 27 Jan 2022 20:40:58 +0800
Message-ID: <20220127124058.1172422-10-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1958D4D169CC.A120D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a PAGE_MAPPING_DAX_COW flag to support association with CoW file
mappings.  In this case, the dax-RMAP already takes the responsibility
to look up for shared files by given dax page.  The page->mapping is no
longer to used for rmap but for marking that this dax page is shared.
And to make sure disassociation works fine, we use page->index as
refcount, and clear page->mapping to the initial state when page->index
is decreased to 0.

With the help of this new flag, it is able to distinguish normal case
and CoW case, and keep the warning in normal case.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c                   | 65 ++++++++++++++++++++++++++++++++------
 include/linux/page-flags.h |  6 ++++
 2 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 250794a5b789..88879c579c1f 100644
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
@@ -810,7 +856,8 @@ static void *dax_insert_entry(struct xa_state *xas,
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
2.34.1



