Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C912B344809
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhCVOuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230241AbhCVOto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzzrxrfbZ6Li1+rV206VufAvp4kmrq19gDEYr0Sjiyg=;
        b=huCnqCoBhGalT+LmtXIU7J6EmxtzCYxCzswKyeIrKP3HxO3wNaDQVaVDwVOnA+6V7Ga9wj
        +EAXeL0u2xGBo1F+mxzMwiM+PojxrlrXZrazUrIl7sKbcTM1EMe5yEFoT10s9lUhYAFS1I
        1bNmqd+4El9ZtJTGQczTe85ao8gQTa4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-VPqmcdQ2NXKSYWIjMeXvwg-1; Mon, 22 Mar 2021 10:49:41 -0400
X-MC-Unique: VPqmcdQ2NXKSYWIjMeXvwg-1
Received: by mail-ej1-f70.google.com with SMTP id rl7so19905658ejb.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzzrxrfbZ6Li1+rV206VufAvp4kmrq19gDEYr0Sjiyg=;
        b=jX52yCdAReo2jxsn3wBZFvxNjiNDKf7Z4G9uc+EvgJ7A5oVCgA/WGBg0Gyy1566i54
         v7XGpwbutYGulwUYnVI+pWd4w1cLQBosarVznOjM+kIY4CteUSO5ZXVwmlgqmFW+GrLZ
         Qla6PjkdAX60g94w0lseJwSg0P6+EvnePbESjJ7jt+luLkxcmJo/eGgDnK6SJQmh8qX/
         wh/IACxSVtLK1w30DrhwgqJEg4g3Dq4uIqPgVPFqJbCvW/yFTMaZzsCC49Mjbw/UvANv
         Qjw6ay7/Hpp7uNWt+bHcCpUnpsDBaEV/M5bgUJsaEndb1zCTuJsjarbsbukCwUfDXeey
         mIXQ==
X-Gm-Message-State: AOAM530+R9q3PDvoAYO4+vh0eDzN9sZZLXS8sSKRQJo9nn9DLhMP6md/
        9Cy2fpKZfyVKqWj4+otLLoBStycxrKD/XGNKEAYQC8bwsEBMZOlbsj8qata3novhhHWd7C8tj+j
        K3KqH8t/wwRT+eSrjS7b47Ph1PGaB4g2L1V5vFwLcrqug+Bk5b+jcKzsiMmd/QKuBnwV98e6sH4
        fgXA==
X-Received: by 2002:a05:6402:181a:: with SMTP id g26mr26122494edy.225.1616424579975;
        Mon, 22 Mar 2021 07:49:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmA+7jm77Yf7uBGUKOCjGtM76lqZiG9z471QyGjwDECbN0X/0/eSaIJdwN8mOgSCCGtChCmA==
X-Received: by 2002:a05:6402:181a:: with SMTP id g26mr26122467edy.225.1616424579749;
        Mon, 22 Mar 2021 07:49:39 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:39 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 18/18] vfs: remove unused ioctl helpers
Date:   Mon, 22 Mar 2021 15:49:16 +0100
Message-Id: <20210322144916.137245-19-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322144916.137245-1-mszeredi@redhat.com>
References: <20210322144916.137245-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove vfs_ioc_setflags_prepare(), vfs_ioc_fssetxattr_check() and
simple_fill_fsxattr(), which are no longer used.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/inode.c         | 87 ----------------------------------------------
 include/linux/fs.h | 12 -------
 2 files changed, 99 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index a047ab306f9a..ae526fd9c0a4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -12,7 +12,6 @@
 #include <linux/security.h>
 #include <linux/cdev.h>
 #include <linux/memblock.h>
-#include <linux/fscrypt.h>
 #include <linux/fsnotify.h>
 #include <linux/mount.h>
 #include <linux/posix_acl.h>
@@ -2314,89 +2313,3 @@ struct timespec64 current_time(struct inode *inode)
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
-
-/*
- * Generic function to check FS_IOC_SETFLAGS values and reject any invalid
- * configurations.
- *
- * Note: the caller should be holding i_mutex, or else be sure that they have
- * exclusive access to the inode structure.
- */
-int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
-			     unsigned int flags)
-{
-	/*
-	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
-	 * the relevant capability.
-	 *
-	 * This test looks nicer. Thanks to Pauline Middelink
-	 */
-	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
-		return -EPERM;
-
-	return fscrypt_prepare_setflags(inode, oldflags, flags);
-}
-EXPORT_SYMBOL(vfs_ioc_setflags_prepare);
-
-/*
- * Generic function to check FS_IOC_FSSETXATTR values and reject any invalid
- * configurations.
- *
- * Note: the caller should be holding i_mutex, or else be sure that they have
- * exclusive access to the inode structure.
- */
-int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
-			     struct fsxattr *fa)
-{
-	/*
-	 * Can't modify an immutable/append-only file unless we have
-	 * appropriate permission.
-	 */
-	if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
-			(FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
-		return -EPERM;
-
-	/*
-	 * Project Quota ID state is only allowed to change from within the init
-	 * namespace. Enforce that restriction only if we are trying to change
-	 * the quota ID state. Everything else is allowed in user namespaces.
-	 */
-	if (current_user_ns() != &init_user_ns) {
-		if (old_fa->fsx_projid != fa->fsx_projid)
-			return -EINVAL;
-		if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
-				FS_XFLAG_PROJINHERIT)
-			return -EINVAL;
-	}
-
-	/* Check extent size hints. */
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
-		return -EINVAL;
-
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
-			!S_ISDIR(inode->i_mode))
-		return -EINVAL;
-
-	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
-	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
-		return -EINVAL;
-
-	/*
-	 * It is only valid to set the DAX flag on regular files and
-	 * directories on filesystems.
-	 */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
-	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
-		return -EINVAL;
-
-	/* Extent size hints of zero turn off the flags. */
-	if (fa->fsx_extsize == 0)
-		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
-	if (fa->fsx_cowextsize == 0)
-		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
-
-	return 0;
-}
-EXPORT_SYMBOL(vfs_ioc_fssetxattr_check);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9e7f6a592a70..1e88ace15004 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3571,18 +3571,6 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
 extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 			   int advice);
 
-int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
-			     unsigned int flags);
-
-int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
-			     struct fsxattr *fa);
-
-static inline void simple_fill_fsxattr(struct fsxattr *fa, __u32 xflags)
-{
-	memset(fa, 0, sizeof(*fa));
-	fa->fsx_xflags = xflags;
-}
-
 /*
  * Flush file data before changing attributes.  Caller must hold any locks
  * required to prevent further writes to this file until we're done setting
-- 
2.30.2

