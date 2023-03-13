Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317AD6B786D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 14:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCMNHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 09:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCMNHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:07:51 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C382C69CF1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 06:07:48 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 955CB40797
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 13:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678712867;
        bh=+IipxgmBDYy4vxMYF5Hn13gIjZvI55oWQHx5+D0L13A=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lVUNJqRkXzEei3fxnqD1Ulh4VK0arBr6OECR10xVFpXYPgd74Koho54RSk0OrgEXv
         s8d2QImJ1wXGWjjTm23pYKoweJpY9jriW3krm1VZnbtFeGYN8UGcjHK5Rn2CHsuTeY
         T8cSe2ZyuGtEAnjH+tAhncFXgx7sMK7siRXdtpsymrfNbvCJu3+MLwIc8K0DIju35L
         49WTP4PbQIoIl7japVr6TyKnpsEB1besVaP/8c5DOF9wL+hIXlOGdslMhGIAqNr4Ff
         RCIFvE3z+sKw6wgyat/RoiJgvNxEdT3hfHB+r0CmcdESNN/aSID0vRLrf2JqBhv6qr
         glfi2FGspx+WA==
Received: by mail-ed1-f71.google.com with SMTP id q13-20020a5085cd000000b004af50de0bcfso17113431edh.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 06:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IipxgmBDYy4vxMYF5Hn13gIjZvI55oWQHx5+D0L13A=;
        b=FsGBgrh2RNfvZ6sVD3Xx4VHNiW9ysOg7id7RfHURRrme8Rv76LEHOqyeKSqabe+qKZ
         0XklU+M/uy2xRskMFdouXK8ZGrdNPNWxqsDfUurbsnkjiXNmiB5n5geEGhXGxDnHuxLC
         OvvYLS8hC9paVy4aevWbAuBrQ8f+l3ZINXVcgYiJqY+0lCeAUZnt9Vq5xh3zfjEg2txg
         p1REL5Y04PZgjjjn+b0I1wJh2XMLq9gIjk2VKaAb156ji07eOIb8dYqvqmEbb686hoVZ
         mpfeXdti4QJIqzr0MA4QNaBn2I7+7DIacFqglZ+uX2js94wUoxYuoER2FOv4t6DsAlls
         6KyA==
X-Gm-Message-State: AO0yUKVAnA87yFVNn6AvMb02DnyKV0TzngrItdwLhBVV0262kpPMPtG+
        88wETZ7igcrOFpeHlrg4mdSr5Mz/jqeWzmA8ptryDqfY8yh+ar8OG/M08s0/U2lAShEaB3H/4Dp
        oeJOlJdr1HtjOqLcnPmrgbIxcoNskN4Tn425pK2T++5sg5yjhk7s=
X-Received: by 2002:aa7:d613:0:b0:4fd:21a6:a649 with SMTP id c19-20020aa7d613000000b004fd21a6a649mr1065201edr.40.1678712866964;
        Mon, 13 Mar 2023 06:07:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set/FrIJX8695pD2ACsMw0u++B3lhxVexezqxtZYcarREhLAPqkS3cnCLOBRDT6Is6zB2IytJ8g==
X-Received: by 2002:aa7:d613:0:b0:4fd:21a6:a649 with SMTP id c19-20020aa7d613000000b004fd21a6a649mr1065182edr.40.1678712866725;
        Mon, 13 Mar 2023 06:07:46 -0700 (PDT)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:c91d:59c1:64e:937b])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090637cb00b00926f89e2213sm1711388ejc.190.2023.03.13.06.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:07:46 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     corbet@lwn.net
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 2/2] docs: filesystems: vfs: actualize struct super_operations description
Date:   Mon, 13 Mar 2023 14:07:18 +0100
Message-Id: <20230313130718.253708-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313130718.253708-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230313130718.253708-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added/updated descriptions for super_operations:
- free_inode method
- evict_inode method
- freeze_super/thaw_super method
- show_{devname,path,stats} procfs-related methods
- get_dquots method

Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 Documentation/filesystems/vfs.rst | 74 ++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index f8905ff070d0..682148679b63 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -245,33 +245,42 @@ struct super_operations
 -----------------------
 
 This describes how the VFS can manipulate the superblock of your
