Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9455AA238
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiIAWDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiIAWCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:02:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630E27A778;
        Thu,  1 Sep 2022 15:02:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p18so93027plr.8;
        Thu, 01 Sep 2022 15:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=e1eM0qi5kNEXaBuV4o8U+3ZrhdfXdzoi+l/ai4waThY=;
        b=gNJXwxFuFke6eYj0nz2/PiDYXJ6uuw/+y6pvA6QnWq7eouNcHBf6+EJm5Gq193Grgh
         QKheBVVmh8HekBMRDB/fVleY8+effRW479vEXXGHLR3S87K//Jhw2e5O+6agt21yf265
         3kAUpqXavBcWDTvapyzBiis+xac8n0OHDWu3AZnWr0Wr+BK3whUep7JGlwqONOkwM7N0
         +1XX1ffonfhplIVIfU/utkDEIIZZiHHrp7IYcKrC4ceg3Zt1nHegjtwcFABUPSqNEdnl
         4EwYzeXkwp7J8eKW59Rb1lKWQlyJ5HTmd9bz7AQHe6l+E5Qrn3Xr5kUs3+qXtBgSUL9M
         Ozqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=e1eM0qi5kNEXaBuV4o8U+3ZrhdfXdzoi+l/ai4waThY=;
        b=YLvGjZt+esdYHMb9AE/QWrW+YOmHizydkxv8goSz4p5OfTyiQcEkcp6wZlzRexJY8J
         Jk7xFZvZ2+oKIyTjvLHSdUglg0VZ+P3Vlywvd5PvbpiDWE35Rwv9pksuVAhQW4JkAqEV
         TQQ7uGN1KI1tuGOxu0s4cmiN3beZrJJTpz6uXYKipnhaqIb6X7dN5B4rl/zZ+T1ZOvZW
         JrODrCRLUzNd1y6RdsTxaEE5DdBzyqV7vkw9qxI6khIORoB0ptKU+Aps2JEamj/tb8Dn
         AeEmAOMe0oR+fa+fecg7ZBv+RUN00f3P5vPLHeJSU/6M5iRlbv11BNEsAog7ywv/dZgC
         zESA==
X-Gm-Message-State: ACgBeo2Ygh+ylqM+RC0lDgz6KqXo+ImUzLgSpCxsGN1La+v9gkXpVOgA
        J++V02ayfcpdIJUoPgbHqQOgUkWr1AoRxg==
X-Google-Smtp-Source: AA6agR79ut39yeQZLj/LWKnnlXRQp19F2hOxIhYbazSQ5kgq5xXWtmAM1WGiML8jodYQoBXi0CNqGg==
X-Received: by 2002:a17:90b:2bca:b0:1fd:a06b:ef4f with SMTP id ru10-20020a17090b2bca00b001fda06bef4fmr1267475pjb.201.1662069758626;
        Thu, 01 Sep 2022 15:02:38 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:02:38 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 03/23] filemap: Convert __filemap_fdatawait_range() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:18 -0700
Message-Id: <20220901220138.182896-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Converted function to use folios. This is in preparation for the removal
of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/filemap.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3ded72a65668..435fc53b3f2f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -503,28 +503,30 @@ static void __filemap_fdatawait_range(struct address_space *mapping,
 {
 	pgoff_t index = start_byte >> PAGE_SHIFT;
 	pgoff_t end = end_byte >> PAGE_SHIFT;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	unsigned nr_folios;
 
 	if (end_byte < start_byte)
 		return;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
+
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
2.36.1

