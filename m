Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC1441AB10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 10:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbhI1Iv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 04:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239768AbhI1Ivp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632819006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GzDX+vQGQswidEJZ9asw0Hf411IrZwGPqiRkhkcHu/Y=;
        b=bs07Y54XvWyhnZ75iIkYMAkHdUDGyZLJ6Uw3uKHBKgm6K2U9pBkSgR4l72qqzziELMHzOp
        ByrQG8q4WiVvUoYuP1YR0ZUH5TG6cEgZAbuCMzntGSz24tH0KlOuSk6F5hI4KzF2y2Rj1Q
        kwlt9ej0k3ngLrQG1g4Jd4MIssdXYq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-3ueACyZEMPq7Doa0vDnGLA-1; Tue, 28 Sep 2021 04:50:02 -0400
X-MC-Unique: 3ueACyZEMPq7Doa0vDnGLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B1411084686;
        Tue, 28 Sep 2021 08:50:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2C075C1C5;
        Tue, 28 Sep 2021 08:49:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH v2] fscache, 9p, afs,
 nfs: Deal with some warnings from W=1
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 28 Sep 2021 09:49:57 +0100
Message-ID: <163281899704.2790286.9177774252843775348.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Deal with some warnings generated from make W=1:

 (1) Add/remove/fix kerneldoc parameters descriptions.

 (2) afs_sillyrename() isn't an API functions, so remove the kerneldoc
     annotation.

 (3) The fscache object CREATE_OBJECT work state isn't used, so remove it.

 (4) Move __add_fid() from between v9fs_fid_add() and its comment.

 (5) 9p's caches_show() doesn't really make sense as an API function, show
     remove the kerneldoc annotation.  It's also not prefixed with 'v9fs_'.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Anna Schumaker <anna.schumaker@netapp.com>
cc: Mauro Carvalho Chehab <mchehab@kernel.org>
cc: v9fs-developer@lists.sourceforge.net
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-doc@vger.kernel.org
---

 fs/9p/fid.c            |   14 +++++++-------
 fs/9p/v9fs.c           |    8 +++-----
 fs/9p/vfs_addr.c       |   15 ++++++++++-----
 fs/9p/vfs_file.c       |   33 ++++++++++++---------------------
 fs/9p/vfs_inode.c      |   24 ++++++++++++++++--------
 fs/9p/vfs_inode_dotl.c |   11 +++++++++--
 fs/afs/dir_silly.c     |    4 ++--
 fs/fscache/object.c    |    2 +-
 fs/fscache/operation.c |    3 +++
 fs/nfs_common/grace.c  |    1 -
 10 files changed, 63 insertions(+), 52 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 9d9de62592be..b8863dd0de5c 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -19,18 +19,18 @@
 #include "v9fs_vfs.h"
 #include "fid.h"
 
+static inline void __add_fid(struct dentry *dentry, struct p9_fid *fid)
+{
+	hlist_add_head(&fid->dlist, (struct hlist_head *)&dentry->d_fsdata);
+}
+
+
 /**
  * v9fs_fid_add - add a fid to a dentry
  * @dentry: dentry that the fid is being added to
  * @fid: fid to add
  *
  */
-
-static inline void __add_fid(struct dentry *dentry, struct p9_fid *fid)
-{
-	hlist_add_head(&fid->dlist, (struct hlist_head *)&dentry->d_fsdata);
-}
-
 void v9fs_fid_add(struct dentry *dentry, struct p9_fid *fid)
 {
 	spin_lock(&dentry->d_lock);
@@ -67,7 +67,7 @@ static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
 
 /**
  * v9fs_open_fid_add - add an open fid to an inode
- * @dentry: inode that the fid is being added to
+ * @inode: inode that the fid is being added to
  * @fid: fid to add
  *
  */
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index cdb99507ef33..2e0fa7c932db 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -155,6 +155,7 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 /**
  * v9fs_parse_options - parse mount options into session structure
  * @v9ses: existing v9fs session information
+ * @opts: The mount option string
  *
  * Return 0 upon success, -ERRNO upon failure.
  */
@@ -542,12 +543,9 @@ extern int v9fs_error_init(void);
 static struct kobject *v9fs_kobj;
 
 #ifdef CONFIG_9P_FSCACHE
-/**
- * caches_show - list caches associated with a session
- *
- * Returns the size of buffer written.
+/*
+ * List caches associated with a session
  */
-
 static ssize_t caches_show(struct kobject *kobj,
 			   struct kobj_attribute *attr,
 			   char *buf)
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 15017b7ce8f8..cff99f5c05e3 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -61,7 +61,7 @@ static void v9fs_init_rreq(struct netfs_read_request *rreq, struct file *file)
 }
 
 /**
- * v9fs_req_ceanup - Cleanup request initialized by v9fs_init_rreq
+ * v9fs_req_cleanup - Cleanup request initialized by v9fs_init_rreq
  * @mapping: unused mapping of request to cleanup
  * @priv: private data to cleanup, a fid, guaranted non-null.
  */
