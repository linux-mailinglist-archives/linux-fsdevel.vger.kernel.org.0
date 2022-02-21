Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460E54BD7AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 09:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiBUIUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 03:20:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiBUIUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:20:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F7BFD52
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 00:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645431608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OuPGiSLCP1c+ausY8+TdT3tZutPgtrWugQKvxmUX/7w=;
        b=UyvUPdqmcYLrZj+IxZfueExJ6Zk7Jx5Hc/8b3U5FdRCJ8kAiebuxXJUXBtLVskIVzpMHke
        miRmYs40tej6auqtzj8Yb5nXrKvsXqT2TrKxz75pzPOLpoV2Y3ONiRArVRbrt4V5hwDAJZ
        E+KcdeIlaCIUIQuxvNh+Gj88YWDuUt8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-CRm_LjTGPPmKQblWFpqWrQ-1; Mon, 21 Feb 2022 03:20:06 -0500
X-MC-Unique: CRm_LjTGPPmKQblWFpqWrQ-1
Received: by mail-ed1-f70.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so9728976edb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 00:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OuPGiSLCP1c+ausY8+TdT3tZutPgtrWugQKvxmUX/7w=;
        b=MNfPeqtvbXeTpalhLLRrL6WI4UHJ3KObk//kTPnPfvv5Bo0lLPz9q2Rp4m598DZNtY
         Xn0y3M0PCs+zbKuVFtN9Sp6o0hJaLpBSciDF1DRxL2bCNjNt/OuHy+hxQhErWbusZOAP
         WpbaJp5GH3kmXA/ZXw5qoOkdddcc3IR9rJOua5EIMDbRdoW1K99z1v6FJ4YMKrGzdC9/
         FDBa5KpBCdMed3os6T+ozLWMztErr7fpQXzxYfEjic1Vt6j6VOinWHQRNewLXqll5e6S
         bj1NoP1i3TU9DbB1KbLEoIJgsy4TC7ElKo0aBQPgayiwzI/oFf8w4jfXuiX6Vj1fISBM
         G3Sw==
X-Gm-Message-State: AOAM533MlpLcum5tgSh3HCqJKmUI8I6BRG5EjS53pV/UREFH19k5cpZQ
        Z7k5GXRF9w1O4deKYsMJtybX2GAPYl3i+s63giEBmE58iAF1GatpDx3+gs32+8Afwz3KIGl61vU
        ciSXZLmrXODQATM5obNB8cLcpNA==
X-Received: by 2002:a17:906:174f:b0:6d0:5629:e4be with SMTP id d15-20020a170906174f00b006d05629e4bemr14590128eje.525.1645431605041;
        Mon, 21 Feb 2022 00:20:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxX/mSLz7e+iY4ov1PUHtRqslwz5GQ33iKZuVMi11Zwb9XoYrtzGIBwPd0JL/oFCEdpRSAt2g==
X-Received: by 2002:a17:906:174f:b0:6d0:5629:e4be with SMTP id d15-20020a170906174f00b006d05629e4bemr14590116eje.525.1645431604768;
        Mon, 21 Feb 2022 00:20:04 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id t29sm5626495edi.84.2022.02.21.00.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 00:20:04 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] vfs: fix link vs. rename race
Date:   Mon, 21 Feb 2022 09:20:02 +0100
Message-Id: <20220221082002.508392-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There has been a longstanding race condition between rename(2) and link(2),
when those operations are done in parallel:

1. Moving a file to an existing target file (eg. mv file target)
2. Creating a link from the target file to a third file (eg. ln target
   link)

