Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 821F433C68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 02:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFDA15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 20:27:57 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57637 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbfFDA15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 20:27:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C85D322050;
        Mon,  3 Jun 2019 20:27:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 03 Jun 2019 20:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2xlWx++rvL9ZnDnI9
        s1hWjCxiDYoebR05acho2g1Ekc=; b=n0cQjfOmKuPTumgYK72al+CfgSSpkySU7
        lBCPeS7eWc51znrtlrpcMu0VQb5jCJ4zhes7ZgOhgzwC8PlNOayXpNspy13PzSBJ
        fkfiy5Fu5ZCajLmE6LqptUYteTnzgUzrBmUFmbui6/iGi2J7gaLxxRcdA4Y1LZhj
        WTPGU8YWl9Bgi+LJGx/2tCIAArlmsVtJ97Voqgebcy+kkfLpjiF3w8xldMdd/+Lk
        9MHSifllPd9sjkHbnyQMDnVL794AtBnGZ/otG1mRgJJjYPkwZmEpncMfEb+P1Xn7
        myzHYNSitqtivtsPE412Rv++WYxdLxejVETpy7IhtP4iSlY1Yertg==
X-ME-Sender: <xms:CLv1XC4IRWtFkDKWKMp4QH2YpgHDf2bg2GJTpNAC4_y85V9o_szj8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefkedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcu
    vedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppe
    duvddurdeggedrvdeffedrvdeggeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Cbv1XMf1FnCbm0mh1c6m3DaVhiaSO0qusx8-JekSILTp5Seky4sPmA>
    <xmx:Cbv1XKWerdgtQpDS_vfK96GT2B1L8jBOOcNP-09aoaIfv9SyZUDy2g>
    <xmx:Cbv1XJUW27xC9U73Jt7XxkUAe7DHJa5qlC83W8lbKvP4z3_3SD2DVg>
    <xmx:Cbv1XDpEWQCxEYHYSB2jGob-zxPgFW6lXu7XrmdoFa_DwxXN-jMCaw>
Received: from eros.localdomain (ppp121-44-233-244.bras2.syd2.internode.on.net [121.44.233.244])
        by mail.messagingengine.com (Postfix) with ESMTPA id 21528380073;
        Mon,  3 Jun 2019 20:27:48 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: filesystems: vfs: Render method descriptions
Date:   Tue,  4 Jun 2019 10:26:56 +1000
Message-Id: <20190604002656.30925-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently vfs.rst does not render well into HTML the method descriptions
for VFS data structures.  We can improve the HTML output by putting the
description string on a new line following the method name.

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

Jon,

As discussed on LKML; this patch applies on top of the series

	[PATCH v4 0/9] docs: Convert VFS doc to RST

If it does not apply cleanly to your branch please feel free to ask me
to fix it.

thanks,
Tobin.

 Documentation/filesystems/vfs.rst | 1146 ++++++++++++++++-------------
 1 file changed, 642 insertions(+), 504 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 3acb74bdddf6..4899085e98d9 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -127,35 +127,46 @@ members are defined:
 		struct lock_class_key s_umount_key;
 	};
 
-``name``: the name of the filesystem type, such as "ext2", "iso9660",
+``name``
+	the name of the filesystem type, such as "ext2", "iso9660",
 	"msdos" and so on
 
-``fs_flags``: various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
+``fs_flags``
+	various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
 
-``mount``: the method to call when a new instance of this filesystem should
-be mounted
+``mount``
+	the method to call when a new instance of this filesystem should
+	be mounted
 
-``kill_sb``: the method to call when an instance of this filesystem
-	should be shut down
+``kill_sb``
+	the method to call when an instance of this filesystem should be
+	shut down
 
-``owner``: for internal VFS use: you should initialize this to THIS_MODULE in
-	most cases.
 
-``next``: for internal VFS use: you should initialize this to NULL
+``owner``
+	for internal VFS use: you should initialize this to THIS_MODULE
+	in most cases.
+
+``next``
+	for internal VFS use: you should initialize this to NULL
 
   s_lock_key, s_umount_key: lockdep-specific
 
 The mount() method has the following arguments:
 
-``struct file_system_type *fs_type``: describes the filesystem, partly initialized
-	by the specific filesystem code
+``struct file_system_type *fs_type``
+	describes the filesystem, partly initialized by the specific
+	filesystem code
 
-``int flags``: mount flags
+``int flags``
+	mount flags
 
-``const char *dev_name``: the device name we are mounting.
+``const char *dev_name``
+	the device name we are mounting.
 
-``void *data``: arbitrary mount options, usually comes as an ASCII
-	string (see "Mount Options" section)
+``void *data``
+	arbitrary mount options, usually comes as an ASCII string (see
+	"Mount Options" section)
 
 The mount() method must return the root dentry of the tree requested by
 caller.  An active reference to its superblock must be grabbed and the
@@ -180,22 +191,27 @@ implementation.
 Usually, a filesystem uses one of the generic mount() implementations
 and provides a fill_super() callback instead.  The generic variants are:
 
-``mount_bdev``: mount a filesystem residing on a block device
+``mount_bdev``
+	mount a filesystem residing on a block device
 
-``mount_nodev``: mount a filesystem that is not backed by a device
+``mount_nodev``
+	mount a filesystem that is not backed by a device
 
-``mount_single``: mount a filesystem which shares the instance between
-	all mounts
+``mount_single``
+	mount a filesystem which shares the instance between all mounts
 
 A fill_super() callback implementation has the following arguments:
 
-``struct super_block *sb``: the superblock structure.  The callback
-	must initialize this properly.
+``struct super_block *sb``
+	the superblock structure.  The callback must initialize this
+	properly.
 
-``void *data``: arbitrary mount options, usually comes as an ASCII
-	string (see "Mount Options" section)
+``void *data``
+	arbitrary mount options, usually comes as an ASCII string (see
+	"Mount Options" section)
 
-``int silent``: whether or not to be silent on error
+``int silent``
+	whether or not to be silent on error
 
 
 The Superblock Object
@@ -242,87 +258,106 @@ noted.  This means that most methods can block safely.  All methods are
 only called from a process context (i.e. not from an interrupt handler
 or bottom half).
 
-``alloc_inode``: this method is called by alloc_inode() to allocate memory
-	for struct inode and initialize it.  If this function is not
+``alloc_inode``
+	this method is called by alloc_inode() to allocate memory for
+	struct inode and initialize it.  If this function is not
 	defined, a simple 'struct inode' is allocated.  Normally
 	alloc_inode will be used to allocate a larger structure which
 	contains a 'struct inode' embedded within it.
 
-``destroy_inode``: this method is called by destroy_inode() to release
-	resources allocated for struct inode.  It is only required if
+``destroy_inode``
+	this method is called by destroy_inode() to release resources
+	allocated for struct inode.  It is only required if
 	->alloc_inode was defined and simply undoes anything done by
 	->alloc_inode.
 
-``dirty_inode``: this method is called by the VFS to mark an inode dirty.
+``dirty_inode``
+	this method is called by the VFS to mark an inode dirty.
 
-``write_inode``: this method is called when the VFS needs to write an
-	inode to disc.  The second parameter indicates whether the write
-	should be synchronous or not, not all filesystems check this flag.
+``write_inode``
+	this method is called when the VFS needs to write an inode to
+	disc.  The second parameter indicates whether the write should
+	be synchronous or not, not all filesystems check this flag.
 
