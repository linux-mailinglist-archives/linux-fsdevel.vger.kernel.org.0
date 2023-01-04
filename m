Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8854365DE87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbjADVPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbjADVPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:05 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B041D0D6;
        Wed,  4 Jan 2023 13:15:04 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ge16so33881783pjb.5;
        Wed, 04 Jan 2023 13:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2mmRSbNA08/uL5X+kgeGS/ZlgopWrLZQOgB2XOAgyQ=;
        b=FtYpbP6QDTs+0lZleCDk5ZEuYILk9YbbUBPUPSrk3Ld9sQDe/AXWgt1NFFEtyzVwVd
         27XIJK2uMXpNSENtPUU9mTolqKYBkyqWBRgiNaPPr+6HKOkzRrfFG7vh51FRnD5XfrPm
         d3yU7xjojsyNe4TVkT6sdDculOxDV3WAY5LGCcI0ZY86e981vkbE2Keq4xL4jQlm+JDy
         0+d7ZCBTlVPh+hBTPdMLgdJw4vZmFBuuPBlkVC18R54ZYLTjgjJSPd6APtzi8XuZocdm
         Vq+WqxTzB5n+aGbr09OvMJrslxbC/mLCAMYTELt30+n+Q7WR+zOqoKkaC27cWNkSuDUT
         61uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2mmRSbNA08/uL5X+kgeGS/ZlgopWrLZQOgB2XOAgyQ=;
        b=csgSZMNRrlVgo3c3ct8PGKvDi36NXVQ4GFnLPM0UuhTM+vl3HDTiz9EMR2KDp4oRN6
         QZ5w7KVTGW0PtD+E8TUykxW/tOMQ03DYo9YARFFGGxw42951jF6LapRkLArudGWLUtIV
         pXemWQzuA4YdLUKdVmC9J+uXWdFIMUwRqpPILmeJZrHGDIuqUW8NUAMFOV3bSlu3fRrR
         L7kzOLNLSs0YaL3XBxXOKDOPDJe1r311cfrpD0j3HyhA13FCfk9F9A+GRLoEEUuGYh0E
         juVNgEMcYJJ5RCCOATzd0BGlV3eYP0S95lTl44Qpx1wd7p6M+rnsDed7CcmSg5QnlG2s
         H+sQ==
X-Gm-Message-State: AFqh2krorRHzyuD77M9fswayYSTA/3YujcUqBTWcQfXPfgmw3glKq7tl
        EmIGtozowNPbhZr//6cidzQUPSxvtoxCqA==
X-Google-Smtp-Source: AMrXdXsgqtpANtSCNZq+/gUhsOvEJLufITPz0tuKGVLeAke3wLXVvQoumIbsLoPmk9yfZKpeAUrvrg==
X-Received: by 2002:a17:90b:2291:b0:226:43ba:54af with SMTP id kx17-20020a17090b229100b0022643ba54afmr18504817pjb.2.1672866903454;
        Wed, 04 Jan 2023 13:15:03 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:03 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v5 05/23] afs: Convert afs_writepages_region() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:30 -0800
Message-Id: <20230104211448.4804-6-vishal.moola@gmail.com>
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

Convert to use folios throughout. This function is in preparation to
remove find_get_pages_range_tag().

Also modified this function to write the whole batch one at a time,
rather than calling for a new set every single write.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Tested-by: David Howells <dhowells@redhat.com>
---
 fs/afs/write.c | 116 +++++++++++++++++++++++++------------------------
 1 file changed, 59 insertions(+), 57 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 19df10d63323..2d3b08b7406c 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -704,85 +704,87 @@ static int afs_writepages_region(struct address_space *mapping,
 				 bool max_one_loop)
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
 
-		start += ret;
-
-		if (max_one_loop)
-			break;
-
+		folio_batch_release(&fbatch);
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
 
-- 
2.38.1

