Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C16019D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiJQU1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJQU0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:26:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F041C7E011;
        Mon, 17 Oct 2022 13:25:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f140so12143506pfa.1;
        Mon, 17 Oct 2022 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZRdB+dZmNtA32T+cQHDMYonPyYz7jjivtFD0eVIJJw=;
        b=EMG8zUe6nj+OzUpxpcc6vz9egeLlNxWJFwjbuAX7cIf8UVozlJc16RJgVW6MmHr8wj
         lAYPDYX2mCzW8yaHilBBcng/MkEd3zQadtzIm4aJed/L2hmaKukav+bbHe5lJaIq8Cmg
         0jCDF+tjRM5z3mhRWX4Pz9YQeJePTcm5XXkFfwT7bZ3hhjUxBBExa8JfvRa7z2z1eEE8
         aa1Z+xdo2jBQyaNl3srNu1X1eXAZfvMUHpUQQgygrIgkLcMnTlgBOGGoIPFtqd0FKlwi
         hsEHCzW24ByTmgfjer1ioe0J81eAgCS681a1EYbjZkADJzINZruwqE0d8CSsY1eGT4Gg
         1ZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZRdB+dZmNtA32T+cQHDMYonPyYz7jjivtFD0eVIJJw=;
        b=Whr4RL1dJApmuUnA2alXFEqKwHjQdyLfvvXwAWNMjD684qJOLnY/l9WtCEb9xT0FIv
         IiavW/wCkPATtR4cX7GhTuLzP6HTFeyX82LZhiKlvrlGvMQ45/vuKWFK9+yVbvV+hYnK
         iGgTisAVo6KEEIAYUwrLjXpr8TPJh7jYzka1tYuOg9EUp20EVxS3NrfwnEWhUpMiddQ1
         f+GTcwx52S32ib5cd+u+VIKNZdOUqWjMqv7ylcCf6wMlhodVYWh14wKqkG9MGnIASvhp
         a4nnqHdvxuqheWs7SH2QECraWaFY/3XMiP6fJFmgEGznFKD2IErwwT/Sl/GrUQK0NzUl
         NKvw==
X-Gm-Message-State: ACrzQf09RdUktVHNm6HV9jQuo873sh758LOZwzaSdihDPPsHkPLABtii
        70h1GWjx9KWtpEbEMu0c4P52mln8QPNP9w==
X-Google-Smtp-Source: AMsMyM6SRYuRbUVytvSXfXMHwh3CkrlxOqmICFrlZTvzhTPoi0L+HxeakG4SqBFzDLfSjWciJ+CMBg==
X-Received: by 2002:a05:6a00:c86:b0:563:b89c:3d0b with SMTP id a6-20020a056a000c8600b00563b89c3d0bmr14629107pfv.50.1666038297319;
        Mon, 17 Oct 2022 13:24:57 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:24:57 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 03/23] filemap: Convert __filemap_fdatawait_range() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:31 -0700
Message-Id: <20221017202451.4951-4-vishal.moola@gmail.com>
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

Converted function to use folios. This is in preparation for the removal
of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/filemap.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index aa6e90ab0551..d78d62a7e44a 100644
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

