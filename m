Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C6682C64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 13:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjAaMQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 07:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjAaMQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:16:18 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DA83FF09
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 04:16:17 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DFAD73F5DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675167372;
        bh=IPu7fLB6LtSUjT3Xte4CmODWi6kb+UhS9k09P1gjo9M=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=qHEsqu6p2bSCZY6QpS4mcdjRq8C+OFNc0Zo/lHRXfst0JqujKG9AJOa8hn2FC96Kf
         DzbnrIoqxXbAzxru8ouVHWSI+hg48x2HR/OvDc9a+7jweTeqQjKHtnegJhzdj4kXG0
         LEZnmTp6G1JDh1XyACzbG1BmvLbbaAH+XwT3wO3UOrlIgwWe1ZzvYlch1iUBpH2XkZ
         +63vez6KUlKgCCla9N+ggdPXilT8AXMS7v5mV3RbYdoPEYhYaOjalPh969F2PvA2gH
         yKCGqI4hm6W4+m3pLHLK2jQXE3zPBpcvqEriw0zV1KqnoZosKqJ24vn3xbJRy/2cCb
         xeNosUZNoKddA==
Received: by mail-ed1-f72.google.com with SMTP id f11-20020a056402354b00b0049e18f0076dso10388311edd.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 04:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPu7fLB6LtSUjT3Xte4CmODWi6kb+UhS9k09P1gjo9M=;
        b=0WfhkvyqtQqx+Fqq/ofo2iBjnGxqRVvLh3UO71DPjRr8CQEQMGYgMFOpNRmduPlZIR
         E17jliBMImnGXm+HQ5MBb7FuMJwzSGju7eY0VBzskoEEACz8i4E21CJQFB0YMkvHoGn/
         Rf6sjrLzSzIFC3PCCCyEdwf6bDQByyocoHlAqpb7o1bHgG3mqKd/fV3sbNo23SiamKc/
         CEq6DIRviDOJDmibT0JkVnUKR8Tqw4S++ucJtQddvZeaWSrIWSrQ7KvI62pPWvxGUF+D
         awzsHNIdnqWLOZMZ9Xs+WM243KsLOA3liUka1oXJmAuyIysMD0zDYsVLoapL+D9YHG9d
         qdsQ==
X-Gm-Message-State: AO0yUKUmnp/9ECvB7MEBkuaQ2MBQ9WbuwS0pkvu1Qqu5UmxJ8NPRXNAs
        ystBuPtV0bZjlKzs6mbyg/I170fDqh7SSGUrX2p+rEoV/eDf+fEPwW124w8Noz5IVyEGc2yQi1q
        0HZEBPkGCfOU2h0AFhZNoN76UVcgTwSqOXSAO5ND96Ck=
X-Received: by 2002:a17:907:9703:b0:880:50de:5e86 with SMTP id jg3-20020a170907970300b0088050de5e86mr15641292ejc.3.1675167372412;
        Tue, 31 Jan 2023 04:16:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+czGFbXYX0+SPaylHMGxT+8Ym4RsNb48wOFnL76iqhkYP7Cpjb2HFobHEHxMpYgSDRWiXgCg==
X-Received: by 2002:a17:907:9703:b0:880:50de:5e86 with SMTP id jg3-20020a170907970300b0088050de5e86mr15641276ejc.3.1675167372189;
        Tue, 31 Jan 2023 04:16:12 -0800 (PST)
Received: from amikhalitsyn.. (ip5f5bf399.dynamic.kabel-deutschland.de. [95.91.243.153])
        by smtp.gmail.com with ESMTPSA id lc7-20020a170906f90700b00887a23bab85sm3641693ejb.220.2023.01.31.04.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:16:11 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     corbet@lwn.net
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 2/2] docs: filesystems: vfs: actualize struct super_operations description
Date:   Tue, 31 Jan 2023 13:16:08 +0100
Message-Id: <20230131121608.177250-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc: linux-fsdevel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 Documentation/filesystems/vfs.rst | 74 ++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index fab3bd702250..8671eafa745a 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -242,33 +242,42 @@ struct super_operations
 -----------------------
 
 This describes how the VFS can manipulate the superblock of your
-filesystem.  As of kernel 2.6.22, the following members are defined:
+filesystem.  As of kernel 6.1, the following members are defined:
 
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
@@ -289,6 +298,11 @@ or bottom half).
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
@@ -316,8 +330,12 @@ or bottom half).
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
@@ -328,14 +346,25 @@ or bottom half).
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
@@ -344,22 +373,37 @@ or bottom half).
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

