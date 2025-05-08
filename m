Return-Path: <linux-fsdevel+bounces-48437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32910AAF133
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 04:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3641E4C5D6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 02:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53B1DDA09;
	Thu,  8 May 2025 02:40:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416132CA9
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746672018; cv=none; b=h9adBiHVydh2TsdHBeWj7IQvvLPHdfceSc95deRk5WL/6ANQMXPIJEjjD5B5uKGd6LZ9Njpfr1CLc8Z4LZIAVX50TB87eyQ+I2pRQ2UoFQudil1UzmB0NOhMfZMZa8F0ySRlgb8pCBjARDwSxU06jDS9eRbCiFcqKawSpP4SUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746672018; c=relaxed/simple;
	bh=+hrO2xkMlure1snfwvyc257mVMLZMjwaIn2J5A7q6rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bnBC6Ij4wP5/tfssJ0vzmu60YgV3v+wfyWRjATl0sGRylMM0u9QYgujm8sxL++ND1Kuw2wek+5VMVlhD2VZlU7etPL/jT2buIQA2x0LZCxiu8hwW/rq/GZzKUFm8qNCwFyToTYYJpLJUTwzqR0TXYFBGPgoxRkCC10j9Xz1K9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZtGXk2Jynz13Lc6;
	Thu,  8 May 2025 10:38:46 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 57CE71400E3;
	Thu,  8 May 2025 10:40:04 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 May 2025 10:40:03 +0800
Message-ID: <6c3c7e74-b85b-44df-801b-b37845791051@huawei.com>
Date: Thu, 8 May 2025 10:40:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/7] f2fs: Add fs parameter specifications for mount
 options
To: Eric Sandeen <sandeen@redhat.com>,
	<linux-f2fs-devel@lists.sourceforge.net>
CC: <linux-fsdevel@vger.kernel.org>, <jaegeuk@kernel.org>, <chao@kernel.org>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-2-sandeen@redhat.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250423170926.76007-2-sandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/4/24 1:08, Eric Sandeen wrote:
> From: Hongbo Li <lihongbo22@huawei.com>
> 
> Use an array of `fs_parameter_spec` called f2fs_param_specs to
> hold the mount option specifications for the new mount api.
> 
> Add constant_table structures for several options to facilitate
> parsing.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> [sandeen: forward port, minor fixes and updates, more fsparam_enum]
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Thanks, I have checked this.
Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

