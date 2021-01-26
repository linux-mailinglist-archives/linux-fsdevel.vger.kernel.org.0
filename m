Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E528F305CEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313076AbhAZWjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbhAZU65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:58:57 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063B9C061574;
        Tue, 26 Jan 2021 12:58:17 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id h192so20071808oib.1;
        Tue, 26 Jan 2021 12:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=H6VwC/RDojdwh9voZtX18IiDAm2ZmQUukm2lKn3UJ5Y=;
        b=JSN4ry1UaxIVmfChf8FWEDtWchWKdUb9bzFhj6sY5GRYZXbbKT3TviRuCHH2NbjSQ4
         iiZ8s7BIPCGAsMiyFzC0iN4Y8aASRpufFEgGFVDFAXWhTqnameHbKoGwTthtCADgcWeK
         oiOp3yZ/veHElzvGmbT8LtaLZCMB4DyrtHD85mHD1ZS+iyU8xv39+rdVJT2r8NKUkm9i
         BQapQx0AuRuiPDPfk7gpYjvQyHXJz/8ku1eIDhF3yqWpmo+uO9wpSJrNkifHeqvA+9aU
         02VtbwyMfRC3RShw9RoA4XldErD5Q1buHJxipvIwZz2KgjVKJG0U/KK4dZkXGtvnHkUD
         VEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=H6VwC/RDojdwh9voZtX18IiDAm2ZmQUukm2lKn3UJ5Y=;
        b=JoutgSAfv0hrEeDRPQ5zgrtQ0iDXk+cIPnNQzAA3JdzvZ993Eo81Hc6wxPJ2FGQHVX
         Y3NmNRN24LqqaK8lnUICWcYVm3+UvWRpSrjheOtgBKNYr4asb4wHOUvKNInzGAAVSROw
         5M4OXWhknd8YoZM2XNjPPOPc7ZlaI1f1GzgVVm7HXjnzEXT+Jh/kaDrjQcuCicBe8qH2
         Jlwvc80D51mCU8gD3jrhcZGJAwJaL8Ukq4/TO9sq7o06sV/PBJyx+3Lh7eD06/YoBXPr
         3MtDK/9JAplITAwaHfQi8LfbUWbLrCllXWL9IWX2MVz7pb7IZP0yKXr9MKnnLkIsem3o
         +vbQ==
X-Gm-Message-State: AOAM533U0P2NhkS419MmQ7jUS6fTSBfYq6wy2UDkpl15p+/z+K3kT7Zu
        qsnTgnZN3XscjGgOnTtjd4ABwCtjzPBD3ngyGKi1tqmyGJPBsw==
X-Google-Smtp-Source: ABdhPJynzWLFJ0cDmqbyP47K0kZSFrosJ+i0B9NjQX49gINPQYPli7ciyy0EWY7u7Lh7fgpei8B0gdnQFLry5/dcuTk=
X-Received: by 2002:a54:458f:: with SMTP id z15mr997411oib.139.1611694696095;
 Tue, 26 Jan 2021 12:58:16 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 26 Jan 2021 12:58:05 -0800
Message-ID: <CAE1WUT55QViS=XE9QUTDp1KQ1_5fwuddLY3+2XSrMdoOuCOyYg@mail.gmail.com>
Subject: [PATCH 1/2] fs/efs/inode.c: follow style guide
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch updates inode.c for EFS to follow the kernel style guide.

Signed-off-by: Amy Parker <enbyamy@gmail.com>
---
fs/efs/inode.c | 64 +++++++++++++++++++++++++-------------------------
1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 89e73a6f0d36..4e81e7a15afb 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -109,9 +109,9 @@ struct inode *efs_iget(struct super_block *super,
unsigned long ino)
       /* this is the number of blocks in the file */
       if (inode->i_size == 0) {
               inode->i_blocks = 0;
-       } else {
+       else
               inode->i_blocks = ((inode->i_size - 1) >>
EFS_BLOCKSIZE_BITS) + 1;
-       }
+

       rdev = be16_to_cpu(efs_inode->di_u.di_dev.odev);
       if (rdev == 0xffff) {
@@ -120,15 +120,16 @@ struct inode *efs_iget(struct super_block
*super, unsigned long ino)
                       device = 0;
               else
                       device = MKDEV(sysv_major(rdev), sysv_minor(rdev));
-       } else
+       } else {
               device = old_decode_dev(rdev);
+    }

       /* get the number of extents for this object */
       in->numextents = be16_to_cpu(efs_inode->di_numextents);
       in->lastextent = 0;

       /* copy the extents contained within the inode to memory */
