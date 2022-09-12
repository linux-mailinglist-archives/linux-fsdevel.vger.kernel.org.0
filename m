Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE795B6076
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiILSZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiILSZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:25:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B1E13F1C;
        Mon, 12 Sep 2022 11:25:26 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so8994280pjh.3;
        Mon, 12 Sep 2022 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=e1eM0qi5kNEXaBuV4o8U+3ZrhdfXdzoi+l/ai4waThY=;
        b=bJasmGzScqLl47mHAWwYGTy+xHPYSMA3r6e6Akj5zuOYYE82oqGqbZsvm2DYlgJuvM
         iMps4WdWA/QA3EYsQGLltl7y9qz0xDAUmovpGz/HkxZ89ew7eFpvFmRqYJVv7dqD5ulf
         O3KrsagjFemGifY5Xe3d4kElJJFdWKCaCRzjuKP3qYmtenXf+GCQCzwhX8BLae3TsCNe
         mQnRqfF5JPwzHAfEaLYTS4VYD6a3sPQ3JkmhsX/Lm3jI5vqF/fMahGq5iyrtOp2cN2cG
         R6kSD85cMsKy+cpKldNx0Vv+PNdZZ/f30Tb1CLNqNwOcacBTqwIJsUVjwLtjGr4ofX20
         VA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=e1eM0qi5kNEXaBuV4o8U+3ZrhdfXdzoi+l/ai4waThY=;
        b=cN/qAl4WQEkw7gX3qCPnwTlDlZKopGAcEv9GdU9yBtcdZCJxgGdk0nKL3OGWuQpgUK
         ZZeNXoNmn4BMcCgqgilgSaYGIIyQEHZdY055+ucjMQ6t3PaidRwtLkGNdKCJo7h1xi9S
         SCCQOx74DYAOI6hGa2yb9eQrdxkY/UHRtmNOTDTEAAZ3OFB3TcjxEuuQTeA1+aFvyEVP
         6L53YabmP7DVcnLEp9E4HHXxzO0APRHZ9PXw5Oq0NiH5axPV1NKRoECb7Br2gtgH0Pm8
         l0lpN+Z5yDwID8JCRuOMlDQiJW8AAmM5kMgSq+7EMzmjKojpL0gsBosT9ls+PMscz4Gl
         reDA==
X-Gm-Message-State: ACgBeo2kwadscNiraicyKWFbkSn9xsraMAa2JG0L6sE+fjv6FNXfEO+p
        ngNz5H4bxYbplou1DQB4ASKIOLRF17Azng==
X-Google-Smtp-Source: AA6agR6Y4DfcP5EX78I9eZCNuPVyyubF6zT3/n42aVyY81UwFMODBRBESkclktOaJJF0wkk5/QE/xA==
X-Received: by 2002:a17:902:ced2:b0:178:3ad0:2672 with SMTP id d18-20020a170902ced200b001783ad02672mr3705806plg.155.1663007125786;
        Mon, 12 Sep 2022 11:25:25 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:25 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 03/23] filemap: Convert __filemap_fdatawait_range() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:04 -0700
Message-Id: <20220912182224.514561-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
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

