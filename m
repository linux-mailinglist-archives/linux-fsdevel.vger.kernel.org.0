Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DCB6B786B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 14:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjCMNHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 09:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCMNHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:07:46 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133F569CF1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 06:07:45 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DAFC13F1F6
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 13:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678712863;
        bh=DxY9gtEb2yUWHmiKh47fPHSDNwQhBlWvUqBBIzAx0HI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YC+Sg0G1aNMNtpIfPIgMAGIAudKo0NxuvdgU23FICU0tCoDjktISTOkh0BJaCLnYF
         e5wl3icVyrRJ800ArJ3NUt4c7zGIay1kUnmqS2yGRgzfKiq6sJBwt6JvlkdvLysR5k
         SgNoU9VvHG84T/z62DX9nQ20v8qLZXVuZYIsmsU8OUVc1bK76rYNxr7xW8jCkwJdax
         2PEyRBkKiI1UrtPj+59NNKvb/9Z08U4zdlwLd1zyEldMhVRuVYV42T2iUV+1lN3DpP
         dJ5b8lp5FdHVGFPqB6tpChg2DbZq8GOdD3bdFnsA/1PN0c3T+GHtbc8GpVXgm/lJOx
         4jFmSbLs0JXOg==
Received: by mail-ed1-f71.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so16631543edc.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 06:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxY9gtEb2yUWHmiKh47fPHSDNwQhBlWvUqBBIzAx0HI=;
        b=NK/oij2dZ7maObo1ThFAG6s76ikHTX7F+LINEHgjqVHI1p1Jldw+HKXKKT4iT/BzHU
         irnUvLk92NUzhSxTLmNPbwOqsjkfboT2Nk40g4UJZhP17oJiEvbe7ni4h1xudVH6K6sD
         MdM6N8/fMZzBCXCoBsIYrM1rXyh91yUldH0igvetk8F3EUY2XPPsj22NgAyL2Dilc8AN
         8oi0AFYMpdfQpEECNY8zwxi+reu6jceEXlelFnBSlNvRdfnrFRy5UoU5bWTPCo7EB3iR
         e24TaACUUrVHnSeZO6aMV3tFbe+2SGpnqaWySt/4EfovpXUNcJLQmV/666holfnQL0Z7
         Ahow==
X-Gm-Message-State: AO0yUKX5k7GazjfJ+unJgvKe69Aj9f1meKc/5p55xwuEgE0rznxaSGpQ
        eAx19771SwTzpThEk3c+KmTx1UF5FeepatvcUDEMhycWv7SVN2XroffmlQXsrY1jkX/YngAKtw+
        VyKforDSuT73xYB+yxUeGOQ5yE35Gzb0M2YnmdD3PKt0=
X-Received: by 2002:a17:907:80e:b0:885:6a2e:f941 with SMTP id wv14-20020a170907080e00b008856a2ef941mr42726425ejb.54.1678712863751;
        Mon, 13 Mar 2023 06:07:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set/0wTgahBc1uWANIavIKGcaDNAp5k/l2W9ZxK1nxedsF/0aIEk3qftlDUPBRBz+wfmafPH/LA==
X-Received: by 2002:a17:907:80e:b0:885:6a2e:f941 with SMTP id wv14-20020a170907080e00b008856a2ef941mr42726395ejb.54.1678712863457;
        Mon, 13 Mar 2023 06:07:43 -0700 (PDT)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:c91d:59c1:64e:937b])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090637cb00b00926f89e2213sm1711388ejc.190.2023.03.13.06.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:07:43 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     corbet@lwn.net
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 1/2] docs: filesystems: vfs: actualize struct file_system_type description
Date:   Mon, 13 Mar 2023 14:07:17 +0100
Message-Id: <20230313130718.253708-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313130718.253708-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230313130718.253708-1-aleksandr.mikhalitsyn@canonical.com>
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

Added descriptions for:
- fscontext API ('init_fs_context' method, 'parameters' field)
- 'fs_supers' field

Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 Documentation/filesystems/vfs.rst | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 2c15e7053113..f8905ff070d0 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -107,7 +107,7 @@ file /proc/filesystems.
 struct file_system_type
 -----------------------
 
-This describes the filesystem.  As of kernel 2.6.39, the following
+This describes the filesystem.  The following
 members are defined:
 
 .. code-block:: c
@@ -115,14 +115,24 @@ members are defined:
 	struct file_system_type {
 		const char *name;
 		int fs_flags;
+		int (*init_fs_context)(struct fs_context *);
+		const struct fs_parameter_spec *parameters;
 		struct dentry *(*mount) (struct file_system_type *, int,
-					 const char *, void *);
+			const char *, void *);
 		void (*kill_sb) (struct super_block *);
 		struct module *owner;
 		struct file_system_type * next;
-		struct list_head fs_supers;
+		struct hlist_head fs_supers;
+
 		struct lock_class_key s_lock_key;
 		struct lock_class_key s_umount_key;
+		struct lock_class_key s_vfs_rename_key;
+		struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
+
+		struct lock_class_key i_lock_key;
+		struct lock_class_key i_mutex_key;
+		struct lock_class_key invalidate_lock_key;
+		struct lock_class_key i_mutex_dir_key;
 	};
 
 ``name``
@@ -132,6 +142,15 @@ members are defined:
 ``fs_flags``
 	various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
 
+``init_fs_context``
+	Initializes 'struct fs_context' ->ops and ->fs_private fields with
+	filesystem-specific data.
+
+``parameters``
+	Pointer to the array of filesystem parameters descriptors
+	'struct fs_parameter_spec'.
+	More info in Documentation/filesystems/mount_api.rst.
+
 ``mount``
 	the method to call when a new instance of this filesystem should
 	be mounted
@@ -148,7 +167,11 @@ members are defined:
 ``next``
 	for internal VFS use: you should initialize this to NULL
 
-  s_lock_key, s_umount_key: lockdep-specific
+``fs_supers``
+	for internal VFS use: hlist of filesystem instances (superblocks)
+
+  s_lock_key, s_umount_key, s_vfs_rename_key, s_writers_key,
+  i_lock_key, i_mutex_key, invalidate_lock_key, i_mutex_dir_key: lockdep-specific
 
 The mount() method has the following arguments:
 
-- 
2.34.1

