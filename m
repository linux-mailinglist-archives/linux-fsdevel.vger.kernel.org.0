Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2075820B43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 17:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfEPPav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 11:30:51 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42850 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPPau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 11:30:50 -0400
Received: by mail-yw1-f67.google.com with SMTP id s5so1504470ywd.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQMWihDrwPqvCO+v1d6CYJwg+Et40k6QAFGQzCBYupw=;
        b=g93QOfc764NuRXyY2V7gPAKSH2KuYwsDKox7FLeOlOl+479JearhlpPmOXnk2Bvlk3
         Im82bd/FNiGRogWssWA7OeD4YXqjzJQjdpBpjpvHwv9gW1x6MvXxcDzOwRKC6tnX7HuK
         RUumwi/yEeQLagC+qL5HF/yNYWaZ9Hug+xVxYxQ6vpduv/L6I4ooDCRUZmmhxkTxcxfs
         wXxhdhygIgcPYPvX4rXpIbk8UApYTEACEKX65JuhgAdOcLCEtRnkXKs6Aai0wnXCOtMY
         tfCMuGk1+sdToDB8fDwCtqSgabVO5iVr+UXGsziRV6J4DSKLNDPuG3Elx788ubJb8UhD
         GU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQMWihDrwPqvCO+v1d6CYJwg+Et40k6QAFGQzCBYupw=;
        b=fZ1reZQEUiDLGYcEWtaGBjwtqvtGusna2XRCT7kGczk9TgH0xWF6DCj0ufkuG3PH2B
         rWE5M4pLHfNpQzOS1XHWxm9jlNIEOjesUMQqaHivQcxkHeePKwq7GJ7DIT2Mu+12fa/2
         +ZJnkLWjwIsZF+3t9Pdmv4aB9pVz54XAdAAGvhZO1XuJcZgIs5lwq3SYeqi1jUIHALqr
         ZrRjjaanTHbe8vPiYz/kjBODJSAdqSkp2m7bFOSHZFZPmCuFoq3vdRJBkowt680f8uQh
         fpSpdRUaT3kddVxy72Rsx68TnwTfTIh1B7EjK2dbwONU+sLveFjDDzc93dUH2cKOPtef
         p08w==
X-Gm-Message-State: APjAAAUZkS85+zOsVhXaEXX2FC+ovKI6AWKnT6Okfhi7GGZT0LDtAPoR
        5V5xZVTeIIzDSCKJ9JgBrdaCBUj1C+WD5QPpUUI=
X-Google-Smtp-Source: APXvYqzEdGHgRd9FoPHJ4AEoe5BV1GEkx/7ksmJkVlrypQQl8sCPj3wMTzIwS+HdhwLmOwcLX0o7YHCzOgEJdwtfK70=
X-Received: by 2002:a81:9903:: with SMTP id q3mr23271009ywg.211.1558020649737;
 Thu, 16 May 2019 08:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102641.6574-1-amir73il@gmail.com> <20190516102641.6574-4-amir73il@gmail.com>
In-Reply-To: <20190516102641.6574-4-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 May 2019 18:30:38 +0300
Message-ID: <CAOQ4uxi+ZcBgSKUrQr8QiWHB=N+udE0F1+Ry-wrCMV_jWkLLDA@mail.gmail.com>
Subject: Fwd: [PATCH v2 03/14] fsnotify: add empty fsnotify_{unlink,rmdir}() hooks
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph,

From my patch series, this is really the only patch that is a
dependency to the patch you received earlier today:
"fsnotify: call fsnotify_rmdir() hook from configfs"

What you should know for wider context is that currently
users can sign up for inotify notifications on configfs.
If they do that with current kernel they will get notified when
directory is removed not via vfs_rmdir() or via
configfs_unregister_{group,subsystem}().

For reasons outside the scope of configfs, we intend to stop
calling fsnotify hook from d_delete(). In order to preserve existing
behavior (whether some users depends on it or not I do not know),
we add explicit fsnotify hooks in configfs_unregister_{group,subsystem}().

For most pseduo filesystems that use simple_rmdir(), I chose a different
approach of calling a new helper simple_remove(), where the new fsnotify
hook is placed. For configfs, I could not use the same technique because
configfs_remove_dir() is also called from execution path of vfs_rmdir(), where
the new fsnotify hook is already called.