-filesystem.  As of kernel 2.6.22, the following members are defined:
+filesystem.  The following members are defined:
 
 .. code-block:: c
 
 	struct super_operations {
 		struct inode *(*alloc_inode)(struct super_block *sb);
 		void (*destroy_inode)(struct inode *);
+		void (*free_inode)(struct inode *);
 
 		void (*dirty_inode) (struct inode *, int flags);
-		int (*write_inode) (struct inode *, int);
-		void (*drop_inode) (struct inode *);
-		void (*delete_inode) (struct inode *);
+		int (*write_inode) (struct inode *, struct writeback_control *wbc);
+		int (*drop_inode) (struct inode *);
+		void (*evict_inode) (struct inode *);
 		void (*put_super) (struct super_block *);
 		int (*sync_fs)(struct super_block *sb, int wait);
+		int (*freeze_super) (struct super_block *);
 		int (*freeze_fs) (struct super_block *);
+		int (*thaw_super) (struct super_block *);
 		int (*unfreeze_fs) (struct super_block *);
 		int (*statfs) (struct dentry *, struct kstatfs *);
 		int (*remount_fs) (struct super_block *, int *, char *);
-		void (*clear_inode) (struct inode *);
 		void (*umount_begin) (struct super_block *);
 
 		int (*show_options)(struct seq_file *, struct dentry *);
+		int (*show_devname)(struct seq_file *, struct dentry *);
+		int (*show_path)(struct seq_file *, struct dentry *);
+		int (*show_stats)(struct seq_file *, struct dentry *);
 
 		ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
 		ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
-		int (*nr_cached_objects)(struct super_block *);
-		void (*free_cached_objects)(struct super_block *, int);
+		struct dquot **(*get_dquots)(struct inode *);
+
+		long (*nr_cached_objects)(struct super_block *,
+					struct shrink_control *);
+		long (*free_cached_objects)(struct super_block *,
+					struct shrink_control *);
 	};
 
 All methods are called without any locks being held, unless otherwise
@@ -292,6 +301,11 @@ or bottom half).
 	->alloc_inode was defined and simply undoes anything done by
 	->alloc_inode.
 
+``free_inode``
+	this method is called from RCU callback. If you use call_rcu()
+	in ->destroy_inode to free 'struct inode' memory, then it's
+	better to release memory in this method.
+
 ``dirty_inode``
 	this method is called by the VFS when an inode is marked dirty.
 	This is specifically for the inode itself being marked dirty,
@@ -319,8 +333,12 @@ or bottom half).
 	practice of using "force_delete" in the put_inode() case, but
 	does not have the races that the "force_delete()" approach had.
 
-``delete_inode``
-	called when the VFS wants to delete an inode
+``evict_inode``
+	called when the VFS wants to evict an inode. Caller does
+	*not* evict the pagecache or inode-associated metadata buffers;
+	the method has to use truncate_inode_pages_final() to get rid
+	of those. Caller makes sure async writeback cannot be running for
+	the inode while (or after) ->evict_inode() is called. Optional.
 
 ``put_super``
 	called when the VFS wishes to free the superblock
@@ -331,14 +349,25 @@ or bottom half).
 	superblock.  The second parameter indicates whether the method
 	should wait until the write out has been completed.  Optional.
 
+``freeze_super``
+	Called instead of ->freeze_fs callback if provided.
+	Main difference is that ->freeze_super is called without taking
+	down_write(&sb->s_umount). If filesystem implements it and wants
+	->freeze_fs to be called too, then it has to call ->freeze_fs
+	explicitly from this callback. Optional.
+
 ``freeze_fs``
 	called when VFS is locking a filesystem and forcing it into a
 	consistent state.  This method is currently used by the Logical
-	Volume Manager (LVM).
+	Volume Manager (LVM) and ioctl(FIFREEZE). Optional.
+
+``thaw_super``
+	called when VFS is unlocking a filesystem and making it writable
+	again after ->freeze_super. Optional.
 
 ``unfreeze_fs``
 	called when VFS is unlocking a filesystem and making it writable
-	again.
+	again after ->freeze_fs. Optional.
 
 ``statfs``
 	called when the VFS needs to get filesystem statistics.
@@ -347,22 +376,37 @@ or bottom half).
 	called when the filesystem is remounted.  This is called with
 	the kernel lock held
 
-``clear_inode``
-	called then the VFS clears the inode.  Optional
-
 ``umount_begin``
 	called when the VFS is unmounting a filesystem.
 
 ``show_options``
-	called by the VFS to show mount options for /proc/<pid>/mounts.
+	called by the VFS to show mount options for /proc/<pid>/mounts
+	and /proc/<pid>/mountinfo.
 	(see "Mount Options" section)
 
+``show_devname``
+	Optional. Called by the VFS to show device name for
+	/proc/<pid>/{mounts,mountinfo,mountstats}. If not provided then
+	'(struct mount).mnt_devname' will be used.
+
+``show_path``
+	Optional. Called by the VFS (for /proc/<pid>/mountinfo) to show
+	the mount root dentry path relative to the filesystem root.
+
+``show_stats``
+	Optional. Called by the VFS (for /proc/<pid>/mountstats) to show
+	filesystem-specific mount statistics.
+
 ``quota_read``
 	called by the VFS to read from filesystem quota file.
 
 ``quota_write``
 	called by the VFS to write to filesystem quota file.
 
+``get_dquots``
+	called by quota to get 'struct dquot' array for a particular inode.
+	Optional.
+
 ``nr_cached_objects``
 	called by the sb cache shrinking function for the filesystem to
 	return the number of freeable cached objects it contains.
-- 
2.34.1

