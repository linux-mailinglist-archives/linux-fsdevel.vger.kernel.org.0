Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C299784708
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbjHVQYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 12:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjHVQYC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:24:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D662C187
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 09:23:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6861869bcdso6013382276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692721439; x=1693326239;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8xEC9yUWCvrWy7dpPlll9qDlrXhi9P3J8UvpO4H/sSs=;
        b=Y2l5OwPUUXMZ0rAFThJ82imqz8h0f/7mBGDmgm259Y+TUBEx020D8R3N0MG7sa6z+J
         ApLbQJXR9hTDrk4VopRBI56nWcYnbKz/SQxKYlu1uZM6YVh12QAe1Ku3v39fkTHPxgDV
         KszNIhwVVhJMbs5rr+amnEtRRlewKc0nwArchdj+Zap5qKOgt66et6DRhyo/zyee1T8a
         Aby6F9ONJ35sl641XVGJamYXdYw/pcZ8PZbgLRXgG2dYmnOcCHO8ozg/omVSF7ZHQ4WA
         7uby84nh6BmyfMKbfv6O5qRGBt8tcusOy0eZiy4onAxLzPWRRkblnkwuD8lmHe6zkItj
         3dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692721439; x=1693326239;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xEC9yUWCvrWy7dpPlll9qDlrXhi9P3J8UvpO4H/sSs=;
        b=Ul1YAQ5Hh6fQ8AaXhg+mbBvHHsMIUR5varkEcTjArmv4WgTERYG2W95bGp2j9yxuri
         FfB+T7ZgPDOZj00Knh/IbLHw03umUETr1P8iIPcuAVKCC7wWU9O6B4wLBmFpqBxXmMVt
         QJQIOBds/YSWPYnaFx7/FWTwzlWYQ43IoSpwyGfBosd3M3H6GAIhFJIrMvR8FoLHJSw/
         ENuEjo0ToO3XPfcUIGM47qb0ofxWbuO7dU6OfsR7SGV7roHp2Ncej0ESMRwPNVccilvO
         0vhWj/Ej1B8QbQVumfW+qhHJIdKRIEoKEXo67K4YDUqdAtnLeBdKC6LhAg+XhSutdLIe
         FbAQ==
X-Gm-Message-State: AOJu0Ywd4FZsLOIleTlZ8ACS5hVfAQl8u351FO34/b0yTiDir6RG9J3Y
        zq+RllqkU4zZbrRhb+XXW9JsLeVff5iqElxkRIZbzD8rtg++M1a4lYBKB/Vy2wnYHoJMQtPjCDr
        d9/HQC93Tx6QNf57ogkxbSLAtkNgIYCdp5XdBe+2HgWrY18qoSoX5kqr0Or+i/FWZFJ4+xZqXH1
        5X
X-Google-Smtp-Source: AGHT+IHy/nN53EgB0o6VeR3Zy+39h+G0YuRd6bkfF1CXZvIwrp27z1ToLWQEFEjH6NdCKm5me3wJVJo+HfVxGg==
X-Received: from jiao.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:10f3])
 (user=jiaozhou job=sendgmr) by 2002:a25:4057:0:b0:d71:9aa2:d953 with SMTP id
 n84-20020a254057000000b00d719aa2d953mr102219yba.5.1692721439047; Tue, 22 Aug
 2023 09:23:59 -0700 (PDT)
Date:   Tue, 22 Aug 2023 16:23:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822162350.1.I96423a31e88428004c2f4a28ccad13828adf433e@changeid>
Subject: [PATCH] kernel: Add Mount Option For Efivarfs
From:   Jiao Zhou <jiaozhou@google.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jiao Zhou <jiaozhou@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add uid and gid in efivarfs's mount option, so that
we can mount the file system with ownership. This approach
is used by a number of other filesystems that don't have
native support for ownership

Signed-off-by: Jiao Zhou <jiaozhou@google.com>
---

 fs/efivarfs/inode.c    |  4 ++++
 fs/efivarfs/internal.h |  9 +++++++
 fs/efivarfs/super.c    | 54 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index b973a2c03dde..86175e229b0f 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -20,9 +20,13 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
 				const struct inode *dir, int mode,
 				dev_t dev, bool is_removable)
 {
+	struct efivarfs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = new_inode(sb);
+	struct efivarfs_mount_opts *opts = &fsi->mount_opts;
 
 	if (inode) {
+		inode->i_uid = opts->uid;
+		inode->i_gid = opts->gid;
 		inode->i_ino = get_next_ino();
 		inode->i_mode = mode;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 8ebf3a6a8aa2..2c7b6b24df19 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -48,6 +48,15 @@ bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
 				  size_t len);
 
+struct efivarfs_mount_opts {
+	kuid_t uid;
+	kgid_t gid;
+};
+
+struct efivarfs_fs_info {
+	struct efivarfs_mount_opts mount_opts;
+};
+
 extern const struct file_operations efivarfs_file_operations;
 extern const struct inode_operations efivarfs_dir_inode_operations;
 extern bool efivarfs_valid_name(const char *str, int len);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f3..e3c81fac8208 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -8,6 +8,7 @@
 #include <linux/efi.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/ucs2_string.h>
@@ -60,10 +61,27 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	return 0;
 }
+static int efivarfs_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct super_block *sb = root->d_sb;
+	struct efivarfs_fs_info *sbi = sb->s_fs_info;
+	struct efivarfs_mount_opts *opts = &sbi->mount_opts;
+
+	/* Show partition info */
+	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
+		seq_printf(m, ",uid=%u",
+				from_kuid_munged(&init_user_ns, opts->uid));
+	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
+		seq_printf(m, ",gid=%u",
+				from_kgid_munged(&init_user_ns, opts->gid));
+	return 0;
+}
+
 static const struct super_operations efivarfs_ops = {
 	.statfs = efivarfs_statfs,
 	.drop_inode = generic_delete_inode,
 	.evict_inode = efivarfs_evict_inode,
+	.show_options	= efivarfs_show_options,
 };
 
 /*
@@ -225,6 +243,40 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
 	return 0;
 }
 
+enum {
+	Opt_uid, Opt_gid,
+};
+
+static const struct fs_parameter_spec efivarfs_parameters[] = {
+	fsparam_u32("uid",			Opt_uid),
+	fsparam_u32("gid",			Opt_gid),
+};
+
+static int efivarfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct efivarfs_fs_info *sbi = fc->s_fs_info;
+	struct efivarfs_mount_opts *opts = &sbi->mount_opts;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, efivarfs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_uid:
+		opts->uid = make_kuid(current_user_ns(), result.uint_32);
+		break;
+	case Opt_gid:
+		opts->gid = make_kgid(current_user_ns(), result.uint_32);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode = NULL;
@@ -271,6 +323,7 @@ static int efivarfs_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations efivarfs_context_ops = {
 	.get_tree	= efivarfs_get_tree,
+	.parse_param	= efivarfs_parse_param,
 };
 
 static int efivarfs_init_fs_context(struct fs_context *fc)
@@ -295,6 +348,7 @@ static struct file_system_type efivarfs_type = {
 	.name    = "efivarfs",
 	.init_fs_context = efivarfs_init_fs_context,
 	.kill_sb = efivarfs_kill_sb,
+	.parameters		= efivarfs_parameters,
 };
 
 static __init int efivarfs_init(void)
-- 
2.42.0.rc1.204.g551eb34607-goog

