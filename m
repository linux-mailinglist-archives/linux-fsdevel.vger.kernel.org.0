Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE7B41E64C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 02:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfEOAaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 20:30:17 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41525 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbfEOAaR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:17 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C34E42585D;
        Tue, 14 May 2019 20:30:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 14 May 2019 20:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ft30YEm/1ED9WZU5mIGyiCiD4ZZj1saa3y6Klrsj9rk=; b=kH9/WZY7
        o8qQ8GhPewNvhphVYp0oJXYpHDT0dldlnNnYOwBH9rodPxSdnRqetl3gHJFyAVwS
        KVxDVuFjJx/nrpNBPys4mt3icp/y2XMpuMe57REVLWPlrKwTycXECXlmbLu7w+NT
        SByl7vDORlrlleM4Hnr20WIiNG4e2TXLKzI4XChM2iPWoCYln3+cs4FO7l58xTCf
        BgJ+kdDCix8gl2a9FCizvAUtbCSK3Exveiz/fLmdo3XihkJwpxnMsX/o40UJX9/j
        +gg0If9PofSLRBQGdthbAVMs16wBCWcc8cAblZE8a28XwgMz2lV6DxQyqv7U89lE
        Mf9pgO4GMQuSHg==
X-ME-Sender: <xms:ll3bXALvefi_hlKoQAKd_yFT4_5DzWb-9DhFmKj_RJI4n5tvEBveQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvvdefrddvuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:ll3bXEaFowvoMWTlI7JI6AKJTyB9cbpu93k51zg_tffsahvVAWw2gQ>
    <xmx:ll3bXLuPjzATBC4BCeZyOZA3N3NGaUSNE7hRdH7InQRgwz9LAUjNeg>
    <xmx:ll3bXBs-pWFAQHnmuql9w-csoO1R_Mkxr7q6_QPFDixCFoqrq7MWAw>
    <xmx:ll3bXBZ0rF3XC9eZHzLSGBjvhZQATRiVh2AHqn-qX0fd0PkzW5SqnA>
