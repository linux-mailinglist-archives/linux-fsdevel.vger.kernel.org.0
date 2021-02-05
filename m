Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30D2310465
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 06:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhBEFPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 00:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhBEFPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:15:19 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C072C06178A;
        Thu,  4 Feb 2021 21:14:39 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id j2so3755577pgl.0;
        Thu, 04 Feb 2021 21:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qwtW+zJmX+si2a8vH28TCkyuUby91Li7mYwYtPsgc4=;
        b=mTR8YxzMrHIS55DNb5QUvLAPMxafVZtl7Z4cXx2vOs4BcCME7ceqnF+INm8UrSmfLf
         yDEyThhQ6gTQ5lsx6MbxHkRZVt75OtFHrgcwqJ7OP1B/qsf/DQmSDXwkRHzM61QYLIrQ
         iK3ziY/GfFVsq1pg5FeE+ePGhhCA8fDhSizv6N4rmU9QLWRuEzQTEw4BaF+tHZCpp/HE
         YF2kO3KVvrpRMSNvxodW1xzOQzZ06R7bMUJdtHP5wUs6yYIf8l+Qg6diorehZ/7drK62
         dASWuSVpvgxpBL1TQWTvJ55EXRmHevy4SsgwM4dSUoiuazrpLWIdJYRV/dQUWkubp8fm
         nX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qwtW+zJmX+si2a8vH28TCkyuUby91Li7mYwYtPsgc4=;
        b=oBYLBAifosJRmNH6YoH7IhWfqP0wF8KwEYNoc7keUYBACAlwqced0qMemRF0c5bVkx
         gA8G1NUBokuAx75CHPvCU7jel6n/r9bAslsVwp7iJatwii+2anrw1ZiSv+hmCF7Fq+8s
         oA5kTsF49tTbn/dHL85Vt/KWu46yEhwRUJ73/eUxQUQZaWyfeXtmtnIW8HeGn2l5sRB+
         5rA7QSlziLN6mLGs1UjHbn7pABgIXe373/8f8G/FNf4D13CKSH6WN+b+COsnjrFxmAIm
         t6NFZUm5ds3rjU9lNu5rJRookBWEZV1QavQsY3OLhlR5SoSj8ptWC75uzcEhe7HLSOjy
         ddQQ==
X-Gm-Message-State: AOAM532PDD5h1lbcR+CH/p+QyJunIi8Fk1/xpnrNA4P/AFUJk4JqmTnm
        V66HK1WUwvJ77qZJ3fembkA1qUg1sxxuog==
X-Google-Smtp-Source: ABdhPJwWNos8fxxxJT4zsvS5JtSPN7YX1f2Th8H/ULerQxpMbpUcQz9hV5n2Gt13uMUDxBVxVw2taQ==
X-Received: by 2002:aa7:8713:0:b029:1bf:ee0:34c4 with SMTP id b19-20020aa787130000b02901bf0ee034c4mr2721057pfo.55.1612502078521;
        Thu, 04 Feb 2021 21:14:38 -0800 (PST)
Received: from amypc-samantha.home ([47.145.126.51])
        by smtp.gmail.com with ESMTPSA id v126sm5905000pfv.163.2021.02.04.21.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 21:14:38 -0800 (PST)
From:   Amy Parker <enbyamy@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Amy Parker <enbyamy@gmail.com>
Subject: [PATCH v2 2/3] fs/efs: Correct spacing after C keywords
Date:   Thu,  4 Feb 2021 21:14:28 -0800
Message-Id: <20210205051429.553657-3-enbyamy@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205051429.553657-1-enbyamy@gmail.com>
References: <20210205051429.553657-1-enbyamy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In EFS code, some C keywords (most commonly 'for') do not have spaces 
before their instructions, such as for() vs for (). The kernel style 
guide indicates that these should be of the latter variant. This patch 
updates them accordingly.

Signed-off-by: Amy Parker <enbyamy@gmail.com>
---
 fs/efs/inode.c |  8 ++++----
 fs/efs/namei.c |  2 +-
 fs/efs/super.c | 10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 36d6c45046e2..2cc55d514421 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -130,7 +130,7 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	in->lastextent = 0;
 
 	/* copy the extents contained within the inode to memory */
