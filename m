Return-Path: <linux-fsdevel+bounces-11057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F9285079B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 03:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B963284637
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 02:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECA0186A;
	Sun, 11 Feb 2024 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="AYeJSuW7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MmeTiDyd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142817CF
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707616887; cv=none; b=Hec7uyeRseSXgJ4xOTqVP2VbVNWTZSvKUH8NyaWSyB1roQsDbXzRmnszlpoHL33OF7DOaV1OAi/wzACGR5ex2CBOLE4TCtm3cWMXJVeDEvpypMpLisMtTp2EvC2YFVwPuX83Qqt1Wg57rdL0JBlqQYBukkvz1aQq67RV4/50mOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707616887; c=relaxed/simple;
	bh=eRSk9f4xeAI9I/8fkmhr1sVJzCfASLPP/H94AK0fneI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwLl+3dusmBOuAmNkrTKYYjOtPBWD3SlsFIxQ0zabs65xWpopicgxgXliMVNyzAc0ZDj/bzhMwQZbgRa3WGzAh5BVqhax7HQ/5DNxFm3ALjhpcP7Jn7b/GtxSFRN4i9Apn6l0HKNQWi847WyF+p468LIZHpOBhNStmyiCXHlQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=AYeJSuW7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MmeTiDyd; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id DC6E95C0091;
	Sat, 10 Feb 2024 21:01:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 10 Feb 2024 21:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1707616883;
	 x=1707703283; bh=GGXtpehi/7FqCv0uC+/87Om89K20ci/IkKNyGjrLjqI=; b=
	AYeJSuW7Ap9RbCAfjeaJ7fMcJf9n/YZkiFrzo37y5WXqrXWw9lmgFSoaFuEPgaVJ
	BN2CScnfBl+XgWoIRenjV7JpKQu2q6VdPDmsp1ehxKRc199M13Hvvn8L7hn9pLwJ
	DbvvgihRRib+RnQ7rFyu2jv11ePoUocrcJHJepRVF2GZa9G2RPYPKVc0sKOa+sgQ
	UpN8kA8VatW4yrISMb+XIy2kc6kgH0+PSmJ6L2svdUf2PiIj2cdGiegbWepjZJO+
	p1n910O8W5CeDeiJe9X9v2r4PbxilXcL1Z/MhGydt2wV3Sl+UhoKD2v3F2AX59I4
	jwIO6qP5pMH3Svqg5Ofmmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707616883; x=
	1707703283; bh=GGXtpehi/7FqCv0uC+/87Om89K20ci/IkKNyGjrLjqI=; b=M
	meTiDyd0dbD6KrF/Y+zWgW8gh2GAtd7nFh9jEPGornJNkhRjXCG94x08FdgXDcw+
	e3CjJIOb7nRuBgK6jeprXt95MgOOhaup40U5TafLdX+pQBbyt09rHcnUavb6d3US
	pp6SWSrgrt+9l6ggmi/sFJEN+fhJmZg1AI6VS5ihKFFxs/eaD5UfDxZo22uODrhT
	g5BpsEvWNkd9l5qIZAj9oJwiIgYBYbinQ0xqA+8NgEsmHDrKXuyhcC5AV2TluZ0c
	IJhqN92QRmRPbnYUpursXJ9YNVzyqiKSV7opS7seMkNrVe4lULPYEHTBl628i1pA
	3Jh2Goec82B6upYiicz7w==
X-ME-Sender: <xms:cyrIZaX3UTOgHpyPuBYCRkJx_GL4v7qfN2Fw8owpGkOnhCOf0OIO7Q>
    <xme:cyrIZWnLdihaJkprR2cfDN3-VF9B8pFJUN9QlhHm7DDI4lUzhHmOBkgUOIsxHEejv
    AGy9RXcTN92>
X-ME-Received: <xmr:cyrIZeZJgX8IK833AVUbIqKHaq4yol-98gCp2Wj6mT9fnTHlE-CZu2cR_aGdlMUzfZwsTAmQRRpRA5JwIA86EATneiVp0FC3ECNS59GqZBe1R7W-Ih-W73lj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    dvueetuefhjedtueethfehlefgleduveduhedvgeeigeelffefveejgeegveeiueenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:cyrIZRWHXEsvVxC49c2tFzBBGudWHd4r7RD9VQbDbJ4J9UA2c1XrWw>
    <xmx:cyrIZUkmYjFfh5vmsTbPvu8OJCNSR-ItDw33Dp9Dq51ugASVoO5Fow>
    <xmx:cyrIZWd_Yk9L9d9I2q87JC4wAKnoLGquV3zn1k9rooVKhq18Hzowvg>
    <xmx:cyrIZbt9G21ff0f7U7CR9H0yZ26b6pVcXbN8FNioY1dYqog4FBK-7Q>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Feb 2024 21:01:21 -0500 (EST)