Received: from eros.localdomain (ppp121-44-223-211.bras1.syd2.internode.on.net [121.44.223.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2BDCB10378;
        Tue, 14 May 2019 20:30:10 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/9] docs: filesystems: vfs: Use 72 character column width
Date:   Wed, 15 May 2019 10:29:07 +1000
Message-Id: <20190515002913.12586-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515002913.12586-1-tobin@kernel.org>
References: <20190515002913.12586-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for conversion to RST format use the kernels favoured
documentation column width.  If we are going to do this we might as well
do it thoroughly.  Just do the paragraphs (not the indented stuff), the
rest will be done during indentation fix up patch.

This patch is whitespace only, no textual changes.

Use 72 character column width for all paragraph sections.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/vfs.txt | 198 +++++++++++++++---------------
 1 file changed, 97 insertions(+), 101 deletions(-)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 2a610b9355e0..14839bc84d38 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -14,15 +14,14 @@
 Introduction
 ============
 
-The Virtual File System (also known as the Virtual Filesystem Switch)
-is the software layer in the kernel that provides the filesystem
-interface to userspace programs.  It also provides an abstraction
-within the kernel which allows different filesystem implementations to
-coexist.
+The Virtual File System (also known as the Virtual Filesystem Switch) is
+the software layer in the kernel that provides the filesystem interface
+to userspace programs.  It also provides an abstraction within the
+kernel which allows different filesystem implementations to coexist.
 
-VFS system calls open(2), stat(2), read(2), write(2), chmod(2) and so
-on are called from a process context.  Filesystem locking is described
-in the document Documentation/filesystems/Locking.
+VFS system calls open(2), stat(2), read(2), write(2), chmod(2) and so on
+are called from a process context.  Filesystem locking is described in
+the document Documentation/filesystems/Locking.
 
 
 Directory Entry Cache (dcache)
@@ -36,11 +35,10 @@ translate a pathname (filename) into a specific dentry.  Dentries live
 in RAM and are never saved to disc: they exist only for performance.
 
 The dentry cache is meant to be a view into your entire filespace.  As
-most computers cannot fit all dentries in the RAM at the same time,
-some bits of the cache are missing.  In order to resolve your pathname
-into a dentry, the VFS may have to resort to creating dentries along
-the way, and then loading the inode.  This is done by looking up the
-inode.
+most computers cannot fit all dentries in the RAM at the same time, some
+bits of the cache are missing.  In order to resolve your pathname into a
+dentry, the VFS may have to resort to creating dentries along the way,
+and then loading the inode.  This is done by looking up the inode.
 
 
 The Inode Object
@@ -48,33 +46,32 @@ The Inode Object
 
 An individual dentry usually has a pointer to an inode.  Inodes are
 filesystem objects such as regular files, directories, FIFOs and other
-beasts.  They live either on the disc (for block device filesystems)
-or in the memory (for pseudo filesystems).  Inodes that live on the
-disc are copied into the memory when required and changes to the inode
-are written back to disc.  A single inode can be pointed to by multiple
+beasts.  They live either on the disc (for block device filesystems) or
+in the memory (for pseudo filesystems).  Inodes that live on the disc
+are copied into the memory when required and changes to the inode are
+written back to disc.  A single inode can be pointed to by multiple
 dentries (hard links, for example, do this).
 
 To look up an inode requires that the VFS calls the lookup() method of
 the parent directory inode.  This method is installed by the specific
-filesystem implementation that the inode lives in.  Once the VFS has
-the required dentry (and hence the inode), we can do all those boring
-things like open(2) the file, or stat(2) it to peek at the inode
-data.  The stat(2) operation is fairly simple: once the VFS has the
-dentry, it peeks at the inode data and passes some of it back to
-userspace.
+filesystem implementation that the inode lives in.  Once the VFS has the
+required dentry (and hence the inode), we can do all those boring things
+like open(2) the file, or stat(2) it to peek at the inode data.  The
+stat(2) operation is fairly simple: once the VFS has the dentry, it
+peeks at the inode data and passes some of it back to userspace.
 
 
 The File Object
 ---------------
 
 Opening a file requires another operation: allocation of a file
-structure (this is the kernel-side implementation of file
-descriptors).  The freshly allocated file structure is initialized with
-a pointer to the dentry and a set of file operation member functions.
-These are taken from the inode data.  The open() file method is then
-called so the specific filesystem implementation can do its work.  You
-can see that this is another switch performed by the VFS.  The file
-structure is placed into the file descriptor table for the process.
+structure (this is the kernel-side implementation of file descriptors).
+The freshly allocated file structure is initialized with a pointer to
+the dentry and a set of file operation member functions.  These are
+taken from the inode data.  The open() file method is then called so the
+specific filesystem implementation can do its work.  You can see that
+this is another switch performed by the VFS.  The file structure is
+placed into the file descriptor table for the process.
 
 Reading, writing and closing files (and other assorted VFS operations)
 is done by using the userspace file descriptor to grab the appropriate
@@ -95,11 +92,12 @@ functions:
    extern int unregister_filesystem(struct file_system_type *);
 
 The passed struct file_system_type describes your filesystem.  When a
-request is made to mount a filesystem onto a directory in your namespace,
-the VFS will call the appropriate mount() method for the specific
-filesystem.  New vfsmount referring to the tree returned by ->mount()
-will be attached to the mountpoint, so that when pathname resolution
-reaches the mountpoint it will jump into the root of that vfsmount.
+request is made to mount a filesystem onto a directory in your
+namespace, the VFS will call the appropriate mount() method for the
+specific filesystem.  New vfsmount referring to the tree returned by
+->mount() will be attached to the mountpoint, so that when pathname
+resolution reaches the mountpoint it will jump into the root of that
+vfsmount.
 
 You can see all filesystems that are registered to the kernel in the
 file /proc/filesystems.
@@ -158,21 +156,21 @@ The mount() method must return the root dentry of the tree requested by
 caller.  An active reference to its superblock must be grabbed and the
 superblock must be locked.  On failure it should return ERR_PTR(error).
 
-The arguments match those of mount(2) and their interpretation
-depends on filesystem type.  E.g. for block filesystems, dev_name is
-interpreted as block device name, that device is opened and if it
-contains a suitable filesystem image the method creates and initializes
-struct super_block accordingly, returning its root dentry to caller.
+The arguments match those of mount(2) and their interpretation depends
+on filesystem type.  E.g. for block filesystems, dev_name is interpreted
+as block device name, that device is opened and if it contains a
+suitable filesystem image the method creates and initializes struct
+super_block accordingly, returning its root dentry to caller.
 
 ->mount() may choose to return a subtree of existing filesystem - it
 doesn't have to create a new one.  The main result from the caller's
-point of view is a reference to dentry at the root of (sub)tree to
-be attached; creation of new superblock is a common side effect.
+point of view is a reference to dentry at the root of (sub)tree to be
+attached; creation of new superblock is a common side effect.
 
-The most interesting member of the superblock structure that the
-mount() method fills in is the "s_op" field.  This is a pointer to
-a "struct super_operations" which describes the next level of the
-filesystem implementation.
+The most interesting member of the superblock structure that the mount()
+method fills in is the "s_op" field.  This is a pointer to a "struct
+super_operations" which describes the next level of the filesystem
+implementation.
 
 Usually, a filesystem uses one of the generic mount() implementations
 and provides a fill_super() callback instead.  The generic variants are:
@@ -319,16 +317,16 @@ or bottom half).
 	implementations will cause holdoff problems due to large scan batch
 	sizes.
 
