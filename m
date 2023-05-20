Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A4570A621
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 09:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjETHXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 03:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjETHXQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 03:23:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC01E0
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 00:23:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-64d24136663so1824646b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 00:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684567394; x=1687159394;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4EggHVDu8pVZBSkU2cuF+QmgXmVc/tyGwSyKxqOmF0=;
        b=Tlpqkalqv+9t/YZnlktLCBPW6f2vJXXATP2Eh12ektOn5Zx1Y/1ycDA3WGLiBM8ECQ
         O8pUtnVMMRjTb+To7uOOGSVJ4P5V4yd6+WyvjsJlYBNnk95pt9+4Hlwp7X1BkDIUbDoL
         R6ro0LpEzCoXXstYnsVGCdvcJLsfNqY/oMfJUugVezryeR3+pmU22/cUTsFPHci9nybW
         G7/8GeQRj4MWyd49vQMp1OpfxPpFRAaNvdUP2nSOoMfMu8Mcm/pPM9t2TdJnvKv7ywVV
         5rwfbgshH67w6tCI7O6DEIUgBuKJHYwe3c1XiwVec7l+88/Pxr9X1WycoMOUxedYYYxl
         I05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684567394; x=1687159394;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4EggHVDu8pVZBSkU2cuF+QmgXmVc/tyGwSyKxqOmF0=;
        b=D4w8PzYlJdMLt+FTyTD+JwlKKBOCSJh2Ax09ylCdTX60wyp/UtLV5BPbO8jzYKXV+d
         O0sDl6BN30etZI3sYWv0QmzqFQtjYgxVq1JNiMkt7ZI842r5OTIvnsJ0m0n2DHrX8rzB
         /w3n6SrENQFLYmlwVBB6W4MNtbcI1aKCqXPHKgT/BR6rIYvBw2mgDnzqwqY2nupBsmg5
         5zLISbsAh+DH9Y3AFC9deKg3YpY27DF0ddyvHjvqXIvFlGC3B7gysASzesdCiR+6wVkM
         y9tXKeg0prs67/PUMe0JhGgeuJntAU4RehPaH7u13JpsMagwAR+pl8amz+WG4xiBNnQj
         GTnw==
X-Gm-Message-State: AC+VfDz6decEZiSc6Kbh8r1wOIZIQOaOzgO52fxeESPd66BBX+ujBXXL
        m/foqq0APFbsFokpT9UhS7qNJkmKKBJQTLUTDUDQhA==
X-Google-Smtp-Source: ACHHUZ6vAU71rm86sOm7Q9g/rtkfHIEnIBvBg0YSD8tJ9MhnpdnU4JABvCYBCbdk33yX52poIrWDwg==
X-Received: by 2002:a05:6a00:10c5:b0:643:440b:1af5 with SMTP id d5-20020a056a0010c500b00643440b1af5mr6526476pfu.16.1684567394516;
        Sat, 20 May 2023 00:23:14 -0700 (PDT)
Received: from xun (139-162-66-236.ip.linodeusercontent.com. [139.162.66.236])
        by smtp.gmail.com with ESMTPSA id c5-20020a63da05000000b00528b78ddbcesm819258pgh.70.2023.05.20.00.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 00:23:14 -0700 (PDT)
Date:   Sat, 20 May 2023 15:23:32 +0800
From:   Yihuan Pan <xun794@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     vgoyal@redhat.com, hch@lst.de
Subject: [PATCH] init: remove unused names parameter in split_fs_names()
Message-ID: <4lsiigvaw4lxcs37rlhgepv77xyxym6krkqcpc3xfncnswok3y@b67z3b44orar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The split_fs_names() function takes a names parameter, but the function actually uses the root_fs_names global variable instead. This names parameter is not used in the function, so it can be safely removed.

This change does not affect the functionality of split_fs_names() or any other part of the kernel.

Signed-off-by: Yihuan Pan <xun794@gmail.com>
---
 init/do_mounts.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 811e94daf0a8..d67efddf8597 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -338,7 +338,7 @@ __setup("rootfstype=", fs_names_setup);
 __setup("rootdelay=", root_delay_setup);
 
 /* This can return zero length strings. Caller should check */
-static int __init split_fs_names(char *page, size_t size, char *names)
+static int __init split_fs_names(char *page, size_t size)
 {
 	int count = 1;
 	char *p = page;
@@ -402,7 +402,7 @@ void __init mount_block_root(char *name, int flags)
 	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
 		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
 	if (root_fs_names)
-		num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
+		num_fs = split_fs_names(fs_names, PAGE_SIZE);
 	else
 		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
 retry:
@@ -545,7 +545,7 @@ static int __init mount_nodev_root(void)
 	fs_names = (void *)__get_free_page(GFP_KERNEL);
 	if (!fs_names)
 		return -EINVAL;
-	num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
+	num_fs = split_fs_names(fs_names, PAGE_SIZE);
 
 	for (i = 0, fstype = fs_names; i < num_fs;
 	     i++, fstype += strlen(fstype) + 1) {
-- 
2.40.1

