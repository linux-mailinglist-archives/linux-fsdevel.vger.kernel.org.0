Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A0A65DE48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbjADVPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbjADVPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:00 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1748B1CB3D;
        Wed,  4 Jan 2023 13:14:59 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 17so37263994pll.0;
        Wed, 04 Jan 2023 13:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWc2oMWZrabUsNL93YYBg0xBgzl7UJM5P4FHRP4dszA=;
        b=X+JhwQB/YFpkv9O3Sz2RIqehaNfUYePllMKYDSfYMVmQ80S+7Znm3qUhQQutUgGzcL
         0uq/hVoyBfqjmkDpyVZm/VIPt68FQqEGQ82Nd+zz6E+E98NXjR4XSpPj/MXztZhY0W/5
         2SnakvGDdpx0xcZLQD7UZxy8cVZY3oo6XDRKLX6rp+1lZ5XfYRhOxIIbBxK+QOE0O7oY
         mvbbq1JpLOKHZ6D7c98chruQCpXs68i4ZX3rFltoX/XuVJPECIsdkN1cooENDtzYQJT2
         bRwgzwaxOKhTwxGYYDaTYxmm4WsaqrwCXgLa3BEJo54/4GqC8mZRZtI56zwUYC6qebL9
         Oo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWc2oMWZrabUsNL93YYBg0xBgzl7UJM5P4FHRP4dszA=;
        b=JgvoNm0ehFACkQtiQpM9h2G4NU3ZW4DxOyg8oPIhRTCCxX8knz53vCYFSXm6GvXUHI
         Ev5EuDRVFiE2gjHXO4o+IoATLSxLyW/xruLYPuDVSLMzD6qI1i60sR60Ml8f6cGt8lzV
         q8cdhMdT3eoHXunHLXPdUu98UgiuD3Bszh7T1FgiGZJ/fGsXMrVF6eUAZa3bhLcMHCba
         jfADS3UJQTGELFQ8qJCjL5c4JVp/nDfTM3cmo1VzFof0sEFAeGKjemwHnHpaXY6/7Ghc
         ubaY407rcI76MwJntzEbJBMJADAwKVRmHXh+yHlmPJdMmXcy53RJkYkECkl4p0FWQnJ8
         dzxQ==
X-Gm-Message-State: AFqh2krKOphbfLWlmiXt7urgTO+cQ1D6xeknMO+n5tWWUTAfBlBtzfMZ
        yffhN798KKWjXIWaKID7CglXR0t5EYoI6w==
X-Google-Smtp-Source: AMrXdXsQLnyc09jFT7hjT2KR1nJMp1M067OD5YrApEuRuIFS+9J6bRUAVKGRrDQmj0MgbIV/5rlsug==
X-Received: by 2002:a17:90a:cc2:b0:219:9973:2746 with SMTP id 2-20020a17090a0cc200b0021999732746mr65437761pjt.0.1672866898346;
        Wed, 04 Jan 2023 13:14:58 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:14:58 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcow <willy@infradead.org>
Subject: [PATCH v5 02/23] filemap: Added filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:27 -0800
Message-Id: <20230104211448.4804-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
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
Reviewed-by: Matthew Wilcow (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 54 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 468183be67be..bb3c1d51b1cb 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -739,6 +739,8 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_contig(struct address_space *mapping,
 		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
+unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
+		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 			pgoff_t end, xa_mark_t tag, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index c4d4ace9cc70..291bb3e0957a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2281,6 +2281,60 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 }
 EXPORT_SYMBOL(filemap_get_folios_contig);
 
+/**
+ * filemap_get_folios_tag - Get a batch of folios matching @tag
+ * @mapping:    The address_space to search
+ * @start:      The starting page index
+ * @end:        The final page index (inclusive)
+ * @tag:        The tag index
+ * @fbatch:     The batch to fill
+ *
+ * Same as filemap_get_folios(), but only returning folios tagged with @tag.
+ *
+ * Return: The number of folios found.
+ * Also update @start to index the next folio for traversal.
+ */
+unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
+			pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch)
+{
+	XA_STATE(xas, &mapping->i_pages, *start);
+	struct folio *folio;
+
+	rcu_read_lock();
+	while ((folio = find_get_entry(&xas, end, tag)) != NULL) {
+		/*
+		 * Shadow entries should never be tagged, but this iteration
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
2.38.1

