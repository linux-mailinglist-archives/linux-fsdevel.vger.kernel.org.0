Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E8C616752
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiKBQLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiKBQLL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:11 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB862C660;
        Wed,  2 Nov 2022 09:11:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2317701pjk.1;
        Wed, 02 Nov 2022 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViGofEkX7yEcmkcXNm3flvqY1FjypmnwIzQ3h5+k6EI=;
        b=n1wMZVPJgGAZfgmD3ZkM/SCD642n1Mc4Zn6+qTmFZdbiwhyj7wS8pZ8SFI+liwrQ2r
         jRtU/zEufgYnUSRmaPQbqmHP5jt+qqrNY2eB+O1n3FUDftvsWT7jdtVrRY3CCZiGe3K8
         A4WNFuGywv6YgnSjp3gkRLGNT2bhdMiVnpZ6tPSRX71fvkRoyEtYetGSXc69oJ1O1mWz
         KZNpeejY8S04w/0+Biv+H5A7Zb8g5E/3r8QLYAtAdy+fJFIPdJKL3md+xbL3oUEKqTZx
         /4olLVxViCwqQAaoUx8z7sEV7+rlEHas4BS4I6u0JIigVObca1ahPMhG3dFM4vj2Miz6
         v6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViGofEkX7yEcmkcXNm3flvqY1FjypmnwIzQ3h5+k6EI=;
        b=aU80nxKEyEiUsQljEDiGIQl/CU980UZFaipwxsXMRVlmsnZuqkdSa7xabKuOaAZea7
         zl4KZGQs0R8bKzCs81cijDbQHoYuVnYml0iMUlVnAu0GS62Kvy2buNSeNaYwXC0NioHC
         JAlUWF+XvJgPIN8nw0G6Inq56PbfISUxrfEBX5kiLKqNienurgE685jjgv/aAYo2GXMo
         Ro34fcOnKKXnQkRB7Pw14HlDHJaT2xQFFmm0O0B1e4ElcHUDzKqdRNT0bdm69FBwi0IP
         w/9HqR/R1er3hNKgazNelBwFsWKNHsoUm+0W8ubQsaBWpBcztMC5wA1XvszKTaF6zlDY
         WfCA==
X-Gm-Message-State: ACrzQf1ewufpOXV5hJP1UjLZo9laJnyNu7B3mTgyfXCYf2hf2p9w9bEp
        gq2z8Xd9NqPyqUDjVTGX0zOGjNq8P0YKRQ==
X-Google-Smtp-Source: AMsMyM50Il1duVwG4WCRXyqqx6zo9JX2k0qIMVQGpTqxyyUEKMma/iNuAz7sS7Uhi64hLkOOMPexZA==
X-Received: by 2002:a17:90b:2248:b0:210:10dc:a314 with SMTP id hk8-20020a17090b224800b0021010dca314mr42536562pjb.15.1667405470077;
        Wed, 02 Nov 2022 09:11:10 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:09 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcow <willy@infradead.org>
Subject: [PATCH v4 02/23] filemap: Added filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:10 -0700
Message-Id: <20221102161031.5820-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102161031.5820-1-vishal.moola@gmail.com>
References: <20221102161031.5820-1-vishal.moola@gmail.com>
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
index 08341616ae7a..9be22672ce1a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2262,6 +2262,60 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
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