Hope this context is sufficient for you to review the configfs patch and provide
an ACK, so Jan or Al can carry the configfs patch.

If you like me to post you the entire series, I can do that.

Thanks,
Amir.

---------- Forwarded message ---------
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, May 16, 2019 at 1:26 PM
Subject: [PATCH v2 03/14] fsnotify: add empty fsnotify_{unlink,rmdir}() hooks
To: Jan Kara <jack@suse.cz>
Cc: Matthew Bobrowski <mbobrowski@mbobrowski.org>,
<linux-fsdevel@vger.kernel.org>


We would like to move fsnotify_nameremove() calls from d_delete()
into a higher layer where the hook makes more sense and so we can
consider every d_delete() call site individually.

Start by creating empty hook fsnotify_{unlink,rmdir}() and place
them in the proper VFS call sites.  After all d_delete() call sites
will be converted to use the new hook, the new hook will generate the
delete events and fsnotify_nameremove() hook will be removed.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/libfs.c               | 11 ++++++++---
 fs/namei.c               |  2 ++
 include/linux/fsnotify.h | 26 ++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index ca1132f1d5c6..4db61ca8cc94 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -10,6 +10,7 @@
 #include <linux/cred.h>
 #include <linux/mount.h>
 #include <linux/vfs.h>
+#include <linux/fsnotify.h>
 #include <linux/quotaops.h>
 #include <linux/mutex.h>
 #include <linux/namei.h>
@@ -367,11 +368,15 @@ int simple_remove(struct inode *dir, struct
dentry *dentry)
         * protect d_delete() from accessing a freed dentry.
         */
        dget(dentry);
-       if (d_is_dir(dentry))
+       if (d_is_dir(dentry)) {
                ret = simple_rmdir(dir, dentry);
-       else
+               if (!ret)
+                       fsnotify_rmdir(dir, dentry);
+       } else {
                ret = simple_unlink(dir, dentry);
-
+               if (!ret)
+                       fsnotify_unlink(dir, dentry);
+       }
        if (!ret)
                d_delete(dentry);
        dput(dentry);
diff --git a/fs/namei.c b/fs/namei.c
index 20831c2fbb34..209c51a5226c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3883,6 +3883,7 @@ int vfs_rmdir(struct inode *dir, struct dentry *dentry)
        dentry->d_inode->i_flags |= S_DEAD;
        dont_mount(dentry);
        detach_mounts(dentry);
+       fsnotify_rmdir(dir, dentry);

 out:
        inode_unlock(dentry->d_inode);
@@ -3999,6 +4000,7 @@ int vfs_unlink(struct inode *dir, struct dentry
*dentry, struct inode **delegate
                        if (!error) {
                                dont_mount(dentry);
                                detach_mounts(dentry);
+                               fsnotify_unlink(dir, dentry);
                        }
                }
        }
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 94972e8eb6d1..7f23eddefcd0 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -188,6 +188,19 @@ static inline void fsnotify_link(struct inode
*dir, struct inode *inode, struct
        fsnotify(dir, FS_CREATE, inode, FSNOTIFY_EVENT_INODE,
&new_dentry->d_name, 0);
 }

+/*
+ * fsnotify_unlink - 'name' was unlinked
+ *
+ * Caller must make sure that dentry->d_name is stable.
+ */
+static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
+{
+       /* Expected to be called before d_delete() */
+       WARN_ON_ONCE(d_is_negative(dentry));
+
+       /* TODO: call fsnotify_dirent() */
+}
+
 /*
  * fsnotify_mkdir - directory 'name' was created
  */
@@ -198,6 +211,19 @@ static inline void fsnotify_mkdir(struct inode
*inode, struct dentry *dentry)
        fsnotify_dirent(inode, dentry, FS_CREATE | FS_ISDIR);
 }

+/*
+ * fsnotify_rmdir - directory 'name' was removed
+ *
+ * Caller must make sure that dentry->d_name is stable.
+ */
+static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
+{
+       /* Expected to be called before d_delete() */
+       WARN_ON_ONCE(d_is_negative(dentry));
+
+       /* TODO: call fsnotify_dirent() */
+}
+
 /*
  * fsnotify_access - file was read
  */
--
2.17.1
