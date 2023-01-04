Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFD165DE83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbjADVPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbjADVPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:06 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27351DDC1;
        Wed,  4 Jan 2023 13:15:05 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y1so1704170plb.2;
        Wed, 04 Jan 2023 13:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/F8d0ryK33J83PP3KTKD8iJBJ7iw3NcsaZlwvBQl84=;
        b=CNESCgcUv9kyk6ZyuvoP2d6/MvhM1pCGilvS2/lZfNbmctlSZWFKUqCSvhFIz1agh0
         MrXYUY/IjeyZdKqV04XP1+w+s563MfL6+BGDibaZYFnnmEIV6pxQQi6KtEvnE/Zh6S9x
         N3YHOD+Wv8qtv3qvpXgMLZUQwwOCEW7H7eRmd/WlRcZhTkbK/UvDIqsoezAJMA0lHvvS
         kWJCDRpjIbsqJnvVQ/ULbh6fTn6+ffdvyUTkqPbElybf60JgjpuMKt4o2uXOPIr/TfNE
         +OyO0tT4kunau+qPwxmhXHoh0V+QCydNCNYwJsT/xGh1U9dwCtvIvQ+8IlclyBNEC2Z1
         /zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/F8d0ryK33J83PP3KTKD8iJBJ7iw3NcsaZlwvBQl84=;
        b=q4f1hkm98Dwi+UZde+0UJnVERislHakYdoWY9mO9MZTv3exAIyxAYrV+/W+BiV1qqo
         1XQKTSMgcLWkBT8OVqg9XvSUvSeIcptSUvJK3FBDtfrudwVK4RvCoY8FCDEXALh3PK8X
         djIwLMN32NAj4LsEsIBPDyOMPKp2btXIZUyYXFly+VTiOyo93PbyHwvo2yA14+a82dOF
         fijSRZKOg4B9SHl9T1+kv5K33YcE83omiX81vRwuUX7Xp7hzTUxYOFlf0vfipcsIfdhk
         qLWdxIXjIPWpc5L2PbCd7bXWyq7Pgq9Bctym47hBq65zoC7l9A+uJZmcyzXU0Lm2JAnN
         ie5w==
X-Gm-Message-State: AFqh2kpqT42V8fWqNhX7z8G3ySoOshO5i+dY9H5hVmlv01TAOv+PvoD+
        lDUqP5uAXTbdcOKpvZuH1of13M8JKkUXSg==
X-Google-Smtp-Source: AMrXdXuAX7hDzmiQPGibqegiPGsPttVBZ/qOOsjXqjfaA/v0yCiadzuJ0YGwzrUP0RByey/eocKZSw==
X-Received: by 2002:a17:90a:8b05:b0:226:7fcb:c215 with SMTP id y5-20020a17090a8b0500b002267fcbc215mr10576703pjn.17.1672866904962;
        Wed, 04 Jan 2023 13:15:04 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:04 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v5 06/23] btrfs: Convert btree_write_cache_pages() to use filemap_get_folio_tag()
Date:   Wed,  4 Jan 2023 13:14:31 -0800
Message-Id: <20230104211448.4804-7-vishal.moola@gmail.com>
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

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 83dd3aa59663..64fbafc70822 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2845,14 +2845,14 @@ int btree_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	unsigned int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	int scanned = 0;
 	xa_mark_t tag;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
 		end = -1;
@@ -2875,14 +2875,15 @@ int btree_write_cache_pages(struct address_space *mapping,
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
 	while (!done && !nr_to_write_done && (index <= end) &&
-	       (nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
-			tag))) {
+	       (nr_folios = filemap_get_folios_tag(mapping, &index, end,
+					    tag, &fbatch))) {
 		unsigned i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(page, wbc, &bio_ctrl, &eb_context);
+			ret = submit_eb_page(&folio->page, wbc, &bio_ctrl,
+					&eb_context);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
@@ -2897,7 +2898,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 			 */
 			nr_to_write_done = wbc->nr_to_write <= 0;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	if (!scanned && !done) {
-- 
2.38.1