-``drop_inode``: called when the last access to the inode is dropped,
-	with the inode->i_lock spinlock held.
+``drop_inode``
+	called when the last access to the inode is dropped, with the
+	inode->i_lock spinlock held.
 
 	This method should be either NULL (normal UNIX filesystem
-	semantics) or "generic_delete_inode" (for filesystems that do not
-	want to cache inodes - causing "delete_inode" to always be
+	semantics) or "generic_delete_inode" (for filesystems that do
+	not want to cache inodes - causing "delete_inode" to always be
 	called regardless of the value of i_nlink)
 
-	The "generic_delete_inode()" behavior is equivalent to the
-	old practice of using "force_delete" in the put_inode() case,
-	but does not have the races that the "force_delete()" approach
-	had. 
+	The "generic_delete_inode()" behavior is equivalent to the old
+	practice of using "force_delete" in the put_inode() case, but
+	does not have the races that the "force_delete()" approach had.
 
-``delete_inode``: called when the VFS wants to delete an inode
+``delete_inode``
+	called when the VFS wants to delete an inode
 
-``put_super``: called when the VFS wishes to free the superblock
+``put_super``
+	called when the VFS wishes to free the superblock
 	(i.e. unmount).  This is called with the superblock lock held
 
-``sync_fs``: called when VFS is writing out all dirty data associated with
-	a superblock.  The second parameter indicates whether the method
+``sync_fs``
+	called when VFS is writing out all dirty data associated with a
+	superblock.  The second parameter indicates whether the method
 	should wait until the write out has been completed.  Optional.
 
-``freeze_fs``: called when VFS is locking a filesystem and
-	forcing it into a consistent state.  This method is currently
-	used by the Logical Volume Manager (LVM).
+``freeze_fs``
+	called when VFS is locking a filesystem and forcing it into a
+	consistent state.  This method is currently used by the Logical
+	Volume Manager (LVM).
 
-``unfreeze_fs``: called when VFS is unlocking a filesystem and making it writable
+``unfreeze_fs``
+	called when VFS is unlocking a filesystem and making it writable
 	again.
 
-``statfs``: called when the VFS needs to get filesystem statistics.
+``statfs``
+	called when the VFS needs to get filesystem statistics.
 
-``remount_fs``: called when the filesystem is remounted.  This is called
-	with the kernel lock held
+``remount_fs``
+	called when the filesystem is remounted.  This is called with
+	the kernel lock held
 
-``clear_inode``: called then the VFS clears the inode.  Optional
+``clear_inode``
+	called then the VFS clears the inode.  Optional
 
-``umount_begin``: called when the VFS is unmounting a filesystem.
+``umount_begin``
+	called when the VFS is unmounting a filesystem.
 
-``show_options``: called by the VFS to show mount options for
-	/proc/<pid>/mounts.  (see "Mount Options" section)
+``show_options``
+	called by the VFS to show mount options for /proc/<pid>/mounts.
+	(see "Mount Options" section)
 
-``quota_read``: called by the VFS to read from filesystem quota file.
+``quota_read``
+	called by the VFS to read from filesystem quota file.
 
-``quota_write``: called by the VFS to write to filesystem quota file.
+``quota_write``
+	called by the VFS to write to filesystem quota file.
 
-``nr_cached_objects``: called by the sb cache shrinking function for the
-	filesystem to return the number of freeable cached objects it contains.
+``nr_cached_objects``
+	called by the sb cache shrinking function for the filesystem to
+	return the number of freeable cached objects it contains.
 	Optional.
 
-``free_cache_objects``: called by the sb cache shrinking function for the
-	filesystem to scan the number of objects indicated to try to free them.
-	Optional, but any filesystem implementing this method needs to also
-	implement ->nr_cached_objects for it to be called correctly.
+``free_cache_objects``
+	called by the sb cache shrinking function for the filesystem to
+	scan the number of objects indicated to try to free them.
+	Optional, but any filesystem implementing this method needs to
+	also implement ->nr_cached_objects for it to be called
+	correctly.
 
 	We can't do anything with any errors that the filesystem might
-	encountered, hence the void return type.  This will never be called if
-	the VM is trying to reclaim under GFP_NOFS conditions, hence this
-	method does not need to handle that situation itself.
+	encountered, hence the void return type.  This will never be
+	called if the VM is trying to reclaim under GFP_NOFS conditions,
+	hence this method does not need to handle that situation itself.
 
-	Implementations must include conditional reschedule calls inside any
-	scanning loop that is done.  This allows the VFS to determine
-	appropriate scan batch sizes without having to worry about whether
-	implementations will cause holdoff problems due to large scan batch
-	sizes.
+	Implementations must include conditional reschedule calls inside
+	any scanning loop that is done.  This allows the VFS to
+	determine appropriate scan batch sizes without having to worry
+	about whether implementations will cause holdoff problems due to
+	large scan batch sizes.
 
 Whoever sets up the inode is responsible for filling in the "i_op"
 field.  This is a pointer to a "struct inode_operations" which describes
@@ -336,23 +371,31 @@ On filesystems that support extended attributes (xattrs), the s_xattr
 superblock field points to a NULL-terminated array of xattr handlers.
 Extended attributes are name:value pairs.
 
-``name``: Indicates that the handler matches attributes with the specified name
-	(such as "system.posix_acl_access"); the prefix field must be NULL.
+``name``
+	Indicates that the handler matches attributes with the specified
+	name (such as "system.posix_acl_access"); the prefix field must
+	be NULL.
 
-``prefix``: Indicates that the handler matches all attributes with the specified
-	name prefix (such as "user."); the name field must be NULL.
+``prefix``
+	Indicates that the handler matches all attributes with the
+	specified name prefix (such as "user."); the name field must be
+	NULL.
 
-``list``: Determine if attributes matching this xattr handler should be listed
-	for a particular dentry.  Used by some listxattr implementations like
-	generic_listxattr.
+``list``
+	Determine if attributes matching this xattr handler should be
+	listed for a particular dentry.  Used by some listxattr
+	implementations like generic_listxattr.
 
-``get``: Called by the VFS to get the value of a particular extended attribute.
-	This method is called by the getxattr(2) system call.
+``get``
+	Called by the VFS to get the value of a particular extended
+	attribute.  This method is called by the getxattr(2) system
+	call.
 
-``set``: Called by the VFS to set the value of a particular extended attribute.
-	When the new value is NULL, called to remove a particular extended
-	attribute.  This method is called by the the setxattr(2) and
-	removexattr(2) system calls.
+``set``
+	Called by the VFS to set the value of a particular extended
+	attribute.  When the new value is NULL, called to remove a
+	particular extended attribute.  This method is called by the the
+	setxattr(2) and removexattr(2) system calls.
 
 When none of the xattr handlers of a filesystem match the specified
 attribute name or when a filesystem doesn't support extended attributes,
@@ -401,121 +444,141 @@ As of kernel 2.6.22, the following members are defined:
 Again, all methods are called without any locks being held, unless
 otherwise noted.
 
-``create``: called by the open(2) and creat(2) system calls.  Only
-	required if you want to support regular files.  The dentry you
-	get should not have an inode (i.e. it should be a negative
-	dentry).  Here you will probably call d_instantiate() with the
-	dentry and the newly created inode
+``create``
+	called by the open(2) and creat(2) system calls.  Only required
+	if you want to support regular files.  The dentry you get should
+	not have an inode (i.e. it should be a negative dentry).  Here
+	you will probably call d_instantiate() with the dentry and the
+	newly created inode
 
-``lookup``: called when the VFS needs to look up an inode in a parent
+``lookup``
+	called when the VFS needs to look up an inode in a parent
 	directory.  The name to look for is found in the dentry.  This
 	method must call d_add() to insert the found inode into the
 	dentry.  The "i_count" field in the inode structure should be
 	incremented.  If the named inode does not exist a NULL inode
 	should be inserted into the dentry (this is called a negative
-	dentry).  Returning an error code from this routine must only
-	be done on a real error, otherwise creating inodes with system
+	dentry).  Returning an error code from this routine must only be
+	done on a real error, otherwise creating inodes with system
 	calls like create(2), mknod(2), mkdir(2) and so on will fail.
 	If you wish to overload the dentry methods then you should
