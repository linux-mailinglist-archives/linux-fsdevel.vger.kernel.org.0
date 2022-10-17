Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3D601A25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiJQU1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiJQU0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:26:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96464399E7;
        Mon, 17 Oct 2022 13:24:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so15372093pjs.0;
        Mon, 17 Oct 2022 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iL1dJ1+HlDDjTxTgJeEvA/bk0AVphIHMY13JSDpQpPE=;
        b=T2PyyDlkptXX08P0R0ss2FTcgqydLRmWv8uDLrgGaq5mTKgJ/us02bEe/BBTCH9sEn
         VgHiNn+EdlC3zxgxF+sscSbNXURHqrEPZaIe1RPlrW5+u0qSWgRqKr40/xbANBXmFg1h
         N1mSVri9e42lN3JGVr+UAHmLNz7otGMbXVDtSFCb4EodUJlvYpoJj8cf2WiW3564ILfR
         9aKPvyyQuTy5ihLisAvNhV6PjDWXr4XNKAQFc4eHwCknIz7qHUllV5jMj5VWlUG6h7nG
         +lg6ZM5Kjl6gaQ08gd163fTmGuQCxiVYgmc+SyhQ5A+9+zFkk3LJGoUSdKcQw1lKYAQ+
         lMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iL1dJ1+HlDDjTxTgJeEvA/bk0AVphIHMY13JSDpQpPE=;
        b=hJzbekrXTrIbeQL/XV0mis95B5C/3mZm2mxzuv5HW9Ql015JLcLv+Q4vVu6VYIoxYU
         o56eA+sKd2xHSqQSFfkwTrfSkm4TtNEgu/aSb9vZqGUKknCW2ZSQuiRCie3QDxRtnQVQ
         nATB6LtpvpIhg9vXYH46zBsPW4xcyOSnjbx8PI4tf/ubtjaKHdR8L/zqOBsSLtXllIAr
         V9m4OGojBbtCHe/j0xG9luXenLJfXAmqFR9/UBluQbD+xtSsxiGMvOQd+/ASr6X+cxLs
         +huAaTkAbjKG06DYmTGMSdhvq1BV60c9y0zip5cQWcBiML2NfPT/JPZBnpXExJMChWGs
         Zxrg==
X-Gm-Message-State: ACrzQf2JGBWjrurugkjgumiAC56U5i+pBKc7oIiVmorbT+LER3D0q47U
        u2l8p3mBYbF4HXhtygXNj2l1TidZyTl/vA==
X-Google-Smtp-Source: AMsMyM4nI+J5VGj2q/Y5LFK0UbiMCKinN+LtZLSm5wfBwq1+N4H+I7ep8VehInFIJJVIXWLltjZUwA==
X-Received: by 2002:a17:90a:8c97:b0:20d:a1a2:bfda with SMTP id b23-20020a17090a8c9700b0020da1a2bfdamr15543342pjo.234.1666038296428;
        Mon, 17 Oct 2022 13:24:56 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:24:56 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 02/23] filemap: Added filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:30 -0700
Message-Id: <20221017202451.4951-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the equivalent of find_get_pages_range_tag(), except for folios
instead of pages.

One noteable difference is filemap_get_folios_tag() does not take in a
maximum pages argument. It instead tries to fill a folio batch and stops
either once full (15 folios) or reaching the end of the search range.

The new function supports large folios, the initial function did not
since all callers don't use large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 74d87e37a142..28275eecb949 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -740,6 +740,8 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_contig(struct address_space *mapping,
 		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
+unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
+		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 08341616ae7a..aa6e90ab0551 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2262,6 +2262,59 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 }
 EXPORT_SYMBOL(filemap_get_folios_contig);
 
+/**
+ * filemap_get_folios_tag - Get a batch of folios matching @tag.
+ * @mapping:    The address_space to search
+ * @start:      The starting page index
+ * @end:        The final page index (inclusive)
+ * @tag:        The tag index
+ * @fbatch:     The batch to fill
+ *
+ * Same as filemap_get_folios, but only returning folios tagged with @tag
+ *
+ * Return: The number of folios found
+ * Also update @start to index the next folio for traversal
+ */
+unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
+			pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch)
+{
+	XA_STATE(xas, &mapping->i_pages, *start);
+	struct folio *folio;
+
+	rcu_read_lock();
+	while ((folio = find_get_entry(&xas, end, tag)) != NULL) {
+		/* Shadow entries should never be tagged, but this iteration
+		 * is lockless so there is a window for page reclaim to evict
+		 * a page we saw tagged. Skip over it.
+		 */
+		if (xa_is_value(folio))
+			continue;
+		if (!folio_batch_add(fbatch, folio)) {
+			unsigned long nr = folio_nr_pages(folio);
+
+			if (folio_test_hugetlb(folio))
+				nr = 1;
+			*start = folio->index + nr;
+			goto out;
+		}
+	}
+	/*
+	 * We come here when there is no page beyond @end. We take care to not
+	 * overflow the index @start as it confuses some of the callers. This
+	 * breaks the iteration when there is a page at index -1 but that is
+	 * already broke anyway.
+	 */
+	if (end == (pgoff_t)-1)
+		*start = (pgoff_t)-1;
+	else
+		*start = end + 1;
+out:
+	rcu_read_unlock();
+
+	return folio_batch_count(fbatch);
+}
+EXPORT_SYMBOL(filemap_get_folios_tag);
+
 /**
  * find_get_pages_range_tag - Find and return head pages matching @tag.
  * @mapping:	the address_space to search
-- 
2.36.1

