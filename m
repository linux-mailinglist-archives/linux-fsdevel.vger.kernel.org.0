Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B21730DA19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhBCMrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:47:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhBCMnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TejRLSU/4tO3xbWCWCiZBCPi7mB6er1iGbgx5H+3dxg=;
        b=F8G9ZMUp0K/Ej/Z9o3diAxgFAwO1NqvLL2KyHmMFgk86WCPxZfQNSymZS8JjEjLQPMTKSY
        +wXy7bZV1ss0v2AlVRzyLyar7H9DF+0e3E0EZkeCllrB7bYE6sRy+ZukPJ+nDU5sCV0mFX
        x5RqSlVDXve44ePVecaDxqCv/yhrZvY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-LR-0E2ElOnC7bVWXPyjLDw-1; Wed, 03 Feb 2021 07:41:56 -0500
X-MC-Unique: LR-0E2ElOnC7bVWXPyjLDw-1
Received: by mail-ed1-f70.google.com with SMTP id f4so11398446eds.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TejRLSU/4tO3xbWCWCiZBCPi7mB6er1iGbgx5H+3dxg=;
        b=fV+quxAAWUIVYBCNKujdPfhWI6FxzkqJNoYSLI6vP05NWpylj0hScE1cobmd+1f644
         v2ZGoY73t3tgvwx4vXTVP89XiB8CMGwN43knBIXwSVEFi6U5+/oIS5FZgdo9ZnGoFOSQ
         7+X1iqfX1CuIOfxnKmfw+Gi1W+CR0V9GOro7m8xHaLaaADKV6PTMh2v0u7A02XPHsBAY
         myJeU7ykEYw1KGb9C4U4HgjPs5Swo/dF3T1hGs2FLFPiYjCIyBheEX1UaQtUibJAcO4K
         +jDitrqIQMNq9NXlWZJx6j7/OhPAxk5QYsnsa4Ga9NiVmP4f5QmG7LYIF3LW9trFvtgn
         tHvw==
X-Gm-Message-State: AOAM533B51uc2jPDdU/cH+vJO7CyNnrr1R1X9S1oYnwirXJtwBqRoxkG
        VCbDABmSXAF6rd8+b2J+QmG370er2cWCH8ycJ7mA9SWmrFH6RfLeeXmhnUreOtD9uSF0QvQuUIV
        QxsXdxqseL2WKnGJJYrM90S5EYsj853AD9OXpAoymCgxeNotwmSc4IoRaefruWsPmkKCwHyy/8y
        DfCQ==
X-Received: by 2002:a17:906:af58:: with SMTP id ly24mr3082694ejb.208.1612356115245;
        Wed, 03 Feb 2021 04:41:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCsL4D1U/WlWFbiBMZiUR/Fin1cSRZf5uO/1GeNn0DQM8iIxJ40kNBYpDqO+tye1RYQWBwKQ==
X-Received: by 2002:a17:906:af58:: with SMTP id ly24mr3082673ejb.208.1612356114937;
        Wed, 03 Feb 2021 04:41:54 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:54 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 18/18] vfs: remove unused ioctl helpers
Date:   Wed,  3 Feb 2021 13:41:12 +0100
Message-Id: <20210203124112.1182614-19-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203124112.1182614-1-mszeredi@redhat.com>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
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
index 6442d97d9a4a..8771d3edbd0b 100644
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
@@ -2293,89 +2292,3 @@ struct timespec64 current_time(struct inode *inode)
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
index ca3bab7d5f6e..fc1727003f3a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3452,18 +3452,6 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
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
2.26.2

