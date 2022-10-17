Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABB16019E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiJQU3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiJQU06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:26:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011467E80C;
        Mon, 17 Oct 2022 13:25:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so15316905pjq.3;
        Mon, 17 Oct 2022 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPyaEfnfsN/s28KIqk5JK9av//7f4plsWX6QMWBWYvw=;
        b=AAaBUf6AYZwl2VDHcCjIUHoo+BDNMPnV+R8K7xw03ITt3bJu/PXwBptMp+Cd78GqHp
         N1fPmeaEcgT0dNOi5heH8RkIvQzLgdDjFTLLFkJTMuZtMzDzhqm3A5e2TUW+009WVhvP
         LnQ+Qnxue4GNQ/W4GSqfITdI/xtl/FcZVOsSAxzDrhPsnLCBNI0Pam1Vx851IlCokycW
         3ihi+TyICcYVO2geBMteJjeyBoyopJkqhfYcH/Zh5WCo+KIFfIyQ0WkYt52MgC2bUa65
         R8/gksQ//p7O7voqbBaQcC5j/XMc08BKModktLu/0bF2tT6gRFEgGcvAeXRPf7IXx8T9
         8+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPyaEfnfsN/s28KIqk5JK9av//7f4plsWX6QMWBWYvw=;
        b=K3y+vz/l6cbKQZH0UzfP5sO9SBtBV3lMKDyNWS7HqJ7LlyDd2aQ28wm2an+T+Gppcs
         pDN6ji5qucv9gQMRdrZRYPqAW/NECZt58Rdn75RsL1IqiGE5oBuEZW/Y/sYXahHqhxyo
         Fg0TkB67eJ4XvuZPqC97zjEezoRVAJkbjeB6uneGeY3OCYnCOb3diWBUkM7EZzv3JPfT
         p+jfuo8z0F8fau22VenNXGrQSCOpAMHAnyJH6yePaCXDGqvucDrR9FloZ2Fmh5zObwOz
         +cuTEswL+Ip488HgT7kpTFx4isssijH0vQPjYaRWtDUgJ6TlTffK3dKfqr+HR6wYwd6d
         SP7Q==
X-Gm-Message-State: ACrzQf0aebnu0k+J/SH1P2HTE2qIB/UcID/XAIEX47mH3lyKmY0KReS6
        81xKvEbRqcjF2XY7PEjLKBrY7kF0NF+qQA==
X-Google-Smtp-Source: AMsMyM7v1A0Nwi1EfmmDwlAxUHQ5Y+/Mfh5CmuQv94z7lhNxS6TEescrW3W2GC19QPdRPdkxp8Fsag==
X-Received: by 2002:a17:90a:4216:b0:20d:2891:157 with SMTP id o22-20020a17090a421600b0020d28910157mr35557408pjg.47.1666038307198;
        Mon, 17 Oct 2022 13:25:07 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:25:06 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 13/23] f2fs: Convert f2fs_sync_node_pages() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:41 -0700
Message-Id: <20221017202451.4951-14-vishal.moola@gmail.com>
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

Convert function to use a folio_batch instead of pagevec. This is in
preparation for the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
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
2.36.1

