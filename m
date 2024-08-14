Return-Path: <linux-fsdevel+bounces-25860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E07AC951279
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE67B244C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7111A286;
	Wed, 14 Aug 2024 02:32:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649761CAB1
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602764; cv=none; b=h70RR/7rosIFYNys/DU3J5f9SnYI2HK+q5WiKKSSA0Exfmx282WEmRdqMRI2PEczEpt+7XAWhND2rgf4k0A6Mqh3bcG1Z6338afVHZIkrQR6VqI6RmvE1SX87UwLZM5WqiCMkCohcEvFx1i07LkduVBPvFQ+r0PyBeU9/vZEt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602764; c=relaxed/simple;
	bh=l0eOka8677h2HlFFvUMVB+J7TYjj795+Yu4zkksloHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNUsVoYvsvlfCuB/lB7tmGyO+XSx7L/zOo1DZ+M7qJwGtWJgd+yewpDhtyl/AICk7GVnsV7c5jxWPCPO9CeqLGAO+FnO5XNXw2d7UwH/PcK40WqN+a1Tev94d/AAkSt6rHYRUUxyrUUPOrxXK19iESKUXc6Cfy48APu/rlFGkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WkBxJ4tHbz1j6NB;
	Wed, 14 Aug 2024 10:27:48 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 13E8A1402CF;
	Wed, 14 Aug 2024 10:32:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 10:32:39 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <brauner@kernel.org>,
	<lczerner@redhat.com>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH 9/9] f2fs: remove unused structure and functions
Date: Wed, 14 Aug 2024 10:39:12 +0800
Message-ID: <20240814023912.3959299-10-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814023912.3959299-1-lihongbo22@huawei.com>
References: <20240814023912.3959299-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The match_table_t and other some functions (which have been replaced
during reconstructure) now are not used, so we can remove them.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/f2fs/super.c | 264 ------------------------------------------------
 1 file changed, 264 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 86acb7354d95..46c0d2087966 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -274,83 +274,6 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
 	{}
 };
 
-static match_table_t f2fs_tokens = {
-	{Opt_gc_background, "background_gc=%s"},
-	{Opt_disable_roll_forward, "disable_roll_forward"},
-	{Opt_norecovery, "norecovery"},
-	{Opt_discard, "discard"},
-	{Opt_nodiscard, "nodiscard"},
-	{Opt_noheap, "no_heap"},
-	{Opt_heap, "heap"},
-	{Opt_user_xattr, "user_xattr"},
-	{Opt_nouser_xattr, "nouser_xattr"},
-	{Opt_acl, "acl"},
-	{Opt_noacl, "noacl"},
-	{Opt_active_logs, "active_logs=%u"},
-	{Opt_disable_ext_identify, "disable_ext_identify"},
-	{Opt_inline_xattr, "inline_xattr"},
-	{Opt_noinline_xattr, "noinline_xattr"},
-	{Opt_inline_xattr_size, "inline_xattr_size=%u"},
-	{Opt_inline_data, "inline_data"},
-	{Opt_inline_dentry, "inline_dentry"},
-	{Opt_noinline_dentry, "noinline_dentry"},
-	{Opt_flush_merge, "flush_merge"},
-	{Opt_noflush_merge, "noflush_merge"},
-	{Opt_barrier, "barrier"},
-	{Opt_nobarrier, "nobarrier"},
-	{Opt_fastboot, "fastboot"},
-	{Opt_extent_cache, "extent_cache"},
-	{Opt_noextent_cache, "noextent_cache"},
-	{Opt_noinline_data, "noinline_data"},
-	{Opt_data_flush, "data_flush"},
-	{Opt_reserve_root, "reserve_root=%u"},
-	{Opt_resgid, "resgid=%u"},
-	{Opt_resuid, "resuid=%u"},
-	{Opt_mode, "mode=%s"},
-	{Opt_fault_injection, "fault_injection=%u"},
-	{Opt_fault_type, "fault_type=%u"},
-	{Opt_quota, "quota"},
-	{Opt_noquota, "noquota"},
-	{Opt_usrquota, "usrquota"},
-	{Opt_grpquota, "grpquota"},
-	{Opt_prjquota, "prjquota"},
-	{Opt_usrjquota, "usrjquota=%s"},
-	{Opt_grpjquota, "grpjquota=%s"},
-	{Opt_prjjquota, "prjjquota=%s"},
-	{Opt_offusrjquota, "usrjquota="},
-	{Opt_offgrpjquota, "grpjquota="},
-	{Opt_offprjjquota, "prjjquota="},
-	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
-	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
-	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
-	{Opt_alloc, "alloc_mode=%s"},
-	{Opt_fsync, "fsync_mode=%s"},
-	{Opt_test_dummy_encryption, "test_dummy_encryption=%s"},
-	{Opt_test_dummy_encryption, "test_dummy_encryption"},
-	{Opt_inlinecrypt, "inlinecrypt"},
-	{Opt_checkpoint_disable, "checkpoint=disable"},
-	{Opt_checkpoint_disable_cap, "checkpoint=disable:%u"},
-	{Opt_checkpoint_disable_cap_perc, "checkpoint=disable:%u%%"},
-	{Opt_checkpoint_enable, "checkpoint=enable"},
-	{Opt_checkpoint_merge, "checkpoint_merge"},
-	{Opt_nocheckpoint_merge, "nocheckpoint_merge"},
-	{Opt_compress_algorithm, "compress_algorithm=%s"},
-	{Opt_compress_log_size, "compress_log_size=%u"},
-	{Opt_compress_extension, "compress_extension=%s"},
-	{Opt_nocompress_extension, "nocompress_extension=%s"},
-	{Opt_compress_chksum, "compress_chksum"},
-	{Opt_compress_mode, "compress_mode=%s"},
-	{Opt_compress_cache, "compress_cache"},
-	{Opt_atgc, "atgc"},
-	{Opt_gc_merge, "gc_merge"},
-	{Opt_nogc_merge, "nogc_merge"},
-	{Opt_discard_unit, "discard_unit=%s"},
-	{Opt_memory_mode, "memory=%s"},
-	{Opt_age_extent_cache, "age_extent_cache"},
-	{Opt_errors, "errors=%s"},
-	{Opt_err, NULL},
-};
-
 #define F2FS_SPEC_background_gc			(1 << 0)
 #define F2FS_SPEC_inline_xattr_size		(1 << 1)
 #define F2FS_SPEC_active_logs			(1 << 2)