-	initialise the "d_dop" field in the dentry; this is a pointer
-	to a struct "dentry_operations".
-	This method is called with the directory inode semaphore held
+	initialise the "d_dop" field in the dentry; this is a pointer to
+	a struct "dentry_operations".  This method is called with the
+	directory inode semaphore held
 
-``link``: called by the link(2) system call.  Only required if you want
-	to support hard links.  You will probably need to call
+``link``
+	called by the link(2) system call.  Only required if you want to
+	support hard links.  You will probably need to call
 	d_instantiate() just as you would in the create() method
 
-``unlink``: called by the unlink(2) system call.  Only required if you
-	want to support deleting inodes
+``unlink``
+	called by the unlink(2) system call.  Only required if you want
+	to support deleting inodes
 
-``symlink``: called by the symlink(2) system call.  Only required if you
-	want to support symlinks.  You will probably need to call
+``symlink``
+	called by the symlink(2) system call.  Only required if you want
+	to support symlinks.  You will probably need to call
 	d_instantiate() just as you would in the create() method
 
-``mkdir``: called by the mkdir(2) system call.  Only required if you want
+``mkdir``
+	called by the mkdir(2) system call.  Only required if you want
 	to support creating subdirectories.  You will probably need to
 	call d_instantiate() just as you would in the create() method
 
-``rmdir``: called by the rmdir(2) system call.  Only required if you want
+``rmdir``
+	called by the rmdir(2) system call.  Only required if you want
 	to support deleting subdirectories
 
-``mknod``: called by the mknod(2) system call to create a device (char,
-	block) inode or a named pipe (FIFO) or socket.  Only required
-	if you want to support creating these types of inodes.  You
-	will probably need to call d_instantiate() just as you would
-	in the create() method
+``mknod``
+	called by the mknod(2) system call to create a device (char,
+	block) inode or a named pipe (FIFO) or socket.  Only required if
+	you want to support creating these types of inodes.  You will
+	probably need to call d_instantiate() just as you would in the
+	create() method
 
-``rename``: called by the rename(2) system call to rename the object to
-	have the parent and name given by the second inode and dentry.
+``rename``
+	called by the rename(2) system call to rename the object to have
+	the parent and name given by the second inode and dentry.
 
 	The filesystem must return -EINVAL for any unsupported or
-	unknown	flags.  Currently the following flags are implemented:
-	(1) RENAME_NOREPLACE: this flag indicates that if the target
-	of the rename exists the rename should fail with -EEXIST
-	instead of replacing the target.  The VFS already checks for
-	existence, so for local filesystems the RENAME_NOREPLACE
-	implementation is equivalent to plain rename.
+	unknown flags.  Currently the following flags are implemented:
+	(1) RENAME_NOREPLACE: this flag indicates that if the target of
+	the rename exists the rename should fail with -EEXIST instead of
+	replacing the target.  The VFS already checks for existence, so
+	for local filesystems the RENAME_NOREPLACE implementation is
+	equivalent to plain rename.
 	(2) RENAME_EXCHANGE: exchange source and target.  Both must
-	exist; this is checked by the VFS.  Unlike plain rename,
-	source and target may be of different type.
-
-``get_link``: called by the VFS to follow a symbolic link to the
-	inode it points to.  Only required if you want to support
-	symbolic links.  This method returns the symlink body
-	to traverse (and possibly resets the current position with
-	nd_jump_link()).  If the body won't go away until the inode
-	is gone, nothing else is needed; if it needs to be otherwise
-	pinned, arrange for its release by having get_link(..., ..., done)
-	do set_delayed_call(done, destructor, argument).
-	In that case destructor(argument) will be called once VFS is
-	done with the body you've returned.
-	May be called in RCU mode; that is indicated by NULL dentry
+	exist; this is checked by the VFS.  Unlike plain rename, source
+	and target may be of different type.
+
+``get_link``
+	called by the VFS to follow a symbolic link to the inode it
+	points to.  Only required if you want to support symbolic links.
+	This method returns the symlink body to traverse (and possibly
+	resets the current position with nd_jump_link()).  If the body
+	won't go away until the inode is gone, nothing else is needed;
+	if it needs to be otherwise pinned, arrange for its release by
+	having get_link(..., ..., done) do set_delayed_call(done,
+	destructor, argument).  In that case destructor(argument) will
+	be called once VFS is done with the body you've returned.  May
+	be called in RCU mode; that is indicated by NULL dentry
 	argument.  If request can't be handled without leaving RCU mode,
 	have it return ERR_PTR(-ECHILD).
 
-``readlink``: this is now just an override for use by readlink(2) for the
+``readlink``
+	this is now just an override for use by readlink(2) for the
 	cases when ->get_link uses nd_jump_link() or object is not in
 	fact a symlink.  Normally filesystems should only implement
 	->get_link for symlinks and readlink(2) will automatically use
 	that.
 
-``permission``: called by the VFS to check for access rights on a POSIX-like
+``permission``
+	called by the VFS to check for access rights on a POSIX-like
 	filesystem.
 
-	May be called in rcu-walk mode (mask & MAY_NOT_BLOCK).  If in rcu-walk
-	mode, the filesystem must check the permission without blocking or
-	storing to the inode.
+	May be called in rcu-walk mode (mask & MAY_NOT_BLOCK).  If in
+	rcu-walk mode, the filesystem must check the permission without
+	blocking or storing to the inode.
 
-	If a situation is encountered that rcu-walk cannot handle, return
+	If a situation is encountered that rcu-walk cannot handle,
+	return
 	-ECHILD and it will be called again in ref-walk mode.
 
-``setattr``: called by the VFS to set attributes for a file.  This method
-	is called by chmod(2) and related system calls.
-
-``getattr``: called by the VFS to get attributes of a file.  This method
-	is called by stat(2) and related system calls.
-
-``listxattr``: called by the VFS to list all extended attributes for a
-	given file.  This method is called by the listxattr(2) system call.
-
-``update_time``: called by the VFS to update a specific time or the i_version of
-	an inode.  If this is not defined the VFS will update the inode itself
-	and call mark_inode_dirty_sync.
-
-``atomic_open``: called on the last component of an open.  Using this optional
-	method the filesystem can look up, possibly create and open the file in
-	one atomic operation.  If it wants to leave actual opening to the
-	caller (e.g. if the file turned out to be a symlink, device, or just
-	something filesystem won't do atomic open for), it may signal this by
-	returning finish_no_open(file, dentry).  This method is only called if
-	the last component is negative or needs lookup.  Cached positive dentries
-	are still handled by f_op->open().  If the file was created,
-	FMODE_CREATED flag should be set in file->f_mode.  In case of O_EXCL
-	the method must only succeed if the file didn't exist and hence FMODE_CREATED
-	shall always be set on success.
-
-``tmpfile``: called in the end of O_TMPFILE open().  Optional, equivalent to
-	atomically creating, opening and unlinking a file in given directory.
+``setattr``
+	called by the VFS to set attributes for a file.  This method is
+	called by chmod(2) and related system calls.
+
+``getattr``
+	called by the VFS to get attributes of a file.  This method is
+	called by stat(2) and related system calls.
+
+``listxattr``
+	called by the VFS to list all extended attributes for a given
+	file.  This method is called by the listxattr(2) system call.
+
+``update_time``
+	called by the VFS to update a specific time or the i_version of
+	an inode.  If this is not defined the VFS will update the inode
+	itself and call mark_inode_dirty_sync.
+
+``atomic_open``
+	called on the last component of an open.  Using this optional
+	method the filesystem can look up, possibly create and open the
+	file in one atomic operation.  If it wants to leave actual
+	opening to the caller (e.g. if the file turned out to be a
+	symlink, device, or just something filesystem won't do atomic
+	open for), it may signal this by returning finish_no_open(file,
+	dentry).  This method is only called if the last component is
+	negative or needs lookup.  Cached positive dentries are still
+	handled by f_op->open().  If the file was created, FMODE_CREATED
+	flag should be set in file->f_mode.  In case of O_EXCL the
+	method must only succeed if the file didn't exist and hence
+	FMODE_CREATED shall always be set on success.
+
+``tmpfile``
+	called in the end of O_TMPFILE open().  Optional, equivalent to
+	atomically creating, opening and unlinking a file in given
+	directory.
 
 
 The Address Space Object
@@ -668,70 +731,75 @@ cache in your filesystem.  The following members are defined:
 		int (*swap_deactivate)(struct file *);
 	};
 
