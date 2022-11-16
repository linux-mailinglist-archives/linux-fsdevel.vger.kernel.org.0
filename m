Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EC462B11B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 03:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiKPCK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 21:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiKPCKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:10:20 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2042331DCB;
        Tue, 15 Nov 2022 18:10:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id k5so15222053pjo.5;
        Tue, 15 Nov 2022 18:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nup6up+46eyh1lCBQu3VG6VwxyWmfFVyQ2yC43shVo=;
        b=kzTno0E757BuQUewd/lzW9JzWZhTRKoWJpj5TsOZemkW3irgjFx+JTcamrVEFZ+ZuK
         rd94aHMDRRsnMe5IjRTrRR0X2yA4oKZyt8VeJm0zlT3nKQE3H4iVnQ9nwf6cjVbIeRnN
         9aAx+D1+N0y89hD+TmOP1QgFYR1ib5eKb91rk3P4CI2m5AyK49XRDYlA5AZv6+WkkBJ0
         gu7a7WBBV/sVvJ43ubRL7RoJ8O18IT4nq/OSq62+8P+2AfbMzGGbzIWRDOwUmxcM/7kJ
         lr0+qQniPM4W/zw/ITl7D7XfrPmKiYARVg0tRSbciDRzhm5g/69Fs85CE+WQq0kwhja4
         NOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nup6up+46eyh1lCBQu3VG6VwxyWmfFVyQ2yC43shVo=;
        b=Ed44bPwZMGmBYPiQ5i2Zzmy+DCs0XUDqdQYTCML+WT3GN2Q5abso3kxWOC/mWCYkg0
         o7ayfE478rJSfVYraQeyc74YagY3NmmOit/kOZ4Rruuhoys23NVtpsi2qmQPiilJz7eJ
         r0qE5NAu1X182cFD1AI6fgEoOzwDk4lgrYddS0XYM/I7+BQ2z9ZOXa4RETBH99aBasIR
         Zs4dZTPXKRh7rtkI3lPyqSopPjqR48eBgTXkqtDp0y36LG2O4b0NN/T5gAPfSmexEK94
         kGSZ6/UKXbM/nagIurqLjhSoiGSnOll7Bl2o3btcLlhVy8tuL0h3uDEeD/rrQwS3pKaH
         9bMg==
X-Gm-Message-State: ANoB5plBfJ2peSDoHNsm5x1qBKx6DbTkhw0AY7QaZLUNRdgK+OeE1HCn
        BKyVDYxmyyvQCIZqy6mtCtY=
X-Google-Smtp-Source: AA0mqf6hvZars6XBjSem/60Am0lJSYcFCbloSRvfORBFk7lHG1Lk1xaJFIBqtkgbxbOvHTg/8ntrTg==
X-Received: by 2002:a17:90a:b392:b0:212:de1a:355b with SMTP id e18-20020a17090ab39200b00212de1a355bmr1406088pjr.1.1668564619604;
        Tue, 15 Nov 2022 18:10:19 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id e18-20020a17090301d200b0018691ce1696sm10782926plh.131.2022.11.15.18.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:10:19 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/4] memory-failure: Convert truncate_error_page() to use folio
Date:   Tue, 15 Nov 2022 18:10:10 -0800
Message-Id: <20221116021011.54164-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116021011.54164-1-vishal.moola@gmail.com>
References: <20221116021011.54164-1-vishal.moola@gmail.com>
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

Replaces try_to_release_page() with filemap_release_folio(). This change
is in preparation for the removal of the try_to_release_page() wrapper.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/memory-failure.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 145bb561ddb3..92ec9b0e58a3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -827,12 +827,13 @@ static int truncate_error_page(struct page *p, unsigned long pfn,
 	int ret = MF_FAILED;
 
 	if (mapping->a_ops->error_remove_page) {
+		struct folio *folio = page_folio(p);
 		int err = mapping->a_ops->error_remove_page(mapping, p);
 
 		if (err != 0) {
 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
-		} else if (page_has_private(p) &&
-			   !try_to_release_page(p, GFP_NOIO)) {
+		} else if (folio_has_private(folio) &&
+			   !filemap_release_folio(folio, GFP_NOIO)) {
 			pr_info("%#lx: failed to release buffers\n", pfn);
 		} else {
 			ret = MF_RECOVERED;
-- 
2.38.1

