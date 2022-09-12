Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F715B60A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiILS2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiILS00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:26:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8394842AEF;
        Mon, 12 Sep 2022 11:25:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u132so9429395pfc.6;
        Mon, 12 Sep 2022 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pWqS4ooFUTFHzhqRBDvFvbwutPU6GCzkgDePLKh0xDE=;
        b=AYWIcUZ91sylesOSzRGl2hKsZM7DiQkiDsyS+9s5+LA+MPta/U3ymY0YWDkPHY9oab
         TuySg+H6RXpkOErLu2PR++mbeOfkgTYRUYqEVnrjpRv+UPKnC3/D3FOtp4XhZFrfgO7X
         86LOFTVnc1CRsA3Yc1TcR//CirAhQzUigoEM9VJBDrwvXswZrs4O2QwJLmXpBw3aaxKC
         O4U1D5hP5xt3/7bU1KCBkhDP79kXcAHKiy2/l4pAA+Zq0gboMPZStEpJ422HzaC98JBQ
         +qawMpBKfA4hSwv0L3tMjDudqnDhF82hZqBXTqC2jkUV1wm/OoqfuvtRTsjq9MsLcqSC
         QclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pWqS4ooFUTFHzhqRBDvFvbwutPU6GCzkgDePLKh0xDE=;
        b=XCtftuAdXiJaRR0P/eQAqdxER+clJFeFxrztxnPX/78Jpg/U95O411ZisirDuwCF/y
         o3t2MLuzcyfjaCpN/d2UciQpht87Y6Uo82wLfiBoYvuYRzRNSBe2KMVMDnJd36Hw6mT2
         69zvamANKT2P7fzgvoweoHH6N9n33J6mS4OPJXoelz0M0POc8jNZUVeMXVOEjFQhFTpe
         /gOA39+5OQhO+1Y6TnOWOaupwJghdmPXURXG0J3Pmws6S0pzeXbmFrUHOoGks1noTSuf
         p8dUwoyNR9cXTIexgmMePvdDhweiLERhUQnYhFUr0KZaGTGNruwHGR9X1sLelQcvFdHy
         YAMQ==
X-Gm-Message-State: ACgBeo2xF59Cs3UuUIdWghpLeCUeogyeo97VZz/dhqFaM4GhZG2+DMPO
        YDMDnNI+HueVu9TnOQ0JBvyIfUSM2JHQiA==
X-Google-Smtp-Source: AA6agR7iHaf9tD1IZum1dK00J/tGnrsDCLmrUllmORyGa507ezKYi/IXYce1EbiFNnQXHzaZYOyPmg==
X-Received: by 2002:a05:6a00:1ac7:b0:537:4186:c106 with SMTP id f7-20020a056a001ac700b005374186c106mr28997861pfv.76.1663007142969;
        Mon, 12 Sep 2022 11:25:42 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:42 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 13/23] f2fs: Convert f2fs_sync_node_pages() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:14 -0700
Message-Id: <20220912182224.514561-14-vishal.moola@gmail.com>
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

Convert function to use folios. This is in preparation for the removal
of find_get_pages_range_tag(). Does NOT support large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c2b54c58392a..cf8665f04c0d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1933,23 +1933,24 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
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
@@ -2024,7 +2025,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			if (--wbc->nr_to_write == 0)
 				break;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 
 		if (wbc->nr_to_write == 0) {
-- 
2.36.1

