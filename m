Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093BD53C479
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 07:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbiFCFiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 01:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240957AbiFCFh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:37:56 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 299A436E00;
        Thu,  2 Jun 2022 22:37:53 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AlL3LF6LAtSJBh8vRFE+RUJQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC6gmhz0mcDxjEcCm3VO6rZZjb0fd4gaISw8U0CusfXz4NqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkj/nRHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToy+UltZq2ZNDs4esY?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQcpOGXfyjn4aR/yGWDKRMA2c5GAEgoPIEw9PxwBGZ?=
 =?us-ascii?q?U//0EbjsKa3irg+OwxbOyTelhrsQ+JdbmPcUUvXQI5THSDd4nR57ZSqnH7NMe2?=
 =?us-ascii?q?y0/7uhRHPLaduIYbzR1ZRjNahEJPU0YYLoyleHuhD/gcjlcqVuQvoI25XTeyEp?=
 =?us-ascii?q?6172FGNbXZduMSu1Wk1yeq2aA+H72ajkeNdqC2X+A91qvmObEnmX8Qo16PLS77?=
 =?us-ascii?q?vtChFyV23xWBhoLU1eyvfi+jAi5Qd03A0oK9isrqIA29Ve3VZ/5XhulsDiIswB?=
 =?us-ascii?q?0c9pbE8U+8x3Lxqe8ywCQAXkNCD5Gct0pqcQ2RBQs21TPlNTsbRRtubuYD3md6?=
 =?us-ascii?q?5+Ttzq5PSVTJmgHDQceQgwB78bypqkokwnCCNpueIaxj9voCXT+2DyHsiU6r6s?=
 =?us-ascii?q?cgNRN1Kih+13DxTW2qfDhSg8z+xWSXW+/6A59TJCqapbu6lXB6/tEaoGDQTGpu?=
 =?us-ascii?q?HkChtjb/O4VJY+CmTbLQ+gXGrytofGfP1X0n191GLEz+jKs5TinfIZN8Hd5Pkg?=
 =?us-ascii?q?vL8VsRNNDSCc/oisIvNkKYiTsNvQxPuqM5w0R5fCIPbzYujr8N7KiuqRMSTI?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AEKLKZa1k3lNUWa/c9zVaBQqjBFQkLtp133Aq?=
 =?us-ascii?q?2lEZdPRUGvb4qynIpoVj6faUskdoZJhOo6HiBEDtexzhHNtOkO0s1NSZLW/bUQ?=
 =?us-ascii?q?mTXeNfBOLZqlWKcUCTygce79YGT0EUMr3N5DZB4/oSmDPIdurI3uP3jJyAtKPP?=
 =?us-ascii?q?yWt3VwF2Z+VF5wd9MAySFUp7X2B9dOAEPavZ9sxavCChZHhSSsy6A0MOV+/Fq8?=
 =?us-ascii?q?aOu4nhZXc9dmMawTjLnTW186T7DhTd+h8fVglEybAk/XOAsyGR3NTZj82G?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124686808"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jun 2022 13:37:51 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 0D5D84D17199;
        Fri,  3 Jun 2022 13:37:47 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 13:37:47 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 13:37:47 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 3 Jun 2022 13:37:46 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>,
        <akpm@linux-foundation.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 07/14] fsdax: set a CoW flag when associate reflink mappings
Date:   Fri, 3 Jun 2022 13:37:31 +0800
Message-ID: <20220603053738.1218681-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0D5D84D17199.A4D5C
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

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c                   | 50 +++++++++++++++++++++++++++++++-------
 include/linux/page-flags.h |  6 +++++
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 65e44d78b3bb..b59b864017ad 100644
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
@@ -830,7 +861,8 @@ static void *dax_insert_entry(struct xa_state *xas,
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
+		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
+				false);
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e66f7aa3191d..a5263a21b72f 100644
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
 static __always_inline bool folio_mapping_flags(struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
-- 
2.36.1



