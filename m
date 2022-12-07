Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F89645242
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Dec 2022 03:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiLGCuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 21:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLGCt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:49:57 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07688554C9;
        Tue,  6 Dec 2022 18:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1670381384; i=@fujitsu.com;
        bh=mOuHndKhs7VITUYdzmDB/hEoxNRPMMBCPL8oHfOLmE8=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=a/RfReDdkHHsilxbBTepweY0bNqPvjDVCT22FtGPepPDr73nYU9m7/erYsOpI5UHG
         EAY6zsR+745s7/bUNp2aBllOIgqWn/4bCIN1mRW4gBt/kW55y6zL5uYaG2FM+tn4iH
         5pHzxFb8z4GTEsKRJsHnnBrBrNzGC7GpbubBx/7sJB/nvEafdJTMr+eit60hJzmM9b
         F5EylDwySpLvVanL2+a+uYSJTod8Wdwf3HaJ/+C5rk+XUDjrfN6th9eJPp0aSywBtw
         OtfrO+SbXVijNNfuIkKNms0xVIsQJSrsjV23lYoYTYFGZHyAajFGYHczF8aIyWkP2N
         sfwWITpCqSctA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRWlGSWpSXmKPExsViZ8ORqOv+vz/
  ZYPknJos569ewWTS0tDFZTJ96gdFiy7F7jBaXn/BZ7Nl7ksXi8q45bBb31vxntdj1Zwe7xcof
  f1gduDxOLZLwWLznJZPHplWdbB6bPk1i9zgx4zeLx4vNMxk9Pj69xeLxeZNcAEcUa2ZeUn5FA
  mvGr12/2QoOKles/7CevYFxv2wXIxeHkMAWRolv2/vZIJzlTBIP/z2EcvYwSlw5eIqpi5GTg0
  1AR+LCgr+sIAkRgUmMEsdu3GQGcZgFOhgl2lpusoBUCQsESPzs6WIEsVkEVCRaz05jBbF5BVw
  k3p7awgZiSwgoSEx5+J4ZxOYUcJU48OghWL0QUM23t/Og6gUlTs58AjaTWUBC4uCLF0D1HEC9
  ShIzu+MhxlRIzJrVxgRhq0lcPbeJeQKj4Cwk3bOQdC9gZFrFaFqcWlSWWqRrppdUlJmeUZKbm
  Jmjl1ilm6iXWqpbnlpcomukl1herJdaXKxXXJmbnJOil5dasokRGFkpxUr3djBOW/ZH7xCjJA
  eTkijvi+r+ZCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvOv/AOUEi1LTUyvSMnOAUQ6TluDgURL
  hnfoFKM1bXJCYW5yZDpE6xWjJMXX2v/3MHMvB5MyvbQeYhVjy8vNSpcR5bf4CNQiANGSU5sGN
  gyWiS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeWP+AU3hycwrgdv6CuggJqCD7v3vBTmoJ
  BEhJdXAxL3p0xH7v7w7DRvSdJ0yo1Zny4Yv6Vq/eD3fGj3R9hOnXRjcbL6c424JL9kqvyzqbl
  EEv2zx08NLXc9PtXmhnlo0dc05SYXr/bxflJuqLj3qV9tnW/roRejdJq0nW3/91HqmxBOctut
  F+V6/kIIwXtWj6wKuzRXzUSo0Op5xdM4Ko7TW3Necm/IyvLrYNPf42U/MtTjB8K0u0d0lsq0t
  3tv9aOWc7qhLeXf+HDOITj44x0metVHqxJENDB/Eew95H5Y38Ql5ePTMzRWJPP0X165bULxl/
  13Z71qvHjBHr/d9ZXDy/zIeruiwoxMv/fbadcfetnp9kNL1bnlDj/f39L4sdBX+rrDLRVOk4H
  GrEktxRqKhFnNRcSIABxgbIr8DAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-9.tower-548.messagelabs.com!1670381382!3496!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32114 invoked from network); 7 Dec 2022 02:49:43 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-9.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Dec 2022 02:49:43 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id AC980100192;
        Wed,  7 Dec 2022 02:49:42 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id A0329100188;
        Wed,  7 Dec 2022 02:49:42 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 7 Dec 2022 02:49:38 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <akpm@linux-foundation.org>,
        <allison.henderson@oracle.com>
