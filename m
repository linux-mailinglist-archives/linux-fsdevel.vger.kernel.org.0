Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB29C3FAA9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhH2J5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 05:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbhH2J5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:57:50 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8B0C06175F;
        Sun, 29 Aug 2021 02:56:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s3so20098297ljp.11;
        Sun, 29 Aug 2021 02:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0dAQLkYIlRiJK9IfureASYoNzBsPTMv+O08xyy3NXM=;
        b=nGOSyCLQIFlWIQ/Lc/mTiZ92PGZp+bmcaZZrQrxA5y5ObxD4l06ZoPBKJ7dD2clMjw
         iNJeBoahyaTfrXiBd3m6Y62rVnP1BDL+Ay52y3GWDfN5NDYno0bzPo2DLiM//4ITHsae
         ZTuGfyEkOrA5UjzpNcgi2/doDujxH6FNvZuMkonGwJvqTnlapCjEPYuZc7ZiL9FnYtmh
         0vNlxrzqGaxpc2My9csZ/leU0MCy4o43UonG/M9RLzy4V6FzjBL4Ity5Rp0gcAexSaJ9
         gsBZkLdm+RIH9O4zxM/voVE6C6hfEVX7cUJ1ZDBc2OwWEQHgJhVddg7bAQSIuL5/C5Cp
         hDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0dAQLkYIlRiJK9IfureASYoNzBsPTMv+O08xyy3NXM=;
        b=ZkGl6OO6aVnTXmp16gbZ8ANObMeOm15hDMAKizV/Yt8CtieCaJZe+JOHCgGUocSll9
         rpQZihu/0qlQPu30Gk4XkAMlXiaGyyV/q8tq2NDTgUrh8ZZVluXsqL5dqiR96XCYJLqv
         m8c4/cLi2mtcCEvjpw7Irlt/H/S9FZaaaPZaIfSK3f7BlP5cZlVkusD1Re1YBquZ9L34
         pXYVG4rZ6ccfOF2D7BTr72NQ8Vr8hVAqu3Pe0/+ZXTLxtmirJvDiHA47wf2wb8yvatK3
         ri8MCX35XV6XBt9XIcXxYcuXYeog8FxvEoFSWPe4OibPvj0LafZZq+UOD0VjrhNgNDWR
         lYoA==
X-Gm-Message-State: AOAM532UTrOEz8rihG/cJbk3WjcYkvSvelJPjTIOdJpIO3FoRIFST7xG
        8Ka4H0/MCeOSyhr8UCGmRwA=
X-Google-Smtp-Source: ABdhPJyAqy1EFURVwVmMWuDazMXwGx/Mut8Do0gXgICIvI9X8r9bCzixcBEaLtH7W9BJ62DWUM4Q6w==
X-Received: by 2002:a05:651c:1af:: with SMTP id c15mr15377950ljn.194.1630231016161;
        Sun, 29 Aug 2021 02:56:56 -0700 (PDT)
Received: from localhost.localdomain (37-33-245-172.bb.dnainternet.fi. [37.33.245.172])
        by smtp.gmail.com with ESMTPSA id d6sm1090521lfi.57.2021.08.29.02.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:56:55 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 8/9] fs/ntfs3: Rename mount option no_acl_rules > (no)acl_rules
Date:   Sun, 29 Aug 2021 12:56:13 +0300
Message-Id: <20210829095614.50021-9-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829095614.50021-1-kari.argillander@gmail.com>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename mount option no_acl_rules to noacl_rules. This allow us to use
possibility to mount with options noacl_rules or acl_rules.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index c79e4aff7a19..4c9ff7fcf0b1 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -743,7 +743,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	umode_t mode = inode->i_mode;
 	int err;
 
-	if (sbi->options->no_acs_rules) {
+	if (sbi->options->noacs_rules) {
 		/* "no access rules" - force any changes of time etc. */
 		attr->ia_valid |= ATTR_FORCE;
 		/* and disable for editing some attributes */
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 45d6f4f91222..5df55bc733bd 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -70,7 +70,7 @@ struct ntfs_mount_options {
 		showmeta : 1, /*show meta files*/
 		nohidden : 1, /*do not show hidden files*/
 		force : 1, /*rw mount dirty volume*/
-		no_acs_rules : 1, /*exclude acs rules*/
+		noacs_rules : 1, /*exclude acs rules*/
 		prealloc : 1 /*preallocate space when file is growing*/
 		;
 };
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index e5c319604c4d..d7408b4f6813 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -221,7 +221,7 @@ enum Opt {
 	Opt_acl,
 	Opt_iocharset,
 	Opt_prealloc,
-	Opt_no_acs_rules,
+	Opt_noacs_rules,
 	Opt_err,
 };
 
@@ -239,7 +239,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("acl",			Opt_acl),
 	fsparam_flag_no("showmeta",		Opt_showmeta),
 	fsparam_flag_no("prealloc",		Opt_prealloc),
-	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
+	fsparam_flag_no("acs_rules",		Opt_noacs_rules),
 	fsparam_string("iocharset",		Opt_iocharset),
 
 	__fsparam(fs_param_is_string,
@@ -351,8 +351,8 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
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
@@ -538,8 +538,8 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
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
index a17d48735b99..4b37ed239579 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -774,7 +774,7 @@ int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode)
 int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		    int mask)
 {
-	if (ntfs_sb(inode->i_sb)->options->no_acs_rules) {
+	if (ntfs_sb(inode->i_sb)->options->noacs_rules) {
 		/* "no access rules" mode - allow all changes */
 		return 0;
 	}
-- 
2.25.1