-Whoever sets up the inode is responsible for filling in the "i_op" field.  This
-is a pointer to a "struct inode_operations" which describes the methods that
-can be performed on individual inodes.
+Whoever sets up the inode is responsible for filling in the "i_op"
+field.  This is a pointer to a "struct inode_operations" which describes
+the methods that can be performed on individual inodes.
 
 struct xattr_handlers
 ---------------------
 
 On filesystems that support extended attributes (xattrs), the s_xattr
-superblock field points to a NULL-terminated array of xattr handlers.  Extended
-attributes are name:value pairs.
+superblock field points to a NULL-terminated array of xattr handlers.
+Extended attributes are name:value pairs.
 
   name: Indicates that the handler matches attributes with the specified name
 	(such as "system.posix_acl_access"); the prefix field must be NULL.
@@ -348,9 +346,9 @@ attributes are name:value pairs.
 	attribute.  This method is called by the the setxattr(2) and
 	removexattr(2) system calls.
 
-When none of the xattr handlers of a filesystem match the specified attribute
-name or when a filesystem doesn't support extended attributes, the various
-*xattr(2) system calls return -EOPNOTSUPP.
+When none of the xattr handlers of a filesystem match the specified
+attribute name or when a filesystem doesn't support extended attributes,
+the various *xattr(2) system calls return -EOPNOTSUPP.
 
 
 The Inode Object
@@ -362,8 +360,8 @@ An inode object represents an object within the filesystem.
 struct inode_operations
 -----------------------
 
