Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6135F9D5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiJJLOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 07:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJJLOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:14:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4771F6565E;
        Mon, 10 Oct 2022 04:14:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a3so16564703wrt.0;
        Mon, 10 Oct 2022 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aFea0r2fAo46iHuuD/8q5QBNTkdkO/FbrfoD+Dc6iI=;
        b=eCKmetoglYwZvldg8JnIvkOT/Zr/HuK2vsDeeEYw5VP9vtWe0ukDCMrVSvnk7TExIh
         mDhdKEYaCHBSTeTbK65FBqeCwifC72TWxaJepJzXkHMJ+cq29kkNB9Ig69aWVaflAPwS
         JdyLv00xkXuWmiRnJgrxtg0SlaGEMqC0k5L0tjv5Murt7NQGkNZRJbG26gJlrcP8C27O
         sPZvdYay/i5k8ouSjw6AVaIX4DqMvS6XvaTsgD+Dx4yJbcC5wB4zo0zPc705KbyNHY+L
         kHvXvIflDci0vWpNEvq/jT294H6+ZdFDdp+HCUgxSnCZNy/9gevpp1JqKJaT4VpE1lYM
         0prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aFea0r2fAo46iHuuD/8q5QBNTkdkO/FbrfoD+Dc6iI=;
        b=h5jrqu+QO6cQeIQJnAizSqOCTNUBLLFtJCRJfbFOLuf8Jnz3Whd0aFa/uoPDdrtvnf
         CY3pLHfMb5VcfgO2K+psvjz/XrkSaUPNMF5VhWMJ3mN08w/WrcKh5hzAkh4FeipBzChR
         4XwuS+CaczMLJDgfdTnojh/GUmZBke37mQ8+hI87tGDcbHej31IPOPnm0lc3IEri5SeL
         Nkt+NcVllon+9tNv9//mmL4VBrLZAI4QiycdKHgvz7emd2RrAkfPxgI0V6WFEgSEiGhH
         hohEk+a25lqYjxcZuXLjHac/i6dKEyxIQCD2ygHZVMAFu9XYSjeEXspYq6QkcBCBYMH5
         agow==
X-Gm-Message-State: ACrzQf1yNApAWqKwc3qJM/n5o1xn1XGVhippQtRxEjsU6/6SqgH34+x/
        rzpES3zRNbr+Z1jHF/4P2qv+qMRHODc=
X-Google-Smtp-Source: AMsMyM6UWeMCAyMymXXGAfztWGnhj8QOJEAHJAAQ+0vzerluZTuOC9KXxDiy8JlI6lUTG6HHb3v2GA==
X-Received: by 2002:a05:6000:257:b0:22c:de79:be97 with SMTP id m23-20020a056000025700b0022cde79be97mr11241594wrz.613.1665400472629;
        Mon, 10 Oct 2022 04:14:32 -0700 (PDT)
Received: from [192.168.42.102] (sm4-84-91-228-85.netvisao.pt. [84.91.228.85])
        by smtp.gmail.com with ESMTPSA id o18-20020a1c7512000000b003b492753826sm9748078wmc.43.2022.10.10.04.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:14:32 -0700 (PDT)
Message-ID: <1c6e08e2-f35c-f6ef-066d-f6eefdd62033@gmail.com>
Date:   Mon, 10 Oct 2022 12:14:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: [PATCH v2 1/2] fs/ntfs3: add windows_names mount option
Content-Language: pt-PT
From:   Daniel Pinto <danielpinto52@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1b23684d-2cac-830e-88e3-1dc1c1567441@gmail.com>
In-Reply-To: <1b23684d-2cac-830e-88e3-1dc1c1567441@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When enabled, the windows_names mount option prevents the creation
of files or directories with names not allowed by Windows. Use
the same option name as NTFS-3G for compatibility.

Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
---
 fs/ntfs3/frecord.c |   7 ++-
 fs/ntfs3/fsntfs.c  | 104 +++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/inode.c   |   7 +++
 fs/ntfs3/ntfs_fs.h |   2 +
 fs/ntfs3/super.c   |   7 +++
 5 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 70a80f9412f7..ce5e8f3b1aca 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3011,6 +3011,7 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
 		struct NTFS_DE *de)
 {
 	int err;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	struct ATTRIB *attr;
 	struct ATTR_LIST_ENTRY *le;
 	struct mft_inode *mi;
@@ -3018,6 +3019,10 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
 	struct ATTR_FILE_NAME *de_name = (struct ATTR_FILE_NAME *)(de + 1);
 	u16 de_key_size = le16_to_cpu(de->key_size);
 
+	if (sbi->options->windows_names &&
+	    !valid_windows_name(sbi, (struct le_str *)&de_name->name_len))
+		return -EINVAL;
+
 	mi_get_ref(&ni->mi, &de->ref);
 	mi_get_ref(&dir_ni->mi, &de_name->home);
 
@@ -3036,7 +3041,7 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
 	memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), de_name, de_key_size);
 
 	/* Insert new name into directory. */
