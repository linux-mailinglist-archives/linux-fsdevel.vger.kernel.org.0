Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA441E64A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 02:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEOAaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 20:30:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58035 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfEOAaI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2704D25948;
        Tue, 14 May 2019 20:30:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 14 May 2019 20:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=tW0q9IQpvRjf2lFt9FhXqPU4hPqJ6KhlCo7abxwmD6c=; b=oU+fp2D6
        Q1xBQSSN+/9joM/YJOoPAbr6jM9cuKdoqpoYbjsoUWU+nHy4YO0gPaXlSdHSWKi1
        fZXOGg5TMLd6ebpvCr5fyJh7J+RV/7pF9NWah46m6R/npHWkfKWuLK0ZR8I2xqUg
        9RElKgQxS+Z22P4eDAYT/uwBs/hropxldrme84VVE9KYEVQw1DoZ0uaML1J5Zu88
        xd71fNkOl+rEJV6x/CTwGZFzxFePOQNFCOhjxc8u5bS5LlWViOELRR3VO6GzolXb
        h79Zc76lU7Yk8AvvtYrHLRcke000TL1/GSqIL2gF4kfJi3zAz2GGUTLN7DuEZJFo
        eJQ7iVcxVO9ACw==
X-ME-Sender: <xms:jl3bXDFipuuxx7zSXyVzWpVbv-7dE3pscOMpZOYRK8ztQyS5fYqwFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvvdefrddvuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:jl3bXMCk3uGV3COEwveKcCzbxxFnik8Dz6CuQGJn08LyYZxni-3waQ>
    <xmx:jl3bXP3-GDEv5qLolb1W-DmsXktsZurnMf7ZG6sPMoppNvsjFbdevw>
    <xmx:jl3bXCAnIqJf1Kj1oMn7SoB5ve9FpHMNk6iDqBFVbRtceBTf3NJdag>
    <xmx:j13bXMMW2atEc5TovIuAXwQhAyluJkjhchK5xmRYGwU6SWOCYQ7AUg>