-       for(i = 0; i < EFS_DIRECTEXTENTS; i++) {
+       for (i = 0; i < EFS_DIRECTEXTENTS; i++) {
               extent_copy(&(efs_inode->di_u.di_extents[i]), &(in->extents[i]));
               if (i < in->numextents && in->extents[i].cooked.ex_magic != 0) {
                       pr_warn("extent %d has bad magic number in inode %lu\n",
@@ -142,28 +143,28 @@ struct inode *efs_iget(struct super_block
*super, unsigned long ino)
       pr_debug("efs_iget(): inode %lu, extents %d, mode %o\n",
                inode->i_ino, in->numextents, inode->i_mode);
       switch (inode->i_mode & S_IFMT) {
-               case S_IFDIR:
-                       inode->i_op = &efs_dir_inode_operations;
-                       inode->i_fop = &efs_dir_operations;
-                       break;
-               case S_IFREG:
-                       inode->i_fop = &generic_ro_fops;
-                       inode->i_data.a_ops = &efs_aops;
-                       break;
-               case S_IFLNK:
-                       inode->i_op = &page_symlink_inode_operations;
-                       inode_nohighmem(inode);
-                       inode->i_data.a_ops = &efs_symlink_aops;
-                       break;
-               case S_IFCHR:
-               case S_IFBLK:
-               case S_IFIFO:
-                       init_special_inode(inode, inode->i_mode, device);
-                       break;
-               default:
-                       pr_warn("unsupported inode mode %o\n", inode->i_mode);
-                       goto read_inode_error;
-                       break;
+    case S_IFDIR:
+        inode->i_op = &efs_dir_inode_operations;
+        inode->i_fop = &efs_dir_operations;
+        break;
+    case S_IFREG:
+        inode->i_fop = &generic_ro_fops;
+        inode->i_data.a_ops = &efs_aops;
+        break;
+    case S_IFLNK:
+        inode->i_op = &page_symlink_inode_operations;
+        inode_nohighmem(inode);
+        inode->i_data.a_ops = &efs_symlink_aops;
+        break;
+    case S_IFCHR:
+    case S_IFBLK:
+    case S_IFIFO:
+        init_special_inode(inode, inode->i_mode, device);
+        break;
+    default:
+        pr_warn("unsupported inode mode %o\n", inode->i_mode);
+        goto read_inode_error;
+        break;
       }

       unlock_new_inode(inode);
@@ -189,11 +190,10 @@ efs_extent_check(efs_extent *ptr, efs_block_t
block, struct efs_sb_info *
sb) {
       length = ptr->cooked.ex_length;
       offset = ptr->cooked.ex_offset;

-       if ((block >= offset) && (block < offset+length)) {
+       if ((block >= offset) && (block < offset+length))
               return(sb->fs_start + start + block - offset);
-       } else {
+       else
               return 0;
-       }
}

efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
@@ -225,7 +225,7 @@ efs_block_t efs_map_block(struct inode *inode,
efs_block_t block) {
                * check the stored extents in the inode
                * start with next extent and check forwards
                */
-               for(dirext = 1; dirext < direxts; dirext++) {
+               for (dirext = 1; dirext < direxts; dirext++) {
                       cur = (last + dirext) % in->numextents;
                       if ((result =
efs_extent_check(&in->extents[cur], block, sb))) {
                               in->lastextent = cur;
@@ -242,7 +242,7 @@ efs_block_t efs_map_block(struct inode *inode,
efs_block_t block) {
       direxts = in->extents[0].cooked.ex_offset;
       indexts = in->numextents;

-       for(indext = 0; indext < indexts; indext++) {
+       for (indext = 0; indext < indexts; indext++) {
               cur = (last + indext) % indexts;

               /*
@@ -253,7 +253,7 @@ efs_block_t efs_map_block(struct inode *inode,
efs_block_t block) {
                *
                */
               ibase = 0;
-               for(dirext = 0; cur < ibase && dirext < direxts; dirext++) {
+               for (dirext = 0; cur < ibase && dirext < direxts; dirext++) {
                       ibase += in->extents[dirext].cooked.ex_length *
                               (EFS_BLOCKSIZE / sizeof(efs_extent));
               }
--
2.29.2
