Return-Path: <linux-fsdevel+bounces-48691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4F4AB2E26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 05:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CB918925D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 03:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B94253F1F;
	Mon, 12 May 2025 03:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hlay0nWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E219CC3A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 03:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747021424; cv=none; b=YoJcpCGWh9cctAI5ERNLP8vmmS1/C2xIc8m2JXMlQYzxfhbZRs7HZifIf3l1UrxrjvYvXjbXKdaV7ZCM+TKrEf1fFvqOXtTEJ/tdIfBs9NUA9VkBIOVUSKYmrRWZXKE6eMMHXtueffAT/UsTERL7Q2QhPFo8tUYub8Y3AAHmzxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747021424; c=relaxed/simple;
	bh=uqcWxyA3RFJmeI8q7BXIHG5hR4mrjWFzeRmzlIcHb1o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V/3yckRxw/7YiBvsKK/N0Aj4H7XmbFo5lg0BpSW5367X4FCDc0MpswFoMAsoodInOK6E3LhmhIoYm46JIbEu8oG5q92lFk0nGtAoAlP21wdbi/hxhi666E783py2RZITlJtXhppaU34u1IAs7LfN0PiD6//HwTY9OscE/rEi1ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hlay0nWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D6CC4CEE7;
	Mon, 12 May 2025 03:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747021423;
	bh=uqcWxyA3RFJmeI8q7BXIHG5hR4mrjWFzeRmzlIcHb1o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Hlay0nWxsAD+6aUu0owsoGuS4Yhn3oc7mAAgA/FJVNQmVdNSM9eyqyloG4vRjWbyu
	 kktRd9FO36WG6k200+Sja5bS9EJRpxxa2iwLaHm+btkJUZF5rtgh3wTZMb5B76d0vi
	 fB4aysq2lk2mknJ1/9LjqE5p1kOSq4b6B6KcpHzEU1OyAwNgTiHcXGioHZe/L6Rrt/
	 GC37gvmDxylFRFhbnwlly90SMFIMsAamN6epwBdOR2LpRLbypqIvQWRtCcIJzh8M21
	 57BcXUaAAipfZ+hRFlKFeVnfKEPzBWFsF+pNIrKToAxCJYx7VxYw3MF0OPm+CfRhkt
	 AkyqCu2sx9hrQ==
Message-ID: <74704f7c-135e-4614-b805-404da6195930@kernel.org>
Date: Mon, 12 May 2025 11:43:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 lihongbo22@huawei.com
Subject: Re: [PATCH V3 7/7] f2fs: switch to the new mount api
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-8-sandeen@redhat.com>
 <b56964c2-ad30-4501-a7fd-1c0b41c407e9@kernel.org>
 <763bed71-1f44-4622-a9a0-d200f0418183@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <763bed71-1f44-4622-a9a0-d200f0418183@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 23:59, Eric Sandeen wrote:
> On 5/8/25 4:19 AM, Chao Yu wrote:
>>> @@ -2645,21 +2603,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>  
>>>  	default_options(sbi, true);
>>>  
>>> -	memset(&fc, 0, sizeof(fc));
>>> -	memset(&ctx, 0, sizeof(ctx));
>>> -	fc.fs_private = &ctx;
>>> -	fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
>>> -
>>> -	/* parse mount options */
>>> -	err = parse_options(&fc, data);
>>> -	if (err)
>>> -		goto restore_opts;
>> There is a retry flow during f2fs_fill_super(), I intenionally inject a
>> fault into f2fs_fill_super() to trigger the retry flow, it turns out that
>> mount option may be missed w/ below testcase:
> 
> I never did understand that retry logic (introduced in ed2e621a95d long
> ago). What errors does it expect to be able to retry, with success?

IIRC, it will retry mount if there is recovery failure due to inconsistent
metadata.

> 
> Anyway ...
> 
> Can you show me (as a patch) exactly what you did to trigger the retry,
> just so we are looking at the same thing?

You can try this?

---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0ee783224953..10f0e66059f8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5066,6 +5066,12 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto reset_checkpoint;
 	}

+	if (retry_cnt) {
+		err = -EIO;
+		skip_recovery = true;
+		goto free_meta;
+	}
+
 	/* recover fsynced data */
 	if (!test_opt(sbi, DISABLE_ROLL_FORWARD) &&
 			!test_opt(sbi, NORECOVERY)) {
-- 
2.49.0

Thanks,

> 
>> - mkfs.f2fs -f -O encrypt /dev/vdb
>> - mount -o test_dummy_encryption /dev/vdb /mnt/f2fs/
>> : return success
>> - dmesg -c
>>
>> [   83.619982] f2fs_fill_super, retry_cnt:1
>> [   83.620914] F2FS-fs (vdb): Test dummy encryption mode enabled
>> [   83.668380] f2fs_fill_super, retry_cnt:0
>> [   83.671601] F2FS-fs (vdb): Mounted with checkpoint version = 7a8dfca5
>>
>> - mount|grep f2fs
>> /dev/vdb on /mnt/f2fs type f2fs (rw,relatime,lazytime,background_gc=on,nogc_merge,
>> discard,discard_unit=block,user_xattr,inline_xattr,acl,inline_data,inline_dentry,
>> flush_merge,barrier,extent_cache,mode=adaptive,active_logs=6,alloc_mode=reuse,
>> checkpoint_merge,fsync_mode=posix,memory=normal,errors=continue)
>>
>> The reason may be it has cleared F2FS_CTX_INFO(ctx).dummy_enc_policy in
>> f2fs_apply_test_dummy_encryption().
>>
>> static void f2fs_apply_test_dummy_encryption(struct fs_context *fc,
>> 					     struct super_block *sb)
>> {
>> 	struct f2fs_fs_context *ctx = fc->fs_private;
>> 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>>
>> 	if (!fscrypt_is_dummy_policy_set(&F2FS_CTX_INFO(ctx).dummy_enc_policy) ||
>> 		/* if already set, it was already verified to be the same */
>> 		fscrypt_is_dummy_policy_set(&F2FS_OPTION(sbi).dummy_enc_policy))
>> 		return;
>> 	F2FS_OPTION(sbi).dummy_enc_policy = F2FS_CTX_INFO(ctx).dummy_enc_policy;
>> 	memset(&F2FS_CTX_INFO(ctx).dummy_enc_policy, 0,
>> 		sizeof(F2FS_CTX_INFO(ctx).dummy_enc_policy));
>> 	f2fs_warn(sbi, "Test dummy encryption mode enabled");
>> }
>>
>> Can we save old mount_info from sbi or ctx from fc, and try to recover it
>> before we retry mount flow?
> 
> I'll have to take more time to understand this concern. But thanks for pointing
> it out.
> 
> -Eric
> 
>> Thanks,
> 