-``writepage``: called by the VM to write a dirty page to backing store.
-      This may happen for data integrity reasons (i.e. 'sync'), or
-      to free up memory (flush).  The difference can be seen in
-      wbc->sync_mode.
-      The PG_Dirty flag has been cleared and PageLocked is true.
-      writepage should start writeout, should set PG_Writeback,
-      and should make sure the page is unlocked, either synchronously
-      or asynchronously when the write operation completes.
-
-      If wbc->sync_mode is WB_SYNC_NONE, ->writepage doesn't have to
-      try too hard if there are problems, and may choose to write out
-      other pages from the mapping if that is easier (e.g. due to
-      internal dependencies).  If it chooses not to start writeout, it
-      should return AOP_WRITEPAGE_ACTIVATE so that the VM will not keep
-      calling ->writepage on that page.
-
-      See the file "Locking" for more details.
-
-``readpage``: called by the VM to read a page from backing store.
-       The page will be Locked when readpage is called, and should be
-       unlocked and marked uptodate once the read completes.
-       If ->readpage discovers that it needs to unlock the page for
-       some reason, it can do so, and then return AOP_TRUNCATED_PAGE.
-       In this case, the page will be relocated, relocked and if
-       that all succeeds, ->readpage will be called again.
-
-``writepages``: called by the VM to write out pages associated with the
+``writepage``
+	called by the VM to write a dirty page to backing store.  This
+	may happen for data integrity reasons (i.e. 'sync'), or to free
+	up memory (flush).  The difference can be seen in
+	wbc->sync_mode.  The PG_Dirty flag has been cleared and
+	PageLocked is true.  writepage should start writeout, should set
+	PG_Writeback, and should make sure the page is unlocked, either
+	synchronously or asynchronously when the write operation
+	completes.
+
+	If wbc->sync_mode is WB_SYNC_NONE, ->writepage doesn't have to
+	try too hard if there are problems, and may choose to write out
+	other pages from the mapping if that is easier (e.g. due to
+	internal dependencies).  If it chooses not to start writeout, it
+	should return AOP_WRITEPAGE_ACTIVATE so that the VM will not
+	keep calling ->writepage on that page.
+
+	See the file "Locking" for more details.
+
+``readpage``
+	called by the VM to read a page from backing store.  The page
+	will be Locked when readpage is called, and should be unlocked
+	and marked uptodate once the read completes.  If ->readpage
+	discovers that it needs to unlock the page for some reason, it
+	can do so, and then return AOP_TRUNCATED_PAGE.  In this case,
+	the page will be relocated, relocked and if that all succeeds,
+	->readpage will be called again.
+
+``writepages``
+	called by the VM to write out pages associated with the
 	address_space object.  If wbc->sync_mode is WBC_SYNC_ALL, then
 	the writeback_control will specify a range of pages that must be
-	written out.  If it is WBC_SYNC_NONE, then a nr_to_write is given
-	and that many pages should be written if possible.
-	If no ->writepages is given, then mpage_writepages is used
-	instead.  This will choose pages from the address space that are
-	tagged as DIRTY and will pass them to ->writepage.
-
-``set_page_dirty``: called by the VM to set a page dirty.
-	This is particularly needed if an address space attaches
-	private data to a page, and that data needs to be updated when
-	a page is dirtied.  This is called, for example, when a memory
-	mapped page gets modified.
+	written out.  If it is WBC_SYNC_NONE, then a nr_to_write is
+	given and that many pages should be written if possible.  If no
+	->writepages is given, then mpage_writepages is used instead.
+	This will choose pages from the address space that are tagged as
+	DIRTY and will pass them to ->writepage.
+
+``set_page_dirty``
+	called by the VM to set a page dirty.  This is particularly
+	needed if an address space attaches private data to a page, and
+	that data needs to be updated when a page is dirtied.  This is
+	called, for example, when a memory mapped page gets modified.
 	If defined, it should set the PageDirty flag, and the
 	PAGECACHE_TAG_DIRTY tag in the radix tree.
 
-``readpages``: called by the VM to read pages associated with the address_space
-	object.  This is essentially just a vector version of
-	readpage.  Instead of just one page, several pages are
-	requested.
+``readpages``
+	called by the VM to read pages associated with the address_space
+	object.  This is essentially just a vector version of readpage.
+	Instead of just one page, several pages are requested.
 	readpages is only used for read-ahead, so read errors are
 	ignored.  If anything goes wrong, feel free to give up.
 
