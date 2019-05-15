Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A601E649
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 02:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfEOAaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 20:30:17 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43379 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfEOAaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 08BEA2524C;
        Tue, 14 May 2019 20:30:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 14 May 2019 20:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=KfR5mcvev6fHvnHRzXuHdmrWfsnB81T8wM8C95aCmgw=; b=0L/lI63S
        fb63T/3VDHD0gdmGs7LM/E51Uo8uaZ7VRQgl40Lw/bOcf+5N1V3SFGuzgMsRWU3v
        5qSEQPRK6dwH6XIzBNIgVpDa+1CGy+oN4BTMHydYqxtPe+qLV40BFB3zKk71L4rs
        +N4pbKDBwHDg/4S3PjcC+2WOO+XnVrzeJEStU+gqptGm0tU57F2Eaipj2lOcRRNy
        QhoXtCg4loUB6Xs70hRqMWuLXO7Aw1wG1Nz+jhON2ICO6lzrjtpi5tyfu8dgijej
        pRP0N5881YxLMGX7xHVNpe9qHlWvd3ORVgmsb+K+85DuKlGNrvsKlifzBthiTVjn
        SLNJreWYfy9wYA==
X-ME-Sender: <xms:kl3bXPhFGQGAizSuAce51GPHb7ge649DzYWed1QfIf8TEpzLmmENag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvvdefrddvuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:kl3bXIWH6n4bmVpmpQp9TXrw_TuyoA73TIeuRFgC32WAiSSVGk2ocQ>
    <xmx:kl3bXB07OBOEKRigJcP0PCnxgauZFuLI8X6DMXeic9CNn--GE8fdNg>
    <xmx:kl3bXOHYXDGQVMOhn8LESvpthShJW8UUg0zZHlbP3Xzb4Xjp2AhpRw>
    <xmx:kl3bXJ-odjkNFw_qP3C5AeJplcn-1_ieSaUk42cbyBcawRasqOSOtw>
Received: from eros.localdomain (ppp121-44-223-211.bras1.syd2.internode.on.net [121.44.223.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 291AC103D0;
        Tue, 14 May 2019 20:30:06 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/9] docs: filesystems: vfs: Use uniform space after period.
Date:   Wed, 15 May 2019 10:29:06 +1000
Message-Id: <20190515002913.12586-3-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515002913.12586-1-tobin@kernel.org>
References: <20190515002913.12586-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently sometimes document has a single space after a period and
sometimes it has double.  Whichever we use it should be uniform.

Use double space after period, be uniform.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/vfs.txt | 246 +++++++++++++++---------------
 1 file changed, 123 insertions(+), 123 deletions(-)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 637fd1756b89..2a610b9355e0 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -16,12 +16,12 @@ Introduction
 
 The Virtual File System (also known as the Virtual Filesystem Switch)
 is the software layer in the kernel that provides the filesystem
-interface to userspace programs. It also provides an abstraction
+interface to userspace programs.  It also provides an abstraction
 within the kernel which allows different filesystem implementations to
 coexist.
 
 VFS system calls open(2), stat(2), read(2), write(2), chmod(2) and so
-on are called from a process context. Filesystem locking is described
+on are called from a process context.  Filesystem locking is described
 in the document Documentation/filesystems/Locking.
 
 
@@ -29,37 +29,37 @@ Directory Entry Cache (dcache)
 ------------------------------
 
 The VFS implements the open(2), stat(2), chmod(2), and similar system
-calls. The pathname argument that is passed to them is used by the VFS
+calls.  The pathname argument that is passed to them is used by the VFS
 to search through the directory entry cache (also known as the dentry
-cache or dcache). This provides a very fast look-up mechanism to
-translate a pathname (filename) into a specific dentry. Dentries live
+cache or dcache).  This provides a very fast look-up mechanism to
+translate a pathname (filename) into a specific dentry.  Dentries live
 in RAM and are never saved to disc: they exist only for performance.
 
-The dentry cache is meant to be a view into your entire filespace. As
+The dentry cache is meant to be a view into your entire filespace.  As
 most computers cannot fit all dentries in the RAM at the same time,