@@ -104,7 +104,7 @@ static const struct netfs_read_request_ops v9fs_req_ops = {
 
 /**
  * v9fs_vfs_readpage - read an entire page in from 9P
- * @filp: file being read
+ * @file: file being read
  * @page: structure to page
  *
  */
@@ -124,6 +124,8 @@ static void v9fs_vfs_readahead(struct readahead_control *ractl)
 
 /**
  * v9fs_release_page - release the private state associated with a page
+ * @page: The page to be released
+ * @gfp: The caller's allocation restrictions
  *
  * Returns 1 if the page can be released, false otherwise.
  */
@@ -144,9 +146,9 @@ static int v9fs_release_page(struct page *page, gfp_t gfp)
 
 /**
  * v9fs_invalidate_page - Invalidate a page completely or partially
- *
- * @page: structure to page
- * @offset: offset in the page
+ * @page: The page to be invalidated
+ * @offset: offset of the invalidated region
+ * @length: length of the invalidated region
  */
 
 static void v9fs_invalidate_page(struct page *page, unsigned int offset,
@@ -206,6 +208,8 @@ static int v9fs_vfs_writepage(struct page *page, struct writeback_control *wbc)
 
 /**
  * v9fs_launder_page - Writeback a dirty page
+ * @page: The page to be cleaned up
+ *
  * Returns 0 on success.
  */
 
@@ -225,6 +229,7 @@ static int v9fs_launder_page(struct page *page)
 /**
  * v9fs_direct_IO - 9P address space operation for direct I/O
  * @iocb: target I/O control block
+ * @iter: The data/buffer to use
  *
  * The presence of v9fs_direct_IO() in the address space ops vector
  * allowes open() O_DIRECT flags which would have failed otherwise.
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 7ed76a4c18f1..80052497f00f 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -359,14 +359,11 @@ static int v9fs_file_flock_dotl(struct file *filp, int cmd,
 }
 
 /**
- * v9fs_file_read - read from a file
- * @filp: file pointer to read
- * @udata: user data buffer to read data into
- * @count: size of buffer
- * @offset: offset at which to read data
+ * v9fs_file_read_iter - read from a file
+ * @iocb: The operation parameters
+ * @to: The buffer to read into
  *
  */
-
 static ssize_t
 v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -388,11 +385,9 @@ v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 }
 
 /**
- * v9fs_file_write - write to a file
- * @filp: file pointer to write
- * @data: data buffer to write data from
- * @count: size of buffer
- * @offset: offset at which to write data
+ * v9fs_file_write_iter - write to a file
+ * @iocb: The operation parameters
+ * @from: The data to write
  *
  */
 static ssize_t
@@ -574,11 +569,9 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 }
 
 /**
- * v9fs_mmap_file_read - read from a file
- * @filp: file pointer to read
- * @data: user data buffer to read data into
- * @count: size of buffer
- * @offset: offset at which to read data
+ * v9fs_mmap_file_read_iter - read from a file
+ * @iocb: The operation parameters
+ * @to: The buffer to read into
  *
  */
 static ssize_t