-	for(i = 0; i < EFS_DIRECTEXTENTS; i++) {
+	for (i = 0; i < EFS_DIRECTEXTENTS; i++) {
 		extent_copy(&(efs_inode->di_u.di_extents[i]), &(in->extents[i]));
 		if (i < in->numextents && in->extents[i].cooked.ex_magic != 0) {
 			pr_warn("extent %d has bad magic number in inode %lu\n",
@@ -227,7 +227,7 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 		 * check the stored extents in the inode
 		 * start with next extent and check forwards
 		 */
-		for(dirext = 1; dirext < direxts; dirext++) {
+		for (dirext = 1; dirext < direxts; dirext++) {
 			cur = (last + dirext) % in->numextents;
 			if ((result = efs_extent_check(&in->extents[cur], block, sb))) {
 				in->lastextent = cur;
@@ -244,7 +244,7 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 	direxts = in->extents[0].cooked.ex_offset;
 	indexts = in->numextents;
 
-	for(indext = 0; indext < indexts; indext++) {
+	for (indext = 0; indext < indexts; indext++) {
 		cur = (last + indext) % indexts;
 
 		/*
@@ -255,7 +255,7 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 		 *
 		 */
 		ibase = 0;
-		for(dirext = 0; cur < ibase && dirext < direxts; dirext++) {
+		for (dirext = 0; cur < ibase && dirext < direxts; dirext++) {
 			ibase += in->extents[dirext].cooked.ex_length *
 				(EFS_BLOCKSIZE / sizeof(efs_extent));
 		}
diff --git a/fs/efs/namei.c b/fs/efs/namei.c
index 38961ee1d1af..65d9c7f4d0c0 100644
--- a/fs/efs/namei.c
+++ b/fs/efs/namei.c
@@ -28,7 +28,7 @@ static efs_ino_t efs_find_entry(struct inode *inode, const char *name, int len)
 		pr_warn("%s(): directory size not a multiple of EFS_DIRBSIZE\n",
 			__func__);
 
-	for(block = 0; block < inode->i_blocks; block++) {
+	for (block = 0; block < inode->i_blocks; block++) {
 
 		bh = sb_bread(inode->i_sb, efs_bmap(inode, block));
 		if (!bh) {
diff --git a/fs/efs/super.c b/fs/efs/super.c
index 874d82096b2f..dd97a071f971 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -169,7 +169,7 @@ static efs_block_t efs_validate_vh(struct volume_header *vh) {
 		return 0;
 
 	ui = ((__be32 *) (vh + 1)) - 1;
-	for(csum = 0; ui >= ((__be32 *) vh);) {
+	for (csum = 0; ui >= ((__be32 *) vh);) {
 		cs = *ui--;
 		csum += be32_to_cpu(cs);
 	}
@@ -181,11 +181,11 @@ static efs_block_t efs_validate_vh(struct volume_header *vh) {
 #ifdef DEBUG
 	pr_debug("bf: \"%16s\"\n", vh->vh_bootfile);
 
-	for(i = 0; i < NVDIR; i++) {
+	for (i = 0; i < NVDIR; i++) {
 		int	j;
 		char	name[VDNAMESIZE+1];
 
-		for(j = 0; j < VDNAMESIZE; j++) {
+		for (j = 0; j < VDNAMESIZE; j++) {
 			name[j] = vh->vh_vd[i].vd_name[j];
 		}
 		name[j] = (char) 0;
@@ -198,9 +198,9 @@ static efs_block_t efs_validate_vh(struct volume_header *vh) {
 	}
 #endif
 
-	for(i = 0; i < NPARTAB; i++) {
+	for (i = 0; i < NPARTAB; i++) {
 		pt_type = (int) be32_to_cpu(vh->vh_pt[i].pt_type);
-		for(pt_entry = sgi_pt_types; pt_entry->pt_name; pt_entry++) {
+		for (pt_entry = sgi_pt_types; pt_entry->pt_name; pt_entry++) {
 			if (pt_type == pt_entry->pt_type) break;
 		}
 #ifdef DEBUG
-- 
2.29.2