-some bits of the cache are missing. In order to resolve your pathname
+some bits of the cache are missing.  In order to resolve your pathname
 into a dentry, the VFS may have to resort to creating dentries along
-the way, and then loading the inode. This is done by looking up the
+the way, and then loading the inode.  This is done by looking up the
 inode.
 
 
 The Inode Object
 ----------------
 
-An individual dentry usually has a pointer to an inode. Inodes are
+An individual dentry usually has a pointer to an inode.  Inodes are
 filesystem objects such as regular files, directories, FIFOs and other
 beasts.  They live either on the disc (for block device filesystems)
-or in the memory (for pseudo filesystems). Inodes that live on the
+or in the memory (for pseudo filesystems).  Inodes that live on the
 disc are copied into the memory when required and changes to the inode
-are written back to disc. A single inode can be pointed to by multiple
+are written back to disc.  A single inode can be pointed to by multiple
 dentries (hard links, for example, do this).
 
 To look up an inode requires that the VFS calls the lookup() method of
-the parent directory inode. This method is installed by the specific
-filesystem implementation that the inode lives in. Once the VFS has
+the parent directory inode.  This method is installed by the specific
+filesystem implementation that the inode lives in.  Once the VFS has
 the required dentry (and hence the inode), we can do all those boring
 things like open(2) the file, or stat(2) it to peek at the inode
-data. The stat(2) operation is fairly simple: once the VFS has the
+data.  The stat(2) operation is fairly simple: once the VFS has the
 dentry, it peeks at the inode data and passes some of it back to
 userspace.
 
@@ -69,17 +69,17 @@ The File Object
 
 Opening a file requires another operation: allocation of a file
 structure (this is the kernel-side implementation of file
-descriptors). The freshly allocated file structure is initialized with
+descriptors).  The freshly allocated file structure is initialized with
 a pointer to the dentry and a set of file operation member functions.
-These are taken from the inode data. The open() file method is then
-called so the specific filesystem implementation can do its work. You
-can see that this is another switch performed by the VFS. The file
+These are taken from the inode data.  The open() file method is then
+called so the specific filesystem implementation can do its work.  You
+can see that this is another switch performed by the VFS.  The file
 structure is placed into the file descriptor table for the process.
 
 Reading, writing and closing files (and other assorted VFS operations)
 is done by using the userspace file descriptor to grab the appropriate
 file structure, and then calling the required file structure method to
-do whatever is required. For as long as the file is open, it keeps the
+do whatever is required.  For as long as the file is open, it keeps the
 dentry in use, which in turn means that the VFS inode is still in use.
 
 
@@ -94,7 +94,7 @@ functions:
    extern int register_filesystem(struct file_system_type *);
    extern int unregister_filesystem(struct file_system_type *);
 
-The passed struct file_system_type describes your filesystem. When a
+The passed struct file_system_type describes your filesystem.  When a
 request is made to mount a filesystem onto a directory in your namespace,
 the VFS will call the appropriate mount() method for the specific
 filesystem.  New vfsmount referring to the tree returned by ->mount()
@@ -108,7 +108,7 @@ file /proc/filesystems.
 struct file_system_type
 -----------------------
 
