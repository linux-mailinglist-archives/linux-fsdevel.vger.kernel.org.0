Return-Path: <linux-fsdevel+bounces-32574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56569A96E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418881F26822
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187A1A262A;
	Tue, 22 Oct 2024 03:13:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF31FF610;
	Tue, 22 Oct 2024 03:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566793; cv=none; b=LEY58rP5XRWV2NK18nV57dMPewcES4ZLFDaKSywcRejE2Zuu5R+qpZ/NS9CsRD95E+rY+Z6l/PYcUYNAkjOAmiN8E3f0Mqc14dm9qLLBjUvOJFGJs6laBH5NYXY87DFEdqDomlPc8ZOVHrvWH4TkmZRaRmB6qjL/dwW7MyVMX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566793; c=relaxed/simple;
	bh=uaagAkzcaigmaepALuH8W84E4x3TWY8c1iyfP0Yfel4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYlOyQ+u6NTrw10cm1rNGGoaHqPGEHVok8Y31AlRYH5ZV5dfhEmd0jGZMJm021tUMXeEK5itVEct6uiDMD4xI3HhsTaA0H9ujSXRcm0DYQkwpN3wHmQ3gQrLpyCoPO0zEB7dSM4vg8KPSv+zs0oqeiSVSnefcDFK3ajB/p3PLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcgM4RVxz4f3lVv;
	Tue, 22 Oct 2024 11:12:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C054D1A018C;
	Tue, 22 Oct 2024 11:13:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S30;
	Tue, 22 Oct 2024 11:13:05 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 26/27] ext4: change mount options code style
Date: Tue, 22 Oct 2024 19:10:57 +0800
Message-ID: <20241022111059.2566137-27-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S30
X-Coremail-Antispam: 1UD129KBjvJXoWfJw17urW3Wr1fAF1UXw13urg_yoWDAr1kpr
	18JFW3u3Z8JrWku3W0kF48tw4FvrnY9r4vyrn8CF17Kw1qyry8XFyIgFyxA3W3t34rZ34r
	KFn0va45Ca17GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
	8v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRio7uDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Just remove the space between the macro name and open parenthesis to