@@ -589,11 +582,9 @@ v9fs_mmap_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 }
 
 /**
- * v9fs_mmap_file_write - write to a file
- * @filp: file pointer to write
- * @data: data buffer to write data from
- * @count: size of buffer
- * @offset: offset at which to write data
+ * v9fs_mmap_file_write_iter - write to a file
+ * @iocb: The operation parameters
+ * @from: The data to write
  *
  */
 static ssize_t
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 795706520b5e..08f48b70a741 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -218,7 +218,7 @@ v9fs_blank_wstat(struct p9_wstat *wstat)
 
 /**
  * v9fs_alloc_inode - helper function to allocate an inode
- *
+ * @sb: The superblock to allocate the inode from
  */
 struct inode *v9fs_alloc_inode(struct super_block *sb)
 {
@@ -238,7 +238,7 @@ struct inode *v9fs_alloc_inode(struct super_block *sb)
 
 /**
  * v9fs_free_inode - destroy an inode
- *
+ * @inode: The inode to be freed
  */
 
 void v9fs_free_inode(struct inode *inode)
@@ -343,7 +343,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
  * v9fs_get_inode - helper function to setup an inode
  * @sb: superblock
  * @mode: mode to setup inode with
- *
+ * @rdev: The device numbers to set
  */
 
 struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode, dev_t rdev)
@@ -369,7 +369,7 @@ struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode, dev_t rdev)
 }
 
 /**
- * v9fs_clear_inode - release an inode
+ * v9fs_evict_inode - Remove an inode from the inode cache
  * @inode: inode to release
  *
  */
@@ -665,14 +665,15 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 
 /**
  * v9fs_vfs_create - VFS hook to create a regular file
+ * @mnt_userns: The user namespace of the mount
+ * @dir: The parent directory
+ * @dentry: The name of file to be created
+ * @mode: The UNIX file mode to set
+ * @excl: True if the file must not yet exist
  *
  * open(.., O_CREAT) is handled in v9fs_vfs_atomic_open().  This is only called
  * for mknod(2).
  *
- * @dir: directory inode that is being created
- * @dentry:  dentry that is being deleted
- * @mode: create permissions
- *
  */
 
 static int
@@ -696,6 +697,7 @@ v9fs_vfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 
 /**
  * v9fs_vfs_mkdir - VFS mkdir hook to create a directory
+ * @mnt_userns: The user namespace of the mount
  * @dir:  inode that is being unlinked
  * @dentry: dentry that is being unlinked
  * @mode: mode for new directory
@@ -900,10 +902,12 @@ int v9fs_vfs_rmdir(struct inode *i, struct dentry *d)
 
 /**
  * v9fs_vfs_rename - VFS hook to rename an inode
+ * @mnt_userns: The user namespace of the mount
  * @old_dir:  old dir inode
  * @old_dentry: old dentry
  * @new_dir: new dir inode
  * @new_dentry: new dentry
+ * @flags: RENAME_* flags
  *
  */
 
@@ -1009,6 +1013,7 @@ v9fs_vfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 /**
  * v9fs_vfs_getattr - retrieve file metadata
+ * @mnt_userns: The user namespace of the mount
  * @path: Object to query
  * @stat: metadata structure to populate
  * @request_mask: Mask of STATX_xxx flags indicating the caller's interests
@@ -1050,6 +1055,7 @@ v9fs_vfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 /**
  * v9fs_vfs_setattr - set file metadata
+ * @mnt_userns: The user namespace of the mount
  * @dentry: file whose metadata to set
  * @iattr: metadata assignment structure
  *
@@ -1285,6 +1291,7 @@ static int v9fs_vfs_mkspecial(struct inode *dir, struct dentry *dentry,
 
 /**
  * v9fs_vfs_symlink - helper function to create symlinks
+ * @mnt_userns: The user namespace of the mount
  * @dir: directory inode containing symlink
  * @dentry: dentry for symlink
  * @symname: symlink data
@@ -1340,6 +1347,7 @@ v9fs_vfs_link(struct dentry *old_dentry, struct inode *dir,
 
 /**
  * v9fs_vfs_mknod - create a special file
+ * @mnt_userns: The user namespace of the mount
  * @dir: inode destination for new link
  * @dentry: dentry for file
  * @mode: mode for creation
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index e1c0240b51c0..01b9e1281a29 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -37,7 +37,10 @@ v9fs_vfs_mknod_dotl(struct user_namespace *mnt_userns, struct inode *dir,
 		    struct dentry *dentry, umode_t omode, dev_t rdev);
 
 /**
- * v9fs_get_fsgid_for_create - Helper function to get the gid for creating a
+ * v9fs_get_fsgid_for_create - Helper function to get the gid for a new object
+ * @dir_inode: The directory inode
+ *
+ * Helper function to get the gid for creating a
  * new file system object. This checks the S_ISGID to determine the owning
  * group of the new file system object.
  */