-This describes the filesystem. As of kernel 2.6.39, the following
+This describes the filesystem.  As of kernel 2.6.39, the following
 members are defined:
 
 struct file_system_type {
@@ -170,12 +170,12 @@ point of view is a reference to dentry at the root of (sub)tree to
 be attached; creation of new superblock is a common side effect.
 
 The most interesting member of the superblock structure that the
-mount() method fills in is the "s_op" field. This is a pointer to
+mount() method fills in is the "s_op" field.  This is a pointer to
 a "struct super_operations" which describes the next level of the
 filesystem implementation.
 
 Usually, a filesystem uses one of the generic mount() implementations
-and provides a fill_super() callback instead. The generic variants are:
+and provides a fill_super() callback instead.  The generic variants are:
 
   mount_bdev: mount a filesystem residing on a block device
 
@@ -186,7 +186,7 @@ and provides a fill_super() callback instead. The generic variants are:
 
 A fill_super() callback implementation has the following arguments:
 
-  struct super_block *sb: the superblock structure. The callback
+  struct super_block *sb: the superblock structure.  The callback
 	must initialize this properly.
 
   void *data: arbitrary mount options, usually comes as an ASCII
@@ -205,7 +205,7 @@ struct super_operations
 -----------------------
 
 This describes how the VFS can manipulate the superblock of your
-filesystem. As of kernel 2.6.22, the following members are defined:
+filesystem.  As of kernel 2.6.22, the following members are defined:
 
 struct super_operations {
         struct inode *(*alloc_inode)(struct super_block *sb);
@@ -233,7 +233,7 @@ struct super_operations {
 };
 
 All methods are called without any locks being held, unless otherwise
-noted. This means that most methods can block safely. All methods are
+noted.  This means that most methods can block safely.  All methods are
 only called from a process context (i.e. not from an interrupt handler
 or bottom half).
 
@@ -270,11 +270,11 @@ or bottom half).
   delete_inode: called when the VFS wants to delete an inode
 
   put_super: called when the VFS wishes to free the superblock
-	(i.e. unmount). This is called with the superblock lock held
+	(i.e. unmount).  This is called with the superblock lock held
 
   sync_fs: called when VFS is writing out all dirty data associated with
-	a superblock. The second parameter indicates whether the method
-	should wait until the write out has been completed. Optional.
+	a superblock.  The second parameter indicates whether the method
+	should wait until the write out has been completed.  Optional.
 
   freeze_fs: called when VFS is locking a filesystem and
 	forcing it into a consistent state.  This method is currently
@@ -285,10 +285,10 @@ or bottom half).
 
   statfs: called when the VFS needs to get filesystem statistics.
 
-  remount_fs: called when the filesystem is remounted. This is called
+  remount_fs: called when the filesystem is remounted.  This is called
 	with the kernel lock held
 
-  clear_inode: called then the VFS clears the inode. Optional
+  clear_inode: called then the VFS clears the inode.  Optional
 
   umount_begin: called when the VFS is unmounting a filesystem.
 
@@ -309,17 +309,17 @@ or bottom half).
 	implement ->nr_cached_objects for it to be called correctly.
 
 	We can't do anything with any errors that the filesystem might
-	encountered, hence the void return type. This will never be called if
+	encountered, hence the void return type.  This will never be called if
 	the VM is trying to reclaim under GFP_NOFS conditions, hence this
 	method does not need to handle that situation itself.
 
 	Implementations must include conditional reschedule calls inside any
-	scanning loop that is done. This allows the VFS to determine
+	scanning loop that is done.  This allows the VFS to determine
 	appropriate scan batch sizes without having to worry about whether
 	implementations will cause holdoff problems due to large scan batch
 	sizes.
 
-Whoever sets up the inode is responsible for filling in the "i_op" field. This
+Whoever sets up the inode is responsible for filling in the "i_op" field.  This
 is a pointer to a "struct inode_operations" which describes the methods that
 can be performed on individual inodes.
 
@@ -363,7 +363,7 @@ struct inode_operations
 -----------------------
 
 This describes how the VFS can manipulate an inode in your
-filesystem. As of kernel 2.6.22, the following members are defined:
+filesystem.  As of kernel 2.6.22, the following members are defined:
 
 struct inode_operations {
 	int (*create) (struct inode *,struct dentry *, umode_t, bool);
@@ -393,19 +393,19 @@ struct inode_operations {
 Again, all methods are called without any locks being held, unless
 otherwise noted.
 
-  create: called by the open(2) and creat(2) system calls. Only
-	required if you want to support regular files. The dentry you
+  create: called by the open(2) and creat(2) system calls.  Only
+	required if you want to support regular files.  The dentry you
 	get should not have an inode (i.e. it should be a negative
-	dentry). Here you will probably call d_instantiate() with the
+	dentry).  Here you will probably call d_instantiate() with the
 	dentry and the newly created inode
 
   lookup: called when the VFS needs to look up an inode in a parent
-	directory. The name to look for is found in the dentry. This
+	directory.  The name to look for is found in the dentry.  This
 	method must call d_add() to insert the found inode into the
-	dentry. The "i_count" field in the inode structure should be
-	incremented. If the named inode does not exist a NULL inode
+	dentry.  The "i_count" field in the inode structure should be
+	incremented.  If the named inode does not exist a NULL inode
 	should be inserted into the dentry (this is called a negative
-	dentry). Returning an error code from this routine must only
+	dentry).  Returning an error code from this routine must only
 	be done on a real error, otherwise creating inodes with system
 	calls like create(2), mknod(2), mkdir(2) and so on will fail.
 	If you wish to overload the dentry methods then you should
