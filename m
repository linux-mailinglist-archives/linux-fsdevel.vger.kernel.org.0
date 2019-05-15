Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D72DE1E634
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 02:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfEOAah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 20:30:37 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54371 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbfEOAag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E3E6A258FD;
        Tue, 14 May 2019 20:30:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 14 May 2019 20:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=oy9fP+do3vyKvofGVAe7dSTiTfxgdcAP/usds/7nvVs=; b=JP+QaqoT
        NLF23ti+RRI/F/R5dfk9jyHYBzgmHBq0OqhzlQQFatkTX3V4WTfhX/r2Aske77+R
        /+dZPMCbSRmPT5NCDw2v6RM01IPBOWxUSKmlnHOniAmRhf33u3ncC2UTn10z3wYR
        2PNV4gbj+/7PheLMynou84yp2EmjdpDozbqHnNIHDAJclxBFsyiGvlGb331emtRR
        5ZEjrRBKBkF28wmKad+tAxLr0qg1bmaWTUx1hQg/aNdHtOYPnE26ovH0C9mFfsRj
        kB8PLooA12aSlEuclcNlMODJF2A49vjV2E/WSOfj48k3P9D7UbhL2a647DjUNiyl
        GY1DO5aOsDTw/w==
X-ME-Sender: <xms:ql3bXExuXOe6jrc3KO387uv9XaRasu3GEPVHbVLCtCu_QJ0B-805aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvvdefrddvuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeej
X-ME-Proxy: <xmx:ql3bXCBKk3aevk3KdCA7hgq6DoDhtOIMHFSAEiMax3b6tKy9J15rUg>
    <xmx:ql3bXC3QsN4536DgLs_GV0iyt_B8RGbWyd-D0UXHCa7PYK68ZWuLpw>
    <xmx:ql3bXGUmb7cU9is45GuEhVkf7kER8mTF6qTi5nT1TJzXN_3jJeQ9aw>
    <xmx:ql3bXBtswOyVC_2S7Y8smCkXFhlk8b0zMynax8eduOZZj71Pp3wjgA>
Received: from eros.localdomain (ppp121-44-223-211.bras1.syd2.internode.on.net [121.44.223.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 186F010378;
        Tue, 14 May 2019 20:30:30 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] docs: filesystems: vfs: Convert spaces to tabs
Date:   Wed, 15 May 2019 10:29:12 +1000
Message-Id: <20190515002913.12586-9-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515002913.12586-1-tobin@kernel.org>
References: <20190515002913.12586-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are bunch of places with 8 spaces, in preparation for correctly
indenting all code snippets (during conversion to RST) change these to
use tabspaces.

This patch is whitespace only.

Convert instances of 8 consecutive spaces to a single tabspace.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/vfs.txt | 124 +++++++++++++++---------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 43b18bafbc20..489bbdc6a40f 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -113,12 +113,12 @@ members are defined:
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-        struct dentry *(*mount) (struct file_system_type *, int,
-                       const char *, void *);
-        void (*kill_sb) (struct super_block *);
-        struct module *owner;
-        struct file_system_type * next;
-        struct list_head fs_supers;
+	struct dentry *(*mount) (struct file_system_type *, int,
+		       const char *, void *);
+	void (*kill_sb) (struct super_block *);
+	struct module *owner;
+	struct file_system_type * next;
+	struct list_head fs_supers;
 	struct lock_class_key s_lock_key;
 	struct lock_class_key s_umount_key;
 };