By the time vfs_link() locks the target inode, it might already be unlinked
by rename.  This results in vfs_link() returning -ENOENT in order to
prevent linking to already unlinked files.  This check was introduced in
v2.6.39 by commit aae8a97d3ec3 ("fs: Don't allow to create hardlink for
deleted file").

This breaks apparent atomicity of rename(2), which is described in
standards and the man page:

    "If newpath already exists, it will be atomically replaced, so that
     there is no point at which another process attempting to access
     newpath will find it missing."

The simplest fix is to exclude renames for the complete link operation.

This patch introduces a global rw_semaphore that is locked for read in
rename and for write in link.  To prevent excessive contention, do not take
the lock in link on the first try.  If the source of the link was found to
be unlinked, then retry with the lock held.

Reuse the lock_rename()/unlock_rename() helpers for the rename part.  This
however needs special treatment for stacking fs (overlayfs, ecryptfs) to
prevent possible deadlocks.  Introduce [un]lock_rename_stacked() for this
purpose.

Reproducer can be found at:

  https://lore.kernel.org/all/20220216131814.GA2463301@xavier-xps/

Reported-by: Xavier Roche <xavier.roche@algolia.com>
Link: https://lore.kernel.org/all/20220214210708.GA2167841@xavier-xps/
Fixes: aae8a97d3ec3 ("fs: Don't allow to create hardlink for deleted file")
Tested-by: Xavier Roche <xavier.roche@algolia.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/ecryptfs/inode.c    |  4 ++--
 fs/namei.c             | 35 ++++++++++++++++++++++++++++++++---
 fs/overlayfs/copy_up.c |  4 ++--
 fs/overlayfs/dir.c     | 12 ++++++------
 fs/overlayfs/util.c    |  4 ++--
 include/linux/namei.h  |  4 ++++
 6 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 16d50dface59..f5c37599bd40 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -596,7 +596,7 @@ ecryptfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 	target_inode = d_inode(new_dentry);
 
-	trap = lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
+	trap = lock_rename_stacked(lower_old_dir_dentry, lower_new_dir_dentry);
 	dget(lower_new_dentry);
 	rc = -EINVAL;
 	if (lower_old_dentry->d_parent != lower_old_dir_dentry)
@@ -631,7 +631,7 @@ ecryptfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		fsstack_copy_attr_all(old_dir, d_inode(lower_old_dir_dentry));
 out_lock:
 	dput(lower_new_dentry);
-	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
+	unlock_rename_stacked(lower_old_dir_dentry, lower_new_dir_dentry);
 	return rc;
 }
 
diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..27e671c354a6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -122,6 +122,8 @@
  * PATH_MAX includes the nul terminator --RR.
  */
 
+static DECLARE_RWSEM(link_rwsem);
+
 #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
 
 struct filename *
@@ -2954,10 +2956,11 @@ static inline int may_create(struct user_namespace *mnt_userns,
 	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
 }
 
+
 /*
  * p1 and p2 should be directories on the same fs.
  */
-struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+struct dentry *lock_rename_stacked(struct dentry *p1, struct dentry *p2)
 {
 	struct dentry *p;
 
@@ -2986,9 +2989,16 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
 	return NULL;
 }
+EXPORT_SYMBOL(lock_rename_stacked);
+
+struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+{
+	down_read(&link_rwsem);
+	return lock_rename_stacked(p1, p2);
+}
 EXPORT_SYMBOL(lock_rename);
 
-void unlock_rename(struct dentry *p1, struct dentry *p2)
+void unlock_rename_stacked(struct dentry *p1, struct dentry *p2)
 {
 	inode_unlock(p1->d_inode);
 	if (p1 != p2) {
@@ -2996,6 +3006,13 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 		mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
 	}
 }
+EXPORT_SYMBOL(unlock_rename_stacked);
+
+void unlock_rename(struct dentry *p1, struct dentry *p2)
+{
+	unlock_rename_stacked(p1, p2);
+	up_read(&link_rwsem);
+}
 EXPORT_SYMBOL(unlock_rename);
 
 /**
@@ -4456,6 +4473,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	struct path old_path, new_path;
 	struct inode *delegated_inode = NULL;
 	int how = 0;
+	bool lock = false;
 	int error;
 
 	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0) {
@@ -4474,10 +4492,13 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 
 	if (flags & AT_SYMLINK_FOLLOW)
 		how |= LOOKUP_FOLLOW;
+retry_lock:
+	if (lock)
+		down_write(&link_rwsem);
 retry:
 	error = filename_lookup(olddfd, old, how, &old_path, NULL);
 	if (error)
-		goto out_putnames;
+		goto out_unlock_link;
 
 	new_dentry = filename_create(newdfd, new, &new_path,
 					(how & LOOKUP_REVAL));
@@ -4511,8 +4532,16 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 		how |= LOOKUP_REVAL;
 		goto retry;
 	}
+	if (!lock && error == -ENOENT) {
+		path_put(&old_path);
+		lock = true;
+		goto retry_lock;
+	}
 out_putpath:
 	path_put(&old_path);
+out_unlock_link:
+	if (lock)
+		up_write(&link_rwsem);
 out_putnames:
 	putname(old);
 	putname(new);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index e040970408d4..911c3cec43c2 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -670,7 +670,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 
 	/* workdir and destdir could be the same when copying up to indexdir */
 	err = -EIO;