-This describes how the VFS can manipulate an inode in your
-filesystem.  As of kernel 2.6.22, the following members are defined:
+This describes how the VFS can manipulate an inode in your filesystem.
+As of kernel 2.6.22, the following members are defined:
 
 struct inode_operations {
 	int (*create) (struct inode *,struct dentry *, umode_t, bool);
@@ -513,42 +511,40 @@ The Address Space Object
 ========================
 
 The address space object is used to group and manage pages in the page
-cache.  It can be used to keep track of the pages in a file (or
-anything else) and also track the mapping of sections of the file into
-process address spaces.
+cache.  It can be used to keep track of the pages in a file (or anything
+else) and also track the mapping of sections of the file into process
+address spaces.
 
 There are a number of distinct yet related services that an
-address-space can provide.  These include communicating memory
-pressure, page lookup by address, and keeping track of pages tagged as
-Dirty or Writeback.
+address-space can provide.  These include communicating memory pressure,
+page lookup by address, and keeping track of pages tagged as Dirty or
+Writeback.
 
 The first can be used independently to the others.  The VM can try to
-either write dirty pages in order to clean them, or release clean
-pages in order to reuse them.  To do this it can call the ->writepage
-method on dirty pages, and ->releasepage on clean pages with
-PagePrivate set.  Clean pages without PagePrivate and with no external
-references will be released without notice being given to the
-address_space.
+either write dirty pages in order to clean them, or release clean pages
+in order to reuse them.  To do this it can call the ->writepage method
+on dirty pages, and ->releasepage on clean pages with PagePrivate set.
+Clean pages without PagePrivate and with no external references will be
+released without notice being given to the address_space.
 
 To achieve this functionality, pages need to be placed on an LRU with
-lru_cache_add and mark_page_active needs to be called whenever the
-page is used.
+lru_cache_add and mark_page_active needs to be called whenever the page
+is used.
 
 Pages are normally kept in a radix tree index by ->index.  This tree
-maintains information about the PG_Dirty and PG_Writeback status of
-each page, so that pages with either of these flags can be found
-quickly.
+maintains information about the PG_Dirty and PG_Writeback status of each
+page, so that pages with either of these flags can be found quickly.
 
 The Dirty tag is primarily used by mpage_writepages - the default
 ->writepages method.  It uses the tag to find dirty pages to call
 ->writepage on.  If mpage_writepages is not used (i.e. the address
-provides its own ->writepages) , the PAGECACHE_TAG_DIRTY tag is
-almost unused.  write_inode_now and sync_inode do use it (through
+provides its own ->writepages) , the PAGECACHE_TAG_DIRTY tag is almost
+unused.  write_inode_now and sync_inode do use it (through
 __sync_single_inode) to check if ->writepages has been successful in
 writing out the whole address_space.
 
-The Writeback tag is used by filemap*wait* and sync_page* functions,
-via filemap_fdatawait_range, to wait for all writeback to complete.
+The Writeback tag is used by filemap*wait* and sync_page* functions, via
+filemap_fdatawait_range, to wait for all writeback to complete.
 
 An address_space handler may attach extra information to a page,
 typically using the 'private' field in the 'struct page'.  If such
@@ -558,25 +554,24 @@ handler to deal with that data.
 
 An address space acts as an intermediate between storage and
 application.  Data is read into the address space a whole page at a
-time, and provided to the application either by copying of the page,
-or by memory-mapping the page.
-Data is written into the address space by the application, and then
-written-back to storage typically in whole pages, however the
-address_space has finer control of write sizes.
+time, and provided to the application either by copying of the page, or
+by memory-mapping the page.  Data is written into the address space by
+the application, and then written-back to storage typically in whole
+pages, however the address_space has finer control of write sizes.
 
 The read process essentially only requires 'readpage'.  The write
 process is more complicated and uses write_begin/write_end or
-set_page_dirty to write data into the address_space, and writepage
-and writepages to writeback data to storage.
+set_page_dirty to write data into the address_space, and writepage and
+writepages to writeback data to storage.
 
 Adding and removing pages to/from an address_space is protected by the
 inode's i_mutex.
 
 When data is written to a page, the PG_Dirty flag should be set.  It
 typically remains set until writepage asks for it to be written.  This
-should clear PG_Dirty and set PG_Writeback.  It can be actually
-written at any point after PG_Dirty is clear.  Once it is known to be
-safe, PG_Writeback is cleared.
+should clear PG_Dirty and set PG_Writeback.  It can be actually written
+at any point after PG_Dirty is clear.  Once it is known to be safe,
+PG_Writeback is cleared.
 
 Writeback makes use of a writeback_control structure to direct the
 operations.  This gives the the writepage and writepages operations some
@@ -605,9 +600,10 @@ file descriptors should get back an error is not possible.
 Instead, the generic writeback error tracking infrastructure in the
 kernel settles for reporting errors to fsync on all file descriptions
 that were open at the time that the error occurred.  In a situation with
-multiple writers, all of them will get back an error on a subsequent fsync,
-even if all of the writes done through that particular file descriptor
-succeeded (or even if there were no writes on that file descriptor at all).
+multiple writers, all of them will get back an error on a subsequent
+fsync, even if all of the writes done through that particular file
+descriptor succeeded (or even if there were no writes on that file
+descriptor at all).
 
 Filesystems that wish to use this infrastructure should call
 mapping_set_error to record the error in the address_space when it
@@ -619,8 +615,8 @@ point in the stream of errors emitted by the backing device(s).
 struct address_space_operations
 -------------------------------
 
-This describes how the VFS can manipulate mapping of a file to page cache in
-your filesystem.  The following members are defined:
+This describes how the VFS can manipulate mapping of a file to page
+cache in your filesystem.  The following members are defined:
 
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
@@ -1227,8 +1223,8 @@ filesystems.
 Showing options
 ---------------
 
-If a filesystem accepts mount options, it must define show_options()
-to show all the currently active options.  The rules are:
+If a filesystem accepts mount options, it must define show_options() to
+show all the currently active options.  The rules are:
 
   - options MUST be shown which are not default or their values differ
     from the default
@@ -1236,14 +1232,14 @@ to show all the currently active options.  The rules are:
   - options MAY be shown which are enabled by default or have their
     default value
 
-Options used only internally between a mount helper and the kernel
-(such as file descriptors), or which only have an effect during the
-mounting (such as ones controlling the creation of a journal) are exempt
-from the above rules.
+Options used only internally between a mount helper and the kernel (such
+as file descriptors), or which only have an effect during the mounting
+(such as ones controlling the creation of a journal) are exempt from the
+above rules.
 
-The underlying reason for the above rules is to make sure, that a
-mount can be accurately replicated (e.g. umounting and mounting again)
-based on the information found in /proc/mounts.
+The underlying reason for the above rules is to make sure, that a mount
+can be accurately replicated (e.g. umounting and mounting again) based
+on the information found in /proc/mounts.
 
 Resources
 =========
-- 
2.21.0

