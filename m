Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F34A61677E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiKBQLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiKBQLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:17 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319672C673;
        Wed,  2 Nov 2022 09:11:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2317866pjk.1;
        Wed, 02 Nov 2022 09:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTHpQKfAdnCJ3tKTn7AZCAQU2IaISjA9jjwi546elPg=;
        b=gQ3c0LdSBzFsK6fT4uYZJxPUXMrdMM/2nflC2cV7sYS3HEKaVakZmlZZyIEpcZLCrr
         azMVA0h0qEnPsHGSm1uNBpGCmLBetfTgOoRBq7HJ7OpluFtNBV6TRmNaUymXPL4NO53x
         lV7bQH7FkCayUIB1xUHmwk2uJBSE9FRd8QFcDG1446fcGXg2qwAnFc+AlpWK5Cx2HX0S
         xCa3bp5qXy30W+m2Z/irS788yBZSG1RzSQVRi5h5sfXIGSOxdwStdFlzSx8gSm/dxXkf
         XwSTeb0E/a4dtZhGU0fFLS5W23VlDnYw64tpG9lcaa2Y8R4gzUGbc7YB4qrZvGdJ5FAN
         uKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTHpQKfAdnCJ3tKTn7AZCAQU2IaISjA9jjwi546elPg=;
        b=5kuXesB/ilhbx+DTt/Jf6SyrWgb2vH8lPx6SIF6h/D+fcSs2CCnwLblJd5FPfDEWVP
         Bnc/gKeGsqLLWAiGd/F1UO3xWBSXHX1d3ZYGaYg10QVCqMZUB1pqfWlSWd//c5niO6Bp
         Wq/97B73B5/jfKl8RDrss34FarUGSpDkV0HX5cvMNqyadicMlLM7+78pjpu5VPn/2lbn
         4wFbeI7Z0s5siQ8azVwaTYRBonedO+tfDaCY3gqYPnAkdkjTr9dUBgK+5r2cybp9Gb8l
         K+uCI7rv2IzsCZnCYtK1q+FfC6izqcrgHnFFRPeQM6MPlgKd2mwYW2K5wo3QDkBAkB4W
         V/2A==
X-Gm-Message-State: ACrzQf09vXB4QTxb44cE7IOjgO29zGj6kxsM9+Y5bjeEQOyiQA69Q92+
        iuHEpewkjbuS0kkc6++gY4JQ3FSHhepuEQ==
X-Google-Smtp-Source: AMsMyM62c1dJQNqvaiM9Z7MzVYpUXu+EHw3vgmAHkN7xcwjpflKXn1VXNFCc0lHQDCMSG8tUJstqLA==
X-Received: by 2002:a17:90b:1bd2:b0:213:2d7:3162 with SMTP id oa18-20020a17090b1bd200b0021302d73162mr25853750pjb.91.1667405474612;
        Wed, 02 Nov 2022 09:11:14 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:14 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v4 05/23] afs: Convert afs_writepages_region() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:13 -0700
Message-Id: <20221102161031.5820-6-vishal.moola@gmail.com>
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

Convert to use folios throughout. This function is in preparation to
remove find_get_pages_range_tag().