@@ -207,26 +207,26 @@ This describes how the VFS can manipulate the superblock of your
 filesystem.  As of kernel 2.6.22, the following members are defined:
 
 struct super_operations {
-        struct inode *(*alloc_inode)(struct super_block *sb);
-        void (*destroy_inode)(struct inode *);
-
-        void (*dirty_inode) (struct inode *, int flags);
-        int (*write_inode) (struct inode *, int);
-        void (*drop_inode) (struct inode *);
-        void (*delete_inode) (struct inode *);
-        void (*put_super) (struct super_block *);
-        int (*sync_fs)(struct super_block *sb, int wait);
-        int (*freeze_fs) (struct super_block *);
-        int (*unfreeze_fs) (struct super_block *);
-        int (*statfs) (struct dentry *, struct kstatfs *);
-        int (*remount_fs) (struct super_block *, int *, char *);
-        void (*clear_inode) (struct inode *);
-        void (*umount_begin) (struct super_block *);
-
-        int (*show_options)(struct seq_file *, struct dentry *);
-
-        ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
-        ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
+	struct inode *(*alloc_inode)(struct super_block *sb);
+	void (*destroy_inode)(struct inode *);
+
+	void (*dirty_inode) (struct inode *, int flags);
+	int (*write_inode) (struct inode *, int);
+	void (*drop_inode) (struct inode *);
+	void (*delete_inode) (struct inode *);
+	void (*put_super) (struct super_block *);
+	int (*sync_fs)(struct super_block *sb, int wait);
+	int (*freeze_fs) (struct super_block *);
+	int (*unfreeze_fs) (struct super_block *);
+	int (*statfs) (struct dentry *, struct kstatfs *);
+	int (*remount_fs) (struct super_block *, int *, char *);
+	void (*clear_inode) (struct inode *);
+	void (*umount_begin) (struct super_block *);
+
+	int (*show_options)(struct seq_file *, struct dentry *);
+
+	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
+	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
 	int (*nr_cached_objects)(struct super_block *);
 	void (*free_cached_objects)(struct super_block *, int);
 };
@@ -475,7 +475,7 @@ otherwise noted.
 	filesystem.
 
 	May be called in rcu-walk mode (mask & MAY_NOT_BLOCK).  If in rcu-walk
-        mode, the filesystem must check the permission without blocking or
+	mode, the filesystem must check the permission without blocking or
 	storing to the inode.
 
 	If a situation is encountered that rcu-walk cannot handle, return
