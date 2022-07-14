Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB930574457
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 07:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiGNFLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 01:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiGNFLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:11:37 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5CDF0;
        Wed, 13 Jul 2022 22:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1657775493; i=@fujitsu.com;
        bh=0rccgM5gxqZqyMjmm0ONjvltkJ29F+tzTgVYE63iOQs=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Z1MPSaRAeeDo6dsNT0iMX6xDxX3mKJeq+iHjruE9h/v7daTVu1IFs1vQfMOM5B8W3
         hE9hQ2ahB6QN6Tsz8b4Qy0SW+ChtgvOR+DwJ1Oto96NOTjUTYKaRFpiBu4awgPsZos
         TUjjiM9Rew+84FmHPTqvxoqA5tGGhIN5rfhWjeZwwIm4mECuBn/fh/R9lSqWY67lCx
         fkdbREx9TN/6l6KSOOwgEHRCITWaTx/FAl7w/tjT+lNOD8D/5zwR3taZzWaulcxg8/
         Ccldg2I7OxsbOV3u9S1+rU3lGOt+RpjpjFPnkRBsLbLfFZfZhyBkSpGHLSivpBKeCQ
         ouvJnFnumRFrA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRWlGSWpSXmKPExsViZ8MxSbdl6fk
  kg+bFwhavD39itPhwcxKTxZZj9xgtLj/hs/i5bBW7xZ69J1ksfty6wWJx/u9xVovfP+awOXB6
  nFok4bF5hZbHplWdbB5nFhxh9/i8Sc5j05O3TAFsUayZeUn5FQmsGddffGQseNXMWLGmeRdLA
  +O/3C5GLg4hgS2MEmcvT2KGcJYzSbw7to0VwtnDKLH4zUf2LkZODjYBTYlnnQuYQWwRAUeJF+
  0zWECKmAX2Mko0bTrPApIQFvCRePXxNBOIzSKgKnF07VtWEJtXwEPi7qP3YIMkBBQkpjx8Dza
  IU8BT4vitzYwgthBQzfJbC5kg6gUlTs58AjaTWUBC4uCLF8wQvYoSlzq+MULYFRKvD1+CiqtJ
  XD23iXkCo+AsJO2zkLQvYGRaxWiVVJSZnlGSm5iZo2toYKBraGiqa6ZraGapl1ilm6iXWqpbn
  lpcomuol1herJdaXKxXXJmbnJOil5dasokRGEUpxWwrdzCu7Pupd4hRkoNJSZT39qLzSUJ8Sf
  kplRmJxRnxRaU5qcWHGGU4OJQkeOUXA+UEi1LTUyvSMnOAEQ2TluDgURLhfQrSyltckJhbnJk
  OkTrFaMmxtuHAXmaOp89PAMmps//tZxZiycvPS5US541ZAtQgANKQUZoHNw6WdC4xykoJ8zIy
  MDAI8RSkFuVmlqDKv2IU52BUEuaVB5nCk5lXArf1FdBBTEAHyUWeATmoJBEhJdXAJKH44g/zl
  3Ofo0q42iquqJXNtEn9+sdRTOWglU25JMc1M/06HscXDVNb+3oq5b8efJJZ+IzRhrtCl+11J/
  ddyU6fvxKanmtmW1sH3jpyx21pCtPRV44XYhgEttw//y7hbO3mg3HC/2pkPnVlb5iuUbH9TPf
  yOb/fe6xYJb3DQ6pK7FnMonN3GO71bHBe4bc3ZP7PeJOrkpfYzWV5YpKqnz0UCJ99NSO+Z4vd
  gfo7Bq+O7J3cY2Ahu71W6t8R1yiut3xp4WatbP6BxZsYH06Y3/3EIzKIR9Dj/x/FX/tvKfd8C
  vs/Iffm9s79zH8ev57Cx3xa/bq9+ITerTMyDKtELGVlSi6qS8X2Cckub+FXYinOSDTUYi4qTg
  QA5afR2bUDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-18.tower-585.messagelabs.com!1657775492!253663!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18152 invoked from network); 14 Jul 2022 05:11:32 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-18.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Jul 2022 05:11:32 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id D42341000CC;
        Thu, 14 Jul 2022 06:11:31 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id C67891000C1;
        Thu, 14 Jul 2022 06:11:31 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 14 Jul 2022 06:11:27 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, <xuyang2018.jy@fujitsu.com>, <pvorel@suse.cz>
