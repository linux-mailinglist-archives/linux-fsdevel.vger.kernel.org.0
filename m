Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13EB601A26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiJQU1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJQU1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:27:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609477EFC6;
        Mon, 17 Oct 2022 13:25:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 67so12111271pfz.12;
        Mon, 17 Oct 2022 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQteUz3c9SmxpbrkCwFkAif0aIJ90TCQG7A+tAmDyzA=;
        b=Fjdsm+Pk28Zc97Y3NfxZL728h8TE5RyApTDow3aidnlAK3LTkxWjYLDilgvIsLE/vY
         DG2gnD/1V7xSRF9OsJCuy+QagbO7ftNrkZXcC/buneGyVqq9VL7AeRJOtRVYGhe2g3EB
         a/blG4d7UpkK2Y2MOZagl8fy+aFT9x6oOzcS45P8bK45kIEfwM/C09l7FqmJaWnoZXwX
         gFZ3AcnGYu59H2kxWRp0XYa5xE9P9qVWQYQvuOmeTw7vv99Hq0namT7cuf+rd9Gkq85p
         7ZTnLCbq+RCD+NDxRapqFx6sJOCTXTzxUuQk7bLK0jIgrjjyBfZ8t57LhzVtWkrgsAPJ
         0NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQteUz3c9SmxpbrkCwFkAif0aIJ90TCQG7A+tAmDyzA=;
        b=tYipH4VV39gNPycdmDeXtiw6xB+LC70XFcNGrm+ZqU+zeRrRsGQEivVbXF77iKBfzW
         V/9R/6upuTr0h1TVK2+6l83xwjUUBoOhIkSxAbKZmXQud+8iOOgC+DrVBP9SFL6RKpLf
         QoOfFLQ0INd8cXeoe2O7RK/liZ/YB+UyVJzCkW/IMFQ1J2p6Yy/JeWkZGEQEUsyJDM7w
         j1RqDlgelxEuwqgxHNxujrioXqksNaU/DAMEC1JK3YWFpM1x32TG/LDTLWMQoQ/9tgWi
         SaUrUP+Yw+tCc49zgvrLQVGjo1eaaCBlU3MTvENyLE43AJrA7jHE/2EZV3k90/TIbH0J
         HsWA==
X-Gm-Message-State: ACrzQf0bzQk1Syu5PzlKPz7jFUwJ3Sny/ip1rBOIQK61Q7cMCWBvEdOd
        c0PBlFJJg14sdCcRxnwFpmUX379gjem+/Q==
X-Google-Smtp-Source: AMsMyM7GsVccXFW8FJ9vOs/U7xJaHdzejE7eEDTC6PUn9s2c9m9uJgd4Zj+a2O6Gv65QrZVSHiZncQ==
X-Received: by 2002:aa7:8a15:0:b0:566:1817:6fcf with SMTP id m21-20020aa78a15000000b0056618176fcfmr14383803pfa.85.1666038313899;
        Mon, 17 Oct 2022 13:25:13 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:25:13 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v3 20/23] nilfs2: Convert nilfs_btree_lookup_dirty_buffers() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:48 -0700
Message-Id: <20221017202451.4951-21-vishal.moola@gmail.com>
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

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index b9d15c3df3cc..da6a19eede9a 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -2141,7 +2141,7 @@ static void nilfs_btree_lookup_dirty_buffers(struct nilfs_bmap *btree,
 	struct inode *btnc_inode = NILFS_BMAP_I(btree)->i_assoc_inode;
 	struct address_space *btcache = btnc_inode->i_mapping;
 	struct list_head lists[NILFS_BTREE_LEVEL_MAX];
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct buffer_head *bh, *head;
 	pgoff_t index = 0;
 	int level, i;
@@ -2151,19 +2151,19 @@ static void nilfs_btree_lookup_dirty_buffers(struct nilfs_bmap *btree,
 	     level++)
 		INIT_LIST_HEAD(&lists[level]);
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
-	while (pagevec_lookup_tag(&pvec, btcache, &index,
-					PAGECACHE_TAG_DIRTY)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			bh = head = page_buffers(pvec.pages[i]);
+	while (filemap_get_folios_tag(btcache, &index, (pgoff_t)-1,
+				PAGECACHE_TAG_DIRTY, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			bh = head = folio_buffers(fbatch.folios[i]);
 			do {
 				if (buffer_dirty(bh))
 					nilfs_btree_add_dirty_buffer(btree,
 								     lists, bh);
 			} while ((bh = bh->b_this_page) != head);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
-- 
2.36.1

