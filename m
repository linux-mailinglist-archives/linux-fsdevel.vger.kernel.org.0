Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E4A77D1DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 20:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbjHOS3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 14:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbjHOS3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:29:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C6BDF;
        Tue, 15 Aug 2023 11:29:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so55869885e9.2;
        Tue, 15 Aug 2023 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692124145; x=1692728945;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cniGeiNrt4R+bebZlHNh2ZkQtweoKY6rI5z77zvVlfw=;
        b=HXBWREToIP3cBlP9RU3kD+A3xaydqOGPg7OTurbo8jQP+ax6nQI5pJKVvWO0PMZ/f+
         zv7UxIBt0HSMkCq4hif1HvKF5sFJEkbBiUpA7amNEwj76jkkVt40RdUyKcTUg8Uax09k
         bWspen7dY8yvN44n6qq5Q9JIKeomS95SG71Dw4sHMbuxbLwZl8ImeshM9kc8qfDDlwgM
         FsIsGLWtOjHOpEvsnW6DSngHl0zRZJtr+1miTHsvEfcKy8lzDahyHJwsIoI81DkSmUSs
         nlLpTgoCS8nAi10XRkFiuuK9V7DAt5eh9CEys8WARRhrBKMa3IWmcqvVYNe0DKMXm/GG
         EiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124145; x=1692728945;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cniGeiNrt4R+bebZlHNh2ZkQtweoKY6rI5z77zvVlfw=;
        b=XSXowaLlNGvzMnxWW8KdSU+8jEEbQ4/fFJyb63GYGE32imv75rTwAYIUWWOPFgo+WE
         9wxxvqtqYRTQ4koLmJ2UA5LS168uuukCzPqJ1y9mnzo3VG8Fhk9iamL9SGuDypNQbhDF
         JFcCk0d/sswi9zjECawOx1vEz4ekIx20BIi2BJCu/6p7m407QvcdZMWN/iUl8dMwIqPa
         2PXCLw47oW4ugqvk4hLw/wpjzyokuvYYVDgb4yJSW+uo8N4dCGTsMTEH0MtG6Rph0AUk
         6QeCsH7scy4L3JMfAbvD72PB3TqJKwBDj4QJ3i+pTGFAV4LPYSbiqfJzkW6iw3dzvPTF
         nTCA==
X-Gm-Message-State: AOJu0YxcyrZa/D6NZQ3moPhNA0bCbSq3tm7bi0yMOJhEZAjVY4y8qURf
        PlGorgu40Kh8pAnlo631I9g=
X-Google-Smtp-Source: AGHT+IGnm2gFFXrt/73W0zweQjnIDD/Dfj+9cPYuWtIIlE24KNRigxnj0FcG3jgH9wE74QPaJXQStQ==
X-Received: by 2002:a7b:ca4f:0:b0:3fe:1af6:6542 with SMTP id m15-20020a7bca4f000000b003fe1af66542mr10774140wml.33.1692124144750;
        Tue, 15 Aug 2023 11:29:04 -0700 (PDT)
Received: from [192.168.0.75] (85-160-61-184.reb.o2.cz. [85.160.61.184])
        by smtp.gmail.com with ESMTPSA id s13-20020a7bc38d000000b003fe2ebf479fsm18699369wmj.36.2023.08.15.11.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 11:29:04 -0700 (PDT)
Message-ID: <1a1af1dd-fb30-1af6-ab2a-d146ff230989@gmail.com>
Date:   Tue, 15 Aug 2023 20:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Jan Cincera <hcincera@gmail.com>
Subject: [PATCH] exfat: add ioctls for accessing attributes
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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
 fs/exfat/exfat_fs.h |  6 +++
 fs/exfat/file.c     | 97 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

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
index 3cbd270e0cba..b358acbead27 100644
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
@@ -316,6 +318,96 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
+	/*
+	 * ATTR_VOLUME and ATTR_SUBDIR cannot be changed; this also
+	 * prevents the user from turning us into a VFAT
+	 * longname entry.  Also, we obviously can't set
+	 * any of the NTFS attributes in the high 24 bits.
+	 */
+	attr &= 0xff & ~(ATTR_VOLUME | ATTR_SUBDIR);
+	/* Merge in ATTR_VOLUME and ATTR_DIR */
+	attr |= (EXFAT_I(inode)->attr & ATTR_VOLUME) |
+		(is_dir ? ATTR_SUBDIR : 0);
+	oldattr = exfat_make_attr(inode);
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
@@ -346,8 +438,13 @@ static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
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