Subject: [PATCH v10 3/4] fs: move S_ISGID stripping into the vfs_*() helpers
Date:   Thu, 14 Jul 2022 14:11:27 +0800
Message-ID: <1657779088-2242-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657779088-2242-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1657779088-2242-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Creating files that have both the S_IXGRP and S_ISGID bit raised in
directories that themselves have the S_ISGID bit set requires additional
privileges to avoid security issues.

When a filesystem creates a new inode it needs to take care that the
caller is either in the group of the newly created inode or they have
CAP_FSETID in their current user namespace and are privileged over the
parent directory of the new inode. If any of these two conditions is
true then the S_ISGID bit can be raised for an S_IXGRP file and if not
it needs to be stripped.

However, there are several key issues with the current state of things:

* The S_ISGID stripping logic is entangled with umask stripping.

  If a filesystem doesn't support or enable POSIX ACLs then umask
  stripping is done directly in the vfs before calling into the
  filesystem.
  If the filesystem does support POSIX ACLs then unmask stripping may be
  done in the filesystem itself when calling posix_acl_create().

* Filesystems that don't rely on inode_init_owner() don't get S_ISGID
  stripping logic.

  While that may be intentional (e.g. network filesystems might just
  defer setgid stripping to a server) it is often just a security issue.

* The first two points taken together mean that there's a
  non-standardized ordering between setgid stripping in
  inode_init_owner() and posix_acl_create() both on the vfs level and
  the filesystem level. The latter part is especially problematic since
  each filesystem is technically free to order inode_init_owner() and
  posix_acl_create() however it sees fit meaning that S_ISGID
  inheritance might or might not be applied.

* We do still have bugs in this areas years after the initial round of
  setgid bugfixes.

So the current state is quite messy and while we won't be able to make
it completely clean as posix_acl_create() is still a filesystem specific
call we can improve the S_SIGD stripping situation quite a bit by
hoisting it out of inode_init_owner() and into the vfs creation
operations. This means we alleviate the burden for filesystems to handle
S_ISGID stripping correctly and can standardize the ordering between
S_ISGID and umask stripping in the vfs.

The S_ISGID bit is stripped before any umask is applied. This has the
advantage that the ordering is unaffected by whether umask stripping is
done by the vfs itself (if no POSIX ACLs are supported or enabled) or in
the filesystem in posix_acl_create() (if POSIX ACLs are supported).

To this end a new helper vfs_prepare_mode() is added which calls the
previously added mode_strip_setgid() helper and strips the umask
afterwards.

All inode operations that create new filesystem objects have been
updated to call vfs_prepare_mode() before passing the mode into the
relevant inode operation of the filesystems. Care has been taken to
ensure that the mode passed to the security hooks is the mode that is
seen by the filesystem.

Moving S_ISGID stripping from filesystem callpaths into the vfs_*() helper
(Christian Brauner wrote a draft patch for this, see [1]) instead of these
do_* helpers because that filesystems that call vfs_*() helpers directly 
still can rely on S_ISGID stripping.

This mostly affects overlayfs which calls vfs_*() functions directly. So
a typical overlayfs callstack would be
sys_mknod()
-> do_mknodat(mode)
   -> .mknod = ovl_mknod(mode)
      -> ovl_create(mode)
         -> vfs_mknod(mode)

By moving setgid stripping into vfs_*() helpers we achieve:
- Moving setgid stripping out of the individual filesystem's responsibility.
- Ensure that callers of vfs_*() helpers continue to get correct setgid
  stripping.

Security hooks currently see a different mode than the
actual filesystem sees when it calls into inode_init_owner(). This patch
doesn't change that!

Following is an overview of the filesystem specific and inode operations
specific implications:

arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
fs/9p/vfs_inode.c:      inode_init_owner(&init_user_ns, inode, NULL, mode);
fs/bfs/dir.c:   inode_init_owner(&init_user_ns, inode, dir, mode);
fs/btrfs/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
fs/btrfs/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
fs/btrfs/inode.c:       inode_init_owner(mnt_userns, inode, dir, S_IFDIR | mode);
fs/btrfs/inode.c:               inode_init_owner(mnt_userns, inode, NULL,
fs/btrfs/inode.c:               inode_init_owner(mnt_userns, inode, dir,
fs/btrfs/inode.c:       inode_init_owner(mnt_userns, inode, dir, S_IFLNK | S_IRWXUGO);
fs/btrfs/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
fs/btrfs/tests/btrfs-tests.c:   inode_init_owner(&init_user_ns, inode, NULL, S_IFREG);
fs/ext2/ialloc.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
fs/ext4/ialloc.c:               inode_init_owner(mnt_userns, inode, dir, mode);
fs/f2fs/namei.c:        inode_init_owner(mnt_userns, inode, dir, mode);
fs/hfsplus/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
fs/hugetlbfs/inode.c:           inode_init_owner(&init_user_ns, inode, dir, mode);
fs/jfs/jfs_inode.c:     inode_init_owner(&init_user_ns, inode, parent, mode);
fs/minix/bitmap.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
fs/nilfs2/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
fs/ntfs3/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
fs/ocfs2/dlmfs/dlmfs.c:         inode_init_owner(&init_user_ns, inode, NULL, mode);
fs/ocfs2/dlmfs/dlmfs.c: inode_init_owner(&init_user_ns, inode, parent, mode);
fs/ocfs2/namei.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
fs/omfs/inode.c:        inode_init_owner(&init_user_ns, inode, NULL, mode);
fs/overlayfs/dir.c:     inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
fs/ramfs/inode.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
fs/reiserfs/namei.c:    inode_init_owner(&init_user_ns, inode, dir, mode);
fs/sysv/ialloc.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
fs/ubifs/dir.c: inode_init_owner(&init_user_ns, inode, dir, mode);
fs/udf/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
fs/ufs/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
fs/xfs/xfs_inode.c:             inode_init_owner(mnt_userns, inode, dir, mode);
fs/zonefs/super.c:      inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
kernel/bpf/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
mm/shmem.c:             inode_init_owner(&init_user_ns, inode, dir, mode);

All of the above filesystems end up calling inode_init_owner() when new
filesystem objects are created through the following ->mkdir(),
->symlink(), ->mknod(), ->create(), ->tmpfile(), ->rename() inode
operations.

Since directories always inherit the S_ISGID bit with the exception of
xfs when irix_sgid_inherit mode is turned on S_ISGID stripping doesn't
apply. The ->symlink() inode operation trivially inherit the mode from
the target and the ->rename() inode operation inherits the mode from the
source inode.

All other inode operations will have the S_ISGID bit stripped once in
vfs_prepare_mode() before.

In addition to this there are filesystems which allow the creation of
filesystem objects through ioctl()s or - in the case of spufs -
circumventing the vfs in other ways. If filesystem objects are created
through ioctl()s the vfs doesn't know about it and can't apply regular
permission checking including S_ISGID logic. Therfore, a filesystem
relying on S_ISGID stripping in inode_init_owner() in their ioctl()
callpath will be affected by moving this logic into the vfs.

So we did our best to audit all filesystems in this regard:

* btrfs allows the creation of filesystem objects through various
  ioctls(). Snapshot creation literally takes a snapshot and so the mode
  is fully preserved and S_ISGID stripping doesn't apply.

  Creating a new subvolum relies on inode_init_owner() in
  btrfs_new_subvol_inode() but only creates directories and doesn't
  raise S_ISGID.

* ocfs2 has a peculiar implementation of reflinks. In contrast to e.g.
  xfs and btrfs FICLONE/FICLONERANGE ioctl() that is only concerned with
  the actual extents ocfs2 uses a separate ioctl() that also creates the
  target file.

  Iow, ocfs2 circumvents the vfs entirely here and did indeed rely on
  inode_init_owner() to strip the S_ISGID bit. This is the only place
  where a filesystem needs to call mode_strip_sgid() directly but this
  is self-inflicted pain tbh.

* spufs doesn't go through the vfs at all and doesn't use ioctl()s
  either. Instead it has a dedicated system call spufs_create() which
  allows the creation of filesystem objects. But spufs only creates
  directories and doesn't allo S_SIGID bits, i.e. it specifically only
  allows 0777 bits.

* bpf uses vfs_mkobj() but also doesn't allow S_ISGID bits to be created.

This patch also changed grpid behaviour for ext4/xfs because the mode
passed to them may have been changed by vfs_prepare_mode.

While we did our best to audit everything there's a risk of regressions
in here. However, for the sake of maintenance and given that we've seen
a range of bugs years after S_ISGID inheritance issues were fixed (see
[1]-[3]) the risk seems worth taking. In the worst case we will have to
revert.

Associated with this change is a new set of fstests to enforce the
semantics for all new filesystems.

Link: https://lore.kernel.org/ceph-devel/20220427092201.wvsdjbnc7b4dttaw@wittgenstein [1]
Link: e014f37db1a2 ("xfs: use setattr_copy to set vfs inode attributes") [2]
Link: 01ea173e103e ("xfs: fix up non-directory creation in SGID directories") [3]
Link: fd84bfdddd16 ("ceph: fix up non-directory creation in SGID directories") [4]
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Suggested-by: Dave Chinner <david@fromorbit.com>
Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-and-Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v9->v10:
1.move strip logic into vfs_* helper instead of vfs
2.add the place of calling inode_init_owner in btrfs and use btrfs_new_subvol_inode
instead of btrfs_new_inode because of btrfs code update
3.TODO: move mode_strup_umask into fs/namei.h or other header, so many
place can use this function ie fs/init.c or fs/nfsd/nfs4proc.c 
 fs/inode.c       |  2 --
 fs/namei.c       | 83 ++++++++++++++++++++++++++++++++++++++++--------
 fs/ocfs2/namei.c |  1 +
 3 files changed, 71 insertions(+), 15 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 133bf018d6ee..027b76a57c0f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2246,8 +2246,6 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		/* Directories are special, and always inherit S_ISGID */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else
-			mode = mode_strip_sgid(mnt_userns, dir, mode);
 	} else
 		inode_fsgid_set(inode, mnt_userns);
 	inode->i_mode = mode;
diff --git a/fs/namei.c b/fs/namei.c
index ac4225ad6ac4..0752969c830f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3042,6 +3042,65 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(unlock_rename);
 
+/**
+ * mode_strip_umask - handle vfs umask stripping
+ * @dir:	parent directory of the new inode
+ * @mode:	mode of the new inode to be created in @dir
+ *
+ * Umask stripping depends on whether or not the filesystem supports POSIX
+ * ACLs. If the filesystem doesn't support it umask stripping is done directly
+ * in here. If the filesystem does support POSIX ACLs umask stripping is
+ * deferred until the filesystem calls posix_acl_create().
+ *
+ * Returns: mode
+ */
+static inline umode_t mode_strip_umask(const struct inode *dir, umode_t mode)
+{
+	if (!IS_POSIXACL(dir))
+		mode &= ~current_umask();
+	return mode;
+}
+
+/**
+ * vfs_prepare_mode - prepare the mode to be used for a new inode
+ * @mnt_userns:		user namespace of the mount the inode was found from
+ * @dir:	parent directory of the new inode
+ * @mode:	mode of the new inode
+ * @mask_perms:	allowed permission by the vfs
+ * @type:	type of file to be created
+ *
+ * This helper consolidates and enforces vfs restrictions on the @mode of a new
+ * object to be created.
+ *
+ * Umask stripping depends on whether the filesystem supports POSIX ACLs (see
+ * the kernel documentation for mode_strip_umask()). Moving umask stripping
+ * after setgid stripping allows the same ordering for both non-POSIX ACL and
+ * POSIX ACL supporting filesystems.
+ *
+ * Note that it's currently valid for @type to be 0 if a directory is created.
+ * Filesystems raise that flag individually and we need to check whether each
+ * filesystem can deal with receiving S_IFDIR from the vfs before we enforce a
+ * non-zero type.
+ *
+ * Returns: mode to be passed to the filesystem
+ */
+static inline umode_t vfs_prepare_mode(struct user_namespace *mnt_userns,
+				       const struct inode *dir, umode_t mode,
+				       umode_t mask_perms, umode_t type)
+{
+	mode = mode_strip_sgid(mnt_userns, dir, mode);
+	mode = mode_strip_umask(dir, mode);
+
+	/*
+	 * Apply the vfs mandated allowed permission mask and set the type of
+	 * file to be created before we call into the filesystem.
+	 */
+	mode &= (mask_perms & ~S_IFMT);
+	mode |= (type & S_IFMT);
+
+	return mode;
+}
+
 /**
  * vfs_create - create new file
  * @mnt_userns:	user namespace of the mount the inode was found from
@@ -3067,8 +3126,8 @@ int vfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 
 	if (!dir->i_op->create)
 		return -EACCES;	/* shouldn't it be ENOSYS? */
-	mode &= S_IALLUGO;
-	mode |= S_IFREG;
+
+	mode = vfs_prepare_mode(mnt_userns, dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
@@ -3331,8 +3390,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		if (!IS_POSIXACL(dir->d_inode))
-			mode &= ~current_umask();
+		mode = vfs_prepare_mode(mnt_userns, dir->d_inode, mode, mode, mode);
 		if (likely(got_write))
 			create_error = may_o_create(mnt_userns, &nd->path,
 						    dentry, mode);
@@ -3565,8 +3623,7 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 	child = d_alloc(dentry, &slash_name);
 	if (unlikely(!child))
 		goto out_err;
-	if (!IS_POSIXACL(dir))
-		mode &= ~current_umask();
+	mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
 	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
 	if (error)
 		goto out_err;
@@ -3844,6 +3901,7 @@ int vfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (!dir->i_op->mknod)
 		return -EPERM;
 
+	mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
 	error = devcgroup_inode_mknod(mode, dev);
 	if (error)
 		return error;
@@ -3894,9 +3952,9 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	if (IS_ERR(dentry))
 		goto out1;
 
-	if (!IS_POSIXACL(path.dentry->d_inode))
-		mode &= ~current_umask();
-	error = security_path_mknod(&path, dentry, mode, dev);
+	error = security_path_mknod(&path, dentry,
+				    mode_strip_umask(path.dentry->d_inode, mode),
+				    dev);
 	if (error)
 		goto out2;
 
@@ -3966,7 +4024,7 @@ int vfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (!dir->i_op->mkdir)
 		return -EPERM;
 
-	mode &= (S_IRWXUGO|S_ISVTX);
+	mode = vfs_prepare_mode(mnt_userns, dir, mode, S_IRWXUGO | S_ISVTX, 0);
 	error = security_inode_mkdir(dir, dentry, mode);
 	if (error)
 		return error;
@@ -3994,15 +4052,14 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	if (IS_ERR(dentry))
 		goto out_putname;
 
-	if (!IS_POSIXACL(path.dentry->d_inode))
-		mode &= ~current_umask();
-	error = security_path_mkdir(&path, dentry, mode);
+	error = security_path_mkdir(&path, dentry, mode_strip_umask(path.dentry->d_inode, mode));
 	if (!error) {
 		struct user_namespace *mnt_userns;
 		mnt_userns = mnt_user_ns(path.mnt);
 		error = vfs_mkdir(mnt_userns, path.dentry->d_inode, dentry,
 				  mode);
 	}
+
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index c75fd54b9185..961d1cf54388 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -197,6 +197,7 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
 	 * callers. */
 	if (S_ISDIR(mode))
 		set_nlink(inode, 2);
+	mode = mode_strip_sgid(&init_user_ns, dir, mode);
 	inode_init_owner(&init_user_ns, inode, dir, mode);
 	status = dquot_initialize(inode);
 	if (status)
-- 
2.27.0