-	err = indx_insert_entry(&dir_ni->dir, dir_ni, de, ni->mi.sbi, NULL, 0);
+	err = indx_insert_entry(&dir_ni->dir, dir_ni, de, sbi, NULL, 0);
 	if (err)
 		ni_remove_attr_le(ni, attr, mi, le);
 
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 4ed15f64b17f..674b644e1070 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -98,6 +98,30 @@ const __le16 WOF_NAME[17] = {
 };
 #endif
 
+static const __le16 CON_NAME[3] = {
+	cpu_to_le16('C'), cpu_to_le16('O'), cpu_to_le16('N'),
+};
+
+static const __le16 NUL_NAME[3] = {
+	cpu_to_le16('N'), cpu_to_le16('U'), cpu_to_le16('L'),
+};
+
+static const __le16 AUX_NAME[3] = {
+	cpu_to_le16('A'), cpu_to_le16('U'), cpu_to_le16('X'),
+};
+
+static const __le16 PRN_NAME[3] = {
+	cpu_to_le16('P'), cpu_to_le16('R'), cpu_to_le16('N'),
+};
+
+static const __le16 COM_NAME[3] = {
+	cpu_to_le16('C'), cpu_to_le16('O'), cpu_to_le16('M'),
+};
+
+static const __le16 LPT_NAME[3] = {
+	cpu_to_le16('L'), cpu_to_le16('P'), cpu_to_le16('T'),
+};
+
 // clang-format on
 
 /*
@@ -2502,3 +2526,83 @@ int run_deallocate(struct ntfs_sb_info *sbi, struct runs_tree *run, bool trim)
 
 	return 0;
 }
+
+static inline bool name_has_forbidden_chars(const struct le_str *fname)
+{
+	int i, ch;
+
+	/* check for forbidden chars */
+	for (i = 0; i < fname->len; ++i) {
+		ch = le16_to_cpu(fname->name[i]);
+
+		/* control chars */
+		if (ch < 0x20)
+			return true;
+
+		switch (ch) {
+		/* disallowed by Windows */
+		case '\\':
+		case '/':
+		case ':':
+		case '*':
+		case '?':
+		case '<':
+		case '>':
+		case '|':
+		case '\"':
+			return true;
+
+		default:
+			/* allowed char */
+			break;
+		}
+	}
+
+	/* file names cannot end with space or . */
+	if (fname->len > 0) {
+		ch = le16_to_cpu(fname->name[fname->len - 1]);
+		if (ch == ' ' || ch == '.')
+			return true;
+	}
+
+	return false;
+}
+
+static inline bool is_reserved_name(struct ntfs_sb_info *sbi,
+				    const struct le_str *fname)
+{
+	int port_digit;
+	const __le16 *name = fname->name;
+	int len = fname->len;
+	u16 *upcase = sbi->upcase;
+
+	/* check for 3 chars reserved names (device names) */
+	/* name by itself or with any extension is forbidden */
+	if (len == 3 || (len > 3 && le16_to_cpu(name[3]) == '.'))
+		if (!ntfs_cmp_names(name, 3, CON_NAME, 3, upcase, false) ||
+		    !ntfs_cmp_names(name, 3, NUL_NAME, 3, upcase, false) ||
+		    !ntfs_cmp_names(name, 3, AUX_NAME, 3, upcase, false) ||
+		    !ntfs_cmp_names(name, 3, PRN_NAME, 3, upcase, false))
+			return true;
+
+	/* check for 4 chars reserved names (port name followed by 1..9) */
+	/* name by itself or with any extension is forbidden */
+	if (len == 4 || (len > 4 && le16_to_cpu(name[4]) == '.')) {
+		port_digit = le16_to_cpu(name[3]);
+		if (port_digit >= '1' && port_digit <= '9')
+			if (!ntfs_cmp_names(name, 3, COM_NAME, 3, upcase, false) ||
+			    !ntfs_cmp_names(name, 3, LPT_NAME, 3, upcase, false))
+				return true;
+	}
+
+	return false;
+}
+
+/*
+ * valid_windows_name - Check if a file name is valid in Windows.
+ */
+bool valid_windows_name(struct ntfs_sb_info *sbi, const struct le_str *fname)
+{
+	return !name_has_forbidden_chars(fname) &&
+	       !is_reserved_name(sbi, fname);
+}
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index e9cf00d14733..4eb298e2ee98 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1361,6 +1361,13 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 	mi_get_ref(&ni->mi, &new_de->ref);
 
 	fname = (struct ATTR_FILE_NAME *)(new_de + 1);
