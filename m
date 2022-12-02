Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AAB64033A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 10:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiLBJYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 04:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiLBJYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:24:22 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36E1BD8BD;
        Fri,  2 Dec 2022 01:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669973008; i=@fujitsu.com;
        bh=MH3WZcJVYCwNNo6ke4z/7i9M7MvmuAOO+p63FGtt8bE=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=fpIcmHabA79RXZZi6H0iB8hyyLZpXHKPhEuGhz8J1l5ki4fA1P8D3ppjPRW+KBeEh
         BaGK8w6CxjVKqMmNcQc47bdXXca+XWx2/SO6S6qvB3xstFCSqZ49hCjt2sNXcetx3o
         uF1vQuWYJsLQRyk9vuOhhbSyxb2r9C9SzIh4lolboQuAfvYkOsa+2PcziK4OTsKce1
         elY6f1W9fUscdb0gxuytL3s9CkDKW+wQgexFZiujoiBnzKv3iLrZxPABZx/xjkrWVC
         9kCTTsDqd7wGmg1gkKYJqdG/SWHbkvt6uRc6ao1x8x+bLOIJukkgM9ATa78EbTw9lH
         nO/Vf44Ejwesg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRWlGSWpSXmKPExsViZ8MxSZf/SGe
  ywf+VQhZz1q9hs5g+9QKjxZZj9xgtLj/hs9iz9ySLxeVdc9gsdv3ZwW6x8scfVgcOj1OLJDwW
  73nJ5LFpVSebx4kZv1k8XmyeyejxeZNcAFsUa2ZeUn5FAmvGuV1H2QuWK1d82WLXwLhCtouRi
  0NIYAujxJrvn1khnOVMEuuOrWeGcPYwSlx8epOti5GTg01AR+LCgr9AVRwcIgLVEreWgoWZBT
  Ikjl/5wwxiCwsESPx8MYcJxGYRUJFomPINrIZXwFVi1d17rCC2hICCxJSH78HqOYHiBx49ZAS
  xhQRcJL69nccKUS8ocXLmExaI+RISB1+8YAZZKyGgJDGzOx5iTIXErFltTBC2msTVc5uYJzAK
  zkLSPQtJ9wJGplWMZsWpRWWpRbqGFnpJRZnpGSW5iZk5eolVuol6qaW65anFJbpGeonlxXqpx
  cV6xZW5yTkpenmpJZsYgbGSUqx+cgfjhmV/9A4xSnIwKYnyvlrWmSzEl5SfUpmRWJwRX1Sak1
  p8iFGGg0NJgpf1AFBOsCg1PbUiLTMHGLcwaQkOHiUR3vd7gdK8xQWJucWZ6RCpU4yKUuK8uw4
  BJQRAEhmleXBtsFRxiVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iwb/U+oCk8mXklcNNfAS1m
  AlocKdYGsrgkESEl1cDkfLycXSV36WLB+UskLrabi2d86HF0We0jpxOXmup5zv95+tXFnUvm6
  FzZFb0hdqKy9CWGozWPLQxPcHO7vmBbd/BZ/s4LD2fn2Tg0LOA0u7ziSeLSoq5738771W6RrT
  mqbqaq6aH3+dySVbIT1GwlvTwNL+7XC6sIXLv1RJrbl6MiG24/PnvgUNjVdO31bxX2dO1T1+A
  w4m1o+G7hcGZqxYXueb7t0myhpvVCavKBdsdn6AstFPo2ZcX6rfOvpnNPnbj9+ApHho1r1Tft
  D03tYCwrYGZqfaF5TLbx7ZeAd8fVbmVHLN3Q1BmjcEDQo9GwySqDvSyuq51H7YHtHn+tIle72
  v+NISeVjnBc/KTEUpyRaKjFXFScCADwne0JkAMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-10.tower-548.messagelabs.com!1669973007!186501!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14904 invoked from network); 2 Dec 2022 09:23:27 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-10.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Dec 2022 09:23:27 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id EA6DE1000E7;
        Fri,  2 Dec 2022 09:23:26 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id E76E11000DB;
        Fri,  2 Dec 2022 09:23:26 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 2 Dec 2022 09:23:23 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: [PATCH v2.1 1/8] fsdax: introduce page->share for fsdax in reflink mode
Date:   Fri, 2 Dec 2022 09:23:11 +0000
Message-ID: <1669972991-246-1-git-send-email-ruansy.fnst@fujitsu.com>
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
---
 fs/dax.c                   | 38 ++++++++++++++++++++++----------------
 include/linux/mm_types.h   |  5 ++++-
 include/linux/page-flags.h |  2 +-
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1c6867810cbd..edbacb273ab5 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -334,35 +334,41 @@ static unsigned long dax_end_pfn(void *entry)
 	for (pfn = dax_to_pfn(entry); \
 			pfn < dax_end_pfn(entry); pfn++)
 
-static inline bool dax_mapping_is_cow(struct address_space *mapping)
+static inline bool dax_page_is_shared(struct page *page)
 {
-	return (unsigned long)mapping == PAGE_MAPPING_DAX_COW;
+	return (unsigned long)page->mapping == PAGE_MAPPING_DAX_SHARED;
 }
 
 /*
- * Set the page->mapping with FS_DAX_MAPPING_COW flag, increase the refcount.
+ * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
+ * refcount.
  */
-static inline void dax_mapping_set_cow(struct page *page)
+static inline void dax_page_bump_sharing(struct page *page)
 {
-	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_COW) {
+	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_SHARED) {
 		/*
 		 * Reset the index if the page was already mapped
 		 * regularly before.
 		 */
 		if (page->mapping)
-			page->index = 1;
-		page->mapping = (void *)PAGE_MAPPING_DAX_COW;
+			page->share = 1;
+		page->mapping = (void *)PAGE_MAPPING_DAX_SHARED;
 	}
-	page->index++;
+	page->share++;
+}
+
+static inline unsigned long dax_page_drop_sharing(struct page *page)
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
+			dax_page_bump_sharing(page);
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
+			if (dax_page_drop_sharing(page) > 0)
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
index 0b0ae5084e60..c8a3aa02278d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -641,7 +641,7 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * Different with flags above, this flag is used only for fsdax mode.  It
  * indicates that this page->mapping is now under reflink case.
  */
-#define PAGE_MAPPING_DAX_COW	0x1
+#define PAGE_MAPPING_DAX_SHARED	0x1
 
 static __always_inline bool folio_mapping_flags(struct folio *folio)
 {
-- 
2.38.1

