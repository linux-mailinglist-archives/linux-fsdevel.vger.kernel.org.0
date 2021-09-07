Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87402402BFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 17:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345614AbhIGPhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345495AbhIGPhf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:37:35 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B376C06179A;
        Tue,  7 Sep 2021 08:36:28 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h1so17223343ljl.9;
        Tue, 07 Sep 2021 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IBOhrHMY/c1tfwUMPdU4gIC4AvL9Y2ZEu59nLM3Bis=;
        b=ecuY4YKKqY9hcXGVgcr5eF6494AIrirQii9krUItCo+qkAgsKVoph54s8t7Iy2wKDI
         ciFIB303/DuMBw8wqrCNcV2J0fZae4BNrYGctK33CNJpwEUdhP54Kgo4DwsmNbILVCgB
         g81DUJ3/Bbx6psqZeKu2zgxOJrJmGxEFi06NLa64SKUulTWhAHX9Qnfe4opfekArtskT
         zQJD2csRnZ4vRs3HqVmhtp4yHYGOLHm4ey/9julIymM1sk+No2FYfDGSEP8unMCHHsXr
         3BXhx+y241cMSZiyz0im/U96+dd7gEnA+oJHq2IB/DAkwHKIzXNYo//8B+C4wt7TZle6
         3xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IBOhrHMY/c1tfwUMPdU4gIC4AvL9Y2ZEu59nLM3Bis=;
        b=V+mHqlppl2OZqcBPgNLgNEN//rX4jiQ9DPul3/gZaVpd4mDnCNi5q/CFI9k7ZITddS
         UlOSlrQ7fbbhpcXDinrzJmj69fb2BY51NEx9AJId82tt32w0g+0rzHMQGU7pbDm83Mc8
         g+iQHzIWod9Iry/SGzKuSTK/1sWusQEfN6LFRJ9QHxSnW1TrxYv7RdZYgOH7qDf2TjHf
         tI2eu93Jtwe9XzpaXeCaQIESzLqZJ0fXCvl+xLyQ/p01rTt8NlJlHZSt3QiGvQlcq2M+
         eCWvhGlnDJO/6Q0l0pRZhx7A7Xtib6Vtl6absKMvLdslCRLNHbFJvv2esuwO+F+Wqc+W
         XJBg==
X-Gm-Message-State: AOAM530GUe9xCaQ0jqMvR9f9BCaiRxo1jgwlbSERpgJj6k1ZJFcZhSEt
        u7fImBtJo6a5XM8oPH3Bwx0=
X-Google-Smtp-Source: ABdhPJwpmkQPafKAJkRMMmr+44q6bqHZjG8USn5+w+wAveGGiMn9+GDaA6WHOcgJotZAMY4rGoeKmw==
X-Received: by 2002:a2e:9dcb:: with SMTP id x11mr15667575ljj.137.1631028986922;
        Tue, 07 Sep 2021 08:36:26 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id p14sm1484458lji.56.2021.09.07.08.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:36:26 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 8/9] fs/ntfs3: Rename mount option no_acs_rules > (no)acsrules
Date:   Tue,  7 Sep 2021 18:35:56 +0300
Message-Id: <20210907153557.144391-9-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907153557.144391-1-kari.argillander@gmail.com>
References: <20210907153557.144391-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename mount option no_acs_rules to (no)acsrules. This allow us to use
possibility to mount with options noaclrules or aclrules.

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
index ded706474825..7b6afe452197 100644
--- a/Documentation/filesystems/ntfs3.rst
+++ b/Documentation/filesystems/ntfs3.rst
@@ -73,7 +73,7 @@ prealloc		Preallocate space for files excessively when file size is
 			increasing on writes. Decreases fragmentation in case of
 			parallel write operations to different files.
 
-no_acs_rules		"No access rules" mount option sets access rights for
+noacsrules		"No access rules" mount option sets access rights for
 			files/folders to 777 and owner/group to root. This mount
 			option absorbs all other permissions:
 			- permissions change for files/folders will be reported
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index fef57141b161..0743d806c567 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -737,7 +737,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	umode_t mode = inode->i_mode;
 	int err;
 
-	if (sbi->options->no_acs_rules) {
+	if (sbi->options->noacsrules) {
 		/* "No access rules" - Force any changes of time etc. */
 		attr->ia_valid |= ATTR_FORCE;
 		/* and disable for editing some attributes. */
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index aa18f12b7096..15bab48bc1ad 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -70,7 +70,7 @@ struct ntfs_mount_options {
 		showmeta : 1, /* Show meta files. */
 		nohidden : 1, /* Do not show hidden files. */
 		force : 1, /* Rw mount dirty volume. */
-		no_acs_rules : 1, /*Exclude acs rules. */
+		noacsrules : 1, /*Exclude acs rules. */
 		prealloc : 1 /* Preallocate space when file is growing. */
 		;
 };
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 503e2e23f711..0690e7e4f00d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -228,7 +228,7 @@ enum Opt {
 	Opt_acl,
 	Opt_iocharset,
 	Opt_prealloc,
-	Opt_no_acs_rules,
+	Opt_noacsrules,
 	Opt_err,
 };
 
@@ -246,7 +246,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("acl",			Opt_acl),
 	fsparam_flag_no("showmeta",		Opt_showmeta),
 	fsparam_flag_no("prealloc",		Opt_prealloc),
-	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
+	fsparam_flag_no("acsrules",		Opt_noacsrules),
 	fsparam_string("iocharset",		Opt_iocharset),
 
 	__fsparam(fs_param_is_string,
@@ -358,8 +358,8 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 	case Opt_prealloc:
 		opts->prealloc = result.negated ? 0 : 1;
 		break;
-	case Opt_no_acs_rules:
-		opts->no_acs_rules = 1;
+	case Opt_noacsrules:
+		opts->noacsrules = result.negated ? 1 : 0;
 		break;
 	default:
 		/* Should not be here unless we forget add case. */
@@ -547,8 +547,8 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",nohidden");
 	if (opts->force)
 		seq_puts(m, ",force");
-	if (opts->no_acs_rules)
-		seq_puts(m, ",no_acs_rules");
+	if (opts->noacsrules)
+		seq_puts(m, ",noacsrules");
 	if (opts->prealloc)
 		seq_puts(m, ",prealloc");
 	if (sb->s_flags & SB_POSIXACL)
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index ac4b37bf8832..6f88cb77a17f 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -769,7 +769,7 @@ int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode)
 int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		    int mask)
 {
-	if (ntfs_sb(inode->i_sb)->options->no_acs_rules) {
+	if (ntfs_sb(inode->i_sb)->options->noacsrules) {
 		/* "No access rules" mode - Allow all changes. */
 		return 0;
 	}
-- 
2.25.1

