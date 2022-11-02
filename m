Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D7B61680D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiKBQNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiKBQLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:43 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6200C2CC96;
        Wed,  2 Nov 2022 09:11:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id b5so16647484pgb.6;
        Wed, 02 Nov 2022 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZvXQK7eydj6IBrzU3IQ20y8xajH5CKQhE5ttfKWvGg=;
        b=O4nbwv9cmBtSK1CT58yVHNsSMZiY/FKUA/O6oX43Ac0n4IX7vDCV2QLGEuoLXlUkd6
         eHvyReQOL/NVjRshopa6fHkLaexjtpSCxifCTQBr0YR9yB++gFXMjIc34iHceLJdJagf
         WrwXLuWuCgB23v0+FXg91vjEGb1kLv6sB3PxXdVEjMmof4a7ofgr/GbDbkATXjxgH/8d
         +4RfUgwVsqN79UT/+0gaRpPE8h5g92Y8O3mytfBiXv715U8K+NOc/77TCeiz+rmrrP3T
         lHzCxF89bepNGUmoT3nYJomOxqi6w38Xq/9CrZcXJ2HzWpJvvHbi3XeAXF5vgGVoLqbr
         TnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZvXQK7eydj6IBrzU3IQ20y8xajH5CKQhE5ttfKWvGg=;
        b=4BiggV4ZoQnWg0pGFly2PbOPfbjBsxd1ws1TSYhKQcnQACNSTdN4ds+X+N6aGuJA6U
         Lm03Hpwh19b+it0UvBy2PufymZilaR16x5DRrngWoer1r5qlp4QY8axJyqdc/Agznvi7
         uNLB0HUYfTeMUh2glC97e5lruh59AQ0KUIhWtQSMdatDiS5goEYyom935HEKrLBjHGY6
         X9DRh+WNVOBj6/UhaL6cRL9FoNN1utgHem+swO5GIEP4l5k/GFaMdtJC1TEl7In44aWt
         Zn2wi9313nCpWadNL8/M4Wo3xBp4aOwUM+Vp64glr30PCiy3tjuQtVlzn+qnHtm3F+Po
         G+AQ==
X-Gm-Message-State: ACrzQf2DLfNNYVEG4hqYQK6NfQIm71p+gsB/VcFggPIZbIMO9CkPDJVv
        /k5G21Lm/Jva0eDrTLL2NJXTzRpZDMGd9A==
X-Google-Smtp-Source: AMsMyM4Mu8mWuuJ9LsgyTXKiaDYuEixqiDshaCcEnGHSJqDXPNt4rQCX6PHQQ4mtu+d6jEWOcHwjbw==
X-Received: by 2002:a05:6a00:999:b0:56c:3d0d:96fe with SMTP id u25-20020a056a00099900b0056c3d0d96femr26077443pfg.12.1667405489645;
        Wed, 02 Nov 2022 09:11:29 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:29 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 15/23] f2fs: Convert last_fsync_dnode() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:23 -0700
Message-Id: <20221102161031.5820-16-vishal.moola@gmail.com>
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
2.38.1