@@ -533,59 +456,6 @@ static void init_once(void *foo)
 #ifdef CONFIG_QUOTA
 static const char * const quotatypes[] = INITQFNAMES;
 #define QTYPE2NAME(t) (quotatypes[t])
-static int f2fs_set_qf_name(struct super_block *sb, int qtype,
-			    struct fs_parameter *param)
-{
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	char *qname;
-	int ret = -EINVAL;
-
-	if (sb_any_quota_loaded(sb) && !F2FS_OPTION(sbi).s_qf_names[qtype]) {
-		f2fs_err(sbi, "Cannot change journaled quota options when quota turned on");
-		return -EINVAL;
-	}
-	if (f2fs_sb_has_quota_ino(sbi)) {
-		f2fs_info(sbi, "QUOTA feature is enabled, so ignore qf_name");
-		return 0;
-	}
-
-	qname = kmemdup_nul(param->string, param->size, GFP_KERNEL);
-	if (!qname) {
-		f2fs_err(sbi, "Not enough memory for storing quotafile name");
-		return -ENOMEM;
-	}
-	if (F2FS_OPTION(sbi).s_qf_names[qtype]) {
-		if (strcmp(F2FS_OPTION(sbi).s_qf_names[qtype], qname) == 0)
-			ret = 0;
-		else
-			f2fs_err(sbi, "%s quota file already specified",
-				 QTYPE2NAME(qtype));
-		goto errout;
-	}
-	if (strchr(qname, '/')) {
-		f2fs_err(sbi, "quotafile must be on filesystem root");
-		goto errout;
-	}
-	F2FS_OPTION(sbi).s_qf_names[qtype] = qname;
-	set_opt(sbi, QUOTA);
-	return 0;
-errout:
-	kfree(qname);
-	return ret;
-}
-
-static int f2fs_clear_qf_name(struct super_block *sb, int qtype)
-{
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-
-	if (sb_any_quota_loaded(sb) && F2FS_OPTION(sbi).s_qf_names[qtype]) {
-		f2fs_err(sbi, "Cannot change journaled quota options when quota turned on");
-		return -EINVAL;
-	}
-	kfree(F2FS_OPTION(sbi).s_qf_names[qtype]);
-	F2FS_OPTION(sbi).s_qf_names[qtype] = NULL;
-	return 0;
-}
 
 /*
  * Note the name of the specified quota file.
@@ -637,50 +507,6 @@ static int f2fs_unnote_qf_name(struct fs_context *fc, int qtype)
 	return 0;
 }
 
-static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
-{
-	/*
-	 * We do the test below only for project quotas. 'usrquota' and
-	 * 'grpquota' mount options are allowed even without quota feature
-	 * to support legacy quotas in quota files.
-	 */
-	if (test_opt(sbi, PRJQUOTA) && !f2fs_sb_has_project_quota(sbi)) {
-		f2fs_err(sbi, "Project quota feature not enabled. Cannot enable project quota enforcement.");
-		return -1;
-	}
-	if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
-			F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
-			F2FS_OPTION(sbi).s_qf_names[PRJQUOTA]) {
-		if (test_opt(sbi, USRQUOTA) &&
-				F2FS_OPTION(sbi).s_qf_names[USRQUOTA])
-			clear_opt(sbi, USRQUOTA);
-
-		if (test_opt(sbi, GRPQUOTA) &&
-				F2FS_OPTION(sbi).s_qf_names[GRPQUOTA])
-			clear_opt(sbi, GRPQUOTA);
-
-		if (test_opt(sbi, PRJQUOTA) &&
-				F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
-			clear_opt(sbi, PRJQUOTA);
-
-		if (test_opt(sbi, GRPQUOTA) || test_opt(sbi, USRQUOTA) ||
-				test_opt(sbi, PRJQUOTA)) {
-			f2fs_err(sbi, "old and new quota format mixing");
-			return -1;
-		}
-
-		if (!F2FS_OPTION(sbi).s_jquota_fmt) {
-			f2fs_err(sbi, "journaled quota format not specified");
-			return -1;
-		}
-	}
-
-	if (f2fs_sb_has_quota_ino(sbi) && F2FS_OPTION(sbi).s_jquota_fmt) {
-		f2fs_info(sbi, "QUOTA feature is enabled, so ignore jquota_fmt");
-		F2FS_OPTION(sbi).s_jquota_fmt = 0;
-	}
-	return 0;
-}
 #endif
 
 static int f2fs_parse_test_dummy_encryption(const struct fs_parameter *param,
@@ -708,53 +534,6 @@ static int f2fs_parse_test_dummy_encryption(const struct fs_parameter *param,
 	return 0;
 }
 
-static int f2fs_set_test_dummy_encryption(struct super_block *sb,
-					  const struct fs_parameter *param,
-					  bool is_remount)
-{
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	struct fscrypt_dummy_policy *policy =
-		&F2FS_OPTION(sbi).dummy_enc_policy;
-	int err;
-
-	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION)) {
-		f2fs_warn(sbi, "test_dummy_encryption option not supported");
-		return -EINVAL;
-	}
-
-	if (!f2fs_sb_has_encrypt(sbi)) {
-		f2fs_err(sbi, "Encrypt feature is off");
-		return -EINVAL;
-	}
-
-	/*
-	 * This mount option is just for testing, and it's not worthwhile to
-	 * implement the extra complexity (e.g. RCU protection) that would be
-	 * needed to allow it to be set or changed during remount.  We do allow
-	 * it to be specified during remount, but only if there is no change.
-	 */
-	if (is_remount && !fscrypt_is_dummy_policy_set(policy)) {
-		f2fs_warn(sbi, "Can't set test_dummy_encryption on remount");
-		return -EINVAL;
-	}
-
-	err = fscrypt_parse_test_dummy_encryption(param, policy);
-	if (err) {
-		if (err == -EEXIST)
-			f2fs_warn(sbi,
-				  "Can't change test_dummy_encryption on remount");
-		else if (err == -EINVAL)
-			f2fs_warn(sbi, "Value of option \"%s\" is unrecognized",
-				  param->key);
-		else
-			f2fs_warn(sbi, "Error processing option \"%s\" [%d]",
-				  param->key, err);
-		return -EINVAL;
-	}
-	f2fs_warn(sbi, "Test dummy encryption mode enabled");
-	return 0;
-}
-
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 static bool is_compress_extension_exist(struct f2fs_mount_info *info,
 					const char *new_ext, bool is_ext)
@@ -1512,49 +1291,6 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
-static int parse_options(struct fs_context *fc, char *options)
-{
-	struct fs_parameter param;
-	char *key;
-	int ret;
-
-	if (!options)
-		goto default_check;
-
-	while ((key = strsep(&options, ",")) != NULL) {
-		if (*key) {
-			size_t v_len = 0;
-			char *value = strchr(key, '=');
-
-			param.type = fs_value_is_flag;
-			param.string = NULL;
-
-			if (value) {
-				if (value == key)
-					continue;
-
-				*value++ = 0;
-				v_len = strlen(value);
-				param.string = kmemdup_nul(value, v_len, GFP_KERNEL);
-				if (!param.string)
-					return -ENOMEM;
-				param.type = fs_value_is_string;
-			}
-
-			param.key = key;
-			param.size = v_len;
-
-			ret = f2fs_parse_param(fc, &param);
-			kfree(param.string);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
-default_check:
-	return f2fs_validate_options(fc);
-}
-
 static int f2fs_validate_options(struct fs_context *fc)
 {
 #ifdef CONFIG_QUOTA
-- 
2.34.1