+
+	if (sbi->options->windows_names &&
+	    !valid_windows_name(sbi, (struct le_str *)&fname->name_len)) {
+		err = -EINVAL;
+		goto out4;
+	}
+
 	mi_get_ref(&dir_ni->mi, &fname->home);
 	fname->dup.cr_time = fname->dup.m_time = fname->dup.c_time =
 		fname->dup.a_time = std5->cr_time;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 6c1c7ef3b2d6..ebfb720fc4fd 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -98,6 +98,7 @@ struct ntfs_mount_options {
 	unsigned showmeta : 1; /* Show meta files. */
 	unsigned nohidden : 1; /* Do not show hidden files. */
 	unsigned hide_dot_files : 1; /* Set hidden flag on dot files. */
+	unsigned windows_names : 1; /* Disallow names forbidden by Windows. */
 	unsigned force : 1; /* RW mount dirty volume. */
 	unsigned noacsrules : 1; /* Exclude acs rules. */
 	unsigned prealloc : 1; /* Preallocate space when file is growing. */
@@ -645,6 +646,7 @@ int ntfs_remove_reparse(struct ntfs_sb_info *sbi, __le32 rtag,
 			const struct MFT_REF *ref);
 void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim);
 int run_deallocate(struct ntfs_sb_info *sbi, struct runs_tree *run, bool trim);
+bool valid_windows_name(struct ntfs_sb_info *sbi, const struct le_str *name);
 
 /* Globals from index.c */
 int indx_used_bit(struct ntfs_index *indx, struct ntfs_inode *ni, size_t *bit);
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 1e2c04e48f98..6f3485fad417 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -248,6 +248,7 @@ enum Opt {
 	Opt_sparse,
 	Opt_nohidden,
 	Opt_hide_dot_files,
+	Opt_windows_names,
 	Opt_showmeta,
 	Opt_acl,
 	Opt_iocharset,
@@ -269,6 +270,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("sparse",		Opt_sparse),
 	fsparam_flag_no("hidden",		Opt_nohidden),
 	fsparam_flag_no("hidedotfiles",		Opt_hide_dot_files),
+	fsparam_flag_no("windows_names",	Opt_windows_names),
 	fsparam_flag_no("acl",			Opt_acl),
 	fsparam_flag_no("showmeta",		Opt_showmeta),
 	fsparam_flag_no("prealloc",		Opt_prealloc),
@@ -361,6 +363,9 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 	case Opt_hide_dot_files:
 		opts->hide_dot_files = result.negated ? 1 : 0;
 		break;
+	case Opt_windows_names:
+		opts->windows_names = result.negated ? 0 : 1;
+		break;
 	case Opt_acl:
 		if (!result.negated)
 #ifdef CONFIG_NTFS3_FS_POSIX_ACL
@@ -561,6 +566,8 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",showmeta");
 	if (opts->nohidden)
 		seq_puts(m, ",nohidden");
+	if (opts->windows_names)
+		seq_puts(m, ",windows_names");
 	if (opts->force)
 		seq_puts(m, ",force");
 	if (opts->noacsrules)