-``write_begin``:
-	Called by the generic buffered write code to ask the filesystem to
-	prepare to write len bytes at the given offset in the file.  The
-	address_space should check that the write will be able to complete,
-	by allocating space if necessary and doing any other internal
-	housekeeping.  If the write will update parts of any basic-blocks on
-	storage, then those blocks should be pre-read (if they haven't been
-	read already) so that the updated blocks can be written out properly.
+``write_begin``
+	Called by the generic buffered write code to ask the filesystem
+	to prepare to write len bytes at the given offset in the file.
+	The address_space should check that the write will be able to
+	complete, by allocating space if necessary and doing any other
+	internal housekeeping.  If the write will update parts of any
+	basic-blocks on storage, then those blocks should be pre-read
+	(if they haven't been read already) so that the updated blocks
+	can be written out properly.
 
-	The filesystem must return the locked pagecache page for the specified
-	offset, in ``*pagep``, for the caller to write into.
+	The filesystem must return the locked pagecache page for the
+	specified offset, in ``*pagep``, for the caller to write into.
 
-	It must be able to cope with short writes (where the length passed to
-	write_begin is greater than the number of bytes copied into the page).
+	It must be able to cope with short writes (where the length
+	passed to write_begin is greater than the number of bytes copied
+	into the page).
 
 	flags is a field for AOP_FLAG_xxx flags, described in
 	include/linux/fs.h.
@@ -739,114 +807,128 @@ cache in your filesystem.  The following members are defined:
 	A void * may be returned in fsdata, which then gets passed into
 	write_end.
 
-	Returns 0 on success; < 0 on failure (which is the error code), in
-	which case write_end is not called.
-
-``write_end``: After a successful write_begin, and data copy, write_end must
-	be called.  len is the original len passed to write_begin, and copied
-	is the amount that was able to be copied.
-
-	The filesystem must take care of unlocking the page and releasing it
-	refcount, and updating i_size.
-
-	Returns < 0 on failure, otherwise the number of bytes (<= 'copied')
-	that were able to be copied into pagecache.
-
-``bmap``: called by the VFS to map a logical block offset within object to
-	physical block number.  This method is used by the FIBMAP
-	ioctl and for working with swap-files.  To be able to swap to
-	a file, the file must have a stable mapping to a block
-	device.  The swap system does not go through the filesystem
-	but instead uses bmap to find out where the blocks in the file
-	are and uses those addresses directly.
-
-``invalidatepage``: If a page has PagePrivate set, then invalidatepage
-	will be called when part or all of the page is to be removed
-	from the address space.  This generally corresponds to either a
-	truncation, punch hole  or a complete invalidation of the address
+	Returns 0 on success; < 0 on failure (which is the error code),
+	in which case write_end is not called.
+
+``write_end``
+	After a successful write_begin, and data copy, write_end must be
+	called.  len is the original len passed to write_begin, and
+	copied is the amount that was able to be copied.
+
+	The filesystem must take care of unlocking the page and
+	releasing it refcount, and updating i_size.
+
+	Returns < 0 on failure, otherwise the number of bytes (<=
+	'copied') that were able to be copied into pagecache.
+
+``bmap``
+	called by the VFS to map a logical block offset within object to
+	physical block number.  This method is used by the FIBMAP ioctl
+	and for working with swap-files.  To be able to swap to a file,
+	the file must have a stable mapping to a block device.  The swap
+	system does not go through the filesystem but instead uses bmap
+	to find out where the blocks in the file are and uses those
+	addresses directly.
+
+``invalidatepage``
+	If a page has PagePrivate set, then invalidatepage will be
+	called when part or all of the page is to be removed from the
+	address space.  This generally corresponds to either a
+	truncation, punch hole or a complete invalidation of the address
 	space (in the latter case 'offset' will always be 0 and 'length'
 	will be PAGE_SIZE).  Any private data associated with the page
-	should be updated to reflect this truncation.  If offset is 0 and
-	length is PAGE_SIZE, then the private data should be released,
-	because the page must be able to be completely discarded.  This may
-	be done by calling the ->releasepage function, but in this case the
-	release MUST succeed.
-
-``releasepage``: releasepage is called on PagePrivate pages to indicate
-	that the page should be freed if possible.  ->releasepage
-	should remove any private data from the page and clear the
-	PagePrivate flag.  If releasepage() fails for some reason, it must
-	indicate failure with a 0 return value.
-	releasepage() is used in two distinct though related cases.  The
-	first is when the VM finds a clean page with no active users and
-	wants to make it a free page.  If ->releasepage succeeds, the
-	page will be removed from the address_space and become free.
+	should be updated to reflect this truncation.  If offset is 0
+	and length is PAGE_SIZE, then the private data should be
+	released, because the page must be able to be completely
+	discarded.  This may be done by calling the ->releasepage
+	function, but in this case the release MUST succeed.
+
+``releasepage``
+	releasepage is called on PagePrivate pages to indicate that the
+	page should be freed if possible.  ->releasepage should remove
+	any private data from the page and clear the PagePrivate flag.
+	If releasepage() fails for some reason, it must indicate failure
+	with a 0 return value.  releasepage() is used in two distinct
+	though related cases.  The first is when the VM finds a clean
+	page with no active users and wants to make it a free page.  If
+	->releasepage succeeds, the page will be removed from the
+	address_space and become free.
 
 	The second case is when a request has been made to invalidate
-	some or all pages in an address_space.  This can happen
-	through the fadvise(POSIX_FADV_DONTNEED) system call or by the
-	filesystem explicitly requesting it as nfs and 9fs do (when
-	they believe the cache may be out of date with storage) by
-	calling invalidate_inode_pages2().
-	If the filesystem makes such a call, and needs to be certain
-	that all pages are invalidated, then its releasepage will
-	need to ensure this.  Possibly it can clear the PageUptodate
-	bit if it cannot free private data yet.
-
-``freepage``: freepage is called once the page is no longer visible in
-	the page cache in order to allow the cleanup of any private
-	data.  Since it may be called by the memory reclaimer, it
-	should not assume that the original address_space mapping still
-	exists, and it should not block.
-
-``direct_IO``: called by the generic read/write routines to perform
-	direct_IO - that is IO requests which bypass the page cache
-	and transfer data directly between the storage and the
-	application's address space.
-
-``isolate_page``: Called by the VM when isolating a movable non-lru page.
-	If page is successfully isolated, VM marks the page as PG_isolated
-	via __SetPageIsolated.
-
-``migrate_page``:  This is used to compact the physical memory usage.
-	If the VM wants to relocate a page (maybe off a memory card
-	that is signalling imminent failure) it will pass a new page
-	and an old page to this function.  migrate_page should
-	transfer any private data across and update any references
-	that it has to the page.
-
-``putback_page``: Called by the VM when isolated page's migration fails.
-
-``launder_page``: Called before freeing a page - it writes back the dirty page.  To
-	prevent redirtying the page, it is kept locked during the whole
-	operation.
-
-``is_partially_uptodate``: Called by the VM when reading a file through the
-	pagecache when the underlying blocksize != pagesize.  If the required
-	block is up to date then the read can complete without needing the IO
-	to bring the whole page up to date.
-
-``is_dirty_writeback``: Called by the VM when attempting to reclaim a page.
-	The VM uses dirty and writeback information to determine if it needs
-	to stall to allow flushers a chance to complete some IO.  Ordinarily
-	it can use PageDirty and PageWriteback but some filesystems have
-	more complex state (unstable pages in NFS prevent reclaim) or
-	do not set those flags due to locking problems.  This callback
-	allows a filesystem to indicate to the VM if a page should be
-	treated as dirty or writeback for the purposes of stalling.
-
-``error_remove_page``: normally set to generic_error_remove_page if truncation
-	is ok for this address space.  Used for memory failure handling.
+	some or all pages in an address_space.  This can happen through
+	the fadvise(POSIX_FADV_DONTNEED) system call or by the
+	filesystem explicitly requesting it as nfs and 9fs do (when they
+	believe the cache may be out of date with storage) by calling
+	invalidate_inode_pages2().  If the filesystem makes such a call,
+	and needs to be certain that all pages are invalidated, then its
+	releasepage will need to ensure this.  Possibly it can clear the
+	PageUptodate bit if it cannot free private data yet.
+
+``freepage``
+	freepage is called once the page is no longer visible in the
+	page cache in order to allow the cleanup of any private data.
+	Since it may be called by the memory reclaimer, it should not
+	assume that the original address_space mapping still exists, and
+	it should not block.
+
+``direct_IO``
+	called by the generic read/write routines to perform direct_IO -
+	that is IO requests which bypass the page cache and transfer
+	data directly between the storage and the application's address
+	space.
+
+``isolate_page``
+	Called by the VM when isolating a movable non-lru page.  If page
+	is successfully isolated, VM marks the page as PG_isolated via
+	__SetPageIsolated.
+
+``migrate_page``
+	This is used to compact the physical memory usage.  If the VM
+	wants to relocate a page (maybe off a memory card that is
+	signalling imminent failure) it will pass a new page and an old
+	page to this function.  migrate_page should transfer any private
+	data across and update any references that it has to the page.
+
+``putback_page``
+	Called by the VM when isolated page's migration fails.
+
+``launder_page``
+	Called before freeing a page - it writes back the dirty page.
+	To prevent redirtying the page, it is kept locked during the
+	whole operation.
+
+``is_partially_uptodate``
+	Called by the VM when reading a file through the pagecache when
+	the underlying blocksize != pagesize.  If the required block is
+	up to date then the read can complete without needing the IO to
+	bring the whole page up to date.
+
+``is_dirty_writeback``
+	Called by the VM when attempting to reclaim a page.  The VM uses
+	dirty and writeback information to determine if it needs to
+	stall to allow flushers a chance to complete some IO.
+	Ordinarily it can use PageDirty and PageWriteback but some
+	filesystems have more complex state (unstable pages in NFS
+	prevent reclaim) or do not set those flags due to locking
+	problems.  This callback allows a filesystem to indicate to the
+	VM if a page should be treated as dirty or writeback for the
+	purposes of stalling.
+
+``error_remove_page``
+	normally set to generic_error_remove_page if truncation is ok
+	for this address space.  Used for memory failure handling.
 	Setting this implies you deal with pages going away under you,
 	unless you have them locked or reference counts increased.
 
-``swap_activate``: Called when swapon is used on a file to allocate
-	space if necessary and pin the block lookup information in
-	memory.  A return value of zero indicates success,
-	in which case this file can be used to back swapspace.
+``swap_activate``
+	Called when swapon is used on a file to allocate space if
+	necessary and pin the block lookup information in memory.  A
+	return value of zero indicates success, in which case this file
+	can be used to back swapspace.
 
-``swap_deactivate``: Called during swapoff on files where swap_activate
-	was successful.
+``swap_deactivate``
+	Called during swapoff on files where swap_activate was
+	successful.
 
 
 The File Object
@@ -907,91 +989,120 @@ This describes how the VFS can manipulate an open file.  As of kernel
 Again, all methods are called without any locks being held, unless
 otherwise noted.
 
-``llseek``: called when the VFS needs to move the file position index
+``llseek``
+	called when the VFS needs to move the file position index
 
-``read``: called by read(2) and related system calls
+``read``
+	called by read(2) and related system calls
 
-``read_iter``: possibly asynchronous read with iov_iter as destination
+``read_iter``
+	possibly asynchronous read with iov_iter as destination
 
-``write``: called by write(2) and related system calls
+``write``
+	called by write(2) and related system calls
 
-``write_iter``: possibly asynchronous write with iov_iter as source
+``write_iter``
+	possibly asynchronous write with iov_iter as source
 
-``iopoll``: called when aio wants to poll for completions on HIPRI iocbs
+``iopoll``
+	called when aio wants to poll for completions on HIPRI iocbs
 
-``iterate``: called when the VFS needs to read the directory contents
+``iterate``
+	called when the VFS needs to read the directory contents
 
-``iterate_shared``: called when the VFS needs to read the directory contents
-	when filesystem supports concurrent dir iterators
+``iterate_shared``
+	called when the VFS needs to read the directory contents when
+	filesystem supports concurrent dir iterators
 
-``poll``: called by the VFS when a process wants to check if there is
+``poll``
+	called by the VFS when a process wants to check if there is
 	activity on this file and (optionally) go to sleep until there
 	is activity.  Called by the select(2) and poll(2) system calls
 
-``unlocked_ioctl``: called by the ioctl(2) system call.
+``unlocked_ioctl``
+	called by the ioctl(2) system call.
 
-``compat_ioctl``: called by the ioctl(2) system call when 32 bit system calls
-	 are used on 64 bit kernels.
+``compat_ioctl``
+	called by the ioctl(2) system call when 32 bit system calls are
+	 used on 64 bit kernels.
 
-``mmap``: called by the mmap(2) system call
+``mmap``
+	called by the mmap(2) system call
 
-``open``: called by the VFS when an inode should be opened.  When the VFS
+``open``
+	called by the VFS when an inode should be opened.  When the VFS
 	opens a file, it creates a new "struct file".  It then calls the
 	open method for the newly allocated file structure.  You might
-	think that the open method really belongs in
-	"struct inode_operations", and you may be right.  I think it's
-	done the way it is because it makes filesystems simpler to
-	implement.  The open() method is a good place to initialize the
+	think that the open method really belongs in "struct
+	inode_operations", and you may be right.  I think it's done the
+	way it is because it makes filesystems simpler to implement.
+	The open() method is a good place to initialize the
 	"private_data" member in the file structure if you want to point
 	to a device structure
 
-``flush``: called by the close(2) system call to flush a file
+``flush``
+	called by the close(2) system call to flush a file
 
-``release``: called when the last reference to an open file is closed
+``release``
+	called when the last reference to an open file is closed
 
-``fsync``: called by the fsync(2) system call.  Also see the section above
-	 entitled "Handling errors during writeback".
+``fsync``
+	called by the fsync(2) system call.  Also see the section above
+	entitled "Handling errors during writeback".
 
-``fasync``: called by the fcntl(2) system call when asynchronous
+``fasync``
+	called by the fcntl(2) system call when asynchronous
 	(non-blocking) mode is enabled for a file
 
-``lock``: called by the fcntl(2) system call for F_GETLK, F_SETLK, and F_SETLKW
-	commands
+``lock``
+	called by the fcntl(2) system call for F_GETLK, F_SETLK, and
+	F_SETLKW commands
 
-``get_unmapped_area``: called by the mmap(2) system call
+``get_unmapped_area``
+	called by the mmap(2) system call
 
-``check_flags``: called by the fcntl(2) system call for F_SETFL command
+``check_flags``
+	called by the fcntl(2) system call for F_SETFL command
 
-``flock``: called by the flock(2) system call
+``flock``
+	called by the flock(2) system call
 
-``splice_write``: called by the VFS to splice data from a pipe to a file.  This
-		method is used by the splice(2) system call
+``splice_write``
+	called by the VFS to splice data from a pipe to a file.  This
+	method is used by the splice(2) system call
 
-``splice_read``: called by the VFS to splice data from file to a pipe.  This
-	       method is used by the splice(2) system call
+``splice_read``
+	called by the VFS to splice data from file to a pipe.  This
+	method is used by the splice(2) system call
 
-``setlease``: called by the VFS to set or release a file lock lease.  setlease
-	    implementations should call generic_setlease to record or remove
-	    the lease in the inode after setting it.
+``setlease``
+	called by the VFS to set or release a file lock lease.  setlease
+	implementations should call generic_setlease to record or remove
+	the lease in the inode after setting it.
 
-``fallocate``: called by the VFS to preallocate blocks or punch a hole.
+``fallocate``
+	called by the VFS to preallocate blocks or punch a hole.
 
-``copy_file_range``: called by the copy_file_range(2) system call.
+``copy_file_range``
+	called by the copy_file_range(2) system call.
 
-``remap_file_range``: called by the ioctl(2) system call for FICLONERANGE and
-	FICLONE and FIDEDUPERANGE commands to remap file ranges.  An
-	implementation should remap len bytes at pos_in of the source file into
-	the dest file at pos_out.  Implementations must handle callers passing
-	in len == 0; this means "remap to the end of the source file".  The
-	return value should the number of bytes remapped, or the usual
-	negative error code if errors occurred before any bytes were remapped.
-	The remap_flags parameter accepts REMAP_FILE_* flags.  If
-	REMAP_FILE_DEDUP is set then the implementation must only remap if the
-	requested file ranges have identical contents.  If REMAP_CAN_SHORTEN is
-	set, the caller is ok with the implementation shortening the request
-	length to satisfy alignment or EOF requirements (or any other reason).
+``remap_file_range``
+	called by the ioctl(2) system call for FICLONERANGE and FICLONE
+	and FIDEDUPERANGE commands to remap file ranges.  An
+	implementation should remap len bytes at pos_in of the source
+	file into the dest file at pos_out.  Implementations must handle
+	callers passing in len == 0; this means "remap to the end of the
+	source file".  The return value should the number of bytes
+	remapped, or the usual negative error code if errors occurred
+	before any bytes were remapped.  The remap_flags parameter
+	accepts REMAP_FILE_* flags.  If REMAP_FILE_DEDUP is set then the
+	implementation must only remap if the requested file ranges have
+	identical contents.  If REMAP_CAN_SHORTEN is set, the caller is
+	ok with the implementation shortening the request length to
+	satisfy alignment or EOF requirements (or any other reason).
 
-``fadvise``: possibly called by the fadvise64() system call.
+``fadvise``
+	possibly called by the fadvise64() system call.
 
 Note that the file operations are implemented by the specific
 filesystem in which the inode resides.  When opening a device node
@@ -1036,89 +1147,104 @@ defined:
 		struct dentry *(*d_real)(struct dentry *, const struct inode *);
 	};
 
