Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9FC662C3D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 18:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjAIRIK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 12:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbjAIRHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:07:39 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F2C3FA32;
        Mon,  9 Jan 2023 09:06:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m7so8875972wrn.10;
        Mon, 09 Jan 2023 09:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCW9hGwXYkgWMlftGJTpxYD0tpe8j+WfiIQir4l86co=;
        b=H9k0NCEKDeLmIFuil7aYpf60LDUgsnUVBOLLoaNJ21ah+wWWV2hFJVeakPLokoZ5Yx
         m6LIOG6Resh3isUjn1ToryFtTe7VB08C5+rTVU9Fax2p1a0PsEEbI5VX74JzWouTcurK
         TdrrNyMOyZp7VRoIU14Lv3rZvpvceTJrs+Zi3EMhSnnC+rPBdfVA2DnrnnEyhrKJcUze
         w1Fbz6A5u+xzSuop9r2Jt2DfJwSX/2fRurS7PTghwuFY1TW4SsvUUVuHII3B4nhR/Ncp
         BD4dRUjleM8hEQ3FnPSwbrNhaoGUju0gM7I/fYtG6VGPC/YlmLpLnmqH3r0rzF0k6cN4
         ibTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCW9hGwXYkgWMlftGJTpxYD0tpe8j+WfiIQir4l86co=;
        b=Lu9RZ/2KX/9m8UhmROyaM0OmTwSQuMXdCl3sEXa4VQNDYe3vvFqzn/0IOg56+R21Uh
         MFI6tmvkOjFi1s+i6miJxzX3YxTzEyUbxLl2QGaOWXV21/9epcGNCIYPB5wNmrxalklJ
         Z/niwx5pM4ygb4DKwg94X8tp125tt3U1Qr+FpdfuzYdJSeALS38GMQG3em/pXkKULXy1
         rBWl7omk7cvadLWmeMDab7jp0Y+FbQ62ITMpQkzHMOGcpQgsdrqK5DIugDy9PW58uZuR
         eptqyWc00j8Eo+fSktcqQwjrq0p/xsCDTjmnl2AZJud36W4XpBo5TvhGhWTP72S0QEf+
         eRjw==
X-Gm-Message-State: AFqh2kpoyuC/ANg94GsPGP1FvbUSRSsyG+ulTsDeLMWoZVlQU+o+TTxa
        nyCDocCk2WTKM6LXSCMXRZvTdUG9M+c=
X-Google-Smtp-Source: AMrXdXu5BSPvAB5e/ZwoDfluSG7dU+KPKdwuQwSPOAO9sr2BLgggyL5bW6C2rusTF3Fwc7mp2vjhOQ==
X-Received: by 2002:a5d:4402:0:b0:2bb:f46f:c136 with SMTP id z2-20020a5d4402000000b002bbf46fc136mr3283198wrq.23.1673284006435;
        Mon, 09 Jan 2023 09:06:46 -0800 (PST)
Received: from localhost.localdomain (host-79-13-98-249.retail.telecomitalia.it. [79.13.98.249])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d6b8a000000b002425787c5easm8954527wrx.96.2023.01.09.09.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:06:45 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 1/4] fs/sysv: Use the offset_in_page() helper
Date:   Mon,  9 Jan 2023 18:06:36 +0100
Message-Id: <20230109170639.19757-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109170639.19757-1-fmdefrancesco@gmail.com>
References: <20230109170639.19757-1-fmdefrancesco@gmail.com>
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

Use the offset_in_page() helper because it is more suitable than doing
explicit subtractions between pointers to directory entries and kernel
virtual addresses of mapped pages.

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

No changes from v1.

 fs/sysv/dir.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 88e38cd8f5c9..685379bc9d64 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -206,8 +206,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) +
-			(char*)de - (char*)page_address(page);
+	pos = page_offset(page) + offset_in_page(de);
 	lock_page(page);
 	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
 	if (err)
@@ -230,8 +229,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	char *kaddr = (char*)page_address(page);
-	loff_t pos = page_offset(page) + (char *)de - kaddr;
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	int err;
 
 	lock_page(page);
@@ -328,8 +326,7 @@ void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	struct inode *inode)
 {
 	struct inode *dir = page->mapping->host;
-	loff_t pos = page_offset(page) +
-			(char *)de-(char*)page_address(page);
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	int err;
 
 	lock_page(page);
-- 
2.39.0