@@ -694,12 +694,12 @@ struct address_space_operations {
 	tagged as DIRTY and will pass them to ->writepage.
 
   set_page_dirty: called by the VM to set a page dirty.
-        This is particularly needed if an address space attaches
-        private data to a page, and that data needs to be updated when
-        a page is dirtied.  This is called, for example, when a memory
+	This is particularly needed if an address space attaches
+	private data to a page, and that data needs to be updated when
+	a page is dirtied.  This is called, for example, when a memory
 	mapped page gets modified.
 	If defined, it should set the PageDirty flag, and the
-        PAGECACHE_TAG_DIRTY tag in the radix tree.
+	PAGECACHE_TAG_DIRTY tag in the radix tree.
 
   readpages: called by the VM to read pages associated with the address_space
 	object.  This is essentially just a vector version of
@@ -717,7 +717,7 @@ struct address_space_operations {
 	storage, then those blocks should be pre-read (if they haven't been
 	read already) so that the updated blocks can be written out properly.
 
-        The filesystem must return the locked pagecache page for the specified
+	The filesystem must return the locked pagecache page for the specified
 	offset, in *pagep, for the caller to write into.
 
 	It must be able to cope with short writes (where the length passed to
@@ -726,21 +726,21 @@ struct address_space_operations {
 	flags is a field for AOP_FLAG_xxx flags, described in
 	include/linux/fs.h.
 
-        A void * may be returned in fsdata, which then gets passed into
-        write_end.
+	A void * may be returned in fsdata, which then gets passed into
+	write_end.
 
-        Returns 0 on success; < 0 on failure (which is the error code), in
+	Returns 0 on success; < 0 on failure (which is the error code), in
 	which case write_end is not called.
 
   write_end: After a successful write_begin, and data copy, write_end must
-        be called.  len is the original len passed to write_begin, and copied
-        is the amount that was able to be copied.
+	be called.  len is the original len passed to write_begin, and copied
+	is the amount that was able to be copied.
 
-        The filesystem must take care of unlocking the page and releasing it
-        refcount, and updating i_size.
+	The filesystem must take care of unlocking the page and releasing it
+	refcount, and updating i_size.
 
-        Returns < 0 on failure, otherwise the number of bytes (<= 'copied')
-        that were able to be copied into pagecache.
+	Returns < 0 on failure, otherwise the number of bytes (<= 'copied')
+	that were able to be copied into pagecache.
 
   bmap: called by the VFS to map a logical block offset within object to
 	physical block number.  This method is used by the FIBMAP
@@ -751,7 +751,7 @@ struct address_space_operations {
 	are and uses those addresses directly.
 
   invalidatepage: If a page has PagePrivate set, then invalidatepage
-        will be called when part or all of the page is to be removed
+	will be called when part or all of the page is to be removed
 	from the address space.  This generally corresponds to either a
 	truncation, punch hole  or a complete invalidation of the address
 	space (in the latter case 'offset' will always be 0 and 'length'
@@ -763,47 +763,47 @@ struct address_space_operations {
 	release MUST succeed.
 
   releasepage: releasepage is called on PagePrivate pages to indicate
-        that the page should be freed if possible.  ->releasepage
-        should remove any private data from the page and clear the
-        PagePrivate flag.  If releasepage() fails for some reason, it must
+	that the page should be freed if possible.  ->releasepage
+	should remove any private data from the page and clear the
+	PagePrivate flag.  If releasepage() fails for some reason, it must
 	indicate failure with a 0 return value.
 	releasepage() is used in two distinct though related cases.  The
 	first is when the VM finds a clean page with no active users and
-        wants to make it a free page.  If ->releasepage succeeds, the
-        page will be removed from the address_space and become free.
+	wants to make it a free page.  If ->releasepage succeeds, the
+	page will be removed from the address_space and become free.
 
 	The second case is when a request has been made to invalidate
-        some or all pages in an address_space.  This can happen
-        through the fadvise(POSIX_FADV_DONTNEED) system call or by the
-        filesystem explicitly requesting it as nfs and 9fs do (when
-        they believe the cache may be out of date with storage) by
-        calling invalidate_inode_pages2().
+	some or all pages in an address_space.  This can happen
+	through the fadvise(POSIX_FADV_DONTNEED) system call or by the
+	filesystem explicitly requesting it as nfs and 9fs do (when
+	they believe the cache may be out of date with storage) by
+	calling invalidate_inode_pages2().
 	If the filesystem makes such a call, and needs to be certain
-        that all pages are invalidated, then its releasepage will
-        need to ensure this.  Possibly it can clear the PageUptodate
-        bit if it cannot free private data yet.
+	that all pages are invalidated, then its releasepage will
+	need to ensure this.  Possibly it can clear the PageUptodate
+	bit if it cannot free private data yet.
 
   freepage: freepage is called once the page is no longer visible in
-        the page cache in order to allow the cleanup of any private
+	the page cache in order to allow the cleanup of any private
 	data.  Since it may be called by the memory reclaimer, it
 	should not assume that the original address_space mapping still
 	exists, and it should not block.
 
   direct_IO: called by the generic read/write routines to perform
-        direct_IO - that is IO requests which bypass the page cache
-        and transfer data directly between the storage and the
-        application's address space.
+	direct_IO - that is IO requests which bypass the page cache
+	and transfer data directly between the storage and the
+	application's address space.
 
   isolate_page: Called by the VM when isolating a movable non-lru page.
 	If page is successfully isolated, VM marks the page as PG_isolated
 	via __SetPageIsolated.
 
   migrate_page:  This is used to compact the physical memory usage.
-        If the VM wants to relocate a page (maybe off a memory card
-        that is signalling imminent failure) it will pass a new page
+	If the VM wants to relocate a page (maybe off a memory card
+	that is signalling imminent failure) it will pass a new page
 	and an old page to this function.  migrate_page should
 	transfer any private data across and update any references
-        that it has to the page.
+	that it has to the page.
 
   putback_page: Called by the VM when isolated page's migration fails.
 
-- 
2.21.0

