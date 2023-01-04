Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A4B65DE80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbjADVPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbjADVPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:08 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BADB1CFEA;
        Wed,  4 Jan 2023 13:15:07 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p24so14704376plw.11;
        Wed, 04 Jan 2023 13:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpQ0T1hY90TiWrye/zwz8Fk0gosiIhGGJdVRGuIm1GI=;
        b=E+BBLApy3NOf4wopcmgQT3kNLqU1Hr79oQuMl3hR4qfUlPWmBHbnGAZdWjmWQ2sPqR
         KD3vqU0o08iqRQDMZ+Dx71Uxb6FKKwlTAVnatYSqFEFo2ql7zVbgfTN0jI5SnejCghpW
         Yp2dxAkOFXpIR/EP01TN2Qi1KZfVkx0gCM6uZyj6KEkdh1uwBHmlMJb1jYaj5mpjWFdJ
         YKq6x1i+oKVpuPiMkiFj7F6T2fVMDzxqmVK0DBQsS4p2ok35IbL+fj4QgWC5A6B2GSq/
         rquvFqryD//D0fhKfDeCa0GAp4a8mm3vC0NMLAwoabxYnh/OEdzg2OeVrhSmFb39plUP
         r7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpQ0T1hY90TiWrye/zwz8Fk0gosiIhGGJdVRGuIm1GI=;
        b=t7nILX2p8l6bVXm78dUNOvxGfqv1wPWPTXBT/Exrk0PBWriQQUqlhnUzmKzaD7xlPm
         S2ybHIAnCKE+wNJkjtYTJji4k55bqMR/WKstT0L/y6S21ObgnBp1Xhe0QDDHXGXBYbT2
         ee8BF2484E3IiLsORP0kuCP/zC/ra0bggwcHQJHq0wO7HxuzYuVIrFmiPyDlNmKbFObX
         qCBHqT4ObvB8SW/xvc0+Zx4H4O6is2rpYrbNE6V3IZShGmebrzCAq4vqeeyya7gvDBc0
         /mNlEpcYY7+nfdbble5wFuNp/fqtT9EvMF/5F1Wn1ZkDvAGR5DypVrrYhkJIQOd+RIR8
         ZTfw==
X-Gm-Message-State: AFqh2kpgyikS2s0flLIMmjvtpwp5o8kzk6HFmIyMjBgat2kzm/zBLdC/
        Trm+p7I31z5CuaTVb2TMe+M1MlWAlM+Zog==
X-Google-Smtp-Source: AMrXdXvMceiLQv8Bi2VTCFImf53/8/DB9Gj8r1k+O8qLsqokGEHS38Bc3wLTcycpGKeKQBiAhwaRsQ==
X-Received: by 2002:a17:90a:fb87:b0:225:d81f:d463 with SMTP id cp7-20020a17090afb8700b00225d81fd463mr43386479pjb.26.1672866906363;
        Wed, 04 Jan 2023 13:15:06 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:06 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v5 07/23] btrfs: Convert extent_write_cache_pages() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:32 -0800
Message-Id: <20230104211448.4804-8-vishal.moola@gmail.com>
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
the removal of find_get_pages_range_tag(). Now also supports large
folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 64fbafc70822..a214b98c52fe 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2973,8 +2973,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	unsigned int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
@@ -2994,7 +2994,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 	if (!igrab(inode))
 		return 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
 		end = -1;
@@ -3032,14 +3032,14 @@ static int extent_write_cache_pages(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, index, end);
 	done_index = index;
 	while (!done && !nr_to_write_done && (index <= end) &&
-			(nr_pages = pagevec_lookup_range_tag(&pvec, mapping,
-						&index, end, tag))) {
+			(nr_folios = filemap_get_folios_tag(mapping, &index,
+							end, tag, &fbatch))) {
 		unsigned i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			done_index = page->index + 1;
+			done_index = folio->index + folio_nr_pages(folio);
 			/*
 			 * At this point we hold neither the i_pages lock nor
 			 * the page lock: the page may be truncated or
@@ -3047,29 +3047,29 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			 * or even swizzled back from swapper_space to
 			 * tmpfs file mapping
 			 */
-			if (!trylock_page(page)) {
+			if (!folio_trylock(folio)) {
 				submit_write_bio(bio_ctrl, 0);
-				lock_page(page);
+				folio_lock(folio);
 			}
 
-			if (unlikely(page->mapping != mapping)) {
-				unlock_page(page);
+			if (unlikely(folio->mapping != mapping)) {
+				folio_unlock(folio);
 				continue;
 			}
 
 			if (wbc->sync_mode != WB_SYNC_NONE) {
-				if (PageWriteback(page))
+				if (folio_test_writeback(folio))
 					submit_write_bio(bio_ctrl, 0);
-				wait_on_page_writeback(page);
+				folio_wait_writeback(folio);
 			}
 
-			if (PageWriteback(page) ||
-			    !clear_page_dirty_for_io(page)) {
-				unlock_page(page);
+			if (folio_test_writeback(folio) ||
+			    !folio_clear_dirty_for_io(folio)) {
+				folio_unlock(folio);
 				continue;
 			}
 
-			ret = __extent_writepage(page, wbc, bio_ctrl);
+			ret = __extent_writepage(&folio->page, wbc, bio_ctrl);
 			if (ret < 0) {
 				done = 1;
 				break;
@@ -3082,7 +3082,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
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

