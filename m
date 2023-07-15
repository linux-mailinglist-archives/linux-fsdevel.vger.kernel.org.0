Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF04C754777
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jul 2023 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjGOIWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 04:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGOIWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 04:22:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A71E10EA;
        Sat, 15 Jul 2023 01:22:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55bac17b442so2062503a12.3;
        Sat, 15 Jul 2023 01:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689409338; x=1692001338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=duMfgCIVZguOpNbI5H3U3sRMxh3NajpqrJJgjIxlh80=;
        b=MZ8j0ij93zXF3W3UTnAe6nnwk+9oqv2cx/rm/8NLStnAIIy8kGlVamIFOfnOBlDtb7
         jCn7hkrd2E980AZmssVFqht/5vjsLe7X2iJ437H1qc6Ad66xhdhEK4seZ3c6T5p8ISVh
         Kow3tZc4QcbZ6jc/qtyT6+O0HWzZaZhGSxIi5pFPJjLy50ujTUcNSJ/PRhl4kTVTYaeD
         VOak0N6SWDXhH55/5R4C7Xl9ngc+jtVFH4+Wn1uS3G+9H6FU+e3gtUGTiPnHjQYOy29C
         eEknovIyqAyzExCUd8oAK3UzbSBi9LAdLFz1z6PCg+ll/P8kubSdSTCorDMarCPY0OJ0
         cb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689409338; x=1692001338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duMfgCIVZguOpNbI5H3U3sRMxh3NajpqrJJgjIxlh80=;
        b=eCXI/Da4n1AdEp9HqGFrt1GbjUvrFBj9r5hYgRZyh221g1UwNieXtXVVOxbEGgrYgG
         L4k8XpO1jTboG+kbQb7wka5ViWqbewjHcyrkgPC0f335EUn9QIed5bhhRoUEASgdyc+0
         w/kJS4rDcyD+GbiIJLNhNArhtJGi4JbCSFp27N/8ty3qUaDz2Nl3E5JsWr60ITCJZlvK
         fHi35Rp4nROjNf0QyvSs23ZKZpM+1jhUGuWnbVMUrR6pWQJ51fpvu9E3TIfkMtDyVND6
         qN8fw2wFpIqQONEb5qZr70h1f7ivjV4N4U7eVsDvFIbNQVQm4tqi2nW9OSNDOTzEZuGx
         4UmQ==
X-Gm-Message-State: ABy/qLafNyip5AYTdL3BL3jpAie/EGoHCXVd9Ztr4WiZ2Sb4UFkoeJvn
        cz4wI5e2xTDmx0BBZESDSQtT/UQYSdZoiA==
X-Google-Smtp-Source: APBJJlEID4EUVjQa2syhpieWlxFb1XXFjXlLSZXWJiHFaWlbyo8z4NV2OMt3JmGXod9ZXjiyrlB8Dg==
X-Received: by 2002:a17:90a:4592:b0:256:2efc:270e with SMTP id v18-20020a17090a459200b002562efc270emr6451406pjg.5.1689409338527;
        Sat, 15 Jul 2023 01:22:18 -0700 (PDT)
Received: from sandbox.. ([115.178.65.130])
        by smtp.googlemail.com with ESMTPSA id e28-20020a63371c000000b0051b7d83ff22sm8743483pga.80.2023.07.15.01.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 01:22:18 -0700 (PDT)
Sender: Leesoo Ahn <yisooan.dev@gmail.com>
From:   Leesoo Ahn <lsahn@ooseel.net>
X-Google-Original-From: Leesoo Ahn <lsahn@wewakecorp.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leesoo Ahn <lsahn@wewakecorp.com>
Subject: [PATCH v2] fs: inode: return proper error code in bmap()
Date:   Sat, 15 Jul 2023 17:22:04 +0900
Message-Id: <20230715082204.1598206-1-lsahn@wewakecorp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Return -EOPNOTSUPP instead of -EINVAL which has the meaning of
the argument is an inappropriate value. The current error code doesn't
make sense to represent that a file system doesn't support bmap operation.

Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
---
Changes since v1:
- Modify the comments of bmap()
- Modify subject and description requested by Markus Elfring
https://lore.kernel.org/lkml/20230715060217.1469690-1-lsahn@wewakecorp.com/

 fs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 8fefb69e1f84..697c51ed226a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1831,13 +1831,13 @@ EXPORT_SYMBOL(iput);
  *	4 in ``*block``, with disk block relative to the disk start that holds that
  *	block of the file.
  *
- *	Returns -EINVAL in case of error, 0 otherwise. If mapping falls into a
+ *	Returns -EOPNOTSUPP in case of error, 0 otherwise. If mapping falls into a
  *	hole, returns 0 and ``*block`` is also set to 0.
  */
 int bmap(struct inode *inode, sector_t *block)
 {
 	if (!inode->i_mapping->a_ops->bmap)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	*block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
 	return 0;
-- 
2.34.1

