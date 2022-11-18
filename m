Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A608062EBC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 03:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbiKRCO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 21:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbiKRCOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:14:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7257087575;
        Thu, 17 Nov 2022 18:14:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b11so3286932pjp.2;
        Thu, 17 Nov 2022 18:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YDT/XAgh5QSXlyod86SZaadrvntYw6ff/cmVDaxdzo=;
        b=WIhEVv40bO8pPOe0T4T4maV1rYV4pai+d0aHe5h0r42FibWzau6xqjlbhDYj7fVP+/
         YVbz1QBIEi5smOOlTRsnqvFnOSv1Un3EXZls7avo8RWt8GuSdf13vWB1vX+nyGT9q/EA
         T4uFXOL3nEQg/604IZpT78KAD+oBUy2DhDfpQmyGPPQ90V+476q3TDhM8JO5/eefRo39
         Kc6oAfVStZxNFPpjkSEaVmtKQ/MwyY+KaTUq/ui8Z+wJ5NVT0RpHdPebMV2bUg0O0Yfb
         SscM0FktFuryyy6iQ7l4iU39d7doVgLL5n+BXTp0RKjfosJtcvVKIK7EIBdl3j/ynnVZ
         8T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YDT/XAgh5QSXlyod86SZaadrvntYw6ff/cmVDaxdzo=;
        b=KEiqHuji93hYmtLxhnOQ/w031eOtW+zGmvz7m1egWJ2Xw9j9diccgnBCrC6SQ558iM
         fuFAGq+31f+kj8zch1tSJFez7UuM6fvxNpyePsyiQXDURnKQk88vYRCLXDtQxPWEzDlU
         75F5fHfJdR4Y3LYwOfNQrGk6eW0F6P2U533wyPdyXRwiMUSqykNMcf2PlIxcRFkkBy8U
         M0nRVCOXhZYA/FvVqtjyb91phLOCYI3mw3NS8B0TTk6/zVb0OgOgKYHG7fvTMfc7a+uc
         F5mxR6JzK1a6ZZ/oR3RDsCQxPdIB6HpRlICil+ZBSTNM9hzkqg+2eN7BybQ5KO+gKErt
         +KtQ==
X-Gm-Message-State: ANoB5pn7Gn0dxJzr0FTgN4KBlqR2MQIp3Xd2MuSVYKLYeWZjm1eB1XMy
        5MiKJp8GsKfatURN1vh6QxVGaIUj3KL7Dg==
X-Google-Smtp-Source: AA0mqf6GjOQDWGuexUgf38gfQKvCyqZA7SD4wDQnxu1HJGFKP1gZXSLR4W2L7BYbOtRyfWYq70EdTQ==
X-Received: by 2002:a17:90b:117:b0:212:f2be:bc38 with SMTP id p23-20020a17090b011700b00212f2bebc38mr11372286pjz.175.1668737658849;
        Thu, 17 Nov 2022 18:14:18 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id ip13-20020a17090b314d00b00212cf2fe8c3sm10678445pjb.1.2022.11.17.18.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 18:14:18 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 2/4] khugepage: Replace try_to_release_page() with filemap_release_folio()
Date:   Thu, 17 Nov 2022 18:14:08 -0800
Message-Id: <20221118021410.24420-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118021410.24420-1-vishal.moola@gmail.com>
References: <20221118021410.24420-1-vishal.moola@gmail.com>
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

Replaces some calls with their folio equivalents. This change removes
4 calls to compound_head() and is in preparation for the removal of the
try_to_release_page() wrapper.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4734315f7940..3f21c010d2bd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1747,6 +1747,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	xas_set(&xas, start);
 	for (index = start; index < end; index++) {
 		struct page *page = xas_next(&xas);
+		struct folio *folio;
 
 		VM_BUG_ON(index != xas.xa_index);
 		if (is_shmem) {
@@ -1773,8 +1774,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			}
 
 			if (xa_is_value(page) || !PageUptodate(page)) {
-				struct folio *folio;
-
 				xas_unlock_irq(&xas);
 				/* swap in or instantiate fallocated page */
 				if (shmem_get_folio(mapping->host, index,
@@ -1862,13 +1861,15 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			goto out_unlock;
 		}
 
-		if (page_mapping(page) != mapping) {
+		folio = page_folio(page);
+
+		if (folio_mapping(folio) != mapping) {
 			result = SCAN_TRUNCATED;
 			goto out_unlock;
 		}
 
-		if (!is_shmem && (PageDirty(page) ||
-				  PageWriteback(page))) {
+		if (!is_shmem && (folio_test_dirty(folio) ||
+				  folio_test_writeback(folio))) {
 			/*
 			 * khugepaged only works on read-only fd, so this
 			 * page is dirty because it hasn't been flushed
@@ -1878,20 +1879,20 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			goto out_unlock;
 		}
 
-		if (isolate_lru_page(page)) {
+		if (folio_isolate_lru(folio)) {
 			result = SCAN_DEL_PAGE_LRU;
 			goto out_unlock;
 		}
 
-		if (page_has_private(page) &&
-		    !try_to_release_page(page, GFP_KERNEL)) {
+		if (folio_has_private(folio) &&
+		    !filemap_release_folio(folio, GFP_KERNEL)) {
 			result = SCAN_PAGE_HAS_PRIVATE;
-			putback_lru_page(page);
+			folio_putback_lru(folio);
 			goto out_unlock;
 		}
 
-		if (page_mapped(page))
-			try_to_unmap(page_folio(page),
+		if (folio_mapped(folio))
+			try_to_unmap(folio,
 					TTU_IGNORE_MLOCK | TTU_BATCH_FLUSH);
 
 		xas_lock_irq(&xas);
-- 
2.38.1