satisfy the checkpatch.pl script and prevent it from complaining when we
add new mount options in the subsequent patch. This will not result in
any logical changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 175 +++++++++++++++++++++++-------------------------
 1 file changed, 84 insertions(+), 91 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 56baadec27e0..89955081c4fe 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1723,101 +1723,94 @@ static const struct constant_table ext4_param_dax[] = {
  * separate for now.
  */
 static const struct fs_parameter_spec ext4_param_specs[] = {
-	fsparam_flag	("bsddf",		Opt_bsd_df),
-	fsparam_flag	("minixdf",		Opt_minix_df),
-	fsparam_flag	("grpid",		Opt_grpid),
-	fsparam_flag	("bsdgroups",		Opt_grpid),
-	fsparam_flag	("nogrpid",		Opt_nogrpid),
-	fsparam_flag	("sysvgroups",		Opt_nogrpid),
-	fsparam_gid	("resgid",		Opt_resgid),
-	fsparam_uid	("resuid",		Opt_resuid),
-	fsparam_u32	("sb",			Opt_sb),
-	fsparam_enum	("errors",		Opt_errors, ext4_param_errors),
-	fsparam_flag	("nouid32",		Opt_nouid32),
-	fsparam_flag	("debug",		Opt_debug),
-	fsparam_flag	("oldalloc",		Opt_removed),
-	fsparam_flag	("orlov",		Opt_removed),
-	fsparam_flag	("user_xattr",		Opt_user_xattr),
-	fsparam_flag	("acl",			Opt_acl),
-	fsparam_flag	("norecovery",		Opt_noload),
-	fsparam_flag	("noload",		Opt_noload),
-	fsparam_flag	("bh",			Opt_removed),
-	fsparam_flag	("nobh",		Opt_removed),
-	fsparam_u32	("commit",		Opt_commit),
-	fsparam_u32	("min_batch_time",	Opt_min_batch_time),
-	fsparam_u32	("max_batch_time",	Opt_max_batch_time),
-	fsparam_u32	("journal_dev",		Opt_journal_dev),
-	fsparam_bdev	("journal_path",	Opt_journal_path),
-	fsparam_flag	("journal_checksum",	Opt_journal_checksum),
-	fsparam_flag	("nojournal_checksum",	Opt_nojournal_checksum),
-	fsparam_flag	("journal_async_commit",Opt_journal_async_commit),
-	fsparam_flag	("abort",		Opt_abort),
-	fsparam_enum	("data",		Opt_data, ext4_param_data),
-	fsparam_enum	("data_err",		Opt_data_err,
+	fsparam_flag("bsddf",			Opt_bsd_df),
+	fsparam_flag("minixdf",			Opt_minix_df),
+	fsparam_flag("grpid",			Opt_grpid),
+	fsparam_flag("bsdgroups",		Opt_grpid),
+	fsparam_flag("nogrpid",			Opt_nogrpid),
+	fsparam_flag("sysvgroups",		Opt_nogrpid),
+	fsparam_gid("resgid",			Opt_resgid),
+	fsparam_uid("resuid",			Opt_resuid),
+	fsparam_u32("sb",			Opt_sb),
+	fsparam_enum("errors",			Opt_errors, ext4_param_errors),
+	fsparam_flag("nouid32",			Opt_nouid32),
+	fsparam_flag("debug",			Opt_debug),
+	fsparam_flag("oldalloc",		Opt_removed),
+	fsparam_flag("orlov",			Opt_removed),
+	fsparam_flag("user_xattr",		Opt_user_xattr),
+	fsparam_flag("acl",			Opt_acl),
+	fsparam_flag("norecovery",		Opt_noload),
+	fsparam_flag("noload",			Opt_noload),
+	fsparam_flag("bh",			Opt_removed),
+	fsparam_flag("nobh",			Opt_removed),
+	fsparam_u32("commit",			Opt_commit),
+	fsparam_u32("min_batch_time",		Opt_min_batch_time),
+	fsparam_u32("max_batch_time",		Opt_max_batch_time),
+	fsparam_u32("journal_dev",		Opt_journal_dev),
+	fsparam_bdev("journal_path",		Opt_journal_path),
+	fsparam_flag("journal_checksum",	Opt_journal_checksum),
+	fsparam_flag("nojournal_checksum",	Opt_nojournal_checksum),
+	fsparam_flag("journal_async_commit",	Opt_journal_async_commit),
+	fsparam_flag("abort",			Opt_abort),
+	fsparam_enum("data",			Opt_data, ext4_param_data),
+	fsparam_enum("data_err",		Opt_data_err,
 						ext4_param_data_err),
-	fsparam_string_empty
-			("usrjquota",		Opt_usrjquota),
-	fsparam_string_empty
-			("grpjquota",		Opt_grpjquota),
-	fsparam_enum	("jqfmt",		Opt_jqfmt, ext4_param_jqfmt),
-	fsparam_flag	("grpquota",		Opt_grpquota),
-	fsparam_flag	("quota",		Opt_quota),
-	fsparam_flag	("noquota",		Opt_noquota),
-	fsparam_flag	("usrquota",		Opt_usrquota),
-	fsparam_flag	("prjquota",		Opt_prjquota),
-	fsparam_flag	("barrier",		Opt_barrier),
-	fsparam_u32	("barrier",		Opt_barrier),
-	fsparam_flag	("nobarrier",		Opt_nobarrier),
-	fsparam_flag	("i_version",		Opt_removed),
-	fsparam_flag	("dax",			Opt_dax),
-	fsparam_enum	("dax",			Opt_dax_type, ext4_param_dax),
-	fsparam_u32	("stripe",		Opt_stripe),
-	fsparam_flag	("delalloc",		Opt_delalloc),
-	fsparam_flag	("nodelalloc",		Opt_nodelalloc),
-	fsparam_flag	("warn_on_error",	Opt_warn_on_error),
-	fsparam_flag	("nowarn_on_error",	Opt_nowarn_on_error),
-	fsparam_u32	("debug_want_extra_isize",
-						Opt_debug_want_extra_isize),
-	fsparam_flag	("mblk_io_submit",	Opt_removed),
-	fsparam_flag	("nomblk_io_submit",	Opt_removed),
-	fsparam_flag	("block_validity",	Opt_block_validity),
-	fsparam_flag	("noblock_validity",	Opt_noblock_validity),
-	fsparam_u32	("inode_readahead_blks",
-						Opt_inode_readahead_blks),
-	fsparam_u32	("journal_ioprio",	Opt_journal_ioprio),
-	fsparam_u32	("auto_da_alloc",	Opt_auto_da_alloc),
-	fsparam_flag	("auto_da_alloc",	Opt_auto_da_alloc),
-	fsparam_flag	("noauto_da_alloc",	Opt_noauto_da_alloc),
-	fsparam_flag	("dioread_nolock",	Opt_dioread_nolock),
-	fsparam_flag	("nodioread_nolock",	Opt_dioread_lock),
-	fsparam_flag	("dioread_lock",	Opt_dioread_lock),
-	fsparam_flag	("discard",		Opt_discard),
-	fsparam_flag	("nodiscard",		Opt_nodiscard),
-	fsparam_u32	("init_itable",		Opt_init_itable),
-	fsparam_flag	("init_itable",		Opt_init_itable),
-	fsparam_flag	("noinit_itable",	Opt_noinit_itable),
+	fsparam_string_empty("usrjquota",	Opt_usrjquota),
+	fsparam_string_empty("grpjquota",	Opt_grpjquota),
+	fsparam_enum("jqfmt",			Opt_jqfmt, ext4_param_jqfmt),
+	fsparam_flag("grpquota",		Opt_grpquota),
+	fsparam_flag("quota",			Opt_quota),
+	fsparam_flag("noquota",			Opt_noquota),
+	fsparam_flag("usrquota",		Opt_usrquota),
+	fsparam_flag("prjquota",		Opt_prjquota),
+	fsparam_flag("barrier",			Opt_barrier),
+	fsparam_u32("barrier",			Opt_barrier),
+	fsparam_flag("nobarrier",		Opt_nobarrier),
+	fsparam_flag("i_version",		Opt_removed),
+	fsparam_flag("dax",			Opt_dax),
+	fsparam_enum("dax",			Opt_dax_type, ext4_param_dax),
+	fsparam_u32("stripe",			Opt_stripe),
+	fsparam_flag("delalloc",		Opt_delalloc),
+	fsparam_flag("nodelalloc",		Opt_nodelalloc),
+	fsparam_flag("warn_on_error",		Opt_warn_on_error),
+	fsparam_flag("nowarn_on_error",		Opt_nowarn_on_error),
+	fsparam_u32("debug_want_extra_isize",	Opt_debug_want_extra_isize),
+	fsparam_flag("mblk_io_submit",		Opt_removed),
+	fsparam_flag("nomblk_io_submit",	Opt_removed),
+	fsparam_flag("block_validity",		Opt_block_validity),
+	fsparam_flag("noblock_validity",	Opt_noblock_validity),
+	fsparam_u32("inode_readahead_blks",	Opt_inode_readahead_blks),
+	fsparam_u32("journal_ioprio",		Opt_journal_ioprio),
+	fsparam_u32("auto_da_alloc",		Opt_auto_da_alloc),
+	fsparam_flag("auto_da_alloc",		Opt_auto_da_alloc),
+	fsparam_flag("noauto_da_alloc",		Opt_noauto_da_alloc),
+	fsparam_flag("dioread_nolock",		Opt_dioread_nolock),
+	fsparam_flag("nodioread_nolock",	Opt_dioread_lock),
+	fsparam_flag("dioread_lock",		Opt_dioread_lock),
+	fsparam_flag("discard",			Opt_discard),
+	fsparam_flag("nodiscard",		Opt_nodiscard),
+	fsparam_u32("init_itable",		Opt_init_itable),
+	fsparam_flag("init_itable",		Opt_init_itable),
+	fsparam_flag("noinit_itable",		Opt_noinit_itable),
 #ifdef CONFIG_EXT4_DEBUG
-	fsparam_flag	("fc_debug_force",	Opt_fc_debug_force),
-	fsparam_u32	("fc_debug_max_replay",	Opt_fc_debug_max_replay),
+	fsparam_flag("fc_debug_force",		Opt_fc_debug_force),
+	fsparam_u32("fc_debug_max_replay",	Opt_fc_debug_max_replay),
 #endif
-	fsparam_u32	("max_dir_size_kb",	Opt_max_dir_size_kb),
-	fsparam_flag	("test_dummy_encryption",
-						Opt_test_dummy_encryption),
-	fsparam_string	("test_dummy_encryption",
-						Opt_test_dummy_encryption),
-	fsparam_flag	("inlinecrypt",		Opt_inlinecrypt),
-	fsparam_flag	("nombcache",		Opt_nombcache),
-	fsparam_flag	("no_mbcache",		Opt_nombcache),	/* for backward compatibility */
-	fsparam_flag	("prefetch_block_bitmaps",
-						Opt_removed),
-	fsparam_flag	("no_prefetch_block_bitmaps",
+	fsparam_u32("max_dir_size_kb",		Opt_max_dir_size_kb),
+	fsparam_flag("test_dummy_encryption",	Opt_test_dummy_encryption),
+	fsparam_string("test_dummy_encryption",	Opt_test_dummy_encryption),
+	fsparam_flag("inlinecrypt",		Opt_inlinecrypt),
+	fsparam_flag("nombcache",		Opt_nombcache),
+	fsparam_flag("no_mbcache",		Opt_nombcache),	/* for backward compatibility */
+	fsparam_flag("prefetch_block_bitmaps",	Opt_removed),
+	fsparam_flag("no_prefetch_block_bitmaps",
 						Opt_no_prefetch_block_bitmaps),
-	fsparam_s32	("mb_optimize_scan",	Opt_mb_optimize_scan),
-	fsparam_string	("check",		Opt_removed),	/* mount option from ext2/3 */
-	fsparam_flag	("nocheck",		Opt_removed),	/* mount option from ext2/3 */
-	fsparam_flag	("reservation",		Opt_removed),	/* mount option from ext2/3 */
-	fsparam_flag	("noreservation",	Opt_removed),	/* mount option from ext2/3 */
-	fsparam_u32	("journal",		Opt_removed),	/* mount option from ext2/3 */
+	fsparam_s32("mb_optimize_scan",		Opt_mb_optimize_scan),
+	fsparam_string("check",			Opt_removed),	/* mount option from ext2/3 */
+	fsparam_flag("nocheck",			Opt_removed),	/* mount option from ext2/3 */
+	fsparam_flag("reservation",		Opt_removed),	/* mount option from ext2/3 */
+	fsparam_flag("noreservation",		Opt_removed),	/* mount option from ext2/3 */
+	fsparam_u32("journal",			Opt_removed),	/* mount option from ext2/3 */
 	{}
 };
 
-- 
2.46.1


