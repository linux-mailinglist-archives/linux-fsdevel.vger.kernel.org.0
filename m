Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD3601A3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiJQU1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJQU0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:26:53 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0257D7E012;
        Mon, 17 Oct 2022 13:25:28 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 129so11456375pgc.5;
        Mon, 17 Oct 2022 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Djg16035gM5p4sGWRwaRPAJ04PvNuws/dBsvoNLi870=;
        b=m2ykFButH5DCs9UiZXZhGomBEJhgTu17N1oM4zXEGXbTg9IQtUH0NbbzFAkFW2esz3
         nnpPJi6pUNONDjhNI4Y4RiuyXTibQAQYFV5KeKrbC/Yog7oxEWPcIRzdbVro5Up8DX/e
         ySYprp3hrV1L88vio3YXgr/bcbV1oA3JtekwIoQzcdh+E47v6inH8Z8COzdK40BsEaIi
         HvyhzLLAKJBZzywyL4Wpy/b8JdeM/8cDKOj1owvmG8RYMWR1zMonMAQ5MWJNLnUQi8NO
         wWXReAMRqCOUU+8mtr4dyMFEA0VkSoB2Usk5SYSWUXONQr45zm4gz/IggsL4MBJ6RHKX
         CtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Djg16035gM5p4sGWRwaRPAJ04PvNuws/dBsvoNLi870=;
        b=eOL93MrBcO0UFRa8hPgasyDtFsuZIFGRUd/5n0hcG89f8WF2H7F9Ryu3KCI0Ww+ExI
         11fT7MI1p5hqvgkzjR3bpQ85KfacnWWRPKlkWVw6tnPW7sqS4JhVnsUiAB4fi4mpz1jS
         P7FvbQ+jEol/DDQLn/uy8JxUhN13uLXLkzPi3j1ZXnCj+LVk/pQ+HLNIM0YHpGjl3iLQ
         aNHMu0fvtNxtigtL4pjd+6o8UyZzT0WiJASgTiKesEzhm6bHUUmXx8cFpBFd40iJ1RlK
         uBgJBeYaClyjWhal1roNJTvhSpjJFkTefFpcDSxRiIT+BpmwNmg/3Nz5DeNTo12VPf67
         ZSnw==
X-Gm-Message-State: ACrzQf2WkNVvyLnu0u04hEqv+cgVj+WflMauEqrXzEKGsIZY/AV6O3L3
        v9v3Xh2AtZEW08OYLu63IHmWef76bjf28A==
X-Google-Smtp-Source: AMsMyM4QGXxJjBRzFOeZlfDfy9O8UjGFPTeRTF/afjSZaqBuetjvpzQ+V6uJN58MVK7EN5cq4zwBhA==
X-Received: by 2002:a05:6a00:3202:b0:565:c863:78a1 with SMTP id bm2-20020a056a00320200b00565c86378a1mr14441253pfb.7.1666038298287;
        Mon, 17 Oct 2022 13:24:58 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:24:58 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 04/23] page-writeback: Convert write_cache_pages() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:32 -0700
Message-Id: <20221017202451.4951-5-vishal.moola@gmail.com>
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

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/page-writeback.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7e9d8d857ecc..aeec8b196232 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2286,15 +2286,15 @@ int write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	int error;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
 	int range_whole = 0;
 	xa_mark_t tag;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* prev offset */
 		end = -1;
@@ -2314,17 +2314,18 @@ int write_cache_pages(struct address_space *mapping,
 	while (!done && (index <= end)) {
 		int i;
 
-		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
-				tag);
-		if (nr_pages == 0)
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				tag, &fbatch);
+
+		if (nr_folios == 0)
 			break;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			done_index = page->index;
+			done_index = folio->index;
 
-			lock_page(page);
+			folio_lock(folio);
 
 			/*
 			 * Page truncated or invalidated. We can freely skip it
@@ -2334,30 +2335,30 @@ int write_cache_pages(struct address_space *mapping,
 			 * even if there is now a new, dirty page at the same
 			 * pagecache address.
 			 */
-			if (unlikely(page->mapping != mapping)) {
+			if (unlikely(folio->mapping != mapping)) {
 continue_unlock:
-				unlock_page(page);
+				folio_unlock(folio);
 				continue;
 			}
 
-			if (!PageDirty(page)) {
+			if (!folio_test_dirty(folio)) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
 
-			if (PageWriteback(page)) {
+			if (folio_test_writeback(folio)) {
 				if (wbc->sync_mode != WB_SYNC_NONE)
-					wait_on_page_writeback(page);
+					folio_wait_writeback(folio);
 				else
 					goto continue_unlock;
 			}
 
-			BUG_ON(PageWriteback(page));
-			if (!clear_page_dirty_for_io(page))
+			BUG_ON(folio_test_writeback(folio));
+			if (!folio_clear_dirty_for_io(folio))
 				goto continue_unlock;
 
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-			error = (*writepage)(page, wbc, data);
+			error = writepage(&folio->page, wbc, data);
 			if (unlikely(error)) {
 				/*
 				 * Handle errors according to the type of
@@ -2372,11 +2373,12 @@ int write_cache_pages(struct address_space *mapping,
 				 * the first error.
 				 */
 				if (error == AOP_WRITEPAGE_ACTIVATE) {
-					unlock_page(page);
+					folio_unlock(folio);
 					error = 0;
 				} else if (wbc->sync_mode != WB_SYNC_ALL) {
 					ret = error;
-					done_index = page->index + 1;
+					done_index = folio->index +
+						folio_nr_pages(folio);
 					done = 1;
 					break;
 				}
@@ -2396,7 +2398,7 @@ int write_cache_pages(struct address_space *mapping,
 				break;
 			}
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
-- 
2.36.1