Subject: [PATCH v2.2 1/8] fsdax: introduce page->share for fsdax in reflink mode
Date:   Wed, 7 Dec 2022 02:49:19 +0000
Message-ID: <1670381359-53-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669908538-55-2-git-send-email-ruansy.fnst@fujitsu.com>
References: <1669908538-55-2-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsdax page is used not only when CoW, but also mapread. To make the it
easily understood, use 'share' to indicate that the dax page is shared
by more than one extent.  And add helper functions to use it.

Also, the flag needs to be renamed to PAGE_MAPPING_DAX_SHARED.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
---
 fs/dax.c                   | 38 ++++++++++++++++++++++----------------
 include/linux/mm_types.h   |  5 ++++-
 include/linux/page-flags.h |  2 +-
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1c6867810cbd..84fadea08705 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -334,35 +334,41 @@ static unsigned long dax_end_pfn(void *entry)
 	for (pfn = dax_to_pfn(entry); \
 			pfn < dax_end_pfn(entry); pfn++)
 
-static inline bool dax_mapping_is_cow(struct address_space *mapping)
+static inline bool dax_page_is_shared(struct page *page)
 {
-	return (unsigned long)mapping == PAGE_MAPPING_DAX_COW;
+	return page->mapping == PAGE_MAPPING_DAX_SHARED;
 }
 
 /*
- * Set the page->mapping with FS_DAX_MAPPING_COW flag, increase the refcount.
+ * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
+ * refcount.
  */
-static inline void dax_mapping_set_cow(struct page *page)
+static inline void dax_page_share_get(struct page *page)
 {
-	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_COW) {
+	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
 		/*
 		 * Reset the index if the page was already mapped
 		 * regularly before.
 		 */
 		if (page->mapping)
-			page->index = 1;
-		page->mapping = (void *)PAGE_MAPPING_DAX_COW;
+			page->share = 1;
+		page->mapping = PAGE_MAPPING_DAX_SHARED;
 	}
-	page->index++;
+	page->share++;
+}
+
+static inline unsigned long dax_page_share_put(struct page *page)
+{
+	return --page->share;
 }
 
 /*
- * When it is called in dax_insert_entry(), the cow flag will indicate that
+ * When it is called in dax_insert_entry(), the shared flag will indicate that
  * whether this entry is shared by multiple files.  If so, set the page->mapping
- * FS_DAX_MAPPING_COW, and use page->index as refcount.
+ * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
  */
 static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address, bool cow)
+		struct vm_area_struct *vma, unsigned long address, bool shared)
 {
 	unsigned long size = dax_entry_size(entry), pfn, index;
 	int i = 0;
@@ -374,8 +380,8 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		if (cow) {
-			dax_mapping_set_cow(page);
+		if (shared) {
+			dax_page_share_get(page);
 		} else {
 			WARN_ON_ONCE(page->mapping);
 			page->mapping = mapping;
@@ -396,9 +402,9 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		struct page *page = pfn_to_page(pfn);
 
 		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		if (dax_mapping_is_cow(page->mapping)) {
-			/* keep the CoW flag if this page is still shared */
-			if (page->index-- > 0)
+		if (dax_page_is_shared(page)) {
+			/* keep the shared flag if this page is still shared */
+			if (dax_page_share_put(page) > 0)
 				continue;
 		} else
 			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..f46cac3657ad 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -103,7 +103,10 @@ struct page {
 			};
 			/* See page-flags.h for PAGE_MAPPING_FLAGS */
 			struct address_space *mapping;
-			pgoff_t index;		/* Our offset within mapping. */
+			union {
+				pgoff_t index;		/* Our offset within mapping. */
+				unsigned long share;	/* share count for fsdax */
+			};
 			/**
 			 * @private: Mapping-private opaque data.
 			 * Usually used for buffer_heads if PagePrivate.
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0b0ae5084e60..d8e94f2f704a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -641,7 +641,7 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * Different with flags above, this flag is used only for fsdax mode.  It
  * indicates that this page->mapping is now under reflink case.
  */
-#define PAGE_MAPPING_DAX_COW	0x1
+#define PAGE_MAPPING_DAX_SHARED	((void *)0x1)
 
 static __always_inline bool folio_mapping_flags(struct folio *folio)
 {
-- 
2.38.1

