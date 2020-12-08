Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A5B2D2207
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 05:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgLHEW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 23:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgLHEWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:22:25 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E727AC0611C5
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Dec 2020 20:21:13 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id j1so6323362pld.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 20:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3KuLT1Cn/hR9CSFlVwhhGNLVEez8vLOWizoZNvv9uxQ=;
        b=Vj4JJ+bRYX5Oj4q3X0L8Fh6Gls+2B/SXWUh4NrNW72Aqtu/BDQ3boPiqVkNwJDDs44
         IS3iz2hn5UDA/kWICAwIBPkt4krmzbzPFMuds4SgvUdlbQrGw5lcfKEIzVcwjOkdDpvf
         MB9rfJai8zIHC6WAzQqjJkCfaHNqZ+5uZENHhIpzcRNXNz/jr43WQzYkJ/SWQmdywRja
         BZ0ty40DqI2t0ZHO1DDDbT0H6eJOJ/rngA3c0K6mew7YyX6o+71G5ojMNfh7mY9TZaWW
         v6P3wbNlykFS+3tfjxMhGQCfsJBYhy4PDAg3pKBNPZXNazNDcahRsjjIQZeEZNzkfuht
         l2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3KuLT1Cn/hR9CSFlVwhhGNLVEez8vLOWizoZNvv9uxQ=;
        b=tvAIL8mYJtSrblNk+yjSAplND9kk/feGmd7QEUHRebpS0uhxGDTwj8BsjUUWhOJyX/
         /mGU1Dedk+2/zZmMQn1HKxHZ9ubKCwxuh3ERcKbEIISX08nWrdsFYQ0QN2vvdJ0xj0VK
         kay3jE2PNFY0hUxJJw3X5AEgK3Fjr9zslkt303/gW/MtveU3AXgghqnGZ+ar50tPSGNt
         7io4ykQlzACr7HlI4zRMAkL/8ls+8EeVFyV2PPdYxKQlGpbkCti8+n9vyTzGk4COWJq/
         bzbpjeexDSCzi1CMnGuZboJBF5RJO3ETvCWhdlfLlYoDpGmSWvaiA/NogkzDATUawdyk
         bllg==
X-Gm-Message-State: AOAM530rJ0OidGO0fG0LtCzT2r+z64WjriUN2GyWOpyAeyi8sRlPzZcy
        RE9B3uwsdyEs7Zhrad7C1v3F3g==
X-Google-Smtp-Source: ABdhPJwnxAh1QoB4VoC3+au0FbztqWHIniEtcuRmqnWoI3WNUPiQuqySX8qVI42PTtXkXaCGg8QztA==
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id 97-20020a170902026ab02900daaf4777c7mr19699178plc.10.1607401273486;
        Mon, 07 Dec 2020 20:21:13 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id mr7sm1031166pjb.31.2020.12.07.20.21.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:21:12 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 3/7] mm: memcontrol: convert NR_FILE_THPS account to pages
Date:   Tue,  8 Dec 2020 12:18:43 +0800
Message-Id: <20201208041847.72122-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201208041847.72122-1-songmuchun@bytedance.com>
References: <20201208041847.72122-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The unit of NR_FILE_THPS is HPAGE_PMD_NR. Converrt NR_FILE_THPS
account to pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c | 3 +--
 fs/proc/meminfo.c   | 2 +-
 mm/filemap.c        | 2 +-
 mm/huge_memory.c    | 3 ++-
 mm/khugepaged.c     | 2 +-
 mm/memcontrol.c     | 5 ++---
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index ec35cb567940..0f752d0fce6f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -466,8 +466,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 				    HPAGE_PMD_NR),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
 				    HPAGE_PMD_NR),
-			     nid, K(node_page_state(pgdat, NR_FILE_THPS) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
 			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
 				    HPAGE_PMD_NR)
 #endif
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index a635c8a84ddf..7ea4679880c8 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -135,7 +135,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "ShmemPmdMapped: ",
 		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
 	show_val_kb(m, "FileHugePages:  ",
-		    global_node_page_state(NR_FILE_THPS) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
 		    global_node_page_state(NR_FILE_PMDMAPPED) * HPAGE_PMD_NR);
 #endif
diff --git a/mm/filemap.c b/mm/filemap.c
index 78090ee08ac2..9cc8b3ac9eac 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -207,7 +207,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 		if (PageTransHuge(page))
 			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
 	} else if (PageTransHuge(page)) {
-		__dec_lruvec_page_state(page, NR_FILE_THPS);
+		__mod_lruvec_page_state(page, NR_FILE_THPS, -HPAGE_PMD_NR);
 		filemap_nr_thps_dec(mapping);
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 66ec454120de..1e24165fa53a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2748,7 +2748,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			if (PageSwapBacked(head))
 				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
 			else
-				__dec_lruvec_page_state(head, NR_FILE_THPS);
+				__mod_lruvec_page_state(head, NR_FILE_THPS,
+							-HPAGE_PMD_NR);
 		}
 
 		__split_huge_page(page, list, end);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 494d3cb0b58a..76b3e064a72a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1869,7 +1869,7 @@ static void collapse_file(struct mm_struct *mm,
 	if (is_shmem)
 		__inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
 	else {
-		__inc_lruvec_page_state(new_page, NR_FILE_THPS);
+		__mod_lruvec_page_state(new_page, NR_FILE_THPS, HPAGE_PMD_NR);
 		filemap_nr_thps_inc(mapping);
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b18e25a5cdf3..04985c8c6a0a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1533,7 +1533,7 @@ static struct memory_stat memory_stats[] = {
 	 * constant(e.g. powerpc).
 	 */
 	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
-	{ "file_thp", 0, NR_FILE_THPS },
+	{ "file_thp", PAGE_SIZE, NR_FILE_THPS },
 	{ "shmem_thp", 0, NR_SHMEM_THPS },
 #endif
 	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
@@ -1565,8 +1565,7 @@ static int __init memory_stats_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memory_stats[i].idx == NR_FILE_THPS ||
-		    memory_stats[i].idx == NR_SHMEM_THPS)
+		if (memory_stats[i].idx == NR_SHMEM_THPS)
 			memory_stats[i].ratio = HPAGE_PMD_SIZE;
 #endif
 		VM_BUG_ON(!memory_stats[i].ratio);
-- 
2.11.0