@@ -211,12 +214,13 @@ int v9fs_open_to_dotl_flags(int flags)
 
 /**
  * v9fs_vfs_create_dotl - VFS hook to create files for 9P2000.L protocol.
+ * @mnt_userns: The user namespace of the mount
  * @dir: directory inode that is being created
  * @dentry:  dentry that is being deleted
  * @omode: create permissions
+ * @excl: True if the file must not yet exist
  *
  */
-
 static int
 v9fs_vfs_create_dotl(struct user_namespace *mnt_userns, struct inode *dir,
 		     struct dentry *dentry, umode_t omode, bool excl)
@@ -361,6 +365,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 
 /**
  * v9fs_vfs_mkdir_dotl - VFS mkdir hook to create a directory
+ * @mnt_userns: The user namespace of the mount
  * @dir:  inode that is being unlinked
  * @dentry: dentry that is being unlinked
  * @omode: mode for new directory
@@ -537,6 +542,7 @@ static int v9fs_mapped_iattr_valid(int iattr_valid)
 
 /**
  * v9fs_vfs_setattr_dotl - set file metadata
+ * @mnt_userns: The user namespace of the mount
  * @dentry: file whose metadata to set
  * @iattr: metadata assignment structure
  *
@@ -816,6 +822,7 @@ v9fs_vfs_link_dotl(struct dentry *old_dentry, struct inode *dir,
 
 /**
  * v9fs_vfs_mknod_dotl - create a special file
+ * @mnt_userns: The user namespace of the mount
  * @dir: inode destination for new link
  * @dentry: dentry for file
  * @omode: mode for creation
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index dae9a57d7ec0..45cfd50a9521 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -86,8 +86,8 @@ static int afs_do_silly_rename(struct afs_vnode *dvnode, struct afs_vnode *vnode
 	return afs_do_sync_operation(op);
 }
 
-/**
- * afs_sillyrename - Perform a silly-rename of a dentry
+/*
+ * Perform silly-rename of a dentry.
  *
  * AFS is stateless and the server doesn't know when the client is holding a
  * file open.  To prevent application problems when a file is unlinked while
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index d7eab46dd826..86ad941726f7 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -77,7 +77,6 @@ static WORK_STATE(INIT_OBJECT,		"INIT", fscache_initialise_object);
 static WORK_STATE(PARENT_READY,		"PRDY", fscache_parent_ready);
 static WORK_STATE(ABORT_INIT,		"ABRT", fscache_abort_initialisation);
 static WORK_STATE(LOOK_UP_OBJECT,	"LOOK", fscache_look_up_object);
-static WORK_STATE(CREATE_OBJECT,	"CRTO", fscache_look_up_object);
 static WORK_STATE(OBJECT_AVAILABLE,	"AVBL", fscache_object_available);
 static WORK_STATE(JUMPSTART_DEPS,	"JUMP", fscache_jumpstart_dependents);
 
@@ -907,6 +906,7 @@ static void fscache_dequeue_object(struct fscache_object *object)
  * @object: The object to ask about
  * @data: The auxiliary data for the object
  * @datalen: The size of the auxiliary data
+ * @object_size: The size of the object according to the server.
  *
  * This function consults the netfs about the coherency state of an object.
  * The caller must be holding a ref on cookie->n_active (held by
diff --git a/fs/fscache/operation.c b/fs/fscache/operation.c
index 433877107700..e002cdfaf3cc 100644
--- a/fs/fscache/operation.c
+++ b/fs/fscache/operation.c
@@ -22,7 +22,10 @@ static void fscache_operation_dummy_cancel(struct fscache_operation *op)
 
 /**
  * fscache_operation_init - Do basic initialisation of an operation
+ * @cookie: The cookie to operate on
  * @op: The operation to initialise
+ * @processor: The function to perform the operation
+ * @cancel: A function to handle operation cancellation
  * @release: The release function to assign
  *
  * Do basic initialisation of an operation.  The caller must still set flags,
diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
index edec45831585..0a9b72685f98 100644
--- a/fs/nfs_common/grace.c
+++ b/fs/nfs_common/grace.c
@@ -42,7 +42,6 @@ EXPORT_SYMBOL_GPL(locks_start_grace);
 
 /**
  * locks_end_grace
- * @net: net namespace that this lock manager belongs to
  * @lm: who this grace period is for
  *
  * Call this function to state that the given lock manager is ready to


