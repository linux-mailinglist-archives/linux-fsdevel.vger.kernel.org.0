Return-Path: <linux-fsdevel+bounces-12097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF785B412
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1411C232BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 07:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F9D5A7AF;
	Tue, 20 Feb 2024 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q6A95PPJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A64E3D69;
	Tue, 20 Feb 2024 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414611; cv=none; b=L0hONE478cgtPixTOf3LAyjrdoK0KjlwYNR3A1cllZJm3m9hMtmDkWG+2LHKIr9KPunAue2vq+FbXTwTEgO4R50THtkb3zkcmFiYyy+sETrCMgrRukCa4CNH1TbDPEMmsroIi+tnmF71xPv1bASc/TCD/PjZXF61IyzY22DfDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414611; c=relaxed/simple;
	bh=mFSD/wFGr7jkZ9Vc1opThnXPxIp9JYkLSf/lZISocp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBp0sQ5pmjpcMvnK2JqnXPpPR0yi7gy0eQ2gU4oDNoIEeIUBih1apoYs/Ch7n6wQY+eLE5Kw7VTRHfGZBue6X6qW8/AcP7Y1oBlvjWwWKU1suP0NbUrVDimZUiKcSBrm3NGXVkBhPcGBHuttHEYAmPVmO4Z41fHOog4Ne2Afb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q6A95PPJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708414607;
	bh=mFSD/wFGr7jkZ9Vc1opThnXPxIp9JYkLSf/lZISocp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q6A95PPJBIUtHUCT2w7izYRmIV2+dv1xuwysXTdFcO1C5vMnTjfQ/RS4p2ehZvAHw
	 N44F1r0HL3GDdqcfbhwDwni1HtKy0rfgis5dKJ2Jhetv4rB9ug0PyMVYkydhWHUeOo
	 eUd7GHy5td1IY3uY673aSys/XKFTI+FwhIta/TAN6+ygQURwb8e8FLZwKpVYeetBih
	 sL5LAAdDqczBL0u9hDcBB2mVK5bofxismA848yszTtdyT7PwmMC8uW+jAqNl65j6yc
	 cm6Kcshdk74TjG86xVTQAxCExKF+wOFP59h2HGKZy5i5eFu0YwTNJZeW7TMA5cRlhy
	 YRc105s7+QKLw==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8BB1E37804B2;
	Tue, 20 Feb 2024 07:36:43 +0000 (UTC)
Message-ID: <fb32fc72-5434-4852-b7e9-f63fc03a8248@collabora.com>
Date: Tue, 20 Feb 2024 09:36:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/8] libfs: Introduce case-insensitive string
 comparison helper
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, Gabriel Krisman Bertazi <krisman@collabora.com>
References: <20240215042654.359210-1-eugen.hristev@collabora.com>
 <20240215042654.359210-4-eugen.hristev@collabora.com>
 <87zfw0bd6y.fsf@mailhost.krisman.be>
 <50d2afaa-fd7e-4772-ac84-24e8994bfba8@collabora.com>
 <87msrwbj18.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <87msrwbj18.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/24 16:55, Gabriel Krisman Bertazi wrote:
