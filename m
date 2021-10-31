Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC6440F11
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 16:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhJaPXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 11:23:48 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24386 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230289AbhJaPXj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 11:23:39 -0400
IronPort-Data: =?us-ascii?q?A9a23=3ASa9wSaMimnIC6LzvrR3OlsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQXs0jl0gmNUxjcYCm7Tbv7fNmf8f95wPYm080hSvpTWm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHiC0SiuFaOC79CAkjvjQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/kSiAmctgjttLroCYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPQYpuCYcCng2SCU5wicG5f2+N1iBV83MaUW4OFyBnt?=
 =?us-ascii?q?E9OBeIzcIBjiDjOKewbS1UOBgi80vas7xM+s3tnhmizOfEvciRZHKRr7i5NlE0?=
 =?us-ascii?q?TN2jcdLdd7SZdUebzVHbxnaZRBLfFANB/oWmOaum2m6djhwq0ycrqlx5HLcpCR?=
 =?us-ascii?q?3zrTsNd/9ft2RWd4Tmkeeu3KA82nnajkYPdqSjzGF71qrnObEmS69U4UXfJW89?=
 =?us-ascii?q?/h3kBid3WAeFhASfUW0rOP/iUOkXd9bbUsO9UIGqak06VzuTdTnWRC8iGCLswR?=
 =?us-ascii?q?aWNdKFeA+rgaXxcL85wefG3hBXjBaQMIpudVwRjEw0FKN2dTzClRSXBe9IZ6G3?=
 =?us-ascii?q?u7M62rsZm5OdilfDRLohDAtu7HLyLzfRDqTJjq7LJOIsw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AhuPtTaB/8w0KpF7lHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,197,1631548800"; 
   d="scan'208";a="116677997"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Oct 2021 23:21:05 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 786B54D0F90E;
        Sun, 31 Oct 2021 23:21:00 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 31 Oct 2021 23:21:01 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 31 Oct 2021 23:20:57 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 31 Oct 2021 23:20:54 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v8 5/8] fsdax: Introduce dax_lock_mapping_entry()
Date:   Sun, 31 Oct 2021 23:20:25 +0800
Message-ID: <20211031152028.3724121-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
References: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 786B54D0F90E.A2C9E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current dax_lock_page() locks dax entry by obtaining mapping and
index in page.  To support 1-to-N RMAP in NVDIMM, we need a new function
to lock a specific dax entry corresponding to this file's mapping,index.
And BTW, output the page corresponding to the specific dax entry for
caller use.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c            | 65 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/dax.h | 15 +++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index a06cbb950950..59e02c9f169c 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -390,7 +390,7 @@ static struct page *dax_busy_page(void *entry)
 }
 
 /*
- * dax_lock_mapping_entry - Lock the DAX entry corresponding to a page
+ * dax_lock_page - Lock the DAX entry corresponding to a page
  * @page: The page whose entry we want to lock
  *
  * Context: Process context.
@@ -455,6 +455,69 @@ void dax_unlock_page(struct page *page, dax_entry_t cookie)
 	dax_unlock_entry(&xas, (void *)cookie);
 }
 
+/*
+ * dax_lock_mapping_entry - Lock the DAX entry corresponding to a mapping
+ * @mapping: the file's mapping whose entry we want to lock
+ * @index: the offset within this file
+ * @page: output the dax page corresponding to this dax entry
+ *
+ * Return: A cookie to pass to dax_unlock_mapping_entry() or 0 if the entry
+ * could not be locked.
+ */
+dax_entry_t dax_lock_mapping_entry(struct address_space *mapping, pgoff_t index,
+		struct page **page)
+{
+	XA_STATE(xas, NULL, 0);
+	void *entry;
+
+	rcu_read_lock();
+	for (;;) {
+		entry = NULL;
+		if (!dax_mapping(mapping))
+			break;
+
+		xas.xa = &mapping->i_pages;
+		xas_lock_irq(&xas);
+		xas_set(&xas, index);
+		entry = xas_load(&xas);
+		if (dax_is_locked(entry)) {
+			rcu_read_unlock();
+			wait_entry_unlocked(&xas, entry);
+			rcu_read_lock();
+			continue;
+		}
+		if (!entry ||
+		    dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+			/*
+			 * Because we are looking for entry from file's mapping
+			 * and index, so the entry may not be inserted for now,
+			 * or even a zero/empty entry.  We don't think this is
+			 * an error case.  So, return a special value and do
+			 * not output @page.
+			 */
+			entry = (void *)~0UL;
+		} else {
+			*page = pfn_to_page(dax_to_pfn(entry));
+			dax_lock_entry(&xas, entry);
+		}
+		xas_unlock_irq(&xas);
+		break;
+	}
+	rcu_read_unlock();
+	return (dax_entry_t)entry;
+}
+
+void dax_unlock_mapping_entry(struct address_space *mapping, pgoff_t index,
+		dax_entry_t cookie)
+{
+	XA_STATE(xas, &mapping->i_pages, index);
+
+	if (cookie == ~0UL)
+		return;
+
+	dax_unlock_entry(&xas, (void *)cookie);
+}
+
 /*
  * Find page cache entry at given index. If it is a DAX entry, return it
  * with the entry locked. If the page cache doesn't contain an entry at
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 891c3e8a40e6..c78ca4f8285a 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -152,6 +152,10 @@ struct page *dax_layout_busy_page(struct address_space *mapping);
 struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
+dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
+		unsigned long index, struct page **page);
+void dax_unlock_mapping_entry(struct address_space *mapping,
+		unsigned long index, dax_entry_t cookie);
 #else
 #define generic_fsdax_supported		NULL
 
@@ -197,6 +201,17 @@ static inline dax_entry_t dax_lock_page(struct page *page)
 static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
 {
 }
+
+static inline dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
+		unsigned long index, struct page **page)
+{
+	return 0;
+}
+
+static inline void dax_unlock_mapping_entry(struct address_space *mapping,
+		unsigned long index, dax_entry_t cookie)
+{
+}
 #endif
 
 #if IS_ENABLED(CONFIG_DAX)
-- 
2.33.0