Also modified this function to write the whole batch one at a time,
rather than calling for a new set every single write.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Tested-by: David Howells <dhowells@redhat.com>
---
 fs/afs/write.c | 114 +++++++++++++++++++++++++------------------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 9ebdd36eaf2f..c17dbd82a38c 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -699,82 +699,86 @@ static int afs_writepages_region(struct address_space *mapping,
 				 loff_t start, loff_t end, loff_t *_next)
 {
 	struct folio *folio;
-	struct page *head_page;
+	struct folio_batch fbatch;
 	ssize_t ret;
+	unsigned int i;
 	int n, skips = 0;
 
 	_enter("%llx,%llx,", start, end);
+	folio_batch_init(&fbatch);
 
 	do {
 		pgoff_t index = start / PAGE_SIZE;
 
-		n = find_get_pages_range_tag(mapping, &index, end / PAGE_SIZE,
-					     PAGECACHE_TAG_DIRTY, 1, &head_page);
+		n = filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
+					PAGECACHE_TAG_DIRTY, &fbatch);
+
 		if (!n)
 			break;
+		for (i = 0; i < n; i++) {
+			folio = fbatch.folios[i];
+			start = folio_pos(folio); /* May regress with THPs */
 
-		folio = page_folio(head_page);
-		start = folio_pos(folio); /* May regress with THPs */
-
-		_debug("wback %lx", folio_index(folio));
+			_debug("wback %lx", folio_index(folio));
 
-		/* At this point we hold neither the i_pages lock nor the
-		 * page lock: the page may be truncated or invalidated
-		 * (changing page->mapping to NULL), or even swizzled
-		 * back from swapper_space to tmpfs file mapping
-		 */
-		if (wbc->sync_mode != WB_SYNC_NONE) {
-			ret = folio_lock_killable(folio);
-			if (ret < 0) {
-				folio_put(folio);
-				return ret;
-			}
-		} else {
-			if (!folio_trylock(folio)) {
-				folio_put(folio);
-				return 0;
+			/* At this point we hold neither the i_pages lock nor the
+			 * page lock: the page may be truncated or invalidated
+			 * (changing page->mapping to NULL), or even swizzled
+			 * back from swapper_space to tmpfs file mapping
+			 */
+			if (wbc->sync_mode != WB_SYNC_NONE) {
+				ret = folio_lock_killable(folio);
+				if (ret < 0) {
+					folio_batch_release(&fbatch);
+					return ret;
+				}
+			} else {
+				if (!folio_trylock(folio))
+					continue;
 			}
-		}
 
-		if (folio_mapping(folio) != mapping ||
-		    !folio_test_dirty(folio)) {
-			start += folio_size(folio);
-			folio_unlock(folio);
-			folio_put(folio);
-			continue;
-		}
+			if (folio->mapping != mapping ||
+			    !folio_test_dirty(folio)) {
+				start += folio_size(folio);
+				folio_unlock(folio);
+				continue;
+			}
 
-		if (folio_test_writeback(folio) ||
-		    folio_test_fscache(folio)) {
-			folio_unlock(folio);
-			if (wbc->sync_mode != WB_SYNC_NONE) {
-				folio_wait_writeback(folio);
+			if (folio_test_writeback(folio) ||
+			    folio_test_fscache(folio)) {
+				folio_unlock(folio);
+				if (wbc->sync_mode != WB_SYNC_NONE) {
+					folio_wait_writeback(folio);
 #ifdef CONFIG_AFS_FSCACHE
-				folio_wait_fscache(folio);
+					folio_wait_fscache(folio);
 #endif
-			} else {
-				start += folio_size(folio);
+				} else {
+					start += folio_size(folio);
+				}
+				if (wbc->sync_mode == WB_SYNC_NONE) {
+					if (skips >= 5 || need_resched()) {
+						*_next = start;
+						_leave(" = 0 [%llx]", *_next);
+						return 0;
+					}
+					skips++;
+				}
+				continue;
 			}
-			folio_put(folio);
-			if (wbc->sync_mode == WB_SYNC_NONE) {
-				if (skips >= 5 || need_resched())
-					break;
-				skips++;
+
+			if (!folio_clear_dirty_for_io(folio))
+				BUG();
+			ret = afs_write_back_from_locked_folio(mapping, wbc,
+					folio, start, end);
+			if (ret < 0) {
+				_leave(" = %zd", ret);
+				folio_batch_release(&fbatch);
+				return ret;
 			}
-			continue;
-		}
 
-		if (!folio_clear_dirty_for_io(folio))
-			BUG();
-		ret = afs_write_back_from_locked_folio(mapping, wbc, folio, start, end);
-		folio_put(folio);
-		if (ret < 0) {
-			_leave(" = %zd", ret);
-			return ret;
+			start += ret;
 		}
-
-		start += ret;
-
+		folio_batch_release(&fbatch);
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
 
-- 
2.38.1

