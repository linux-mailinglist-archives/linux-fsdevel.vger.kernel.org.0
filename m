Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3163601A3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiJQU2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiJQU07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:26:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D717E835;
        Mon, 17 Oct 2022 13:25:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d10so12137650pfh.6;
        Mon, 17 Oct 2022 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOnFNLr6WPd7tItI5uxkca8Truk0f560xSuLirSKI30=;
        b=Ebrl+fflonMxXmYbjzZ0W5FnuUgF1ENZ6beNYeaCYzgPsSFFFY2nuwfTKiz2FudAe/
         7ZKdf6z/O/+HYjYCpK8ChxO2CQY7gBGoDhDIU1UeMcG99x96VPKcLvY7daaxIL6HByus
         /5yfixBKbG6rVzNv4/ZTcQkFvGUMjjvk2/T8YJVcM+iPU6/Q8umaLAUYJtaxOxiT1yX5
         slob1M+6u8lOpnGyvViPT+9/xv790R5/qWr3BkN0/2P0geRVbBZeT1bsX1UOhX0vCD6O
         vBYMGTV1jDQT8d5fBXvzef0tlyd90rL/RgBQhVdelCPIZRq4EycvfekOVwfGoK8elKWC
         hXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOnFNLr6WPd7tItI5uxkca8Truk0f560xSuLirSKI30=;
        b=C95pPs0mChxlojNmZTrZniHF92JyqVVZbWeaemLqxqPOla+NcT/+nMTa1QbYJHR6/y
         8Uyf8Zx22A6ffr4tIYk0kXQ5G2B+rURiZ/SGsLQj9+sGRa+3KS3mSrTxMFuATQPrA9R9
         Uoh6KxDTubbGt5SWupNBTWHx9962a2TKpaE+n0lNe8SpxKxhRLzkf9/Va1Ixhe1dfBsD
         3y7lmm0s9TqiYiGwDSlI/JODHqxRMJkCpFfStg+HMlWcN9EWYLzPh3YmqIw+4aLAL80H
         7OQTkG2I+B/tw0SDufCUxUamqsHk/TjDaQb7abEz5JQPtJhIT8y1JAzHOtRyPjBTqkt4
         thfg==
X-Gm-Message-State: ACrzQf1z4Phb+0KEdgojl6tC1kfcfEhddTxXRDDZ7wsFWD8SxD+9uM3Z
        cf1O3XcYI3huNQDLAOWW/V/ry5tac29HXA==
X-Google-Smtp-Source: AMsMyM4iyKgrXnehJ3N5g/lij9/dekJchm4sLReFYRq/SJGRVZDxiW6SK1PII0agzfMo68SeWUzaMA==
X-Received: by 2002:a63:5b5c:0:b0:440:8531:d3f6 with SMTP id l28-20020a635b5c000000b004408531d3f6mr12503042pgm.114.1666038308965;
        Mon, 17 Oct 2022 13:25:08 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:25:08 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 15/23] f2fs: Convert last_fsync_dnode() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:43 -0700
Message-Id: <20221017202451.4951-16-vishal.moola@gmail.com>
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

Convert to use a folio_batch instead of pagevec. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 38f32b4d61dc..3e1764960a96 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1515,23 +1515,24 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	pgoff_t index;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct page *last_page = NULL;
-	int nr_pages;
+	int nr_folios;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	index = 0;
 
-	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_DIRTY))) {
+	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
+					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+					&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				f2fs_put_page(last_page, 0);
-				pagevec_release(&pvec);
+				folio_batch_release(&fbatch);
 				return ERR_PTR(-EIO);
 			}
 
@@ -1562,7 +1563,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 			last_page = page;
 			unlock_page(page);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	return last_page;
-- 
2.36.1