-``d_revalidate``: called when the VFS needs to revalidate a dentry.  This
-	is called whenever a name look-up finds a dentry in the
-	dcache.  Most local filesystems leave this as NULL, because all their
-	dentries in the dcache are valid.  Network filesystems are different
-	since things can change on the server without the client necessarily
-	being aware of it.
-
-	This function should return a positive value if the dentry is still
-	valid, and zero or a negative error code if it isn't.
-
-	d_revalidate may be called in rcu-walk mode (flags & LOOKUP_RCU).
-	If in rcu-walk mode, the filesystem must revalidate the dentry without
-	blocking or storing to the dentry, d_parent and d_inode should not be
-	used without care (because they can change and, in d_inode case, even
-	become NULL under us).
-
-	If a situation is encountered that rcu-walk cannot handle, return
+``d_revalidate``
+	called when the VFS needs to revalidate a dentry.  This is
+	called whenever a name look-up finds a dentry in the dcache.
+	Most local filesystems leave this as NULL, because all their
+	dentries in the dcache are valid.  Network filesystems are
+	different since things can change on the server without the
+	client necessarily being aware of it.
+
+	This function should return a positive value if the dentry is
+	still valid, and zero or a negative error code if it isn't.
+
+	d_revalidate may be called in rcu-walk mode (flags &
+	LOOKUP_RCU).  If in rcu-walk mode, the filesystem must
+	revalidate the dentry without blocking or storing to the dentry,
+	d_parent and d_inode should not be used without care (because
+	they can change and, in d_inode case, even become NULL under
+	us).
+
+	If a situation is encountered that rcu-walk cannot handle,
+	return
 	-ECHILD and it will be called again in ref-walk mode.
 
