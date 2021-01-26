Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E001A305CE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313650AbhAZWjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbhAZU67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:58:59 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC7C06174A;
        Tue, 26 Jan 2021 12:58:18 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id n42so17627445ota.12;
        Tue, 26 Jan 2021 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jjW5OEcZEFJ6u5ebD6rDQaRdPlzKWugxX9448B0qRJs=;
        b=QFHep74mF1ZAnLEgFtqjI+6kUUvf4aq0kOEwKAyrJrvGDbG3OqL7k0JAFn8VIGdwzf
         GT9xOBfp1NXnpDQK1TQzlzmPurx+2aWYhzvaiUqDoA9VHqO04zlE+6YqsmKSgp2CFUgI
         q9vAMUcCr3QKWOGiDz62wV9ERC+xOL/E8fRzMjH9IsAcWgZsH53m/2uPoApuic0rsYVH
         WMe69hSMJac19/8CtDzP7rLLXZOV+CWsCMEstkVXocs/h8e1RRHLhOJE9QqURiTBWyxy
         saaUtYq3lqIXa5OBxYpQNeFZrYoE+wavVwWVFig5oA1HwoOt2uDZn1sPdM6BmmzDmNTn
         OSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jjW5OEcZEFJ6u5ebD6rDQaRdPlzKWugxX9448B0qRJs=;
        b=tvFrPQ1Ex9oBEM702CDna7UgurbR6Ps0r1dXwjpE/YdbFPbaZ0RfjPuNnablOd9VtH
         xPSNNgupTvdDq4FoL9CvTwSuKA35tBaWpEsjom6EJv9aq115mpXeKjwUjOLcHYeJHNC+
         3FDpVH4lyVAB3OPfKRbUiHJSIC++Hhgn7FcSKWnkJ8HF5k8sDsYlq7FQ0E9KqoJdA/uR
         gMxHP9Mrlv/5S6AAX0u/WIcpcqpcCaFKIjY7ZAJlXCcUcclnGXt+M2O3qSq5ePMV73iV
         7J+ZF8cmLGoGoUFro92FY6yRrnvbH8ttto+BjmeB6xj8GOlg+1RvSNzv0/bQ0piqxDwM
         x20g==
X-Gm-Message-State: AOAM531/30manfPk19D3HIL5OBYH8qWBK3+EOnG5qfbOBGdlKDgPadSP
        BfMWqYWMVzbsqH+UUgG5kDTlgTYPVsu8KNcdaXDR8ILYQoCEXw==
X-Google-Smtp-Source: ABdhPJyYuoQT7bg2Zstgv6iLeM0JmdIyGPiL+piwLs0XE3t2Yl5890z8EWEuA3mPoz4RCIInx5aui/vrMA+OANPM+f4=
X-Received: by 2002:a05:6830:15c5:: with SMTP id j5mr5283017otr.185.1611694697939;
 Tue, 26 Jan 2021 12:58:17 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 26 Jan 2021 12:58:06 -0800
Message-ID: <CAE1WUT7agR9YvnK8+11yFU1sGwOxXchpP0PQeuPziKvw6GFrMQ@mail.gmail.com>
Subject: [PATCH 2/2] fs/efs: fix style guide for namei.c and super.c
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch updates various styling in namei.c and super.c to follow
the kernel style guide.

Signed-off-by: Amy Parker <enbyamy@gmail.com>
---
fs/efs/namei.c |  2 +-
fs/efs/super.c | 13 +++++++------
2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/efs/namei.c b/fs/efs/namei.c
index 38961ee1d1af..65d9c7f4d0c0 100644
--- a/fs/efs/namei.c
+++ b/fs/efs/namei.c
@@ -28,7 +28,7 @@ static efs_ino_t efs_find_entry(struct inode *inode,
const char *name, int le
n)
               pr_warn("%s(): directory size not a multiple of EFS_DIRBSIZE\n",
                       __func__);

-       for(block = 0; block < inode->i_blocks; block++) {
+       for (block = 0; block < inode->i_blocks; block++) {

               bh = sb_bread(inode->i_sb, efs_bmap(inode, block));
               if (!bh) {
diff --git a/fs/efs/super.c b/fs/efs/super.c
index 62b155b9366b..d55c481796f1 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -170,7 +170,7 @@ static efs_block_t efs_validate_vh(struct
volume_header *vh) {
       }

       ui = ((__be32 *) (vh + 1)) - 1;
-       for(csum = 0; ui >= ((__be32 *) vh);) {
+       for (csum = 0; ui >= ((__be32 *) vh);) {
               cs = *ui--;
               csum += be32_to_cpu(cs);
       }
@@ -182,11 +182,11 @@ static efs_block_t efs_validate_vh(struct
volume_header *vh) {
#ifdef DEBUG
       pr_debug("bf: \"%16s\"\n", vh->vh_bootfile);

-       for(i = 0; i < NVDIR; i++) {
+       for (i = 0; i < NVDIR; i++) {
               int     j;
               char    name[VDNAMESIZE+1];

-               for(j = 0; j < VDNAMESIZE; j++) {
+               for (j = 0; j < VDNAMESIZE; j++) {
                       name[j] = vh->vh_vd[i].vd_name[j];
               }
               name[j] = (char) 0;
@@ -199,9 +199,9 @@ static efs_block_t efs_validate_vh(struct
volume_header *vh) {
       }
#endif

-       for(i = 0; i < NPARTAB; i++) {
+       for (i = 0; i < NPARTAB; i++) {
               pt_type = (int) be32_to_cpu(vh->vh_pt[i].pt_type);
-               for(pt_entry = sgi_pt_types; pt_entry->pt_name; pt_entry++) {
+               for (pt_entry = sgi_pt_types; pt_entry->pt_name; pt_entry++) {
                       if (pt_type == pt_entry->pt_type) break;
               }
#ifdef DEBUG
@@ -222,7 +222,8 @@ static efs_block_t efs_validate_vh(struct
volume_header *vh) {
       if (slice == -1) {
               pr_notice("partition table contained no EFS partitions\n");
#ifdef DEBUG
-       } else {
+       }
+       else {
               pr_info("using slice %d (type %s, offset 0x%x)\n", slice,
                       (pt_entry->pt_name) ? pt_entry->pt_name : "unknown",
                       sblock);
--
2.29.2
