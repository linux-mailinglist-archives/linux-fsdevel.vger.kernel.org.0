Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BA91E63A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 02:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfEOAan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 20:30:43 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37665 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbfEOAam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9CFC025911;
        Tue, 14 May 2019 20:30:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 14 May 2019 20:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=rrRwk5BBxsv3WeDWc+cQGbGKEeRq2fSHq0QnvLkGChE=; b=I5HB0wW1
        UUvzsAxQGkidXR8R+aQz5cBqC6T8qAY7upegEa2LSZ0dvqNjkcgRrlR20nr6gYps
        57xAUu+jdJRCDEKg6tpmISVfJMz1ZHocXJuBO0wJ+E3SOq3zLxd2uDZ2q1VL7vyE
        +IRQ/D6dyfOjQ7XN6V07xp1wpQZTwZfCzBNVpCxHayR27IuzXJYuI4iEQbJWDEpR
        WwzhQ6mr93STcBRMnJpXz6V2lVHYdfWkwE8kLTEpgy7bvntEiZAxi5P9yXvJdBjS
        7AJO+CmSq1arODNQ8Uvj6Xj3/JJVIFUsLvgF9MtYWwwtfkir0Hxxe2nAzpuiKDuT
        HBeAq4CtXlayNw==
X-ME-Sender: <xms:r13bXK-705beuaxssjAfa5FsOepX1lfpK2L_UCESGMMoAFzKfYwEmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvvdefrddvuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeek
X-ME-Proxy: <xmx:r13bXO8YP9tT-uWnK8H7wFdlvkwSug83qX1ESZAyxoPCOnjTWDvOig>
    <xmx:r13bXLBEQwokbE0LiH8NRYlIKQek8TJhhcrEpRl_QAD0aDhKIMnRlQ>
    <xmx:r13bXGxomc-DFr5Bt7KFbyyoZps3d09U0G7vx-SAtnqFuvC51QY46A>
    <xmx:r13bXEtQu-oTZFm3Dimwb8PgSxyK9ceIps0FgXZf6pGau1hsJnf99w>