@@ -413,27 +413,27 @@ otherwise noted.
 	to a struct "dentry_operations".
 	This method is called with the directory inode semaphore held
 
-  link: called by the link(2) system call. Only required if you want
-	to support hard links. You will probably need to call
+  link: called by the link(2) system call.  Only required if you want
+	to support hard links.  You will probably need to call
 	d_instantiate() just as you would in the create() method
 
-  unlink: called by the unlink(2) system call. Only required if you
+  unlink: called by the unlink(2) system call.  Only required if you
 	want to support deleting inodes
 
-  symlink: called by the symlink(2) system call. Only required if you
-	want to support symlinks. You will probably need to call
+  symlink: called by the symlink(2) system call.  Only required if you
+	want to support symlinks.  You will probably need to call
 	d_instantiate() just as you would in the create() method
 
-  mkdir: called by the mkdir(2) system call. Only required if you want
-	to support creating subdirectories. You will probably need to
+  mkdir: called by the mkdir(2) system call.  Only required if you want
+	to support creating subdirectories.  You will probably need to
 	call d_instantiate() just as you would in the create() method
 
-  rmdir: called by the rmdir(2) system call. Only required if you want
+  rmdir: called by the rmdir(2) system call.  Only required if you want
 	to support deleting subdirectories
 
   mknod: called by the mknod(2) system call to create a device (char,
-	block) inode or a named pipe (FIFO) or socket. Only required
-	if you want to support creating these types of inodes. You
+	block) inode or a named pipe (FIFO) or socket.  Only required
+	if you want to support creating these types of inodes.  You
 	will probably need to call d_instantiate() just as you would
 	in the create() method
 
@@ -474,21 +474,21 @@ otherwise noted.
   permission: called by the VFS to check for access rights on a POSIX-like
 	filesystem.
 
-	May be called in rcu-walk mode (mask & MAY_NOT_BLOCK). If in rcu-walk
-	mode, the filesystem must check the permission without blocking or
+	May be called in rcu-walk mode (mask & MAY_NOT_BLOCK).  If in rcu-walk
+        mode, the filesystem must check the permission without blocking or
 	storing to the inode.
 
 	If a situation is encountered that rcu-walk cannot handle, return
 	-ECHILD and it will be called again in ref-walk mode.
 
-  setattr: called by the VFS to set attributes for a file. This method
+  setattr: called by the VFS to set attributes for a file.  This method
 	is called by chmod(2) and related system calls.
 
-  getattr: called by the VFS to get attributes of a file. This method
+  getattr: called by the VFS to get attributes of a file.  This method
 	is called by stat(2) and related system calls.
 
   listxattr: called by the VFS to list all extended attributes for a
-	given file. This method is called by the listxattr(2) system call.
+	given file.  This method is called by the listxattr(2) system call.
 
   update_time: called by the VFS to update a specific time or the i_version of
 	an inode.  If this is not defined the VFS will update the inode itself
@@ -526,7 +526,7 @@ The first can be used independently to the others.  The VM can try to
 either write dirty pages in order to clean them, or release clean
 pages in order to reuse them.  To do this it can call the ->writepage
 method on dirty pages, and ->releasepage on clean pages with
-PagePrivate set. Clean pages without PagePrivate and with no external
+PagePrivate set.  Clean pages without PagePrivate and with no external
 references will be released without notice being given to the
 address_space.
 
@@ -534,7 +534,7 @@ To achieve this functionality, pages need to be placed on an LRU with
 lru_cache_add and mark_page_active needs to be called whenever the
 page is used.
 
