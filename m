Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F0B789D03
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Aug 2023 12:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjH0Kmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 06:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjH0KmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:42:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B10CEA;
        Sun, 27 Aug 2023 03:42:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98377c5d53eso284949466b.0;
        Sun, 27 Aug 2023 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693132929; x=1693737729;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz9CBAI4zwM+YFF3Ydx79sOTLw/EqjnM+oe9j4q1ErI=;
        b=VCEycUcoyxDEGtLTbMyHcGta0DUHaobkaI73Dq9dJtQmgMu7/ITac3nHcALL6xWQUA
         PCY1A8ezoOuYuTKEriOAO1ln5XFp08Qe8IWaUk9GpwY4ivvmUPl65bCrYpXB5nOIJz+I
         zNlB+z109H/IfD42a0EDKwLz9TihYM7bdifmx9ajYncAmfWIJK/mWufH0QaUCGy8pfam
         T/S6l7oLxpBaLw9m1ZFpjVnvznG15TI5bEjGjYi31PC4rkqA5ig54BMWf0a1Y6ndp9S0
         x27NJSVj6n4I1NqYJsy8QR9H36nQsbecJdmhAcITlqijyHTuJ+Amijlx38Ubi+xvqcCC
         FWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693132929; x=1693737729;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rz9CBAI4zwM+YFF3Ydx79sOTLw/EqjnM+oe9j4q1ErI=;
        b=JNmgzf1QMtxAqtRqtiQQcJyzMaCYlpdbH9nfahARBLJgEeVCC8PywsWXM4QjJzf7vp
         XH/UCA0L2lYqjKTPSumR1ZYRzAKTi8HiMfXNvsyx+s3fts4W/jSMztpE4S83XSLZad1Z
         QyzhhbcIpgY/G2a+Ab2Vy357KCwYzApg8lNo+ccVx/0fcL/8Z51Zrrb+9WIzMwh1G83e
         OGWTQ2H4i4dHWMazVBYTzf1AgMsHWV5UVdQIh+uWVR+l81vku5kvNoaNqiZl/JuXiQhG
         Z2Pe/sib1y3D5KCXSsl2XU3Pqo0bM8aRHwUL6HOmiN9aq8LTK/KVIl3zokc3cv/jx8g1
         H2VQ==
X-Gm-Message-State: AOJu0YzjGyBTrLBpFlQ1suw3WxWaiOFizhn6+e5cRbxyE6axbkWHbc6i
        XRJDKNOdJAed3xoPqg5+Qx10KLvaqT0fTA==
X-Google-Smtp-Source: AGHT+IFAOR7TUKUTek81wSVLxldVECpmhuoaGY+lkEGnqAv5EQ2XPSKr3VQ7/XikDzrUuOlnIv59tQ==
X-Received: by 2002:a17:907:2e19:b0:9a2:16e2:35a with SMTP id ig25-20020a1709072e1900b009a216e2035amr7109135ejc.62.1693132929399;
        Sun, 27 Aug 2023 03:42:09 -0700 (PDT)
Received: from [192.168.0.75] (85-160-48-176.reb.o2.cz. [85.160.48.176])
        by smtp.gmail.com with ESMTPSA id i27-20020a1709063c5b00b009a1c05bd672sm3302442ejg.127.2023.08.27.03.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 03:42:08 -0700 (PDT)
Message-ID: <30bfc906-1d73-01c9-71d0-aa441ac34b96@gmail.com>
Date:   Sun, 27 Aug 2023 12:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Jan Cincera <hcincera@gmail.com>
Subject: [PATCH v2] exfat: add ioctls for accessing attributes
To:     Namjae Jeon <linkinjeon@kernel.org>
Content-Language: cs
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add GET and SET attributes ioctls to enable attribute modification.
We already do this in FAT and a few userspace utils made for it would
benefit from this also working on exFAT, namely fatattr.