Received: from eros.localdomain (ppp121-44-223-211.bras1.syd2.internode.on.net [121.44.223.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 336B110378;
        Tue, 14 May 2019 20:30:34 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] docs: filesystems: vfs: Convert vfs.txt to RST
Date:   Wed, 15 May 2019 10:29:13 +1000
Message-Id: <20190515002913.12586-10-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515002913.12586-1-tobin@kernel.org>
References: <20190515002913.12586-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vfs.txt is currently stale.  If we convert it to RST this is a good
first step in the process of getting the VFS documentation up to date.

This patch does the following (all as a single patch so as not to
introduce any new SPHINX build warnings)

 - Use '.. code-block:: c' for C code blocks and indent the code blocks.
 - Use double backticks for struct member descriptions.
 - Fix a couple of build warnings by guarding pointers (*) with double
   backticks .e.g  ``*ptr``.
 - Add vfs to Documentation/filesystems/index.rst

The member descriptions paragraph indentation was not touched.  It is
not pretty but these do not cause build warnings.  These descriptions
all need updating anyways so leave it as it is for now.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/index.rst           |   1 +
 .../filesystems/{vfs.txt => vfs.rst}          | 578 +++++++++---------
 2 files changed, 298 insertions(+), 281 deletions(-)
 rename Documentation/filesystems/{vfs.txt => vfs.rst} (70%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 1131c34d77f6..35644840a690 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -16,6 +16,7 @@ algorithms work.
 .. toctree::
    :maxdepth: 2
 
+   vfs
    path-lookup.rst
    api-summary
    splice
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.rst
similarity index 70%
rename from Documentation/filesystems/vfs.txt
rename to Documentation/filesystems/vfs.rst
index 489bbdc6a40f..3acb74bdddf6 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.rst
@@ -87,10 +87,12 @@ Registering and Mounting a Filesystem
 To register and unregister a filesystem, use the following API
 functions:
 
-   #include <linux/fs.h>
+.. code-block:: c
 
-   extern int register_filesystem(struct file_system_type *);
-   extern int unregister_filesystem(struct file_system_type *);
+	#include <linux/fs.h>
+
+	extern int register_filesystem(struct file_system_type *);
+	extern int unregister_filesystem(struct file_system_type *);
 
 The passed struct file_system_type describes your filesystem.  When a
 request is made to mount a filesystem onto a directory in your
@@ -110,47 +112,49 @@ struct file_system_type
 This describes the filesystem.  As of kernel 2.6.39, the following
 members are defined:
 
-struct file_system_type {
-	const char *name;
-	int fs_flags;
-	struct dentry *(*mount) (struct file_system_type *, int,
-		       const char *, void *);
-	void (*kill_sb) (struct super_block *);
-	struct module *owner;
-	struct file_system_type * next;
-	struct list_head fs_supers;
-	struct lock_class_key s_lock_key;
-	struct lock_class_key s_umount_key;
-};
-
-  name: the name of the filesystem type, such as "ext2", "iso9660",
+.. code-block:: c
+
+	struct file_system_operations {
+		const char *name;
+		int fs_flags;
+		struct dentry *(*mount) (struct file_system_type *, int,
+					 const char *, void *);
+		void (*kill_sb) (struct super_block *);
+		struct module *owner;
+		struct file_system_type * next;
+		struct list_head fs_supers;
+		struct lock_class_key s_lock_key;
+		struct lock_class_key s_umount_key;
+	};
+
+``name``: the name of the filesystem type, such as "ext2", "iso9660",
 	"msdos" and so on
 
-  fs_flags: various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
+``fs_flags``: various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
 
-  mount: the method to call when a new instance of this
-	filesystem should be mounted
+``mount``: the method to call when a new instance of this filesystem should
+be mounted
 
-  kill_sb: the method to call when an instance of this filesystem
+``kill_sb``: the method to call when an instance of this filesystem
 	should be shut down
 
-  owner: for internal VFS use: you should initialize this to THIS_MODULE in
+``owner``: for internal VFS use: you should initialize this to THIS_MODULE in
 	most cases.
 
-  next: for internal VFS use: you should initialize this to NULL
+``next``: for internal VFS use: you should initialize this to NULL
 
   s_lock_key, s_umount_key: lockdep-specific
 
 The mount() method has the following arguments:
 
-  struct file_system_type *fs_type: describes the filesystem, partly initialized
+``struct file_system_type *fs_type``: describes the filesystem, partly initialized
 	by the specific filesystem code
 
-  int flags: mount flags
+``int flags``: mount flags
 
-  const char *dev_name: the device name we are mounting.
+``const char *dev_name``: the device name we are mounting.
 
-  void *data: arbitrary mount options, usually comes as an ASCII
+``void *data``: arbitrary mount options, usually comes as an ASCII
 	string (see "Mount Options" section)
 
 The mount() method must return the root dentry of the tree requested by
@@ -176,22 +180,22 @@ implementation.
 Usually, a filesystem uses one of the generic mount() implementations
 and provides a fill_super() callback instead.  The generic variants are:
 
-  mount_bdev: mount a filesystem residing on a block device
+``mount_bdev``: mount a filesystem residing on a block device
 
-  mount_nodev: mount a filesystem that is not backed by a device
+``mount_nodev``: mount a filesystem that is not backed by a device
 
-  mount_single: mount a filesystem which shares the instance between
+``mount_single``: mount a filesystem which shares the instance between
 	all mounts
 
 A fill_super() callback implementation has the following arguments:
 
-  struct super_block *sb: the superblock structure.  The callback
+``struct super_block *sb``: the superblock structure.  The callback
 	must initialize this properly.
 
-  void *data: arbitrary mount options, usually comes as an ASCII
+``void *data``: arbitrary mount options, usually comes as an ASCII
 	string (see "Mount Options" section)
 
-  int silent: whether or not to be silent on error
+``int silent``: whether or not to be silent on error
 
 
 The Superblock Object
@@ -206,54 +210,56 @@ struct super_operations
 This describes how the VFS can manipulate the superblock of your
 filesystem.  As of kernel 2.6.22, the following members are defined:
 
-struct super_operations {
-	struct inode *(*alloc_inode)(struct super_block *sb);
-	void (*destroy_inode)(struct inode *);
-
-	void (*dirty_inode) (struct inode *, int flags);
-	int (*write_inode) (struct inode *, int);
-	void (*drop_inode) (struct inode *);
-	void (*delete_inode) (struct inode *);
-	void (*put_super) (struct super_block *);
-	int (*sync_fs)(struct super_block *sb, int wait);
-	int (*freeze_fs) (struct super_block *);
-	int (*unfreeze_fs) (struct super_block *);
-	int (*statfs) (struct dentry *, struct kstatfs *);
-	int (*remount_fs) (struct super_block *, int *, char *);
-	void (*clear_inode) (struct inode *);
-	void (*umount_begin) (struct super_block *);
-
-	int (*show_options)(struct seq_file *, struct dentry *);
-
-	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
-	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
-	int (*nr_cached_objects)(struct super_block *);
-	void (*free_cached_objects)(struct super_block *, int);
-};
+.. code-block:: c
+
+	struct super_operations {
+		struct inode *(*alloc_inode)(struct super_block *sb);
+		void (*destroy_inode)(struct inode *);
+
+		void (*dirty_inode) (struct inode *, int flags);
+		int (*write_inode) (struct inode *, int);
+		void (*drop_inode) (struct inode *);
+		void (*delete_inode) (struct inode *);
+		void (*put_super) (struct super_block *);
+		int (*sync_fs)(struct super_block *sb, int wait);
+		int (*freeze_fs) (struct super_block *);
+		int (*unfreeze_fs) (struct super_block *);
+		int (*statfs) (struct dentry *, struct kstatfs *);
+		int (*remount_fs) (struct super_block *, int *, char *);
+		void (*clear_inode) (struct inode *);
+		void (*umount_begin) (struct super_block *);
+
+		int (*show_options)(struct seq_file *, struct dentry *);
+
+		ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
+		ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
+		int (*nr_cached_objects)(struct super_block *);
+		void (*free_cached_objects)(struct super_block *, int);
+	};
 
 All methods are called without any locks being held, unless otherwise
 noted.  This means that most methods can block safely.  All methods are
 only called from a process context (i.e. not from an interrupt handler
 or bottom half).
 
-  alloc_inode: this method is called by alloc_inode() to allocate memory
+``alloc_inode``: this method is called by alloc_inode() to allocate memory
 	for struct inode and initialize it.  If this function is not
 	defined, a simple 'struct inode' is allocated.  Normally
 	alloc_inode will be used to allocate a larger structure which
 	contains a 'struct inode' embedded within it.
 
-  destroy_inode: this method is called by destroy_inode() to release
+``destroy_inode``: this method is called by destroy_inode() to release
 	resources allocated for struct inode.  It is only required if
 	->alloc_inode was defined and simply undoes anything done by
 	->alloc_inode.
 
-  dirty_inode: this method is called by the VFS to mark an inode dirty.
+``dirty_inode``: this method is called by the VFS to mark an inode dirty.
 
-  write_inode: this method is called when the VFS needs to write an
+``write_inode``: this method is called when the VFS needs to write an
 	inode to disc.  The second parameter indicates whether the write
 	should be synchronous or not, not all filesystems check this flag.
 
-  drop_inode: called when the last access to the inode is dropped,
+``drop_inode``: called when the last access to the inode is dropped,
 	with the inode->i_lock spinlock held.
 
 	This method should be either NULL (normal UNIX filesystem
@@ -266,43 +272,43 @@ or bottom half).
 	but does not have the races that the "force_delete()" approach
 	had. 
 
-  delete_inode: called when the VFS wants to delete an inode
+``delete_inode``: called when the VFS wants to delete an inode
 
-  put_super: called when the VFS wishes to free the superblock
+``put_super``: called when the VFS wishes to free the superblock
 	(i.e. unmount).  This is called with the superblock lock held
 
-  sync_fs: called when VFS is writing out all dirty data associated with
+``sync_fs``: called when VFS is writing out all dirty data associated with
 	a superblock.  The second parameter indicates whether the method
 	should wait until the write out has been completed.  Optional.
 
-  freeze_fs: called when VFS is locking a filesystem and
+``freeze_fs``: called when VFS is locking a filesystem and
 	forcing it into a consistent state.  This method is currently
 	used by the Logical Volume Manager (LVM).
 
-  unfreeze_fs: called when VFS is unlocking a filesystem and making it writable
+``unfreeze_fs``: called when VFS is unlocking a filesystem and making it writable
 	again.
 
-  statfs: called when the VFS needs to get filesystem statistics.
+``statfs``: called when the VFS needs to get filesystem statistics.
 
-  remount_fs: called when the filesystem is remounted.  This is called
+``remount_fs``: called when the filesystem is remounted.  This is called
 	with the kernel lock held
 
-  clear_inode: called then the VFS clears the inode.  Optional
+``clear_inode``: called then the VFS clears the inode.  Optional
 
-  umount_begin: called when the VFS is unmounting a filesystem.
+``umount_begin``: called when the VFS is unmounting a filesystem.
 
-  show_options: called by the VFS to show mount options for
+``show_options``: called by the VFS to show mount options for
 	/proc/<pid>/mounts.  (see "Mount Options" section)
 
-  quota_read: called by the VFS to read from filesystem quota file.
+``quota_read``: called by the VFS to read from filesystem quota file.
 
-  quota_write: called by the VFS to write to filesystem quota file.
+``quota_write``: called by the VFS to write to filesystem quota file.
 
-  nr_cached_objects: called by the sb cache shrinking function for the
+``nr_cached_objects``: called by the sb cache shrinking function for the
 	filesystem to return the number of freeable cached objects it contains.
 	Optional.
 
-  free_cache_objects: called by the sb cache shrinking function for the
+``free_cache_objects``: called by the sb cache shrinking function for the
 	filesystem to scan the number of objects indicated to try to free them.
 	Optional, but any filesystem implementing this method needs to also
 	implement ->nr_cached_objects for it to be called correctly.
@@ -330,27 +336,27 @@ On filesystems that support extended attributes (xattrs), the s_xattr
 superblock field points to a NULL-terminated array of xattr handlers.
 Extended attributes are name:value pairs.
 
-  name: Indicates that the handler matches attributes with the specified name
+``name``: Indicates that the handler matches attributes with the specified name
 	(such as "system.posix_acl_access"); the prefix field must be NULL.
 
-  prefix: Indicates that the handler matches all attributes with the specified
+``prefix``: Indicates that the handler matches all attributes with the specified
 	name prefix (such as "user."); the name field must be NULL.
 
-  list: Determine if attributes matching this xattr handler should be listed
+``list``: Determine if attributes matching this xattr handler should be listed
 	for a particular dentry.  Used by some listxattr implementations like
 	generic_listxattr.
 
-  get: Called by the VFS to get the value of a particular extended attribute.
+``get``: Called by the VFS to get the value of a particular extended attribute.
 	This method is called by the getxattr(2) system call.
 
-  set: Called by the VFS to set the value of a particular extended attribute.
+``set``: Called by the VFS to set the value of a particular extended attribute.
 	When the new value is NULL, called to remove a particular extended
 	attribute.  This method is called by the the setxattr(2) and
 	removexattr(2) system calls.
 
 When none of the xattr handlers of a filesystem match the specified
 attribute name or when a filesystem doesn't support extended attributes,
-the various *xattr(2) system calls return -EOPNOTSUPP.
+the various ``*xattr(2)`` system calls return -EOPNOTSUPP.
 
 
 The Inode Object
@@ -365,41 +371,43 @@ struct inode_operations
 This describes how the VFS can manipulate an inode in your filesystem.
 As of kernel 2.6.22, the following members are defined:
 
-struct inode_operations {
-	int (*create) (struct inode *,struct dentry *, umode_t, bool);
-	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
-	int (*link) (struct dentry *,struct inode *,struct dentry *);
-	int (*unlink) (struct inode *,struct dentry *);
-	int (*symlink) (struct inode *,struct dentry *,const char *);
-	int (*mkdir) (struct inode *,struct dentry *,umode_t);
-	int (*rmdir) (struct inode *,struct dentry *);
-	int (*mknod) (struct inode *,struct dentry *,umode_t,dev_t);
-	int (*rename) (struct inode *, struct dentry *,
-			struct inode *, struct dentry *, unsigned int);
-	int (*readlink) (struct dentry *, char __user *,int);
-	const char *(*get_link) (struct dentry *, struct inode *,
-				 struct delayed_call *);
-	int (*permission) (struct inode *, int);
-	int (*get_acl)(struct inode *, int);
-	int (*setattr) (struct dentry *, struct iattr *);
-	int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
-	ssize_t (*listxattr) (struct dentry *, char *, size_t);
-	void (*update_time)(struct inode *, struct timespec *, int);
-	int (*atomic_open)(struct inode *, struct dentry *, struct file *,
-			unsigned open_flag, umode_t create_mode);
-	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
-};
+.. code-block:: c
+
+	struct inode_operations {
+		int (*create) (struct inode *,struct dentry *, umode_t, bool);
+		struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
+		int (*link) (struct dentry *,struct inode *,struct dentry *);
+		int (*unlink) (struct inode *,struct dentry *);
+		int (*symlink) (struct inode *,struct dentry *,const char *);
+		int (*mkdir) (struct inode *,struct dentry *,umode_t);
+		int (*rmdir) (struct inode *,struct dentry *);
+		int (*mknod) (struct inode *,struct dentry *,umode_t,dev_t);
+		int (*rename) (struct inode *, struct dentry *,
+			       struct inode *, struct dentry *, unsigned int);
+		int (*readlink) (struct dentry *, char __user *,int);
+		const char *(*get_link) (struct dentry *, struct inode *,
+					 struct delayed_call *);
+		int (*permission) (struct inode *, int);
+		int (*get_acl)(struct inode *, int);
+		int (*setattr) (struct dentry *, struct iattr *);
+		int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
+		ssize_t (*listxattr) (struct dentry *, char *, size_t);
+		void (*update_time)(struct inode *, struct timespec *, int);
+		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
+				   unsigned open_flag, umode_t create_mode);
+		int (*tmpfile) (struct inode *, struct dentry *, umode_t);
+	};
 
 Again, all methods are called without any locks being held, unless
 otherwise noted.
 
-  create: called by the open(2) and creat(2) system calls.  Only
+``create``: called by the open(2) and creat(2) system calls.  Only
 	required if you want to support regular files.  The dentry you
 	get should not have an inode (i.e. it should be a negative
 	dentry).  Here you will probably call d_instantiate() with the
 	dentry and the newly created inode
 
-  lookup: called when the VFS needs to look up an inode in a parent
+``lookup``: called when the VFS needs to look up an inode in a parent
 	directory.  The name to look for is found in the dentry.  This
 	method must call d_add() to insert the found inode into the
 	dentry.  The "i_count" field in the inode structure should be
@@ -413,31 +421,31 @@ otherwise noted.
 	to a struct "dentry_operations".
 	This method is called with the directory inode semaphore held
 
-  link: called by the link(2) system call.  Only required if you want
+``link``: called by the link(2) system call.  Only required if you want
 	to support hard links.  You will probably need to call
 	d_instantiate() just as you would in the create() method
 
-  unlink: called by the unlink(2) system call.  Only required if you
+``unlink``: called by the unlink(2) system call.  Only required if you
 	want to support deleting inodes
 
-  symlink: called by the symlink(2) system call.  Only required if you
+``symlink``: called by the symlink(2) system call.  Only required if you
 	want to support symlinks.  You will probably need to call
 	d_instantiate() just as you would in the create() method
 
-  mkdir: called by the mkdir(2) system call.  Only required if you want
+``mkdir``: called by the mkdir(2) system call.  Only required if you want
 	to support creating subdirectories.  You will probably need to
 	call d_instantiate() just as you would in the create() method
 
-  rmdir: called by the rmdir(2) system call.  Only required if you want
+``rmdir``: called by the rmdir(2) system call.  Only required if you want
 	to support deleting subdirectories
 
-  mknod: called by the mknod(2) system call to create a device (char,
+``mknod``: called by the mknod(2) system call to create a device (char,
 	block) inode or a named pipe (FIFO) or socket.  Only required
 	if you want to support creating these types of inodes.  You
 	will probably need to call d_instantiate() just as you would
 	in the create() method
 
-  rename: called by the rename(2) system call to rename the object to
+``rename``: called by the rename(2) system call to rename the object to
 	have the parent and name given by the second inode and dentry.
 
 	The filesystem must return -EINVAL for any unsupported or
@@ -451,7 +459,7 @@ otherwise noted.
 	exist; this is checked by the VFS.  Unlike plain rename,
 	source and target may be of different type.
 
-  get_link: called by the VFS to follow a symbolic link to the
+``get_link``: called by the VFS to follow a symbolic link to the
 	inode it points to.  Only required if you want to support
 	symbolic links.  This method returns the symlink body
 	to traverse (and possibly resets the current position with
@@ -465,13 +473,13 @@ otherwise noted.
 	argument.  If request can't be handled without leaving RCU mode,
 	have it return ERR_PTR(-ECHILD).
 
-  readlink: this is now just an override for use by readlink(2) for the
+``readlink``: this is now just an override for use by readlink(2) for the
 	cases when ->get_link uses nd_jump_link() or object is not in
 	fact a symlink.  Normally filesystems should only implement
 	->get_link for symlinks and readlink(2) will automatically use
 	that.
 
-  permission: called by the VFS to check for access rights on a POSIX-like
+``permission``: called by the VFS to check for access rights on a POSIX-like
 	filesystem.
 
 	May be called in rcu-walk mode (mask & MAY_NOT_BLOCK).  If in rcu-walk
@@ -481,20 +489,20 @@ otherwise noted.
 	If a situation is encountered that rcu-walk cannot handle, return
 	-ECHILD and it will be called again in ref-walk mode.
 
-  setattr: called by the VFS to set attributes for a file.  This method
+``setattr``: called by the VFS to set attributes for a file.  This method
 	is called by chmod(2) and related system calls.
 
-  getattr: called by the VFS to get attributes of a file.  This method
+``getattr``: called by the VFS to get attributes of a file.  This method
 	is called by stat(2) and related system calls.
 
-  listxattr: called by the VFS to list all extended attributes for a
+``listxattr``: called by the VFS to list all extended attributes for a
 	given file.  This method is called by the listxattr(2) system call.
 
-  update_time: called by the VFS to update a specific time or the i_version of
+``update_time``: called by the VFS to update a specific time or the i_version of
 	an inode.  If this is not defined the VFS will update the inode itself
 	and call mark_inode_dirty_sync.
 
-  atomic_open: called on the last component of an open.  Using this optional
+``atomic_open``: called on the last component of an open.  Using this optional
 	method the filesystem can look up, possibly create and open the file in
 	one atomic operation.  If it wants to leave actual opening to the
 	caller (e.g. if the file turned out to be a symlink, device, or just
@@ -506,7 +514,7 @@ otherwise noted.
 	the method must only succeed if the file didn't exist and hence FMODE_CREATED
 	shall always be set on success.
 
-  tmpfile: called in the end of O_TMPFILE open().  Optional, equivalent to
+``tmpfile``: called in the end of O_TMPFILE open().  Optional, equivalent to
 	atomically creating, opening and unlinking a file in given directory.
 
 
@@ -624,41 +632,43 @@ struct address_space_operations
 This describes how the VFS can manipulate mapping of a file to page
 cache in your filesystem.  The following members are defined:
 
-struct address_space_operations {
-	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	int (*readpage)(struct file *, struct page *);
-	int (*writepages)(struct address_space *, struct writeback_control *);
-	int (*set_page_dirty)(struct page *page);
-	int (*readpages)(struct file *filp, struct address_space *mapping,
-			struct list_head *pages, unsigned nr_pages);
-	int (*write_begin)(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
+.. code-block:: c
+
+	struct address_space_operations {
+		int (*writepage)(struct page *page, struct writeback_control *wbc);
+		int (*readpage)(struct file *, struct page *);
+		int (*writepages)(struct address_space *, struct writeback_control *);
+		int (*set_page_dirty)(struct page *page);
+		int (*readpages)(struct file *filp, struct address_space *mapping,
+				 struct list_head *pages, unsigned nr_pages);
+		int (*write_begin)(struct file *, struct address_space *mapping,
+				   loff_t pos, unsigned len, unsigned flags,
 				struct page **pagep, void **fsdata);
-	int (*write_end)(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned copied,
-				struct page *page, void *fsdata);
-	sector_t (*bmap)(struct address_space *, sector_t);
-	void (*invalidatepage) (struct page *, unsigned int, unsigned int);
-	int (*releasepage) (struct page *, int);
-	void (*freepage)(struct page *);
-	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
-	/* isolate a page for migration */
-	bool (*isolate_page) (struct page *, isolate_mode_t);
-	/* migrate the contents of a page to the specified target */
-	int (*migratepage) (struct page *, struct page *);
-	/* put migration-failed page back to right list */
-	void (*putback_page) (struct page *);
-	int (*launder_page) (struct page *);
-
-	int (*is_partially_uptodate) (struct page *, unsigned long,
-					unsigned long);
-	void (*is_dirty_writeback) (struct page *, bool *, bool *);
-	int (*error_remove_page) (struct mapping *mapping, struct page *page);
-	int (*swap_activate)(struct file *);
-	int (*swap_deactivate)(struct file *);
-};
-
-  writepage: called by the VM to write a dirty page to backing store.
+		int (*write_end)(struct file *, struct address_space *mapping,
+				 loff_t pos, unsigned len, unsigned copied,
+				 struct page *page, void *fsdata);
+		sector_t (*bmap)(struct address_space *, sector_t);
+		void (*invalidatepage) (struct page *, unsigned int, unsigned int);
+		int (*releasepage) (struct page *, int);
+		void (*freepage)(struct page *);
+		ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
+		/* isolate a page for migration */
+		bool (*isolate_page) (struct page *, isolate_mode_t);
+		/* migrate the contents of a page to the specified target */
+		int (*migratepage) (struct page *, struct page *);
+		/* put migration-failed page back to right list */
+		void (*putback_page) (struct page *);
+		int (*launder_page) (struct page *);
+
+		int (*is_partially_uptodate) (struct page *, unsigned long,
+					      unsigned long);
+		void (*is_dirty_writeback) (struct page *, bool *, bool *);
+		int (*error_remove_page) (struct mapping *mapping, struct page *page);
+		int (*swap_activate)(struct file *);
+		int (*swap_deactivate)(struct file *);
+	};
+
+``writepage``: called by the VM to write a dirty page to backing store.
       This may happen for data integrity reasons (i.e. 'sync'), or
       to free up memory (flush).  The difference can be seen in
       wbc->sync_mode.
@@ -676,7 +686,7 @@ struct address_space_operations {
 
       See the file "Locking" for more details.
 
-  readpage: called by the VM to read a page from backing store.
+``readpage``: called by the VM to read a page from backing store.
        The page will be Locked when readpage is called, and should be
        unlocked and marked uptodate once the read completes.
        If ->readpage discovers that it needs to unlock the page for
@@ -684,7 +694,7 @@ struct address_space_operations {
        In this case, the page will be relocated, relocked and if
        that all succeeds, ->readpage will be called again.
 
-  writepages: called by the VM to write out pages associated with the
+``writepages``: called by the VM to write out pages associated with the
 	address_space object.  If wbc->sync_mode is WBC_SYNC_ALL, then
 	the writeback_control will specify a range of pages that must be
 	written out.  If it is WBC_SYNC_NONE, then a nr_to_write is given
@@ -693,7 +703,7 @@ struct address_space_operations {
 	instead.  This will choose pages from the address space that are
 	tagged as DIRTY and will pass them to ->writepage.
 
-  set_page_dirty: called by the VM to set a page dirty.
+``set_page_dirty``: called by the VM to set a page dirty.
 	This is particularly needed if an address space attaches
 	private data to a page, and that data needs to be updated when
 	a page is dirtied.  This is called, for example, when a memory
@@ -701,14 +711,14 @@ struct address_space_operations {
 	If defined, it should set the PageDirty flag, and the
 	PAGECACHE_TAG_DIRTY tag in the radix tree.
 
-  readpages: called by the VM to read pages associated with the address_space
+``readpages``: called by the VM to read pages associated with the address_space
 	object.  This is essentially just a vector version of
 	readpage.  Instead of just one page, several pages are
 	requested.
 	readpages is only used for read-ahead, so read errors are
 	ignored.  If anything goes wrong, feel free to give up.
 
-  write_begin:
+``write_begin``:
 	Called by the generic buffered write code to ask the filesystem to
 	prepare to write len bytes at the given offset in the file.  The
 	address_space should check that the write will be able to complete,
@@ -718,7 +728,7 @@ struct address_space_operations {
 	read already) so that the updated blocks can be written out properly.
 
 	The filesystem must return the locked pagecache page for the specified
-	offset, in *pagep, for the caller to write into.
+	offset, in ``*pagep``, for the caller to write into.
 
 	It must be able to cope with short writes (where the length passed to
 	write_begin is greater than the number of bytes copied into the page).
@@ -732,7 +742,7 @@ struct address_space_operations {
 	Returns 0 on success; < 0 on failure (which is the error code), in
 	which case write_end is not called.
 
-  write_end: After a successful write_begin, and data copy, write_end must
+``write_end``: After a successful write_begin, and data copy, write_end must
 	be called.  len is the original len passed to write_begin, and copied
 	is the amount that was able to be copied.
 
@@ -742,7 +752,7 @@ struct address_space_operations {
 	Returns < 0 on failure, otherwise the number of bytes (<= 'copied')
 	that were able to be copied into pagecache.
 
-  bmap: called by the VFS to map a logical block offset within object to
+``bmap``: called by the VFS to map a logical block offset within object to
 	physical block number.  This method is used by the FIBMAP
 	ioctl and for working with swap-files.  To be able to swap to
 	a file, the file must have a stable mapping to a block
@@ -750,7 +760,7 @@ struct address_space_operations {
 	but instead uses bmap to find out where the blocks in the file
 	are and uses those addresses directly.
 
-  invalidatepage: If a page has PagePrivate set, then invalidatepage
+``invalidatepage``: If a page has PagePrivate set, then invalidatepage
 	will be called when part or all of the page is to be removed
 	from the address space.  This generally corresponds to either a
 	truncation, punch hole  or a complete invalidation of the address
@@ -762,7 +772,7 @@ struct address_space_operations {
 	be done by calling the ->releasepage function, but in this case the
 	release MUST succeed.
 
-  releasepage: releasepage is called on PagePrivate pages to indicate
+``releasepage``: releasepage is called on PagePrivate pages to indicate
 	that the page should be freed if possible.  ->releasepage
 	should remove any private data from the page and clear the
 	PagePrivate flag.  If releasepage() fails for some reason, it must
@@ -783,40 +793,40 @@ struct address_space_operations {
 	need to ensure this.  Possibly it can clear the PageUptodate
 	bit if it cannot free private data yet.
 
-  freepage: freepage is called once the page is no longer visible in
+``freepage``: freepage is called once the page is no longer visible in
 	the page cache in order to allow the cleanup of any private
 	data.  Since it may be called by the memory reclaimer, it
 	should not assume that the original address_space mapping still
 	exists, and it should not block.
 
-  direct_IO: called by the generic read/write routines to perform
+``direct_IO``: called by the generic read/write routines to perform
 	direct_IO - that is IO requests which bypass the page cache
 	and transfer data directly between the storage and the
 	application's address space.
 
-  isolate_page: Called by the VM when isolating a movable non-lru page.
+``isolate_page``: Called by the VM when isolating a movable non-lru page.
 	If page is successfully isolated, VM marks the page as PG_isolated
 	via __SetPageIsolated.
 
-  migrate_page:  This is used to compact the physical memory usage.
+``migrate_page``:  This is used to compact the physical memory usage.
 	If the VM wants to relocate a page (maybe off a memory card
 	that is signalling imminent failure) it will pass a new page
 	and an old page to this function.  migrate_page should
 	transfer any private data across and update any references
 	that it has to the page.
 
-  putback_page: Called by the VM when isolated page's migration fails.
+``putback_page``: Called by the VM when isolated page's migration fails.
 
-  launder_page: Called before freeing a page - it writes back the dirty page.  To
+``launder_page``: Called before freeing a page - it writes back the dirty page.  To
 	prevent redirtying the page, it is kept locked during the whole
 	operation.
 
-  is_partially_uptodate: Called by the VM when reading a file through the
+``is_partially_uptodate``: Called by the VM when reading a file through the
 	pagecache when the underlying blocksize != pagesize.  If the required
 	block is up to date then the read can complete without needing the IO
 	to bring the whole page up to date.
 
-  is_dirty_writeback: Called by the VM when attempting to reclaim a page.
+``is_dirty_writeback``: Called by the VM when attempting to reclaim a page.
 	The VM uses dirty and writeback information to determine if it needs
 	to stall to allow flushers a chance to complete some IO.  Ordinarily
 	it can use PageDirty and PageWriteback but some filesystems have
@@ -825,17 +835,17 @@ struct address_space_operations {
 	allows a filesystem to indicate to the VM if a page should be
 	treated as dirty or writeback for the purposes of stalling.
 
-  error_remove_page: normally set to generic_error_remove_page if truncation
+``error_remove_page``: normally set to generic_error_remove_page if truncation
 	is ok for this address space.  Used for memory failure handling.
 	Setting this implies you deal with pages going away under you,
 	unless you have them locked or reference counts increased.
 
-  swap_activate: Called when swapon is used on a file to allocate
+``swap_activate``: Called when swapon is used on a file to allocate
 	space if necessary and pin the block lookup information in
 	memory.  A return value of zero indicates success,
 	in which case this file can be used to back swapspace.
 
-  swap_deactivate: Called during swapoff on files where swap_activate
+``swap_deactivate``: Called during swapoff on files where swap_activate
 	was successful.
 
 
@@ -852,78 +862,80 @@ struct file_operations
 This describes how the VFS can manipulate an open file.  As of kernel
 4.18, the following members are defined:
 
-struct file_operations {
-	struct module *owner;
-	loff_t (*llseek) (struct file *, loff_t, int);
-	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
-	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
-	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
-	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
-	int (*iopoll)(struct kiocb *kiocb, bool spin);
-	int (*iterate) (struct file *, struct dir_context *);
-	int (*iterate_shared) (struct file *, struct dir_context *);
-	__poll_t (*poll) (struct file *, struct poll_table_struct *);
-	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
-	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
-	int (*mmap) (struct file *, struct vm_area_struct *);
-	int (*open) (struct inode *, struct file *);
-	int (*flush) (struct file *, fl_owner_t id);
-	int (*release) (struct inode *, struct file *);
-	int (*fsync) (struct file *, loff_t, loff_t, int datasync);
-	int (*fasync) (int, struct file *, int);
-	int (*lock) (struct file *, int, struct file_lock *);
-	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
-	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
-	int (*check_flags)(int);
-	int (*flock) (struct file *, int, struct file_lock *);
-	ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
-	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
-	int (*setlease)(struct file *, long, struct file_lock **, void **);
-	long (*fallocate)(struct file *file, int mode, loff_t offset,
-			  loff_t len);
-	void (*show_fdinfo)(struct seq_file *m, struct file *f);
-#ifndef CONFIG_MMU
-	unsigned (*mmap_capabilities)(struct file *);
-#endif
-	ssize_t (*copy_file_range)(struct file *, loff_t, struct file *, loff_t, size_t, unsigned int);
-	loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
-				   struct file *file_out, loff_t pos_out,
-				   loff_t len, unsigned int remap_flags);
-	int (*fadvise)(struct file *, loff_t, loff_t, int);
-};
+.. code-block:: c
+
+	struct file_operations {
+		struct module *owner;
+		loff_t (*llseek) (struct file *, loff_t, int);
+		ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
+		ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
+		ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
+		ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+		int (*iopoll)(struct kiocb *kiocb, bool spin);
+		int (*iterate) (struct file *, struct dir_context *);
+		int (*iterate_shared) (struct file *, struct dir_context *);
+		__poll_t (*poll) (struct file *, struct poll_table_struct *);
+		long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
+		long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
+		int (*mmap) (struct file *, struct vm_area_struct *);
+		int (*open) (struct inode *, struct file *);
+		int (*flush) (struct file *, fl_owner_t id);
+		int (*release) (struct inode *, struct file *);
+		int (*fsync) (struct file *, loff_t, loff_t, int datasync);
+		int (*fasync) (int, struct file *, int);
+		int (*lock) (struct file *, int, struct file_lock *);
+		ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
+		unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+		int (*check_flags)(int);
+		int (*flock) (struct file *, int, struct file_lock *);
+		ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
+		ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
+		int (*setlease)(struct file *, long, struct file_lock **, void **);
+		long (*fallocate)(struct file *file, int mode, loff_t offset,
+				  loff_t len);
+		void (*show_fdinfo)(struct seq_file *m, struct file *f);
+	#ifndef CONFIG_MMU
+		unsigned (*mmap_capabilities)(struct file *);
+	#endif
+		ssize_t (*copy_file_range)(struct file *, loff_t, struct file *, loff_t, size_t, unsigned int);
+		loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
+					   struct file *file_out, loff_t pos_out,
+					   loff_t len, unsigned int remap_flags);
+		int (*fadvise)(struct file *, loff_t, loff_t, int);
+	};
 
 Again, all methods are called without any locks being held, unless
 otherwise noted.
 
-  llseek: called when the VFS needs to move the file position index
+``llseek``: called when the VFS needs to move the file position index
 
-  read: called by read(2) and related system calls
+``read``: called by read(2) and related system calls
 
-  read_iter: possibly asynchronous read with iov_iter as destination
+``read_iter``: possibly asynchronous read with iov_iter as destination
 
-  write: called by write(2) and related system calls
+``write``: called by write(2) and related system calls
 
-  write_iter: possibly asynchronous write with iov_iter as source
+``write_iter``: possibly asynchronous write with iov_iter as source
 
-  iopoll: called when aio wants to poll for completions on HIPRI iocbs
+``iopoll``: called when aio wants to poll for completions on HIPRI iocbs
 
-  iterate: called when the VFS needs to read the directory contents
+``iterate``: called when the VFS needs to read the directory contents
 
-  iterate_shared: called when the VFS needs to read the directory contents
+``iterate_shared``: called when the VFS needs to read the directory contents
 	when filesystem supports concurrent dir iterators
 
-  poll: called by the VFS when a process wants to check if there is
+``poll``: called by the VFS when a process wants to check if there is
 	activity on this file and (optionally) go to sleep until there
 	is activity.  Called by the select(2) and poll(2) system calls
 
-  unlocked_ioctl: called by the ioctl(2) system call.
+``unlocked_ioctl``: called by the ioctl(2) system call.
 
-  compat_ioctl: called by the ioctl(2) system call when 32 bit system calls
+``compat_ioctl``: called by the ioctl(2) system call when 32 bit system calls
 	 are used on 64 bit kernels.
 
-  mmap: called by the mmap(2) system call
+``mmap``: called by the mmap(2) system call
 
-  open: called by the VFS when an inode should be opened.  When the VFS
+``open``: called by the VFS when an inode should be opened.  When the VFS
 	opens a file, it creates a new "struct file".  It then calls the
 	open method for the newly allocated file structure.  You might
 	think that the open method really belongs in
@@ -933,40 +945,40 @@ otherwise noted.
 	"private_data" member in the file structure if you want to point
 	to a device structure
 
-  flush: called by the close(2) system call to flush a file
+``flush``: called by the close(2) system call to flush a file
 
-  release: called when the last reference to an open file is closed
+``release``: called when the last reference to an open file is closed
 
-  fsync: called by the fsync(2) system call.  Also see the section above
+``fsync``: called by the fsync(2) system call.  Also see the section above
 	 entitled "Handling errors during writeback".
 
-  fasync: called by the fcntl(2) system call when asynchronous
+``fasync``: called by the fcntl(2) system call when asynchronous
 	(non-blocking) mode is enabled for a file
 
-  lock: called by the fcntl(2) system call for F_GETLK, F_SETLK, and F_SETLKW
+``lock``: called by the fcntl(2) system call for F_GETLK, F_SETLK, and F_SETLKW
 	commands
 
-  get_unmapped_area: called by the mmap(2) system call
+``get_unmapped_area``: called by the mmap(2) system call
 
-  check_flags: called by the fcntl(2) system call for F_SETFL command
+``check_flags``: called by the fcntl(2) system call for F_SETFL command
 
-  flock: called by the flock(2) system call
+``flock``: called by the flock(2) system call
 
-  splice_write: called by the VFS to splice data from a pipe to a file.  This
+``splice_write``: called by the VFS to splice data from a pipe to a file.  This
 		method is used by the splice(2) system call
 
-  splice_read: called by the VFS to splice data from file to a pipe.  This
+``splice_read``: called by the VFS to splice data from file to a pipe.  This
 	       method is used by the splice(2) system call
 
-  setlease: called by the VFS to set or release a file lock lease.  setlease
+``setlease``: called by the VFS to set or release a file lock lease.  setlease
 	    implementations should call generic_setlease to record or remove
 	    the lease in the inode after setting it.
 
-  fallocate: called by the VFS to preallocate blocks or punch a hole.
+``fallocate``: called by the VFS to preallocate blocks or punch a hole.
 
-  copy_file_range: called by the copy_file_range(2) system call.
+``copy_file_range``: called by the copy_file_range(2) system call.
 
-  remap_file_range: called by the ioctl(2) system call for FICLONERANGE and
+``remap_file_range``: called by the ioctl(2) system call for FICLONERANGE and
 	FICLONE and FIDEDUPERANGE commands to remap file ranges.  An
 	implementation should remap len bytes at pos_in of the source file into
 	the dest file at pos_out.  Implementations must handle callers passing
@@ -979,7 +991,7 @@ otherwise noted.
 	set, the caller is ok with the implementation shortening the request
 	length to satisfy alignment or EOF requirements (or any other reason).
 
-  fadvise: possibly called by the fadvise64() system call.
+``fadvise``: possibly called by the fadvise64() system call.
 
 Note that the file operations are implemented by the specific
 filesystem in which the inode resides.  When opening a device node
@@ -1006,23 +1018,25 @@ here.  These methods may be set to NULL, as they are either optional or
 the VFS uses a default.  As of kernel 2.6.22, the following members are
 defined:
 
-struct dentry_operations {
-	int (*d_revalidate)(struct dentry *, unsigned int);
-	int (*d_weak_revalidate)(struct dentry *, unsigned int);
-	int (*d_hash)(const struct dentry *, struct qstr *);
-	int (*d_compare)(const struct dentry *,
-			unsigned int, const char *, const struct qstr *);
-	int (*d_delete)(const struct dentry *);
-	int (*d_init)(struct dentry *);
-	void (*d_release)(struct dentry *);
-	void (*d_iput)(struct dentry *, struct inode *);
-	char *(*d_dname)(struct dentry *, char *, int);
-	struct vfsmount *(*d_automount)(struct path *);
-	int (*d_manage)(const struct path *, bool);
-	struct dentry *(*d_real)(struct dentry *, const struct inode *);
-};
-
-  d_revalidate: called when the VFS needs to revalidate a dentry.  This
+.. code-block:: c
+
+	struct dentry_operations {
+		int (*d_revalidate)(struct dentry *, unsigned int);
+		int (*d_weak_revalidate)(struct dentry *, unsigned int);
+		int (*d_hash)(const struct dentry *, struct qstr *);
+		int (*d_compare)(const struct dentry *,
+				 unsigned int, const char *, const struct qstr *);
+		int (*d_delete)(const struct dentry *);
+		int (*d_init)(struct dentry *);
+		void (*d_release)(struct dentry *);
+		void (*d_iput)(struct dentry *, struct inode *);
+		char *(*d_dname)(struct dentry *, char *, int);
+		struct vfsmount *(*d_automount)(struct path *);
+		int (*d_manage)(const struct path *, bool);
+		struct dentry *(*d_real)(struct dentry *, const struct inode *);
+	};
+
+``d_revalidate``: called when the VFS needs to revalidate a dentry.  This
 	is called whenever a name look-up finds a dentry in the
 	dcache.  Most local filesystems leave this as NULL, because all their
 	dentries in the dcache are valid.  Network filesystems are different
@@ -1041,7 +1055,7 @@ struct dentry_operations {
 	If a situation is encountered that rcu-walk cannot handle, return
 	-ECHILD and it will be called again in ref-walk mode.
 
- d_weak_revalidate: called when the VFS needs to revalidate a "jumped" dentry.
+``_weak_revalidate``: called when the VFS needs to revalidate a "jumped" dentry.
 	This is called when a path-walk ends at dentry that was not acquired by
 	doing a lookup in the parent directory.  This includes "/", "." and "..",
 	as well as procfs-style symlinks and mountpoint traversal.
@@ -1055,14 +1069,14 @@ struct dentry_operations {
 
 	d_weak_revalidate is only called after leaving rcu-walk mode.
 
-  d_hash: called when the VFS adds a dentry to the hash table.  The first
+``d_hash``: called when the VFS adds a dentry to the hash table.  The first
 	dentry passed to d_hash is the parent directory that the name is
 	to be hashed into.
 
 	Same locking and synchronisation rules as d_compare regarding
 	what is safe to dereference etc.
 
-  d_compare: called to compare a dentry name with a given name.  The first
+``d_compare``: called to compare a dentry name with a given name.  The first
 	dentry is the parent of the dentry to be compared, the second is
 	the child dentry.  len and name string are properties of the dentry
 	to be compared.  qstr is the name to compare it with.
@@ -1079,22 +1093,22 @@ struct dentry_operations {
 	It is a tricky calling convention because it needs to be called under
 	"rcu-walk", ie. without any locks or references on things.
 
-  d_delete: called when the last reference to a dentry is dropped and the
+``d_delete``: called when the last reference to a dentry is dropped and the
 	dcache is deciding whether or not to cache it.  Return 1 to delete
 	immediately, or 0 to cache the dentry.  Default is NULL which means to
 	always cache a reachable dentry.  d_delete must be constant and
 	idempotent.
 
-  d_init: called when a dentry is allocated
+``d_init``: called when a dentry is allocated
 
-  d_release: called when a dentry is really deallocated
+``d_release``: called when a dentry is really deallocated
 
-  d_iput: called when a dentry loses its inode (just prior to its
+``d_iput``: called when a dentry loses its inode (just prior to its
 	being deallocated).  The default when this is NULL is that the
 	VFS calls iput().  If you define this method, you must call
 	iput() yourself
 
-  d_dname: called when the pathname of a dentry should be generated.
+``d_dname``: called when the pathname of a dentry should be generated.
 	Useful for some pseudo filesystems (sockfs, pipefs, ...) to delay
 	pathname generation.  (Instead of doing it when dentry is created,
 	it's done only when the path is needed.).  Real filesystems probably
@@ -1108,13 +1122,15 @@ struct dentry_operations {
 
 	Example :
 
+.. code-block:: c
+
 	static char *pipefs_dname(struct dentry *dent, char *buffer, int buflen)
 	{
 		return dynamic_dname(dentry, buffer, buflen, "pipe:[%lu]",
 				dentry->d_inode->i_ino);
 	}
 
-  d_automount: called when an automount dentry is to be traversed (optional).
+``d_automount``: called when an automount dentry is to be traversed (optional).
 	This should create a new VFS mount record and return the record to the
 	caller.  The caller is supplied with a path parameter giving the
 	automount directory to describe the automount target and the parent
@@ -1134,7 +1150,7 @@ struct dentry_operations {
 	dentry.  This is set by __d_instantiate() if S_AUTOMOUNT is set on the
 	inode being added.
 
-  d_manage: called to allow the filesystem to manage the transition from a
+``d_manage``: called to allow the filesystem to manage the transition from a
 	dentry (optional).  This allows autofs, for example, to hold up clients
 	waiting to explore behind a 'mountpoint' while letting the daemon go
 	past and construct the subtree there.  0 should be returned to let the
@@ -1152,7 +1168,7 @@ struct dentry_operations {
 	This function is only used if DCACHE_MANAGE_TRANSIT is set on the
 	dentry being transited from.
 
-  d_real: overlay/union type filesystems implement this method to return one of
+``d_real``: overlay/union type filesystems implement this method to return one of
 	the underlying dentries hidden by the overlay.  It is used in two
 	different modes:
 
@@ -1174,36 +1190,36 @@ Directory Entry Cache API
 There are a number of functions defined which permit a filesystem to
 manipulate dentries:
 
-  dget: open a new handle for an existing dentry (this just increments
+``dget``: open a new handle for an existing dentry (this just increments
 	the usage count)
 
-  dput: close a handle for a dentry (decrements the usage count).  If
+``dput``: close a handle for a dentry (decrements the usage count).  If
 	the usage count drops to 0, and the dentry is still in its
 	parent's hash, the "d_delete" method is called to check whether
 	it should be cached.  If it should not be cached, or if the dentry
 	is not hashed, it is deleted.  Otherwise cached dentries are put
 	into an LRU list to be reclaimed on memory shortage.
 
-  d_drop: this unhashes a dentry from its parents hash list.  A
+``d_drop``: this unhashes a dentry from its parents hash list.  A
 	subsequent call to dput() will deallocate the dentry if its
 	usage count drops to 0
 
-  d_delete: delete a dentry.  If there are no other open references to
+``d_delete``: delete a dentry.  If there are no other open references to
 	the dentry then the dentry is turned into a negative dentry
 	(the d_iput() method is called).  If there are other
 	references, then d_drop() is called instead
 
-  d_add: add a dentry to its parents hash list and then calls
+``d_add``: add a dentry to its parents hash list and then calls
 	d_instantiate()
 
-  d_instantiate: add a dentry to the alias hash list for the inode and
+``d_instantiate``: add a dentry to the alias hash list for the inode and
 	updates the "d_inode" member.  The "i_count" member in the
 	inode structure should be set/incremented.  If the inode
 	pointer is NULL, the dentry is called a "negative
 	dentry".  This function is commonly called when an inode is
 	created for an existing negative dentry
 
-  d_lookup: look up a dentry given its parent and path name component
+``d_lookup``: look up a dentry given its parent and path name component
 	It looks up the child of that given name from the dcache
 	hash table.  If it is found, the reference count is incremented
 	and the dentry is returned.  The caller must use dput()
-- 
2.21.0

