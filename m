Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6093038C552
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 12:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhEUK6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 06:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbhEUK6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 06:58:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB36C061574;
        Fri, 21 May 2021 03:56:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so6964396pjb.2;
        Fri, 21 May 2021 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OMj8UtOKZd2HOLgsJ4v7RT7nDBlE06n7wLRp+Jshv9w=;
        b=BgB4kpW5A/BbrQiQVfXgfJTrpLCeXZJPZF/CzwXU203w6je18yLXBPaT3JGzmagOtN
         GoS1c/SuqBFc2MXZELZPK06DXRA3cik8qFBehjGCT3OHVbU/VqR9wAYXlDNcTJgYedBg
         y3y6HmUnp0RuFrnFpQDsbFg8kvbVntYvwtGSqJgHNBRcHMVeVTS5gq6wnyHOMffMGOnx
         MFew+SheuWR5BPQ/8RCgWs1GkGGTlPWX8i3SuvPxTgGcVyIxF31uGu3btU7KjoAX/0yc
         UrQVriS3v7rPp2h+5Ta0xBG9hYIUecqQaHRiDltG9by4lfHNttUug4GY7IlWdrmP+vHA
         hraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OMj8UtOKZd2HOLgsJ4v7RT7nDBlE06n7wLRp+Jshv9w=;
        b=PeMzq1nx0B2dee8HddRknAwLBIBpAOmB8DxfKD4bsLYXAgiaWX7qejrOtgop5tbTpM
         2iJuJvFau+I6smXmw0Wvszv5j4KhktxTmH/P4QH2ux9ori9fmn4bgc+YE6xvW0mMz1j9
         xcm21xb2Lgvaef/F2x8xS21qOwI/smOTKMUvyPBDkyaHymFkqEVeost4So/LwwgwJbJy
         muW5+0Xk8N5cxqZlKDfTxaY6NSkiBfl0irVPm1HEPuZvwtyI5D5G1OgkFltj5xRbxxNA
         /ALDuhxab8dUL1/caMV8SQX8vVRY+ohHAx5WtUC6r2+jZqoy+RSU050cQxCKA/H2p29c
         M0YA==
X-Gm-Message-State: AOAM532YRofdABGUKYntLeK5AhX3keW8/vHti84Sstug5SLH28fkvYHk
        zSEaoAsNjAiUVPdBDdtxTQo=
X-Google-Smtp-Source: ABdhPJzG5m+mqW5TAplKQGYXrKfzeh+aTFi5d3vDnPDZB6b9NzKBhXTuMBU7MazvagTwaQY5e+Y7GQ==
X-Received: by 2002:a17:902:ee54:b029:ef:8497:e097 with SMTP id 20-20020a170902ee54b02900ef8497e097mr11468049plo.22.1621594610712;
        Fri, 21 May 2021 03:56:50 -0700 (PDT)
Received: from localhost.localdomain ([139.167.194.135])
        by smtp.gmail.com with ESMTPSA id c195sm4337309pfb.144.2021.05.21.03.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 03:56:50 -0700 (PDT)
From:   Aviral Gupta <shiv14112001@gmail.com>
To:     viro@zeniv.linux.org.uk, shuah@kernal.org
Cc:     Aviral Gupta <shiv14112001@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] This commit fixes the error generated due to the wrong indentation which does not follow the codding  style norms set by Linux-kernel  and space- bar is used in place of tab to give space which causes a visual error for  some compilers
Date:   Fri, 21 May 2021 16:26:54 +0530
Message-Id: <20210521105654.4046-1-shiv14112001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ERROR: switch and case should be at the same indent
+	switch (whence) {
+		case 1:
[...]
+		case 0:
[...]
+		default:
ERROR: code indent should use tabs where possible
+                              void (*callback)(struct dentry *))$

Signed-off-by: Aviral Gupta <shiv14112001@gmail.com>
---
 fs/libfs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index e9b29c6ffccb..a7a9deec546c 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -138,15 +138,15 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
 {
 	struct dentry *dentry = file->f_path.dentry;
 	switch (whence) {
-		case 1:
-			offset += file->f_pos;
-			fallthrough;
-		case 0:
-			if (offset >= 0)
-				break;
-			fallthrough;
-		default:
-			return -EINVAL;
+	case 1:
+		offset += file->f_pos;
+		fallthrough;
+	case 0:
+		if (offset >= 0)
+			break;
+		fallthrough;
+	default:
+		return -EINVAL;
 	}
 	if (offset != file->f_pos) {
 		struct dentry *cursor = file->private_data;
@@ -266,7 +266,7 @@ static struct dentry *find_next_child(struct dentry *parent, struct dentry *prev
 }
 
 void simple_recursive_removal(struct dentry *dentry,
-                              void (*callback)(struct dentry *))
+				void (*callback)(struct dentry *))
 {
 	struct dentry *this = dget(dentry);
 	while (true) {
-- 
2.25.1

