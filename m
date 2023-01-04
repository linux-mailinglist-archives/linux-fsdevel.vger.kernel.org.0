Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F0F65DEE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbjADVPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240283AbjADVPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2331B9DA;
        Wed,  4 Jan 2023 13:15:00 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso40283162pjt.0;
        Wed, 04 Jan 2023 13:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ONYMO0PIN9dk55uWmFjeEGp9OM+yknAPJhSRMx3xaw=;
        b=B4tZImsNKLYbwaEqQjZ6y+RmfYlF9uPZ5GCZplXcCJF3iTUDgroyLgSP3mqYOoL8tg
         YUfyLoz3u5XgGnDE8mGVieFI7uGrvjpm7MV2567un6rA6WUGTCXfddQ3eRYqgtAPAsej
         ouYl8YS3aBd3N56Obqpj4h8BMtdtujYYIOVDFk+W7HfSFDJTTHDe65xJxpTl3VgqIUmo
         pI4SkMbuMEFagQxYzTZziQxn82J39o2Z7ocFmImgkgV9x4eSLUJZQMl3FydDHvRMUEpG
         u+rOOzvhF8F30SkjJIA4rPh2WDlpUGXokQmXmXOoIKmRVkH4a151vkBklfMzbbK9lmfe
         ilCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ONYMO0PIN9dk55uWmFjeEGp9OM+yknAPJhSRMx3xaw=;
        b=gKTfRcCnn20qBOL4vKPZVO1XkyxKEw9YVXyteSXpaSb3Mp04KHLe8/19YstX5nAZDE
         R1XB2SCzxA7+BsWyRGCqHbCx51CLvIvPm/ehWc1Jyq73L8pJfQhSPQBiTJ14vpFjfCXo
         OevDbxxFk0YXwL1fZIrq9RdORCpgYPMc+7weMZlZIiqwEKTTPwPEJ5gb3zrVGmgNuClW
         qUPMMBWipzhxLKum+o9Z3UCxOb3PCzu37PJY26pYFLOdQVR4MNJ7iCz/C6/459YN1Kap
         iOMPhmJ0lT6FHazefzOItuKclW3CAFZLFST2Zae53AZ+D+8avk8LiXupBY91wnfv923M
         CHpA==
X-Gm-Message-State: AFqh2krEQlXxpWkvbaoySoFPASgNmtw3LERBNsrVtgWYkISwIPJtppn+
        tVsvYQdXcAdCMIFy8Q8x1u6omJlgML1pJw==
X-Google-Smtp-Source: AMrXdXvZLValNoGwSyObnfnQYoAH4bPSeKaHZWatAKcSnlYAPIvL07xJdtB6+9NqIK7AN3tdnyykVg==
X-Received: by 2002:a17:90b:2485:b0:226:b9ed:1788 with SMTP id nt5-20020a17090b248500b00226b9ed1788mr2782434pjb.31.1672866899803;
        Wed, 04 Jan 2023 13:14:59 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:14:59 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcow <willy@infradead.org>
Subject: [PATCH v5 03/23] filemap: Convert __filemap_fdatawait_range() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:28 -0800
Message-Id: <20230104211448.4804-4-vishal.moola@gmail.com>
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

Converted function to use folios. This is in preparation for the removal
of find_get_pages_range_tag(). This change removes 2 calls to
compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcow (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 291bb3e0957a..85adbcf2d9a7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -503,25 +503,27 @@ static void __filemap_fdatawait_range(struct address_space *mapping,
 {
 	pgoff_t index = start_byte >> PAGE_SHIFT;
 	pgoff_t end = end_byte >> PAGE_SHIFT;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	unsigned nr_folios;
+
+	folio_batch_init(&fbatch);
 
-	pagevec_init(&pvec);
 	while (index <= end) {
 		unsigned i;
 
-		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index,
-				end, PAGECACHE_TAG_WRITEBACK);
-		if (!nr_pages)
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				PAGECACHE_TAG_WRITEBACK, &fbatch);
+
+		if (!nr_folios)
 			break;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			wait_on_page_writeback(page);
-			ClearPageError(page);
+			folio_wait_writeback(folio);
+			folio_clear_error(folio);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.38.1