> ---
>   fs/f2fs/super.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 122 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 22f26871b7aa..ebea03bba054 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -27,6 +27,7 @@
>   #include <linux/part_stat.h>
>   #include <linux/zstd.h>
>   #include <linux/lz4.h>
> +#include <linux/fs_parser.h>
>   
>   #include "f2fs.h"
>   #include "node.h"
> @@ -194,9 +195,130 @@ enum {
>   	Opt_age_extent_cache,
>   	Opt_errors,
>   	Opt_nat_bits,
> +	Opt_jqfmt,
> +	Opt_checkpoint,
>   	Opt_err,
>   };
>   
> +static const struct constant_table f2fs_param_background_gc[] = {
> +	{"on",		BGGC_MODE_ON},
> +	{"off",		BGGC_MODE_OFF},
> +	{"sync",	BGGC_MODE_SYNC},
> +	{}
> +};
> +
> +static const struct constant_table f2fs_param_mode[] = {
> +	{"adaptive",		FS_MODE_ADAPTIVE},
> +	{"lfs",			FS_MODE_LFS},
> +	{"fragment:segment",	FS_MODE_FRAGMENT_SEG},
> +	{"fragment:block",	FS_MODE_FRAGMENT_BLK},
> +	{}
> +};
> +
> +static const struct constant_table f2fs_param_jqfmt[] = {
> +	{"vfsold",	QFMT_VFS_OLD},
> +	{"vfsv0",	QFMT_VFS_V0},
> +	{"vfsv1",	QFMT_VFS_V1},
> +	{}
> +};
> +
> +static const struct constant_table f2fs_param_alloc_mode[] = {
> +	{"default",	ALLOC_MODE_DEFAULT},
> +	{"reuse",	ALLOC_MODE_REUSE},
> +	{}
> +};
> +static const struct constant_table f2fs_param_fsync_mode[] = {
> +	{"posix",	FSYNC_MODE_POSIX},
> +	{"strict",	FSYNC_MODE_STRICT},
> +	{"nobarrier",	FSYNC_MODE_NOBARRIER},
> +	{}
> +};
> +
> +static const struct constant_table f2fs_param_compress_mode[] = {
> +	{"fs",		COMPR_MODE_FS},
> +	{"user",	COMPR_MODE_USER},
> +	{}
> +};
> +
> +static const struct constant_table f2fs_param_discard_unit[] = {
> +	{"block",	DISCARD_UNIT_BLOCK},
> +	{"segment",	DISCARD_UNIT_SEGMENT},
> +	{"section",	DISCARD_UNIT_SECTION},
> +	{}
> +};
> +
> +static const struct constant_table f2fs_param_memory_mode[] = {
> +	{"normal",	MEMORY_MODE_NORMAL},
> +	{"low",		MEMORY_MODE_LOW},
> +	{}
> +};
> +
> +static const struct constant_table f2fs_param_errors[] = {
> +	{"remount-ro",	MOUNT_ERRORS_READONLY},
> +	{"continue",	MOUNT_ERRORS_CONTINUE},
> +	{"panic",	MOUNT_ERRORS_PANIC},
> +	{}
> +};
> +
> +static const struct fs_parameter_spec f2fs_param_specs[] = {
> +	fsparam_enum("background_gc", Opt_gc_background, f2fs_param_background_gc),
> +	fsparam_flag("disable_roll_forward", Opt_disable_roll_forward),
> +	fsparam_flag("norecovery", Opt_norecovery),
> +	fsparam_flag_no("discard", Opt_discard),
> +	fsparam_flag("no_heap", Opt_noheap),
> +	fsparam_flag("heap", Opt_heap),
> +	fsparam_flag_no("user_xattr", Opt_user_xattr),
> +	fsparam_flag_no("acl", Opt_acl),
> +	fsparam_s32("active_logs", Opt_active_logs),
> +	fsparam_flag("disable_ext_identify", Opt_disable_ext_identify),
> +	fsparam_flag_no("inline_xattr", Opt_inline_xattr),
> +	fsparam_s32("inline_xattr_size", Opt_inline_xattr_size),
> +	fsparam_flag_no("inline_data", Opt_inline_data),
> +	fsparam_flag_no("inline_dentry", Opt_inline_dentry),
> +	fsparam_flag_no("flush_merge", Opt_flush_merge),
> +	fsparam_flag_no("barrier", Opt_barrier),
> +	fsparam_flag("fastboot", Opt_fastboot),
> +	fsparam_flag_no("extent_cache", Opt_extent_cache),
> +	fsparam_flag("data_flush", Opt_data_flush),
> +	fsparam_u32("reserve_root", Opt_reserve_root),
> +	fsparam_gid("resgid", Opt_resgid),
> +	fsparam_uid("resuid", Opt_resuid),
> +	fsparam_enum("mode", Opt_mode, f2fs_param_mode),
> +	fsparam_s32("fault_injection", Opt_fault_injection),
> +	fsparam_u32("fault_type", Opt_fault_type),
> +	fsparam_flag_no("lazytime", Opt_lazytime),
> +	fsparam_flag_no("quota", Opt_quota),
> +	fsparam_flag("usrquota", Opt_usrquota),
> +	fsparam_flag("grpquota", Opt_grpquota),
> +	fsparam_flag("prjquota", Opt_prjquota),
> +	fsparam_string_empty("usrjquota", Opt_usrjquota),
> +	fsparam_string_empty("grpjquota", Opt_grpjquota),
> +	fsparam_string_empty("prjjquota", Opt_prjjquota),
> +	fsparam_flag("nat_bits", Opt_nat_bits),
> +	fsparam_enum("jqfmt", Opt_jqfmt, f2fs_param_jqfmt),
> +	fsparam_enum("alloc_mode", Opt_alloc, f2fs_param_alloc_mode),
> +	fsparam_enum("fsync_mode", Opt_fsync, f2fs_param_fsync_mode),
> +	fsparam_string("test_dummy_encryption", Opt_test_dummy_encryption),
> +	fsparam_flag("test_dummy_encryption", Opt_test_dummy_encryption),
> +	fsparam_flag("inlinecrypt", Opt_inlinecrypt),
> +	fsparam_string("checkpoint", Opt_checkpoint),
> +	fsparam_flag_no("checkpoint_merge", Opt_checkpoint_merge),
> +	fsparam_string("compress_algorithm", Opt_compress_algorithm),
> +	fsparam_u32("compress_log_size", Opt_compress_log_size),
> +	fsparam_string("compress_extension", Opt_compress_extension),
> +	fsparam_string("nocompress_extension", Opt_nocompress_extension),
> +	fsparam_flag("compress_chksum", Opt_compress_chksum),
> +	fsparam_enum("compress_mode", Opt_compress_mode, f2fs_param_compress_mode),
> +	fsparam_flag("compress_cache", Opt_compress_cache),
> +	fsparam_flag("atgc", Opt_atgc),
> +	fsparam_flag_no("gc_merge", Opt_gc_merge),
> +	fsparam_enum("discard_unit", Opt_discard_unit, f2fs_param_discard_unit),
> +	fsparam_enum("memory", Opt_memory_mode, f2fs_param_memory_mode),
> +	fsparam_flag("age_extent_cache", Opt_age_extent_cache),
> +	fsparam_enum("errors", Opt_errors, f2fs_param_errors),
> +	{}
> +};
> +
>   static match_table_t f2fs_tokens = {
>   	{Opt_gc_background, "background_gc=%s"},
>   	{Opt_disable_roll_forward, "disable_roll_forward"},