Signed-off-by: Jan Cincera <hcincera@gmail.com>
---
Changes in v2:
  - Removed irrelevant comments.
  - Now masking reserved fields.

 fs/exfat/exfat_fs.h |  6 +++
 fs/exfat/file.c     | 93 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 729ada9e26e8..ebe8c4b928f4 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -149,6 +149,12 @@ enum {
 #define DIR_CACHE_SIZE		\
 	(DIV_ROUND_UP(EXFAT_DEN_TO_B(ES_MAX_ENTRY_NUM), SECTOR_SIZE) + 1)
 
+/*
+ * attribute ioctls, same as their FAT equivalents.
+ */
+#define EXFAT_IOCTL_GET_ATTRIBUTES	_IOR('r', 0x10, __u32)
+#define EXFAT_IOCTL_SET_ATTRIBUTES	_IOW('r', 0x11, __u32)
+
 struct exfat_dentry_namebuf {
 	char *lfn;
 	int lfnbuf_len; /* usually MAX_UNINAME_BUF_SIZE */
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 3cbd270e0cba..b31ce0868ddd 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -8,6 +8,8 @@
 #include <linux/cred.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
+#include <linux/fsnotify.h>
+#include <linux/security.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -316,6 +318,92 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return error;
 }
 
+/*
+ * modified ioctls from fat/file.c by Welmer Almesberger
+ */
+static int exfat_ioctl_get_attributes(struct inode *inode, u32 __user *user_attr)
+{
+	u32 attr;
+
+	inode_lock_shared(inode);
+	attr = exfat_make_attr(inode);
+	inode_unlock_shared(inode);
+
+	return put_user(attr, user_attr);
+}
+
+static int exfat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
+{
+	struct inode *inode = file_inode(file);
+	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
+	int is_dir = S_ISDIR(inode->i_mode);
+	u32 attr, oldattr;
+	struct iattr ia;
+	int err;
+
+	err = get_user(attr, user_attr);
+	if (err)
+		goto out;
+
+	err = mnt_want_write_file(file);
+	if (err)
+		goto out;
+	inode_lock(inode);
+
+	oldattr = exfat_make_attr(inode);
+
+	/*
+	 * Mask attributes so we don't set reserved fields.
+	 */
+	attr &= (ATTR_READONLY | ATTR_HIDDEN | ATTR_SYSTEM | ATTR_ARCHIVE);
+	attr |= (is_dir ? ATTR_SUBDIR : 0);
+
+	/* Equivalent to a chmod() */
+	ia.ia_valid = ATTR_MODE | ATTR_CTIME;
+	ia.ia_ctime = current_time(inode);
+	if (is_dir)
+		ia.ia_mode = exfat_make_mode(sbi, attr, 0777);
+	else
+		ia.ia_mode = exfat_make_mode(sbi, attr, 0666 | (inode->i_mode & 0111));
+
+	/* The root directory has no attributes */
+	if (inode->i_ino == EXFAT_ROOT_INO && attr != ATTR_SUBDIR) {
+		err = -EINVAL;
+		goto out_unlock_inode;
+	}
+
+	if (((attr | oldattr) & ATTR_SYSTEM) &&
+	    !capable(CAP_LINUX_IMMUTABLE)) {
+		err = -EPERM;
+		goto out_unlock_inode;
+	}
+
+	/*
+	 * The security check is questionable...  We single
+	 * out the RO attribute for checking by the security
+	 * module, just because it maps to a file mode.
+	 */
+	err = security_inode_setattr(file_mnt_idmap(file),
+				     file->f_path.dentry, &ia);
+	if (err)
+		goto out_unlock_inode;
+
+	/* This MUST be done before doing anything irreversible... */
+	err = exfat_setattr(file_mnt_idmap(file), file->f_path.dentry, &ia);
+	if (err)
+		goto out_unlock_inode;
+
+	fsnotify_change(file->f_path.dentry, ia.ia_valid);
+
+	exfat_save_attr(inode, attr);
+	mark_inode_dirty(inode);
+out_unlock_inode:
+	inode_unlock(inode);
+	mnt_drop_write_file(file);
+out:
+	return err;
+}
+
 static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
 {
 	struct fstrim_range range;
@@ -346,8 +434,13 @@ static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
+	u32 __user *user_attr = (u32 __user *)arg;
 
 	switch (cmd) {
+	case EXFAT_IOCTL_GET_ATTRIBUTES:
+		return exfat_ioctl_get_attributes(inode, user_attr);
+	case EXFAT_IOCTL_SET_ATTRIBUTES:
+		return exfat_ioctl_set_attributes(filp, user_attr);
 	case FITRIM:
 		return exfat_ioctl_fitrim(inode, arg);
 	default:
-- 
2.40.1