-``_weak_revalidate``: called when the VFS needs to revalidate a "jumped" dentry.
-	This is called when a path-walk ends at dentry that was not acquired by
-	doing a lookup in the parent directory.  This includes "/", "." and "..",
-	as well as procfs-style symlinks and mountpoint traversal.
+``_weak_revalidate``
+	called when the VFS needs to revalidate a "jumped" dentry.  This
+	is called when a path-walk ends at dentry that was not acquired
+	by doing a lookup in the parent directory.  This includes "/",
+	"." and "..", as well as procfs-style symlinks and mountpoint
+	traversal.
 
-	In this case, we are less concerned with whether the dentry is still
-	fully correct, but rather that the inode is still valid.  As with
-	d_revalidate, most local filesystems will set this to NULL since their
-	dcache entries are always valid.
+	In this case, we are less concerned with whether the dentry is
+	still fully correct, but rather that the inode is still valid.
+	As with d_revalidate, most local filesystems will set this to
+	NULL since their dcache entries are always valid.
 
-	This function has the same return code semantics as d_revalidate.
+	This function has the same return code semantics as
+	d_revalidate.
 
 	d_weak_revalidate is only called after leaving rcu-walk mode.
 
-``d_hash``: called when the VFS adds a dentry to the hash table.  The first
+``d_hash``
+	called when the VFS adds a dentry to the hash table.  The first
 	dentry passed to d_hash is the parent directory that the name is
 	to be hashed into.
 
 	Same locking and synchronisation rules as d_compare regarding
 	what is safe to dereference etc.
 
-``d_compare``: called to compare a dentry name with a given name.  The first
+``d_compare``
+	called to compare a dentry name with a given name.  The first
 	dentry is the parent of the dentry to be compared, the second is
-	the child dentry.  len and name string are properties of the dentry
-	to be compared.  qstr is the name to compare it with.
+	the child dentry.  len and name string are properties of the
+	dentry to be compared.  qstr is the name to compare it with.
 
 	Must be constant and idempotent, and should not take locks if
-	possible, and should not or store into the dentry.
-	Should not dereference pointers outside the dentry without
-	lots of care (eg.  d_parent, d_inode, d_name should not be used).
-
-	However, our vfsmount is pinned, and RCU held, so the dentries and
-	inodes won't disappear, neither will our sb or filesystem module.
-	->d_sb may be used.
-
-	It is a tricky calling convention because it needs to be called under
-	"rcu-walk", ie. without any locks or references on things.
-
-``d_delete``: called when the last reference to a dentry is dropped and the
-	dcache is deciding whether or not to cache it.  Return 1 to delete
-	immediately, or 0 to cache the dentry.  Default is NULL which means to
-	always cache a reachable dentry.  d_delete must be constant and
-	idempotent.
-
-``d_init``: called when a dentry is allocated
-
-``d_release``: called when a dentry is really deallocated
-
-``d_iput``: called when a dentry loses its inode (just prior to its
-	being deallocated).  The default when this is NULL is that the
-	VFS calls iput().  If you define this method, you must call
-	iput() yourself
-
-``d_dname``: called when the pathname of a dentry should be generated.
-	Useful for some pseudo filesystems (sockfs, pipefs, ...) to delay
-	pathname generation.  (Instead of doing it when dentry is created,
-	it's done only when the path is needed.).  Real filesystems probably
-	dont want to use it, because their dentries are present in global
-	dcache hash, so their hash should be an invariant.  As no lock is
-	held, d_dname() should not try to modify the dentry itself, unless
-	appropriate SMP safety is used.  CAUTION : d_path() logic is quite
-	tricky.  The correct way to return for example "Hello" is to put it
-	at the end of the buffer, and returns a pointer to the first char.
-	dynamic_dname() helper function is provided to take care of this.
+	possible, and should not or store into the dentry.  Should not
+	dereference pointers outside the dentry without lots of care
+	(eg.  d_parent, d_inode, d_name should not be used).
+
+	However, our vfsmount is pinned, and RCU held, so the dentries
+	and inodes won't disappear, neither will our sb or filesystem
+	module.  ->d_sb may be used.
+
+	It is a tricky calling convention because it needs to be called
+	under "rcu-walk", ie. without any locks or references on things.
+
+``d_delete``
+	called when the last reference to a dentry is dropped and the
+	dcache is deciding whether or not to cache it.  Return 1 to
+	delete immediately, or 0 to cache the dentry.  Default is NULL
+	which means to always cache a reachable dentry.  d_delete must
+	be constant and idempotent.
+
+``d_init``
+	called when a dentry is allocated
+
+``d_release``
+	called when a dentry is really deallocated
+
+``d_iput``
+	called when a dentry loses its inode (just prior to its being
+	deallocated).  The default when this is NULL is that the VFS
+	calls iput().  If you define this method, you must call iput()
+	yourself
+
+``d_dname``
+	called when the pathname of a dentry should be generated.
+	Useful for some pseudo filesystems (sockfs, pipefs, ...) to
+	delay pathname generation.  (Instead of doing it when dentry is
+	created, it's done only when the path is needed.).  Real
+	filesystems probably dont want to use it, because their dentries
+	are present in global dcache hash, so their hash should be an
+	invariant.  As no lock is held, d_dname() should not try to
+	modify the dentry itself, unless appropriate SMP safety is used.
+	CAUTION : d_path() logic is quite tricky.  The correct way to
+	return for example "Hello" is to put it at the end of the
+	buffer, and returns a pointer to the first char.
+	dynamic_dname() helper function is provided to take care of
+	this.
 
 	Example :
 
@@ -1130,52 +1256,57 @@ defined:
 				dentry->d_inode->i_ino);
 	}
 
