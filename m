Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0398165DE91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbjADVQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbjADVP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE451CB3D;
        Wed,  4 Jan 2023 13:15:27 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b2so37200719pld.7;
        Wed, 04 Jan 2023 13:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdjIiLbt6NZs/+ugsh8p0DToyI6+NA6EFXmKyQS/uaI=;
        b=glpIa7fah0tr/iN8VTblVZOLKx6udw1Y6CMH9y932LtgL0yAdBTRzwDIj0zvhgD39Q
         E1sL9pDcu27gNo9eBb2VjNhIMTDlKXVfRv6jhGeAPXWY0rUHIfhMoFfE3XhufWQTIbMH
         E2KvefozTkDS3/Hp893OF3S49VHllnT3CB69+mEDG9UtLBa4m/skO7yUjlUTWoasN5ZG
         NU+lE/pxu55tM0OK9vSbnCVSEU358m3zsG6W/CVnAseJloUEUnw/6cEJcYNAvsfouAqL
         w9cFz18Y11YtSUOFogC9JICjRGGamrfqBabqoubTBObtLZcvFhc86wyCAt/PfmLLGeYC
         HJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdjIiLbt6NZs/+ugsh8p0DToyI6+NA6EFXmKyQS/uaI=;
        b=jG7x06hPKWm72mzhB+AtwH7U2AuBVHVrmo0rlgq4gA5+HPwCnemdworYaR3BCa/slu
         0AX0TftbGjT8wppDlTTroFZw20gvR0sFayJXAsfPjEt0t/4Xl6VBo42Z3u9C5k1tT764
         Zsd5Gng3RSVppUrqZZMDrvWYmR+0uU7ikFkJaicTpf330kUIouLz/ahBD7e+lyvpqfLm
         h6kDaZv4MQwBMKekNLHGaTkN8xBYJW6Mv2dFFuBy0ovaA1jY6giKUYBbk/tdarboJiWU
         CBE6nGTFxkfw4tTkfoyzNEK//hdmmMrw9RJy3+OV+3xiLIUqDnaonanjPU/BBkL2593z
         Omzg==
X-Gm-Message-State: AFqh2kr064JokLRyV4pNQ0CB2AVouyJYq/NafkPDLm1H5txs5DahYCMb
        cT5Y100JlTV/TJ5t3KKCvETQy4JA8Z8qlQ==
X-Google-Smtp-Source: AMrXdXueuis6NhJlGTgG2VFmI91e7ab5OxbM/PwA6uv8A4+49g3wkiIGZ6yZWeV3aNkAfE4Gmx5MoQ==
X-Received: by 2002:a17:90a:4ca7:b0:226:317f:f832 with SMTP id k36-20020a17090a4ca700b00226317ff832mr21893775pjh.39.1672866926361;
        Wed, 04 Jan 2023 13:15:26 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:26 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v5 21/23] nilfs2: Convert nilfs_copy_dirty_pages() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:46 -0800
Message-Id: <20230104211448.4804-22-vishal.moola@gmail.com>
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

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag(). This change removes 8 calls
to compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 39b7eea2642a..d921542a9593 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -240,42 +240,43 @@ static void nilfs_copy_page(struct page *dst, struct page *src, int copy_dirty)
 int nilfs_copy_dirty_pages(struct address_space *dmap,
 			   struct address_space *smap)
 {
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	unsigned int i;
 	pgoff_t index = 0;
 	int err = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 repeat:
-	if (!pagevec_lookup_tag(&pvec, smap, &index, PAGECACHE_TAG_DIRTY))
+	if (!filemap_get_folios_tag(smap, &index, (pgoff_t)-1,
+				PAGECACHE_TAG_DIRTY, &fbatch))
 		return 0;
 
-	for (i = 0; i < pagevec_count(&pvec); i++) {
-		struct page *page = pvec.pages[i], *dpage;
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
+		struct folio *folio = fbatch.folios[i], *dfolio;
 
-		lock_page(page);
-		if (unlikely(!PageDirty(page)))
-			NILFS_PAGE_BUG(page, "inconsistent dirty state");
+		folio_lock(folio);
+		if (unlikely(!folio_test_dirty(folio)))
+			NILFS_PAGE_BUG(&folio->page, "inconsistent dirty state");
 
-		dpage = grab_cache_page(dmap, page->index);
-		if (unlikely(!dpage)) {
+		dfolio = filemap_grab_folio(dmap, folio->index);
+		if (unlikely(!dfolio)) {
 			/* No empty page is added to the page cache */
 			err = -ENOMEM;
-			unlock_page(page);
+			folio_unlock(folio);
 			break;
 		}
-		if (unlikely(!page_has_buffers(page)))
-			NILFS_PAGE_BUG(page,
+		if (unlikely(!folio_buffers(folio)))
+			NILFS_PAGE_BUG(&folio->page,
 				       "found empty page in dat page cache");
 
-		nilfs_copy_page(dpage, page, 1);
-		__set_page_dirty_nobuffers(dpage);
+		nilfs_copy_page(&dfolio->page, &folio->page, 1);
+		filemap_dirty_folio(folio_mapping(dfolio), dfolio);
 
-		unlock_page(dpage);
-		put_page(dpage);
-		unlock_page(page);
+		folio_unlock(dfolio);
+		folio_put(dfolio);
+		folio_unlock(folio);
 	}
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	cond_resched();
 
 	if (likely(!err))
-- 
2.38.1

