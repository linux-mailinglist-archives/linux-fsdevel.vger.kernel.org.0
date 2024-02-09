Return-Path: <linux-fsdevel+bounces-10908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8B884F373
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AD51C256AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408CE1D697;
	Fri,  9 Feb 2024 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vi7DW3tP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA84107A0;
	Fri,  9 Feb 2024 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474665; cv=none; b=bAfjr2Pu0R0vlJ6GstvuyLbzGhn15+tbCShByQZzSCG/c5Ro97Z7bC52LZWMn8I//jsJfh2KBQE9j10FjmYCsh/rsFjd/5qjAcVS6onQtty7YEUf5BuValOhXll31oFboVomFe8Ouon7VMFAIa/jkLkHpL6yl1F6UH5btzA09ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474665; c=relaxed/simple;
	bh=jNqkdKdn0JwaBXPN748/BkL+FwjFFKuIip9sMqyOPhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/S5FbAwLAhkrbTwGrZjuzzRC+lHlfrfwA6Xi5y420wXBePIkzs07UjUFe7JhjO38sd4Xmn4bbyb6MK2gJJJLJsYKy5zzUM6sibbCPpvfe8q22FdW0lv/Dl6zBHOj5v2CXuR4sIU9FpZoXiJWBZ7fWdnh/7AjU+UCfGhz50nvnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vi7DW3tP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707474655;
	bh=jNqkdKdn0JwaBXPN748/BkL+FwjFFKuIip9sMqyOPhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vi7DW3tPlgmW0CjN8cMks0wpG+dd44UAH3ltMHDfmQt0ekovLv+js4f4/RSNxMflE
	 wgTsM3+l1R4sh4LFuXhDwHUpMLArimD5z6ffaU+UkIuhWccYSmg573BTxM6LQAenCh
	 Is6hjn7UgKLNI5QKe+5nkhWcguv7bLswqdLpLh4B89y2yYxlua2qWDLJVvc+mKIfFu
	 XpBnP9kuLjERomwJdPDEjtlDwSjS1DQ2E3M4M3bnM2f4CJnbGsTf36RNod9JDeF7bR
	 wh9Za7UvM+eEvl0Bgn1nEBgb4W+BQPhnJBo/SArrdCJTEhgiMJQnUmbNGQMcx8s8d6
	 xQXwEodDwgZ8g==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DDBBE3781115;
	Fri,  9 Feb 2024 10:30:50 +0000 (UTC)
Message-ID: <ff492e0f-3760-430e-968a-8b2adab13f3f@collabora.com>
Date: Fri, 9 Feb 2024 12:30:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v9 1/3] libfs: Introduce case-insensitive string
 comparison helper
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel@collabora.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
 Eric Biggers <ebiggers@google.com>
References: <20240208064334.268216-1-eugen.hristev@collabora.com>
 <20240208064334.268216-2-eugen.hristev@collabora.com>
 <87ttmivm1i.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <87ttmivm1i.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/24 20:38, Gabriel Krisman Bertazi wrote:
> Eugen Hristev <eugen.hristev@collabora.com> writes:
> 
>> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>>
>> generic_ci_match can be used by case-insensitive filesystems to compare
>> strings under lookup with dirents in a case-insensitive way.  This
>> function is currently reimplemented by each filesystem supporting
>> casefolding, so this reduces code duplication in filesystem-specific
>> code.
>>
>> Reviewed-by: Eric Biggers <ebiggers@google.com>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> 
> Hi Eugen,
> 
> Thanks for picking this up.  Please,  CC me in future versions.

Hello Gabriel,