Message-ID: <75e24776-e83e-4522-9185-09a2d40bc2b3@themaw.net>
Date: Sun, 11 Feb 2024 10:01:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: convert zonefs to use the new mount api
To: Bill O'Donnell <bodonnel@redhat.com>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
References: <20240209000857.21040-1-bodonnel@redhat.com>
 <54dca606-e67f-4933-b8ca-a5e2095193ae@kernel.org>
 <ZcZZFseicmkgzTwU@redhat.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <ZcZZFseicmkgzTwU@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 00:55, Bill O'Donnell wrote:
> On Fri, Feb 09, 2024 at 11:10:00AM +0900, Damien Le Moal wrote:
>> On 2/9/24 09:08, Bill O'Donnell wrote:
>>> Convert the zonefs filesystem to use the new mount API.
>>> Tested using the zonefs test suite from:
>>> https://github.com/damien-lemoal/zonefs-tools
>>>
>>> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
>> Thanks for doing this. I will run tests on this but I do have a few nits below.
> I will provide a v2 with the changes you suggest, with one exception (please
> see my note within).

First sorry I haven't had time to devote to looking at this just lately.

I'll review the patch here as soon as I can but ...


One thing that I wanted to add about the mount api conversions, not just

this conversion and I'm also guilty of it, is the handling of error returns.


One of the things the mount api is meant to do is provide a way for user 
space

to retrieve error strings from the kernel mount process. Within the current

mount api this is done via macros such as invalfc(), warnfc() et. al. (see

fs_context.h).


But we have seen that using them can also increase the kernel log noise and

can cause surprises for users. On one occasion an NFS user was, it seemed,

unwilling to accept that it was the logging in the NFS mount api change that

caused a new log message and the cause had been there all along. It was this

that caused me to think we will probably need to revisit this after the

conversions because they may need some changes.


Bottom line is I'm not sure we need to care about using these macros, and

they haven't been used here, but maybe they should be to save on further

work later. It's not a simple decision but is worth some thought.


It's probably worth casting a eye over those macros and the log functions

they lead to but please don't worry too much as I expect these will need

some more thought anyway.


Ian

