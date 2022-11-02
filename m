Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED56D6167BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiKBQMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiKBQLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE0D2CCB4;
        Wed,  2 Nov 2022 09:11:27 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id b62so6262383pgc.0;
        Wed, 02 Nov 2022 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlCTXZScWdlX0aVFB5ZBh3WOEeZ8Gy5thYVDo4sECVo=;
        b=Poe9rdZUsWmbLff7Q1y+73uQ67NvWbfBoZzK/+dTQlX7qeN0LjEz/N/rBuja3dj4uQ
         V58XNqhmnAdXT/u5YYVAqWdQcM7IpZGzdPiS7WJ/SuI2UpsvG2jJQJ+QAjUVQ7//El8f
         fQS1kK8H9mty21sekVYBC67x1RIEUTD3q3zpcHhzYIZ7P8X4Gbv+aZIdKeXKk4H9Em2r
         Lzi0RsgndfKDM+rr+KiKcBf1rF+xpOLsZp5o+CS+hW7qQC1gAlW/yAz9e7GEL5+HY1Ox
         2g2BT9bK3F21AxzoWn7zFoPz5OORdwHo0wvIqeyqfrg05E/t6JECV9fE6vKrC2SiNIWT
         MocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlCTXZScWdlX0aVFB5ZBh3WOEeZ8Gy5thYVDo4sECVo=;
        b=v3M9PSO+Ge6tlLgNG+JUQotDSO/41N25NkSrpbBHxGYZeSMjaJNGFdXfNq7OzWi6YW
         U5H1/qS3FXstmZhXl974kGMGlJhtXLcZtePo5Nah6qPaj9qP7+4VM2DcZW+xJAgNzn5P
         6n8PTgao1xwWwMyr1Ibu0hExgKdFjG5M49RzgWyPnBdKjw7A9oxQwRXqRo4OFclOunMd
         2+CW2gTBv4GnzGYJObgb0UFh4D+92ZaM+o935LVCiGB2IsT/Hdb5UY17zZRH7uweHWHW
         osM5DXMmhv9e61SddtPPf3Y3jaKXSYeNoU8ZJ4z1v27gueCc+VtC9fyz3DeckgJLLywk
         sLog==
X-Gm-Message-State: ACrzQf0NhQa4CUXB5ElcgmUNfJBPT4TRruMM9YovjZDx8NHD8k6nRQNU
        IgwcTZxlIADkYMD8sFldhEwEjQCQr5ovog==
X-Google-Smtp-Source: AMsMyM7qibMFP4MyzDtzWi/W3QQD3NnJO1ppwFeeVWeabtq6FG43QL7qxxbpoZrNHocmvogYaW3TuQ==
X-Received: by 2002:a05:6a00:b47:b0:56d:5266:464c with SMTP id p7-20020a056a000b4700b0056d5266464cmr18973688pfo.2.1667405486894;
        Wed, 02 Nov 2022 09:11:26 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:26 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v4 13/23] f2fs: Convert f2fs_sync_node_pages() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:21 -0700
Message-Id: <20221102161031.5820-14-vishal.moola@gmail.com>
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
 fs/f2fs/node.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a2f477cc48c7..38f32b4d61dc 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1935,23 +1935,24 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 				bool do_balance, enum iostat_type io_type)
 {
 	pgoff_t index;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	int step = 0;
 	int nwritten = 0;
 	int ret = 0;
-	int nr_pages, done = 0;
+	int nr_folios, done = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
 next_step:
 	index = 0;
 
-	while (!done && (nr_pages = pagevec_lookup_tag(&pvec,
-			NODE_MAPPING(sbi), &index, PAGECACHE_TAG_DIRTY))) {
+	while (!done && (nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi),
+				&index, (pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+				&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 			bool submitted = false;
 
 			/* give a priority to WB_SYNC threads */
@@ -2026,7 +2027,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			if (--wbc->nr_to_write == 0)
 				break;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 
 		if (wbc->nr_to_write == 0) {
-- 
2.38.1

