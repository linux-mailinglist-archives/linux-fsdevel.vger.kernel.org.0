Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C052465DEB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbjADVPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbjADVPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:14 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7CD1DDD0;
        Wed,  4 Jan 2023 13:15:14 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w3so5568774ply.3;
        Wed, 04 Jan 2023 13:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JTMc/Rft/vIyJlvWKFcn8nkQrf+O33NuNawnN6rRgI=;
        b=nqEuKaTI9dAXbJiKNF6NFVlHonYqdpnzDFZQRbj6c6q33P4q7zmgWoLXJ3cvwJxiFU
         R4EchBW4P9btK5EV2Ivos6RVjg1pCqpX1sdrjygOWSOWvR56x6MAcYlVYqzqYxU9e9pD
         7EqyoRZKmtKUIC4XqucME2BOGZCWoquaRcoAjwG6f440GMABya0GF45MLcEdcWoBQIPQ
         aSrPTzqxY2gV56movVnmY+sLkzpn2sZ/+NfGjAOpD0jKjJOna2t97nyuQoo/S3JNHjEa
         jJZ5wa0Qe7mURn1kHsaymS4r8Y1pr0V1FypBr74zDvcLsepES4cYIoRevgoh6RoBOUZe
         pZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JTMc/Rft/vIyJlvWKFcn8nkQrf+O33NuNawnN6rRgI=;
        b=hrb7oAREyLNFhTSN5b1GgMNCj0kt+b7U5E9iB7w33PzlCZjcEyHHmZ1eCXoryFV6uM
         80gzkASSPLZgkgxsA56SaWtJaJM1Ti2n2q0E3lPRpk00GvBU8CyeZcS0o908fz2hMzoJ
         LQD9ct+9Y/9pGB+yGyvmYOmUdRoHLt2vUP7KUjO0ssbf3g1bRgf7oMNUydR6tMyF2i6W
         83vcxy/qtt9Mh+znEXJl6nQjWr9U6ryqe+beL3c93yKlbQQMvVsmmhFvPXPTHz7gR5gr
         DZxBE9hn+hFQbEPq8zieJQaiWOHsgfRBn5CLzj/o+6LKlzkKKIVvGh2/eEpZh3G5h3Gj
         WKvg==
X-Gm-Message-State: AFqh2kpIHJvxBQN5aFOCLO5rCu0lZPErM64zreh98fCIfox708eSTaOJ
        e03or1fq+GEjaw1vlO34lJ9Lr09uk2t8rg==
X-Google-Smtp-Source: AMrXdXs4LlgTrixclkrOcCZrpN6SR5Ezctmf4LJMRiV2PQ69qXIMCxzU7F8St0tY9EKMLcnxhYsTtw==
X-Received: by 2002:a05:6a20:8e10:b0:a4:a73e:d1e2 with SMTP id y16-20020a056a208e1000b000a4a73ed1e2mr72696381pzj.57.1672866913342;
        Wed, 04 Jan 2023 13:15:13 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:13 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v5 12/23] f2fs: Convert f2fs_flush_inline_data() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:37 -0800
Message-Id: <20230104211448.4804-13-vishal.moola@gmail.com>
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

Convert function to use a folio_batch instead of pagevec. This is in
preparation for the removal of find_get_pages_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3e0362794e27..1c5dc7a3207e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1890,17 +1890,18 @@ static bool flush_dirty_inode(struct page *page)
 void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 {
 	pgoff_t index = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	int nr_folios;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
-	while ((nr_pages = pagevec_lookup_tag(&pvec,
-			NODE_MAPPING(sbi), &index, PAGECACHE_TAG_DIRTY))) {
+	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
+					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+					&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 
 			if (!IS_DNODE(page))
 				continue;
@@ -1927,7 +1928,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 			}
 			unlock_page(page);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.38.1