-	if (lock_rename(c->workdir, c->destdir) != NULL)
+	if (lock_rename_stacked(c->workdir, c->destdir) != NULL)
 		goto unlock;
 
 	err = ovl_prep_cu_creds(c->dentry, &cc);
@@ -711,7 +711,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
 unlock:
-	unlock_rename(c->workdir, c->destdir);
+	unlock_rename_stacked(c->workdir, c->destdir);
 
 	return err;
 
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index f18490813170..fea397666174 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -416,7 +416,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 
 	ovl_cleanup_whiteouts(upper, list);
 	ovl_cleanup(wdir, upper);
-	unlock_rename(workdir, upperdir);
+	unlock_rename_stacked(workdir, upperdir);
 
 	/* dentry's upper doesn't match now, get rid of it */
 	d_drop(dentry);
@@ -427,7 +427,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	ovl_cleanup(wdir, opaquedir);
 	dput(opaquedir);
 out_unlock:
-	unlock_rename(workdir, upperdir);
+	unlock_rename_stacked(workdir, upperdir);
 out:
 	return ERR_PTR(err);
 }
@@ -551,7 +551,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 out_dput:
 	dput(upper);
 out_unlock:
-	unlock_rename(workdir, upperdir);
+	unlock_rename_stacked(workdir, upperdir);
 out:
 	if (!hardlink) {
 		posix_acl_release(acl);
@@ -790,7 +790,7 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 out_dput_upper:
 	dput(upper);
 out_unlock:
-	unlock_rename(workdir, upperdir);
+	unlock_rename_stacked(workdir, upperdir);
 out_dput:
 	dput(opaquedir);
 out:
@@ -1187,7 +1187,7 @@ static int ovl_rename(struct user_namespace *mnt_userns, struct inode *olddir,
 		}
 	}
 
-	trap = lock_rename(new_upperdir, old_upperdir);
+	trap = lock_rename_stacked(new_upperdir, old_upperdir);
 
 	olddentry = lookup_one_len(old->d_name.name, old_upperdir,
 				   old->d_name.len);
@@ -1281,7 +1281,7 @@ static int ovl_rename(struct user_namespace *mnt_userns, struct inode *olddir,
 out_dput_old:
 	dput(olddentry);
 out_unlock:
-	unlock_rename(new_upperdir, old_upperdir);
+	unlock_rename_stacked(new_upperdir, old_upperdir);
 out_revert_creds:
 	revert_creds(old_cred);
 	if (update_nlink)
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f48284a2a896..9358282278b1 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -930,13 +930,13 @@ int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir)
 		goto err;
 
 	/* Workdir should not be subdir of upperdir and vice versa */
-	if (lock_rename(workdir, upperdir) != NULL)
+	if (lock_rename_stacked(workdir, upperdir) != NULL)
 		goto err_unlock;
 
 	return 0;
 
 err_unlock:
-	unlock_rename(workdir, upperdir);
+	unlock_rename_stacked(workdir, upperdir);
 err:
 	pr_err("failed to lock workdir+upperdir\n");
 	return -EIO;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index e89329bb3134..0a87bb0d56ce 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -77,6 +77,10 @@ extern int follow_up(struct path *);
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 
+/* Special version of the above for stacking filesystems */
+extern struct dentry *lock_rename_stacked(struct dentry *, struct dentry *);
+extern void unlock_rename_stacked(struct dentry *, struct dentry *);
+
 extern int __must_check nd_jump_link(struct path *path);
 
 static inline void nd_terminate_link(void *name, size_t len, size_t maxlen)
-- 
2.34.1

