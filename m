Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99186616804
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiKBQMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiKBQLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FAD2CDD7;
        Wed,  2 Nov 2022 09:11:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l6so16727947pjj.0;
        Wed, 02 Nov 2022 09:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu3slT1mXNSkpn8qwZYtvOZ6o4Mg9MvjQ46v3hYxERk=;
        b=PjiE5RDJ/IhYcpSdkRRACJ+kB6nieGFRihYA8FJAb8afHr//PYuLhKMedJ3nWsns4m
         WHHZ7o+B5kW/fEmrnRCfh1hKfAzAMYSiot+Tf/JsHplhr3y+1cIneR2pnNTm0Xu0G5/m
         eXGrJg3NPWw15lzsyaW8TPQOvC7voLcYyraNuBkGyVFr9BgKbhi8dJn3bhWNj61g20i8
         HxoYlQ9BOFdM1wk4SoRmch2ZbfqT7e1EAK8uxuBGxdgsBMcHv1a+OFX50FwbjOGyxYjS
         TKmeuA3P8SPD1RJ2IqePqBoSh63VQ7QpSMtxtOjPS+T3FcYMe+l8npdlhpiu0xfcFt+6
         AsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xu3slT1mXNSkpn8qwZYtvOZ6o4Mg9MvjQ46v3hYxERk=;
        b=rKBTf7MVM1O3Bb1OklQ3Px646GqxBo0IZtCD+dMBxqvZcyNcIUDUIM5Y2Rio+y6oEb
         DFeqpAC2dttU+GRn+4KfZ34/YT17SGAD9li239PHL+t29RP0AtZGTDBonDUJdEJ7z+TJ
         p7a5xGDpb9HRdFEDeJwPbEzlXoS9vnYqNGp2RtYlAfk3lsxu6TIydf6SV56rlZVOCplT
         BdYv5SHEjF8bmoosxTrO+8RhNKzusQa7dptC5CV3OZSE5u7pYZcHlmaBFSYJY0eUxliZ
         gO7RkgyWy1bKNCu1UZY0pKiJN9LtZbjbJQ7jmYU857jiJlo2ZpRCjghkDe5E/BBexbI0
         9nHg==
X-Gm-Message-State: ACrzQf2YwgiclNPsXIe9Ak+cHkJlNMXF5zvPQT9aEGJh6AhWLPWwyMlF
        rIHfPRWKByLrDp6S9w1l2cx41ctKyLZPZA==
X-Google-Smtp-Source: AMsMyM4/rTjRmXiZvaL0/UA6LSo69655Cl1G+qIeDGgAuEAjZIffsRS5BQYkpUCsHm79cx4g/ZmawQ==
X-Received: by 2002:a17:90a:c918:b0:213:f5ea:5a60 with SMTP id v24-20020a17090ac91800b00213f5ea5a60mr14026872pjt.167.1667405483870;
        Wed, 02 Nov 2022 09:11:23 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:23 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v4 11/23] f2fs: Convert f2fs_fsync_node_pages() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:19 -0700
Message-Id: <20221102161031.5820-12-vishal.moola@gmail.com>
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

Convert function to use a folio_batch instead of pagevec. This is in
preparation for the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 983572f23896..e8b72336c096 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1728,12 +1728,12 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			unsigned int *seq_id)
 {
 	pgoff_t index;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	int ret = 0;
 	struct page *last_page = NULL;
 	bool marked = false;
 	nid_t ino = inode->i_ino;
-	int nr_pages;
+	int nr_folios;
 	int nwritten = 0;
 
 	if (atomic) {
@@ -1742,20 +1742,21 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			return PTR_ERR_OR_ZERO(last_page);
 	}
 retry:
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
 			bool submitted = false;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				f2fs_put_page(last_page, 0);
-				pagevec_release(&pvec);
+				folio_batch_release(&fbatch);
 				ret = -EIO;
 				goto out;
 			}
@@ -1821,7 +1822,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				break;
 			}
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 
 		if (ret || marked)
-- 
2.38.1