> Eugen Hristev <eugen.hristev@collabora.com> writes:
> 
>> On 2/16/24 18:12, Gabriel Krisman Bertazi wrote:
>>> Eugen Hristev <eugen.hristev@collabora.com> writes:
>>>
>>>> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>>>>
>>>> generic_ci_match can be used by case-insensitive filesystems to compare
>>>> strings under lookup with dirents in a case-insensitive way.  This
>>>> function is currently reimplemented by each filesystem supporting
>>>> casefolding, so this reduces code duplication in filesystem-specific
>>>> code.
>>>>
>>>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>>>> [eugen.hristev@collabora.com: rework to first test the exact match]
>>>> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
>>>> ---
>>>>  fs/libfs.c         | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/fs.h |  4 +++
>>>>  2 files changed, 84 insertions(+)
>>>>
>>>> diff --git a/fs/libfs.c b/fs/libfs.c
>>>> index bb18884ff20e..82871fa1b066 100644
>>>> --- a/fs/libfs.c
>>>> +++ b/fs/libfs.c
>>>> @@ -1773,6 +1773,86 @@ static const struct dentry_operations generic_ci_dentry_ops = {
>>>>  	.d_hash = generic_ci_d_hash,
>>>>  	.d_compare = generic_ci_d_compare,
>>>>  };
>>>> +
>>>> +/**
>>>> + * generic_ci_match() - Match a name (case-insensitively) with a dirent.
>>>> + * This is a filesystem helper for comparison with directory entries.
>>>> + * generic_ci_d_compare should be used in VFS' ->d_compare instead.
>>>> + *
>>>> + * @parent: Inode of the parent of the dirent under comparison
>>>> + * @name: name under lookup.
>>>> + * @folded_name: Optional pre-folded name under lookup
>>>> + * @de_name: Dirent name.
>>>> + * @de_name_len: dirent name length.
>>>> + *
>>>> + *
>>>
>>> Since this need a respin, mind dropping the extra empty line here?
>>>
>>>> + * Test whether a case-insensitive directory entry matches the filename
>>>> + * being searched.  If @folded_name is provided, it is used instead of
>>>> + * recalculating the casefold of @name.
>>>> + *
>>>> + * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
>>>> + * < 0 on error.
>>>> + */
>>>> +int generic_ci_match(const struct inode *parent,
>>>> +		     const struct qstr *name,
>>>> +		     const struct qstr *folded_name,
>>>> +		     const u8 *de_name, u32 de_name_len)
>>>> +{
>>>> +	const struct super_block *sb = parent->i_sb;
>>>> +	const struct unicode_map *um = sb->s_encoding;
>>>> +	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
>>>> +	struct qstr dirent = QSTR_INIT(de_name, de_name_len);
>>>> +	int res;
>>>> +
>>>> +	if (IS_ENCRYPTED(parent)) {
>>>> +		const struct fscrypt_str encrypted_name =
>>>> +			FSTR_INIT((u8 *) de_name, de_name_len);
>>>> +
>>>> +		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
>>>> +			return -EINVAL;
>>>> +
>>>> +		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
>>>> +		if (!decrypted_name.name)
>>>> +			return -ENOMEM;
>>>> +		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
>>>> +						&decrypted_name);
>>>> +		if (res < 0)
>>>> +			goto out;
>>>> +		dirent.name = decrypted_name.name;
>>>> +		dirent.len = decrypted_name.len;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Attempt a case-sensitive match first. It is cheaper and
>>>> +	 * should cover most lookups, including all the sane
>>>> +	 * applications that expect a case-sensitive filesystem.
>>>> +	 *
>>>
>>>
>>>> +	 * This comparison is safe under RCU because the caller
>>>> +	 * guarantees the consistency between str and len. See
>>>> +	 * __d_lookup_rcu_op_compare() for details.
>>>> +	 */
>>>
>>> This paragraph doesn't really make sense here.  It is originally from
>>> the d_compare hook, which can be called under RCU, but there is no RCU
>>> here.  Also, here we are comparing the dirent with the
>>> name-under-lookup, name which is already safe.
>>>
>>>
>>>> +	if (folded_name->name) {
>>>> +		if (dirent.len == folded_name->len &&
>>>> +		    !memcmp(folded_name->name, dirent.name, dirent.len)) {
>>>> +			res = 1;
>>>> +			goto out;
>>>> +		}
>>>> +		res = !utf8_strncasecmp_folded(um, folded_name, &dirent);
>>>
>>> Hmm, second thought on this.  This will ignore errors from utf8_strncasecmp*,
>>> which CAN happen for the first time here, if the dirent itself is
>>> corrupted on disk (exactly why we have patch 6).  Yes, ext4_match will drop the
>>> error, but we want to propagate it from here, such that the warning on
>>> patch 6 can trigger.
>>>
>>> This is why I did that match dance on the original submission.  Sorry
>>> for suggesting it.  We really want to get the error from utf8 and
>>> propagate it if it is negative. basically:
>>>
>>>         res > 0: match
>>>         res == 0: no match.
>>>         res < 0: propagate error and let the caller handle it
>>
>> In that case I will revert to the original v9 implementation and send a v11 to
>> handle that.
> 
> Please, note that the memcmp optimization is still valid. On match, we
> know the name is valid utf8.  It is just a matter of propagating the
> error code from utf8 to the caller if we need to call it.
> 


Okay, I am changing it.

By the way, is this supposed to work like this on case-insensitive directories ?

user@debian-rockchip-rock5b-rk3588:~$ ls -la /media/CI_dir/*cuc
ls: cannot access '/media/CI_dir/*cuc': No such file or directory
user@debian-rockchip-rock5b-rk3588:~$ ls -la /media/CI_dir/*CUC
-rw-r--r-- 1 root root 0 Feb 12 17:47 /media/CI_dir/CUC
user@debian-rockchip-rock5b-rk3588:~$ ls -la /media/CI_dir/cuc
-rw-r--r-- 1 root root 0 Feb 12 17:47 /media/CI_dir/cuc
user@debian-rockchip-rock5b-rk3588:~$


basically wildcards don't work.

Thanks,
Eugen