Received: from eros.localdomain (ppp121-44-223-211.bras1.syd2.internode.on.net [121.44.223.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 49CC210379;
        Tue, 14 May 2019 20:30:03 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/9] docs: filesystems: vfs: Remove space before tab
Date:   Wed, 15 May 2019 10:29:05 +1000
Message-Id: <20190515002913.12586-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515002913.12586-1-tobin@kernel.org>
References: <20190515002913.12586-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the file has a bunch of spaces before tabspaces.  This is a
nuisance when patching the file because they show up whenever we touch
these lines.  Let's just fix them all now in preparation for doing the
RST conversion.

Remove spaces before tabspaces.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/vfs.txt | 78 +++++++++++++++----------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 761c6fd24a53..637fd1756b89 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -136,7 +136,7 @@ struct file_system_type {
 	should be shut down
 
   owner: for internal VFS use: you should initialize this to THIS_MODULE in
-  	most cases.
+	most cases.
 
   next: for internal VFS use: you should initialize this to NULL
 
@@ -145,7 +145,7 @@ struct file_system_type {
 The mount() method has the following arguments:
 
   struct file_system_type *fs_type: describes the filesystem, partly initialized
-  	by the specific filesystem code
+	by the specific filesystem code
 
   int flags: mount flags
 
@@ -182,12 +182,12 @@ and provides a fill_super() callback instead. The generic variants are:
   mount_nodev: mount a filesystem that is not backed by a device
 
   mount_single: mount a filesystem which shares the instance between
-  	all mounts
+	all mounts
 
 A fill_super() callback implementation has the following arguments:
 
   struct super_block *sb: the superblock structure. The callback
-  	must initialize this properly.
+	must initialize this properly.
 
   void *data: arbitrary mount options, usually comes as an ASCII
 	string (see "Mount Options" section)
@@ -238,14 +238,14 @@ only called from a process context (i.e. not from an interrupt handler
 or bottom half).
 
   alloc_inode: this method is called by alloc_inode() to allocate memory
- 	for struct inode and initialize it.  If this function is not
- 	defined, a simple 'struct inode' is allocated.  Normally
- 	alloc_inode will be used to allocate a larger structure which
- 	contains a 'struct inode' embedded within it.
+	for struct inode and initialize it.  If this function is not
+	defined, a simple 'struct inode' is allocated.  Normally
+	alloc_inode will be used to allocate a larger structure which
+	contains a 'struct inode' embedded within it.
 
   destroy_inode: this method is called by destroy_inode() to release
-  	resources allocated for struct inode.  It is only required if
-  	->alloc_inode was defined and simply undoes anything done by
+	resources allocated for struct inode.  It is only required if
+	->alloc_inode was defined and simply undoes anything done by
 	->alloc_inode.
 
   dirty_inode: this method is called by the VFS to mark an inode dirty.
@@ -273,15 +273,15 @@ or bottom half).
 	(i.e. unmount). This is called with the superblock lock held
 
   sync_fs: called when VFS is writing out all dirty data associated with
-  	a superblock. The second parameter indicates whether the method
+	a superblock. The second parameter indicates whether the method
 	should wait until the write out has been completed. Optional.
 
   freeze_fs: called when VFS is locking a filesystem and
-  	forcing it into a consistent state.  This method is currently
-  	used by the Logical Volume Manager (LVM).
+	forcing it into a consistent state.  This method is currently
+	used by the Logical Volume Manager (LVM).
 
   unfreeze_fs: called when VFS is unlocking a filesystem and making it writable
-  	again.
+	again.
 
   statfs: called when the VFS needs to get filesystem statistics.
 
@@ -472,30 +472,30 @@ otherwise noted.
 	that.
 
   permission: called by the VFS to check for access rights on a POSIX-like
-  	filesystem.
+	filesystem.
 
 	May be called in rcu-walk mode (mask & MAY_NOT_BLOCK). If in rcu-walk
-        mode, the filesystem must check the permission without blocking or
+	mode, the filesystem must check the permission without blocking or
 	storing to the inode.
 
 	If a situation is encountered that rcu-walk cannot handle, return
 	-ECHILD and it will be called again in ref-walk mode.
 
   setattr: called by the VFS to set attributes for a file. This method
-  	is called by chmod(2) and related system calls.
+	is called by chmod(2) and related system calls.
 
   getattr: called by the VFS to get attributes of a file. This method
-  	is called by stat(2) and related system calls.
+	is called by stat(2) and related system calls.
 
   listxattr: called by the VFS to list all extended attributes for a
 	given file. This method is called by the listxattr(2) system call.
 
   update_time: called by the VFS to update a specific time or the i_version of
-  	an inode.  If this is not defined the VFS will update the inode itself
-  	and call mark_inode_dirty_sync.
+	an inode.  If this is not defined the VFS will update the inode itself
+	and call mark_inode_dirty_sync.
 
   atomic_open: called on the last component of an open.  Using this optional
-  	method the filesystem can look up, possibly create and open the file in
+	method the filesystem can look up, possibly create and open the file in
 	one atomic operation.  If it wants to leave actual opening to the
 	caller (e.g. if the file turned out to be a symlink, device, or just
 	something filesystem won't do atomic open for), it may signal this by
@@ -683,13 +683,13 @@ struct address_space_operations {
        that all succeeds, ->readpage will be called again.
 
   writepages: called by the VM to write out pages associated with the
-  	address_space object.  If wbc->sync_mode is WBC_SYNC_ALL, then
-  	the writeback_control will specify a range of pages that must be
-  	written out.  If it is WBC_SYNC_NONE, then a nr_to_write is given
+	address_space object.  If wbc->sync_mode is WBC_SYNC_ALL, then
+	the writeback_control will specify a range of pages that must be
+	written out.  If it is WBC_SYNC_NONE, then a nr_to_write is given
 	and that many pages should be written if possible.
 	If no ->writepages is given, then mpage_writepages is used
-  	instead.  This will choose pages from the address space that are
-  	tagged as DIRTY and will pass them to ->writepage.
+	instead.  This will choose pages from the address space that are
+	tagged as DIRTY and will pass them to ->writepage.
 
   set_page_dirty: called by the VM to set a page dirty.
         This is particularly needed if an address space attaches
@@ -700,11 +700,11 @@ struct address_space_operations {
         PAGECACHE_TAG_DIRTY tag in the radix tree.
 
   readpages: called by the VM to read pages associated with the address_space
-  	object. This is essentially just a vector version of
-  	readpage.  Instead of just one page, several pages are
-  	requested.
+	object. This is essentially just a vector version of
+	readpage.  Instead of just one page, several pages are
+	requested.
 	readpages is only used for read-ahead, so read errors are
-  	ignored.  If anything goes wrong, feel free to give up.
+	ignored.  If anything goes wrong, feel free to give up.
 
   write_begin:
 	Called by the generic buffered write code to ask the filesystem to
@@ -741,12 +741,12 @@ struct address_space_operations {
         that were able to be copied into pagecache.
 
   bmap: called by the VFS to map a logical block offset within object to
-  	physical block number. This method is used by the FIBMAP
-  	ioctl and for working with swap-files.  To be able to swap to
-  	a file, the file must have a stable mapping to a block
-  	device.  The swap system does not go through the filesystem
-  	but instead uses bmap to find out where the blocks in the file
-  	are and uses those addresses directly.
+	physical block number. This method is used by the FIBMAP
+	ioctl and for working with swap-files.  To be able to swap to
+	a file, the file must have a stable mapping to a block
+	device.  The swap system does not go through the filesystem
+	but instead uses bmap to find out where the blocks in the file
+	are and uses those addresses directly.
 
   invalidatepage: If a page has PagePrivate set, then invalidatepage
         will be called when part or all of the page is to be removed
@@ -806,7 +806,7 @@ struct address_space_operations {
   putback_page: Called by the VM when isolated page's migration fails.
 
   launder_page: Called before freeing a page - it writes back the dirty page. To
-  	prevent redirtying the page, it is kept locked during the whole
+	prevent redirtying the page, it is kept locked during the whole
 	operation.
 
   is_partially_uptodate: Called by the VM when reading a file through the
@@ -917,7 +917,7 @@ otherwise noted.
   unlocked_ioctl: called by the ioctl(2) system call.
 
   compat_ioctl: called by the ioctl(2) system call when 32 bit system calls
- 	 are used on 64 bit kernels.
+	 are used on 64 bit kernels.
 
   mmap: called by the mmap(2) system call
 
@@ -942,7 +942,7 @@ otherwise noted.
 	(non-blocking) mode is enabled for a file
 
   lock: called by the fcntl(2) system call for F_GETLK, F_SETLK, and F_SETLKW
-  	commands
+	commands
 
   get_unmapped_area: called by the mmap(2) system call
 
-- 
2.21.0

