Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900633F0F78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 02:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhHSA2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 20:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbhHSA1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:27:54 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD86C06179A;
        Wed, 18 Aug 2021 17:27:19 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id n7so8432095ljq.0;
        Wed, 18 Aug 2021 17:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OuvPHidmzGM3xfvyJ/iRKu/nSL+2mL7ylUN+am7Bbio=;
        b=QHLuK343vWAbHssWFJiqUq/ClvS8ybP8SFbiNvZdDGERaX8lm1TiDdscI58S6H0brn
         Eh5mHnYJpSUloyVBFz9UdJiB/Fi91YUkuZ4mLc9zDbZ8pCn9IXzZ3+c6xcqcsLguGNvr
         NqbQihZmTgou2SRrEUMfiHLJcNhgqEXeobum2ayxoFkbh3H9iDb9q7WjlvdbzvwSpszy
         TS0gceKowVH5pVA/uCaJV+sfu7xgg1Ypo4ERRJw2Hxj8rLnUdJ6EnVhDef5XjeZZfwbw
         clNSp7oPFAbO6IfZwCu8GBrkfjohEczljt/LrIEqgNY+mwAlylqefmI96dQxWLQPg3LJ
         9gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OuvPHidmzGM3xfvyJ/iRKu/nSL+2mL7ylUN+am7Bbio=;
        b=jEnkjMBbX8SfZimgTjrVIdsdqORqqpxuFm1Sv4SJdQ3hbl0piQ+Robd0MXVg/1EDCH
         1BzOJ25Q/x9HjM2BrbsWOEdlotVPXslvLF6DUQEa+Ngfuk3xJZPuUL9GdVNzFcYyI1yZ
         dQXYOMegPRZn2kLbyVqOPKhJfdA5aEQb0fhE0bO+J7dQaoFOUwFtxhVEI7mesFBa8Txb
         JAIwUQIT9Cmtfl1Pjf9PMAkui8U6pSt2jwd7IK9fdSqG5JGnsD6ZoZZmt1kR2zx7jv+z
         lT1dPZqbxhSm5y8U2V3yGwKk5PAvlz55VHOesjQbH7GenVD+O2KUoL+TWkLAtnHe0Pim
         1ijw==
X-Gm-Message-State: AOAM5327svj7GGuN+krMx77TmI+ofa3z26Q5PvnE9UN1QektfWbDNlKw
        Udbb2sT/ijBulODCig0aG3I=
X-Google-Smtp-Source: ABdhPJzNY06Mdbi0olL8L1uvNM5ELIcy5kw93h80MXSXsXqRbYMBDqVIa2QxmhSxS/+xaf9EiS0iBg==
X-Received: by 2002:a2e:a912:: with SMTP id j18mr8953804ljq.330.1629332837418;
        Wed, 18 Aug 2021 17:27:17 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id l14sm125907lji.106.2021.08.18.17.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 17:27:17 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 6/6] fs/ntfs3: Rename mount option no_acl_rules > (no)acl_rules
Date:   Thu, 19 Aug 2021 03:26:33 +0300
Message-Id: <20210819002633.689831-7-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819002633.689831-1-kari.argillander@gmail.com>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename mount option no_acl_rules to noacl_rules. This allow us to use
possibility to mount with options noacl_rules or acl_rules.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 Documentation/filesystems/ntfs3.rst |  2 +-
 fs/ntfs3/file.c                     |  2 +-
 fs/ntfs3/ntfs_fs.h                  |  2 +-
 fs/ntfs3/super.c                    | 12 ++++++------
 fs/ntfs3/xattr.c                    |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
index ded706474825..bdc9dd5a9185 100644
--- a/Documentation/filesystems/ntfs3.rst
+++ b/Documentation/filesystems/ntfs3.rst
@@ -73,7 +73,7 @@ prealloc		Preallocate space for files excessively when file size is
 			increasing on writes. Decreases fragmentation in case of
 			parallel write operations to different files.
 
-no_acs_rules		"No access rules" mount option sets access rights for
+noacs_rules		"No access rules" mount option sets access rights for
 			files/folders to 777 and owner/group to root. This mount
 			option absorbs all other permissions:
 			- permissions change for files/folders will be reported
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 59344985c2e8..de3c6c76ab7d 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -743,7 +743,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	umode_t mode = inode->i_mode;
 	int err;
 
-	if (sbi->options.no_acs_rules) {
+	if (sbi->options.noacs_rules) {
 		/* "no access rules" - force any changes of time etc. */
 		attr->ia_valid |= ATTR_FORCE;
 		/* and disable for editing some attributes */
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 1f07dd17c6c7..bec51e6f476d 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -67,7 +67,7 @@ struct ntfs_mount_options {
 		showmeta : 1, /*show meta files*/
 		nohidden : 1, /*do not show hidden files*/
 		force : 1, /*rw mount dirty volume*/
-		no_acs_rules : 1, /*exclude acs rules*/
+		noacs_rules : 1, /*exclude acs rules*/
 		prealloc : 1 /*preallocate space when file is growing*/
 		;
 };
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index c3c07c181f15..a94a094463ad 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -242,7 +242,7 @@ enum Opt {
 	Opt_acl,
 	Opt_iocharset,
 	Opt_prealloc,
-	Opt_no_acs_rules,
+	Opt_noacs_rules,
 	Opt_err,
 };
 
@@ -260,7 +260,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("acl",			Opt_acl),
 	fsparam_flag_no("showmeta",		Opt_showmeta),
 	fsparam_flag_no("prealloc",		Opt_prealloc),
-	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
+	fsparam_flag_no("acs_rules",		Opt_noacs_rules),
 	fsparam_string("iocharset",		Opt_iocharset),
 
 	__fsparam(fs_param_is_string,
@@ -343,8 +343,8 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 	case Opt_prealloc:
 		opts->prealloc = result.negated ? 0 : 1;
 		break;
-	case Opt_no_acs_rules:
-		opts->no_acs_rules = 1;
+	case Opt_noacs_rules:
+		opts->noacs_rules = result.negated ? 1 : 0;
 		break;
 	default:
 		/* Should not be here unless we forget add case. */
@@ -536,8 +536,8 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",nohidden");
 	if (opts->force)
 		seq_puts(m, ",force");
-	if (opts->no_acs_rules)
-		seq_puts(m, ",no_acs_rules");
+	if (opts->noacs_rules)
+		seq_puts(m, ",noacs_rules");
 	if (opts->prealloc)
 		seq_puts(m, ",prealloc");
 	if (sb->s_flags & SB_POSIXACL)
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 98871c895e77..e20e710a065f 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -774,7 +774,7 @@ int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode)
 int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		    int mask)
 {
-	if (ntfs_sb(inode->i_sb)->options.no_acs_rules) {
+	if (ntfs_sb(inode->i_sb)->options.noacs_rules) {
 		/* "no access rules" mode - allow all changes */
 		return 0;
 	}
-- 
2.25.1

