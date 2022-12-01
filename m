Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9792C63F3D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 16:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiLAP3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 10:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiLAP3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:29:22 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8091AA95AF;
        Thu,  1 Dec 2022 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669908559; i=@fujitsu.com;
        bh=sW0O04zZ8nMkiVbvumEcLtFp7gSnPMgrurjjHklR19o=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=nhMHVvm1Is+yywEXkcKGUP2GAd0j9IfkD1XyfNCkEtt1RlV46cNOp6XqfPg7NdhpV
         Xnco3EAj0zszQV7wkL89XCMWoy6nqTyK5p5J6IqdG513CiQZWmomT+j2ILWwpicbjx
         8n3qP7B+1RrZ/wGJwuCoUwbdho1Rnh6YJs1ayHjxWsujVqCUIBRzbfACnTCEk0e5U9
         xV6ngwaYFok0xgUcz4jNFVVxQMJd2SNdWPStO4hFa+5ihApkXmee3vm59VEw/+Cd6r
         OVP7lxj4PB/pkIuFkbMz2bwDd7YVQL9Ng2qjKYfa27V8LM9n7xPy8jOlXUUCplzKVb
         VvgfJHhhs5HvQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRWlGSWpSXmKPExsViZ8ORpOt/oiP
  Z4Mwdbos569ewWUyfeoHRYsuxe4wWl5/wWezZe5LF4vKuOWwWu/7sYLdY+eMPqwOHx6lFEh6L
  97xk8ti0qpPN48SM3yweLzbPZPT4vEkugC2KNTMvKb8igTXjwEedgt3KFRvbFzI1MO6R7WLk4
  hAS2MgoMeVLOwuEs4RJYuajU6wQzh5GiW8rjgFlODnYBHQkLiz4C5Tg4BARqJa4tZQNJMwskC
  Fx/MofZhBbWMBP4ta6C2DlLAIqEu8P97CD2LwCLhLdj2aA1UsIKEhMefgerJ5TwFXi5d+NYDV
  CQDXXmw8yQ9QLSpyc+YQFYr6ExMEXL5hB1koIKEnM7I6HGFMhMWtWGxOErSZx9dwm5gmMgrOQ
  dM9C0r2AkWkVo1lxalFZapGukYFeUlFmekZJbmJmjl5ilW6iXmqpbnlqcYmuoV5iebFeanGxX
  nFlbnJOil5easkmRmCspBQzTtnB2LPsj94hRkkOJiVRXu19HclCfEn5KZUZicUZ8UWlOanFhx
  hlODiUJHhT9gDlBItS01Mr0jJzgHELk5bg4FES4eU7BpTmLS5IzC3OTIdInWJUlBLnvQiSEAB
  JZJTmwbXBUsUlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK827YBTeHJzCuBm/4KaDET0OJI
  sTaQxSWJCCmpBibTy0detRiIdCxQ6pvk+IntYOmPk/wXFug/ubNsb8X+aOesKZe3rmTYp6vpV
  ilteytrK0fOQ/kWv4yfjiUvM93efMvxkzmpzf3fbbZd/9wtX9S+fvwnvrPvvdaq6082mxaePL
  72dKEAc/32D6oxmlqepTIf1jTa3U440jd55m6H5qPh0bOVfzSuObbMUWjGN5MXl2a8Nf2/5qp
  Iyp24YjXOBpYVbYd8dFJ09+oZXe42M9RdJ37FdWrsDqsTHf6z9LpnzYt7sPYLD9+KLWkvxHL/
  sYQnbToT/bHNc88P+0UTUirrjY7lS3VaTkpJ6WvcKpPqFnhj9aGZUYd+bFm58uTVxxuqGg80b
  NV69cxAQbtHiaU4I9FQi7moOBEAIg/U2JADAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-9.tower-585.messagelabs.com!1669908558!94255!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29783 invoked from network); 1 Dec 2022 15:29:19 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-9.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 15:29:19 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id AB80F1B6;
        Thu,  1 Dec 2022 15:29:18 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 9FFF31B5;
        Thu,  1 Dec 2022 15:29:18 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 15:29:15 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: [PATCH v2 1/8] fsdax: introduce page->share for fsdax in reflink mode
Date:   Thu, 1 Dec 2022 15:28:51 +0000
Message-ID: <1669908538-55-2-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
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
index 1c6867810cbd..85b81963ea31 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -334,35 +334,41 @@ static unsigned long dax_end_pfn(void *entry)
 	for (pfn = dax_to_pfn(entry); \
 			pfn < dax_end_pfn(entry); pfn++)
 
-static inline bool dax_mapping_is_cow(struct address_space *mapping)
+static inline bool dax_mapping_is_shared(struct page *page)
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
+static inline void dax_mapping_set_shared(struct page *page)
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
+static inline unsigned long dax_mapping_decrease_shared(struct page *page)
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
+			dax_mapping_set_shared(page);
 		} else {
 			WARN_ON_ONCE(page->mapping);
 			page->mapping = mapping;
@@ -396,9 +402,9 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		struct page *page = pfn_to_page(pfn);
 
 		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		if (dax_mapping_is_cow(page->mapping)) {
-			/* keep the CoW flag if this page is still shared */
-			if (page->index-- > 0)
+		if (dax_mapping_is_shared(page)) {
+			/* keep the shared flag if this page is still shared */
+			if (dax_mapping_decrease_shared(page) > 0)
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