-``d_automount``: called when an automount dentry is to be traversed (optional).
-	This should create a new VFS mount record and return the record to the
-	caller.  The caller is supplied with a path parameter giving the
-	automount directory to describe the automount target and the parent
-	VFS mount record to provide inheritable mount parameters.  NULL should
-	be returned if someone else managed to make the automount first.  If
-	the vfsmount creation failed, then an error code should be returned.
-	If -EISDIR is returned, then the directory will be treated as an
-	ordinary directory and returned to pathwalk to continue walking.
-
-	If a vfsmount is returned, the caller will attempt to mount it on the
-	mountpoint and will remove the vfsmount from its expiration list in
-	the case of failure.  The vfsmount should be returned with 2 refs on
-	it to prevent automatic expiration - the caller will clean up the
-	additional ref.
-
-	This function is only used if DCACHE_NEED_AUTOMOUNT is set on the
-	dentry.  This is set by __d_instantiate() if S_AUTOMOUNT is set on the
-	inode being added.
-
-``d_manage``: called to allow the filesystem to manage the transition from a
-	dentry (optional).  This allows autofs, for example, to hold up clients
-	waiting to explore behind a 'mountpoint' while letting the daemon go
-	past and construct the subtree there.  0 should be returned to let the
-	calling process continue.  -EISDIR can be returned to tell pathwalk to
-	use this directory as an ordinary directory and to ignore anything
-	mounted on it and not to check the automount flag.  Any other error
-	code will abort pathwalk completely.
+``d_automount``
+	called when an automount dentry is to be traversed (optional).
+	This should create a new VFS mount record and return the record
+	to the caller.  The caller is supplied with a path parameter
+	giving the automount directory to describe the automount target
+	and the parent VFS mount record to provide inheritable mount
+	parameters.  NULL should be returned if someone else managed to
+	make the automount first.  If the vfsmount creation failed, then
+	an error code should be returned.  If -EISDIR is returned, then
+	the directory will be treated as an ordinary directory and
+	returned to pathwalk to continue walking.
+
+	If a vfsmount is returned, the caller will attempt to mount it
+	on the mountpoint and will remove the vfsmount from its
+	expiration list in the case of failure.  The vfsmount should be
+	returned with 2 refs on it to prevent automatic expiration - the
+	caller will clean up the additional ref.
+
+	This function is only used if DCACHE_NEED_AUTOMOUNT is set on
+	the dentry.  This is set by __d_instantiate() if S_AUTOMOUNT is
+	set on the inode being added.
+
+``d_manage``
+	called to allow the filesystem to manage the transition from a
+	dentry (optional).  This allows autofs, for example, to hold up
+	clients waiting to explore behind a 'mountpoint' while letting
+	the daemon go past and construct the subtree there.  0 should be
+	returned to let the calling process continue.  -EISDIR can be
+	returned to tell pathwalk to use this directory as an ordinary
+	directory and to ignore anything mounted on it and not to check
+	the automount flag.  Any other error code will abort pathwalk
+	completely.
 
 	If the 'rcu_walk' parameter is true, then the caller is doing a
-	pathwalk in RCU-walk mode.  Sleeping is not permitted in this mode,
-	and the caller can be asked to leave it and call again by returning
-	-ECHILD.  -EISDIR may also be returned to tell pathwalk to
-	ignore d_automount or any mounts.
+	pathwalk in RCU-walk mode.  Sleeping is not permitted in this
+	mode, and the caller can be asked to leave it and call again by
+	returning -ECHILD.  -EISDIR may also be returned to tell
+	pathwalk to ignore d_automount or any mounts.
 
-	This function is only used if DCACHE_MANAGE_TRANSIT is set on the
-	dentry being transited from.
+	This function is only used if DCACHE_MANAGE_TRANSIT is set on
+	the dentry being transited from.
 
-``d_real``: overlay/union type filesystems implement this method to return one of
-	the underlying dentries hidden by the overlay.  It is used in two
-	different modes:
+``d_real``
+	overlay/union type filesystems implement this method to return
+	one of the underlying dentries hidden by the overlay.  It is
+	used in two different modes:
 
-	Called from file_dentry() it returns the real dentry matching the inode
-	argument.  The real dentry may be from a lower layer already copied up,
-	but still referenced from the file.  This mode is selected with a
-	non-NULL inode argument.
+	Called from file_dentry() it returns the real dentry matching
+	the inode argument.  The real dentry may be from a lower layer
+	already copied up, but still referenced from the file.  This
+	mode is selected with a non-NULL inode argument.
 
 	With NULL inode the topmost real underlying dentry is returned.
 
@@ -1190,40 +1321,47 @@ Directory Entry Cache API
 There are a number of functions defined which permit a filesystem to
 manipulate dentries:
 
-``dget``: open a new handle for an existing dentry (this just increments
+``dget``
+	open a new handle for an existing dentry (this just increments
 	the usage count)
 
-``dput``: close a handle for a dentry (decrements the usage count).  If
+``dput``
+	close a handle for a dentry (decrements the usage count).  If
 	the usage count drops to 0, and the dentry is still in its
 	parent's hash, the "d_delete" method is called to check whether
-	it should be cached.  If it should not be cached, or if the dentry
-	is not hashed, it is deleted.  Otherwise cached dentries are put
-	into an LRU list to be reclaimed on memory shortage.
-
-``d_drop``: this unhashes a dentry from its parents hash list.  A
-	subsequent call to dput() will deallocate the dentry if its
-	usage count drops to 0
-
-``d_delete``: delete a dentry.  If there are no other open references to
-	the dentry then the dentry is turned into a negative dentry
-	(the d_iput() method is called).  If there are other
-	references, then d_drop() is called instead
-
-``d_add``: add a dentry to its parents hash list and then calls
+	it should be cached.  If it should not be cached, or if the
+	dentry is not hashed, it is deleted.  Otherwise cached dentries
+	are put into an LRU list to be reclaimed on memory shortage.
+
+``d_drop``
+	this unhashes a dentry from its parents hash list.  A subsequent
+	call to dput() will deallocate the dentry if its usage count
+	drops to 0
+
+``d_delete``
+	delete a dentry.  If there are no other open references to the
+	dentry then the dentry is turned into a negative dentry (the
+	d_iput() method is called).  If there are other references, then
+	d_drop() is called instead
+
+``d_add``
+	add a dentry to its parents hash list and then calls
 	d_instantiate()
 
-``d_instantiate``: add a dentry to the alias hash list for the inode and
-	updates the "d_inode" member.  The "i_count" member in the
-	inode structure should be set/incremented.  If the inode
-	pointer is NULL, the dentry is called a "negative
-	dentry".  This function is commonly called when an inode is
-	created for an existing negative dentry
-
-``d_lookup``: look up a dentry given its parent and path name component
-	It looks up the child of that given name from the dcache
-	hash table.  If it is found, the reference count is incremented
-	and the dentry is returned.  The caller must use dput()
-	to free the dentry when it finishes using it.
+``d_instantiate``
+	add a dentry to the alias hash list for the inode and updates
+	the "d_inode" member.  The "i_count" member in the inode
+	structure should be set/incremented.  If the inode pointer is
+	NULL, the dentry is called a "negative dentry".  This function
+	is commonly called when an inode is created for an existing
+	negative dentry
+
+``d_lookup``
+	look up a dentry given its parent and path name component It
+	looks up the child of that given name from the dcache hash
+	table.  If it is found, the reference count is incremented and
+	the dentry is returned.  The caller must use dput() to free the
+	dentry when it finishes using it.
 
 
 Mount Options
-- 
2.21.0