Thanks for reviewing :)
> 
>> ---
>>  fs/libfs.c         | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/fs.h |  4 +++
>>  2 files changed, 72 insertions(+)
>>
>> diff --git a/fs/libfs.c b/fs/libfs.c
>> index bb18884ff20e..f80cb982ac89 100644
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -1773,6 +1773,74 @@ static const struct dentry_operations generic_ci_dentry_ops = {
>>  	.d_hash = generic_ci_d_hash,
>>  	.d_compare = generic_ci_d_compare,
>>  };
>> +
>> +/**
>> + * generic_ci_match() - Match a name (case-insensitively) with a dirent.
>> + * @parent: Inode of the parent of the dirent under comparison
>> + * @name: name under lookup.
>> + * @folded_name: Optional pre-folded name under lookup
>> + * @de_name: Dirent name.
>> + * @de_name_len: dirent name length.
>> + *
>> + *
>> + * Test whether a case-insensitive directory entry matches the filename
>> + * being searched.  If @folded_name is provided, it is used instead of
>> + * recalculating the casefold of @name.
> 
> Can we add a note that this is a filesystem helper for comparison with
> directory entries, and VFS' ->d_compare should use generic_ci_d_compare.
> 
>> + *
>> + * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
>> + * < 0 on error.
>> + */
>> +int generic_ci_match(const struct inode *parent,
>> +		     const struct qstr *name,
>> +		     const struct qstr *folded_name,
>> +		     const u8 *de_name, u32 de_name_len)
>> +{
>> +	const struct super_block *sb = parent->i_sb;
>> +	const struct unicode_map *um = sb->s_encoding;
>> +	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
>> +	struct qstr dirent = QSTR_INIT(de_name, de_name_len);
>> +	int res, match = false;
> 
> I know I originally wrote it this way, but match is an integer, so
> let's use integers instead of false/true.

With the changes below, 'match' is no longer needed
> 
>> +
>> +	if (IS_ENCRYPTED(parent)) {
>> +		const struct fscrypt_str encrypted_name =
>> +			FSTR_INIT((u8 *) de_name, de_name_len);
>> +
>> +		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
>> +			return -EINVAL;
>> +
>> +		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
>> +		if (!decrypted_name.name)
>> +			return -ENOMEM;
>> +		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
>> +						&decrypted_name);
>> +		if (res < 0)
>> +			goto out;
>> +		dirent.name = decrypted_name.name;
>> +		dirent.len = decrypted_name.len;
>> +	}
>> +
>> +	if (folded_name->name)
>> +		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
>> +	else
>> +		res = utf8_strncasecmp(um, name, &dirent);
> 
> Similar to
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git/commit/?h=for-next&id=367122c529f35b4655acbe33c0cc4d6d3b32ba71
> 
> We should be checking for an exact-match first to avoid the utf8
> comparison cost unnecessarily.  The only problem is that we need to
> ensure we fail for an invalid utf-8 de_name in "strict mode".
> 
> Fortunately, if folded_name->name exists, we know the name-under-lookup
> was validated when initialized, so an exact-match of de_name must also
> be valid.  If folded_name is NULL, though, we might either have an
> invalid utf-8 dentry-under-lookup or the allocation itself failed, so we
> need to utf8_validate it.
> 
> Honestly, I don't care much about this !folded_name->name case, since
> utf8_strncasecmp will do the right thing and an invalid utf8 on
> case-insensitive directories should be an exception, not the norm.  but
> the code might get simpler if we do both:
> 
> (untested)

I implemented your suggestion, but any idea about testing ? I ran smoke on xfstests
and it appears to be fine, but maybe some specific test case might try the
different paths here ?

Let me know,
Eugen
> 
> if (folded_name->name) {
> 	if (dirent.len == folded_name->len &&
> 	    !memcmp(folded_name->name, dirent.name, dirent.len)) {
>             	res = 1;
> 		goto out;
>         }
> 	res = utf8_strncasecmp_folded(um, folded_name, &dirent);
> } else {
> 	if (dirent.len == name->len &&
> 	    !memcmp(name->name, dirent.name, dirent.len) &&
>             (!sb_has_strict_encoding(sb) || !utf8_validate(um, name))) {
>             	res = 1;
> 		goto out;
>         }
> 	res = utf8_strncasecmp(um, name, &dirent);
> }
> 
>> +
>> +	if (!res)
>> +		match = true;
>> +	else if (res < 0 && !sb_has_strict_encoding(sb)) {
>> +		/*
>> +		 * In non-strict mode, fallback to a byte comparison if
>> +		 * the names have invalid characters.
>> +		 */
>> +		res = 0;
>> +		match = ((name->len == dirent.len) &&
>> +			 !memcmp(name->name, dirent.name, dirent.len));
>> +	}
> 
> This goes away entirely.
> 
>> +
>> +out:
>> +	kfree(decrypted_name.name);
>> +	return (res >= 0) ? match : res;
> 
> and this becomes:
> 
> return res;
> 