>
>>> ---
>>>   fs/zonefs/super.c | 156 ++++++++++++++++++++++++++--------------------
>>>   1 file changed, 90 insertions(+), 66 deletions(-)
>>>
>>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>>> index e6a75401677d..6b8ecd2e55b8 100644
>>> --- a/fs/zonefs/super.c
>>> +++ b/fs/zonefs/super.c
>>> @@ -15,13 +15,13 @@
>>>   #include <linux/writeback.h>
>>>   #include <linux/quotaops.h>
>>>   #include <linux/seq_file.h>
>>> -#include <linux/parser.h>
>>>   #include <linux/uio.h>
>>>   #include <linux/mman.h>
>>>   #include <linux/sched/mm.h>
>>>   #include <linux/crc32.h>
>>>   #include <linux/task_io_accounting_ops.h>
>>> -
>>> +#include <linux/fs_parser.h>
>>> +#include <linux/fs_context.h>
>> Please keep the whiteline here.
>>
>>>   #include "zonefs.h"
>>>   
>>>   #define CREATE_TRACE_POINTS
>>> @@ -460,58 +460,47 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>>   }
>>>   
>>>   enum {
>>> -	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,
>>> -	Opt_explicit_open, Opt_err,
>>> +	Opt_errors, Opt_explicit_open,
>>>   };
>>>   
>>> -static const match_table_t tokens = {
>>> -	{ Opt_errors_ro,	"errors=remount-ro"},
>>> -	{ Opt_errors_zro,	"errors=zone-ro"},
>>> -	{ Opt_errors_zol,	"errors=zone-offline"},
>>> -	{ Opt_errors_repair,	"errors=repair"},
>>> -	{ Opt_explicit_open,	"explicit-open" },
>>> -	{ Opt_err,		NULL}
>>> +struct zonefs_context {
>>> +	unsigned long s_mount_opts;
>>>   };
>>>   
>>> -static int zonefs_parse_options(struct super_block *sb, char *options)
>>> -{
>>> -	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>>> -	substring_t args[MAX_OPT_ARGS];
>>> -	char *p;
>>> -
>>> -	if (!options)
>>> -		return 0;
>>> -
>>> -	while ((p = strsep(&options, ",")) != NULL) {
>>> -		int token;
>>> +static const struct constant_table zonefs_param_errors[] = {
>>> +	{"remount-ro",		ZONEFS_MNTOPT_ERRORS_RO},
>>> +	{"zone-ro",		ZONEFS_MNTOPT_ERRORS_ZRO},
>>> +	{"zone-offline",	ZONEFS_MNTOPT_ERRORS_ZOL},
>>> +	{"repair", 		ZONEFS_MNTOPT_ERRORS_REPAIR},
>>> +	{}
>>> +};
>>>   
>>> -		if (!*p)
>>> -			continue;
>>> +static const struct fs_parameter_spec zonefs_param_spec[] = {
>>> +	fsparam_enum	("errors",		Opt_errors, zonefs_param_errors),
>>> +	fsparam_flag	("explicit-open",	Opt_explicit_open),
>>> +	{}
>>> +};
>>>   
>>> -		token = match_token(p, tokens, args);
>>> -		switch (token) {
>>> -		case Opt_errors_ro:
>>> -			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
>>> -			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_RO;
>>> -			break;
>>> -		case Opt_errors_zro:
>>> -			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
>>> -			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_ZRO;
>>> -			break;
>>> -		case Opt_errors_zol:
>>> -			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
>>> -			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_ZOL;
>>> -			break;
>>> -		case Opt_errors_repair:
>>> -			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
>>> -			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_REPAIR;
>>> -			break;
>>> -		case Opt_explicit_open:
>>> -			sbi->s_mount_opts |= ZONEFS_MNTOPT_EXPLICIT_OPEN;
>>> -			break;
>>> -		default:
>>> -			return -EINVAL;
>>> -		}
>>> +static int zonefs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>> +{
>>> +	struct zonefs_context *ctx = fc->fs_private;
>>> +	struct fs_parse_result result;
>>> +	int opt;
>>> +
>>> +	opt = fs_parse(fc, zonefs_param_spec, param, &result);
>>> +	if (opt < 0)
>>> +		return opt;
>>> +
>>> +	switch (opt) {
>>> +	case Opt_errors:
>>> +		ctx->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
>>> +		ctx->s_mount_opts |= result.uint_32;
>>> +		break;
>>> +	case Opt_explicit_open:
>>> +		ctx->s_mount_opts |= ZONEFS_MNTOPT_EXPLICIT_OPEN;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>>   	}
>>>   
>>>   	return 0;
>>> @@ -533,11 +522,19 @@ static int zonefs_show_options(struct seq_file *seq, struct dentry *root)
>>>   	return 0;
>>>   }
>>>   
>>> -static int zonefs_remount(struct super_block *sb, int *flags, char *data)
>>> +static int zonefs_get_tree(struct fs_context *fc);
>> Why the forward definition ? It seems that you could define this function here
>> directly.
>>
>>> +
>>> +static int zonefs_reconfigure(struct fs_context *fc)
>>>   {
>>> -	sync_filesystem(sb);
>>> +	struct zonefs_context *ctx = fc->fs_private;
>>> +	struct super_block *sb = fc->root->d_sb;
>>> +	struct zonefs_sb_info *sbi = sb->s_fs_info;
>>>   
>>> -	return zonefs_parse_options(sb, data);
>>> +	sync_filesystem(fc->root->d_sb);
>>> +	/* Copy new options from ctx into sbi. */
>>> +	sbi->s_mount_opts = ctx->s_mount_opts;
>>> +
>>> +	return 0;
>>>   }
>>>   
>>>   static int zonefs_inode_setattr(struct mnt_idmap *idmap,
>>> @@ -1197,7 +1194,6 @@ static const struct super_operations zonefs_sops = {
>>>   	.alloc_inode	= zonefs_alloc_inode,
>>>   	.free_inode	= zonefs_free_inode,
>>>   	.statfs		= zonefs_statfs,
>>> -	.remount_fs	= zonefs_remount,
>>>   	.show_options	= zonefs_show_options,
>>>   };
>>>   
>>> @@ -1242,9 +1238,10 @@ static void zonefs_release_zgroup_inodes(struct super_block *sb)
>>>    * sub-directories and files according to the device zone configuration and
>>>    * format options.
>>>    */
>>> -static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>>> +static int zonefs_fill_super(struct super_block *sb, struct fs_context *fc)
>>>   {
>>>   	struct zonefs_sb_info *sbi;
>>> +	struct zonefs_context *ctx = fc->fs_private;
>>>   	struct inode *inode;
>>>   	enum zonefs_ztype ztype;
>>>   	int ret;
>>> @@ -1281,21 +1278,17 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>>>   	sbi->s_uid = GLOBAL_ROOT_UID;
>>>   	sbi->s_gid = GLOBAL_ROOT_GID;
>>>   	sbi->s_perm = 0640;
>>> -	sbi->s_mount_opts = ZONEFS_MNTOPT_ERRORS_RO;
>>> -
>>> +	sbi->s_mount_opts = ctx->s_mount_opts;
>> Please keep the white line here...
>>
>>>   	atomic_set(&sbi->s_wro_seq_files, 0);
>>>   	sbi->s_max_wro_seq_files = bdev_max_open_zones(sb->s_bdev);
>>>   	atomic_set(&sbi->s_active_seq_files, 0);
>>> +
>> ...and remove this one. The initializations here are "grouped" together byt
>> "theme" (sbi standard stuff first and zone resource accounting in a second
>> "paragraph". I like to keep it that way.
>>
>>>   	sbi->s_max_active_seq_files = bdev_max_active_zones(sb->s_bdev);
>>>   
>>>   	ret = zonefs_read_super(sb);
>>>   	if (ret)
>>>   		return ret;
>>>   
>>> -	ret = zonefs_parse_options(sb, data);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>>   	zonefs_info(sb, "Mounting %u zones", bdev_nr_zones(sb->s_bdev));
>>>   
>>>   	if (!sbi->s_max_wro_seq_files &&
>>> @@ -1356,12 +1349,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>>>   	return ret;
>>>   }
>>>   
>>> -static struct dentry *zonefs_mount(struct file_system_type *fs_type,
>>> -				   int flags, const char *dev_name, void *data)
>>> -{
>>> -	return mount_bdev(fs_type, flags, dev_name, data, zonefs_fill_super);
>>> -}
>>> -
>>>   static void zonefs_kill_super(struct super_block *sb)
>>>   {
>>>   	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>>> @@ -1376,17 +1363,54 @@ static void zonefs_kill_super(struct super_block *sb)
>>>   	kfree(sbi);
>>>   }
>>>   
>>> +static void zonefs_free_fc(struct fs_context *fc)
>>> +{
>>> +	struct zonefs_context *ctx = fc->fs_private;
>> I do not think you need this variable.
>>
>>> +
>>> +	kfree(ctx);
>> Is it safe to not set fc->fs_private to NULL ?
> I agree that ctx is not needed, and instead kfree(fc->fs_private) is
> sufficient. However, since other fs conversions do not simply set
> fc->fs_private to NULL, kfree(fc_fs_private) is preferred here.
>
>>> +}
>>> +
>>> +static const struct fs_context_operations zonefs_context_ops = {
>>> +	.parse_param    = zonefs_parse_param,
>>> +	.get_tree       = zonefs_get_tree,
>>> +	.reconfigure	= zonefs_reconfigure,
>>> +	.free           = zonefs_free_fc,
>>> +};
>>> +
>>> +/*
>>> + * Set up the filesystem mount context.
>>> + */
>>> +static int zonefs_init_fs_context(struct fs_context *fc)
>>> +{
>>> +	struct zonefs_context *ctx;
>>> +
>>> +	ctx = kzalloc(sizeof(struct zonefs_context), GFP_KERNEL);
>>> +	if (!ctx)
>>> +		return 0;
>> return 0 ? Shouldn't this be "return -ENOMEM" ?
>>
>>> +	ctx->s_mount_opts = ZONEFS_MNTOPT_ERRORS_RO;
>>> +	fc->ops = &zonefs_context_ops;
>>> +	fc->fs_private = ctx;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   /*
>>>    * File system definition and registration.
>>>    */
>>>   static struct file_system_type zonefs_type = {
>>>   	.owner		= THIS_MODULE,
>>>   	.name		= "zonefs",
>>> -	.mount		= zonefs_mount,
>>>   	.kill_sb	= zonefs_kill_super,
>>>   	.fs_flags	= FS_REQUIRES_DEV,
>>> +	.init_fs_context	= zonefs_init_fs_context,
>>> +	.parameters	= zonefs_param_spec,
>> Please re-align everything together.
>>
>>>   };
>>>   
>>> +static int zonefs_get_tree(struct fs_context *fc)
>>> +{
>>> +	return get_tree_bdev(fc, zonefs_fill_super);
>>> +}
>>> +
>>>   static int __init zonefs_init_inodecache(void)
>>>   {
>>>   	zonefs_inode_cachep = kmem_cache_create("zonefs_inode_cache",
>> -- 
>> Damien Le Moal
>> Western Digital Research
>>
>