-Pages are normally kept in a radix tree index by ->index. This tree
+Pages are normally kept in a radix tree index by ->index.  This tree
 maintains information about the PG_Dirty and PG_Writeback status of
 each page, so that pages with either of these flags can be found
 quickly.
@@ -620,7 +620,7 @@ struct address_space_operations
 -------------------------------
 
 This describes how the VFS can manipulate mapping of a file to page cache in
-your filesystem. The following members are defined:
+your filesystem.  The following members are defined:
 
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
@@ -700,7 +700,7 @@ struct address_space_operations {
         PAGECACHE_TAG_DIRTY tag in the radix tree.
 
   readpages: called by the VM to read pages associated with the address_space
-	object. This is essentially just a vector version of
+	object.  This is essentially just a vector version of
 	readpage.  Instead of just one page, several pages are
 	requested.
 	readpages is only used for read-ahead, so read errors are
@@ -708,7 +708,7 @@ struct address_space_operations {
 
   write_begin:
 	Called by the generic buffered write code to ask the filesystem to
-	prepare to write len bytes at the given offset in the file. The
+	prepare to write len bytes at the given offset in the file.  The
 	address_space should check that the write will be able to complete,
 	by allocating space if necessary and doing any other internal
 	housekeeping.  If the write will update parts of any basic-blocks on
@@ -731,7 +731,7 @@ struct address_space_operations {
 	which case write_end is not called.
 
   write_end: After a successful write_begin, and data copy, write_end must
-        be called. len is the original len passed to write_begin, and copied
+        be called.  len is the original len passed to write_begin, and copied
         is the amount that was able to be copied.
 
         The filesystem must take care of unlocking the page and releasing it
@@ -741,7 +741,7 @@ struct address_space_operations {
         that were able to be copied into pagecache.
 
   bmap: called by the VFS to map a logical block offset within object to
-	physical block number. This method is used by the FIBMAP
+	physical block number.  This method is used by the FIBMAP
 	ioctl and for working with swap-files.  To be able to swap to
 	a file, the file must have a stable mapping to a block
 	device.  The swap system does not go through the filesystem
@@ -753,7 +753,7 @@ struct address_space_operations {
 	from the address space.  This generally corresponds to either a
 	truncation, punch hole  or a complete invalidation of the address
 	space (in the latter case 'offset' will always be 0 and 'length'
-	will be PAGE_SIZE). Any private data associated with the page
+	will be PAGE_SIZE).  Any private data associated with the page
 	should be updated to reflect this truncation.  If offset is 0 and
 	length is PAGE_SIZE, then the private data should be released,
 	because the page must be able to be completely discarded.  This may
@@ -763,7 +763,7 @@ struct address_space_operations {
   releasepage: releasepage is called on PagePrivate pages to indicate
         that the page should be freed if possible.  ->releasepage
         should remove any private data from the page and clear the
-        PagePrivate flag. If releasepage() fails for some reason, it must
+        PagePrivate flag.  If releasepage() fails for some reason, it must
 	indicate failure with a 0 return value.
 	releasepage() is used in two distinct though related cases.  The
 	first is when the VM finds a clean page with no active users and
@@ -783,7 +783,7 @@ struct address_space_operations {
 
   freepage: freepage is called once the page is no longer visible in
         the page cache in order to allow the cleanup of any private
-	data. Since it may be called by the memory reclaimer, it
+	data.  Since it may be called by the memory reclaimer, it
 	should not assume that the original address_space mapping still
 	exists, and it should not block.
 
@@ -805,32 +805,32 @@ struct address_space_operations {
 
   putback_page: Called by the VM when isolated page's migration fails.
 
-  launder_page: Called before freeing a page - it writes back the dirty page. To
+  launder_page: Called before freeing a page - it writes back the dirty page.  To
 	prevent redirtying the page, it is kept locked during the whole
 	operation.
 
   is_partially_uptodate: Called by the VM when reading a file through the
-	pagecache when the underlying blocksize != pagesize. If the required
+	pagecache when the underlying blocksize != pagesize.  If the required
 	block is up to date then the read can complete without needing the IO
 	to bring the whole page up to date.
 
   is_dirty_writeback: Called by the VM when attempting to reclaim a page.
 	The VM uses dirty and writeback information to determine if it needs
-	to stall to allow flushers a chance to complete some IO. Ordinarily
+	to stall to allow flushers a chance to complete some IO.  Ordinarily
 	it can use PageDirty and PageWriteback but some filesystems have
 	more complex state (unstable pages in NFS prevent reclaim) or
-	do not set those flags due to locking problems. This callback
+	do not set those flags due to locking problems.  This callback
 	allows a filesystem to indicate to the VM if a page should be
 	treated as dirty or writeback for the purposes of stalling.
 
   error_remove_page: normally set to generic_error_remove_page if truncation
-	is ok for this address space. Used for memory failure handling.
+	is ok for this address space.  Used for memory failure handling.
 	Setting this implies you deal with pages going away under you,
 	unless you have them locked or reference counts increased.
 
   swap_activate: Called when swapon is used on a file to allocate
 	space if necessary and pin the block lookup information in
-	memory. A return value of zero indicates success,
+	memory.  A return value of zero indicates success,
 	in which case this file can be used to back swapspace.
 
   swap_deactivate: Called during swapoff on files where swap_activate
@@ -840,14 +840,14 @@ struct address_space_operations {
 The File Object
 ===============
 
-A file object represents a file opened by a process. This is also known
+A file object represents a file opened by a process.  This is also known
 as an "open file description" in POSIX parlance.
 
 
 struct file_operations
 ----------------------
 
-This describes how the VFS can manipulate an open file. As of kernel
+This describes how the VFS can manipulate an open file.  As of kernel
 4.18, the following members are defined:
 
 struct file_operations {
@@ -912,7 +912,7 @@ otherwise noted.
 
   poll: called by the VFS when a process wants to check if there is
 	activity on this file and (optionally) go to sleep until there
-	is activity. Called by the select(2) and poll(2) system calls
+	is activity.  Called by the select(2) and poll(2) system calls
 
   unlocked_ioctl: called by the ioctl(2) system call.
 
@@ -921,13 +921,13 @@ otherwise noted.
 
   mmap: called by the mmap(2) system call
 
-  open: called by the VFS when an inode should be opened. When the VFS
-	opens a file, it creates a new "struct file". It then calls the
-	open method for the newly allocated file structure. You might
+  open: called by the VFS when an inode should be opened.  When the VFS
+	opens a file, it creates a new "struct file".  It then calls the
+	open method for the newly allocated file structure.  You might
 	think that the open method really belongs in
-	"struct inode_operations", and you may be right. I think it's
+	"struct inode_operations", and you may be right.  I think it's
 	done the way it is because it makes filesystems simpler to
-	implement. The open() method is a good place to initialize the
+	implement.  The open() method is a good place to initialize the
 	"private_data" member in the file structure if you want to point
 	to a device structure
 
@@ -935,7 +935,7 @@ otherwise noted.
 
   release: called when the last reference to an open file is closed
 
-  fsync: called by the fsync(2) system call. Also see the section above
+  fsync: called by the fsync(2) system call.  Also see the section above
 	 entitled "Handling errors during writeback".
 
   fasync: called by the fcntl(2) system call when asynchronous
@@ -950,13 +950,13 @@ otherwise noted.
 
   flock: called by the flock(2) system call
 
-  splice_write: called by the VFS to splice data from a pipe to a file. This
+  splice_write: called by the VFS to splice data from a pipe to a file.  This
 		method is used by the splice(2) system call
 
-  splice_read: called by the VFS to splice data from file to a pipe. This
+  splice_read: called by the VFS to splice data from file to a pipe.  This
 	       method is used by the splice(2) system call
 
-  setlease: called by the VFS to set or release a file lock lease. setlease
+  setlease: called by the VFS to set or release a file lock lease.  setlease
 	    implementations should call generic_setlease to record or remove
 	    the lease in the inode after setting it.
 
@@ -980,12 +980,12 @@ otherwise noted.
   fadvise: possibly called by the fadvise64() system call.
 
 Note that the file operations are implemented by the specific
-filesystem in which the inode resides. When opening a device node
+filesystem in which the inode resides.  When opening a device node
 (character or block special) most filesystems will call special
 support routines in the VFS which will locate the required device
-driver information. These support routines replace the filesystem file
+driver information.  These support routines replace the filesystem file
 operations with those for the device driver, and then proceed to call
-the new open() method for the file. This is how opening a device file
+the new open() method for the file.  This is how opening a device file
 in the filesystem eventually ends up calling the device driver open()
 method.
 
@@ -998,10 +998,10 @@ struct dentry_operations
 ------------------------
 
 This describes how a filesystem can overload the standard dentry
-operations. Dentries and the dcache are the domain of the VFS and the
-individual filesystem implementations. Device drivers have no business
-here. These methods may be set to NULL, as they are either optional or
-the VFS uses a default. As of kernel 2.6.22, the following members are
+operations.  Dentries and the dcache are the domain of the VFS and the
+individual filesystem implementations.  Device drivers have no business
+here.  These methods may be set to NULL, as they are either optional or
+the VFS uses a default.  As of kernel 2.6.22, the following members are
 defined:
 
 struct dentry_operations {
@@ -1020,10 +1020,10 @@ struct dentry_operations {
 	struct dentry *(*d_real)(struct dentry *, const struct inode *);
 };
 
-  d_revalidate: called when the VFS needs to revalidate a dentry. This
+  d_revalidate: called when the VFS needs to revalidate a dentry.  This
 	is called whenever a name look-up finds a dentry in the
-	dcache. Most local filesystems leave this as NULL, because all their
-	dentries in the dcache are valid. Network filesystems are different
+	dcache.  Most local filesystems leave this as NULL, because all their
+	dentries in the dcache are valid.  Network filesystems are different
 	since things can change on the server without the client necessarily
 	being aware of it.
 
@@ -1041,11 +1041,11 @@ struct dentry_operations {
 
  d_weak_revalidate: called when the VFS needs to revalidate a "jumped" dentry.
 	This is called when a path-walk ends at dentry that was not acquired by
-	doing a lookup in the parent directory. This includes "/", "." and "..",
+	doing a lookup in the parent directory.  This includes "/", "." and "..",
 	as well as procfs-style symlinks and mountpoint traversal.
 
 	In this case, we are less concerned with whether the dentry is still
-	fully correct, but rather that the inode is still valid. As with
+	fully correct, but rather that the inode is still valid.  As with
 	d_revalidate, most local filesystems will set this to NULL since their
 	dcache entries are always valid.
 
@@ -1053,17 +1053,17 @@ struct dentry_operations {
 
 	d_weak_revalidate is only called after leaving rcu-walk mode.
 
-  d_hash: called when the VFS adds a dentry to the hash table. The first
+  d_hash: called when the VFS adds a dentry to the hash table.  The first
 	dentry passed to d_hash is the parent directory that the name is
 	to be hashed into.
 
 	Same locking and synchronisation rules as d_compare regarding
 	what is safe to dereference etc.
 
-  d_compare: called to compare a dentry name with a given name. The first
+  d_compare: called to compare a dentry name with a given name.  The first
 	dentry is the parent of the dentry to be compared, the second is
-	the child dentry. len and name string are properties of the dentry
-	to be compared. qstr is the name to compare it with.
+	the child dentry.  len and name string are properties of the dentry
+	to be compared.  qstr is the name to compare it with.
 
 	Must be constant and idempotent, and should not take locks if
 	possible, and should not or store into the dentry.
@@ -1078,9 +1078,9 @@ struct dentry_operations {
 	"rcu-walk", ie. without any locks or references on things.
 
   d_delete: called when the last reference to a dentry is dropped and the
-	dcache is deciding whether or not to cache it. Return 1 to delete
-	immediately, or 0 to cache the dentry. Default is NULL which means to
-	always cache a reachable dentry. d_delete must be constant and
+	dcache is deciding whether or not to cache it.  Return 1 to delete
+	immediately, or 0 to cache the dentry.  Default is NULL which means to
+	always cache a reachable dentry.  d_delete must be constant and
 	idempotent.
 
   d_init: called when a dentry is allocated
@@ -1088,19 +1088,19 @@ struct dentry_operations {
   d_release: called when a dentry is really deallocated
 
   d_iput: called when a dentry loses its inode (just prior to its
-	being deallocated). The default when this is NULL is that the
-	VFS calls iput(). If you define this method, you must call
+	being deallocated).  The default when this is NULL is that the
+	VFS calls iput().  If you define this method, you must call
 	iput() yourself
 
   d_dname: called when the pathname of a dentry should be generated.
 	Useful for some pseudo filesystems (sockfs, pipefs, ...) to delay
-	pathname generation. (Instead of doing it when dentry is created,
-	it's done only when the path is needed.). Real filesystems probably
+	pathname generation.  (Instead of doing it when dentry is created,
+	it's done only when the path is needed.).  Real filesystems probably
 	dont want to use it, because their dentries are present in global
-	dcache hash, so their hash should be an invariant. As no lock is
+	dcache hash, so their hash should be an invariant.  As no lock is
 	held, d_dname() should not try to modify the dentry itself, unless
-	appropriate SMP safety is used. CAUTION : d_path() logic is quite
-	tricky. The correct way to return for example "Hello" is to put it
+	appropriate SMP safety is used.  CAUTION : d_path() logic is quite
+	tricky.  The correct way to return for example "Hello" is to put it
 	at the end of the buffer, and returns a pointer to the first char.
 	dynamic_dname() helper function is provided to take care of this.
 
@@ -1162,7 +1162,7 @@ struct dentry_operations {
 	With NULL inode the topmost real underlying dentry is returned.
 
 Each dentry has a pointer to its parent dentry, as well as a hash list
-of child dentries. Child dentries are basically like files in a
+of child dentries.  Child dentries are basically like files in a
 directory.
 
 
@@ -1175,36 +1175,36 @@ manipulate dentries:
   dget: open a new handle for an existing dentry (this just increments
 	the usage count)
 
-  dput: close a handle for a dentry (decrements the usage count). If
+  dput: close a handle for a dentry (decrements the usage count).  If
 	the usage count drops to 0, and the dentry is still in its
 	parent's hash, the "d_delete" method is called to check whether
-	it should be cached. If it should not be cached, or if the dentry
-	is not hashed, it is deleted. Otherwise cached dentries are put
+	it should be cached.  If it should not be cached, or if the dentry
+	is not hashed, it is deleted.  Otherwise cached dentries are put
 	into an LRU list to be reclaimed on memory shortage.
 
-  d_drop: this unhashes a dentry from its parents hash list. A
+  d_drop: this unhashes a dentry from its parents hash list.  A
 	subsequent call to dput() will deallocate the dentry if its
 	usage count drops to 0
 
-  d_delete: delete a dentry. If there are no other open references to
+  d_delete: delete a dentry.  If there are no other open references to
 	the dentry then the dentry is turned into a negative dentry
-	(the d_iput() method is called). If there are other
+	(the d_iput() method is called).  If there are other
 	references, then d_drop() is called instead
 
   d_add: add a dentry to its parents hash list and then calls
 	d_instantiate()
 
   d_instantiate: add a dentry to the alias hash list for the inode and
-	updates the "d_inode" member. The "i_count" member in the
-	inode structure should be set/incremented. If the inode
+	updates the "d_inode" member.  The "i_count" member in the
+	inode structure should be set/incremented.  If the inode
 	pointer is NULL, the dentry is called a "negative
-	dentry". This function is commonly called when an inode is
+	dentry".  This function is commonly called when an inode is
 	created for an existing negative dentry
 
   d_lookup: look up a dentry given its parent and path name component
 	It looks up the child of that given name from the dcache
-	hash table. If it is found, the reference count is incremented
-	and the dentry is returned. The caller must use dput()
+	hash table.  If it is found, the reference count is incremented
+	and the dentry is returned.  The caller must use dput()
 	to free the dentry when it finishes using it.
 
 Mount Options
-- 
2.21.0

