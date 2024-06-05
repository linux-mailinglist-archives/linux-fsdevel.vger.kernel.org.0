Return-Path: <linux-fsdevel+bounces-21032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267188FC95A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 12:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6B91C2316A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 10:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4B191492;
	Wed,  5 Jun 2024 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F0mNudOF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD5146017;
	Wed,  5 Jun 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717584543; cv=none; b=aSQPzh7JVmVr6P1gwX5yk5XVDvgLg2rIyEFcaichulVQN17qqgdllgaz5jEpd9E162VXpEzqJGfAW1/l7OHEK2z6VwEDCdMMyVsqwhCTPdyGjmhVD2NgA91W6SUcKVVcelnbPhHNHGSk1TJixQ5LGEPv21CjikMMGNKIwR5VfxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717584543; c=relaxed/simple;
	bh=eSiAi6Lhsei8wwn034IBNlVxZz98AQlYvyQcTm/aRaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/mFAW7hOm9yIz6uhaV5lowr5wVqS+4CVeDzcmKGHIS8Po4iYTD4g/4I/crEgaqZ+MDyQG1AScj11Sb8nbz7q6khARdf+Bo5Y03FZYWDuvG44l3CpPM3ZuOwAJV+CKzUBmMM65IuH1P4PRFR9rBtw4Jfivow/6mI6CJqeNHPORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F0mNudOF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717584540;
	bh=eSiAi6Lhsei8wwn034IBNlVxZz98AQlYvyQcTm/aRaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F0mNudOFfUPF1KXvZCSn0/j69uNCHETC1I9e0ikxSJCN7QoT+O66CUDBBUdYHS3FD
	 kplcyk6oJdQdjAtqWfCC36hPvNDJxV43c9iZx50eDh4tmkcveQagw2NdexZaSHcWCH
	 GiZP12DhU7dAAtHe28fdjNLoEuz8jjN1ZmGIWbdHVDRGtoL48F2JlRKDZe83GWO6Zv
	 Nk3kKwbhM0niJr3UwsgMjRkrpilNR/CyAowKrqnX3E/9N/s9Q7e5OE3QPTVugkgDiP
	 qmCTE5YnN1GNeo+QwHzug5MdDBuqXKFZMEnhp7EIg0Veu9cMc7uMMibMoL1F5ejZrZ
	 89BKQXWc7trFg==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0F01F37806BA;
	Wed,  5 Jun 2024 10:48:58 +0000 (UTC)
Message-ID: <690c503e-b5eb-4f0d-a7db-b23a5899f0fd@collabora.com>
Date: Wed, 5 Jun 2024 13:48:58 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 4/7] ext4: Reuse generic_ci_match for ci comparisons
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, adilger.kernel@dilger.ca, tytso@mit.edu,
 chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 ebiggers@google.com, kernel@collabora.com,
 Gabriel Krisman Bertazi <krisman@collabora.com>
References: <20240529082634.141286-1-eugen.hristev@collabora.com>
 <20240529082634.141286-5-eugen.hristev@collabora.com>
 <87cyowldpm.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <87cyowldpm.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 22:17, Gabriel Krisman Bertazi wrote:
> Eugen Hristev <eugen.hristev@collabora.com> writes:
> 
>> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>>
>> Instead of reimplementing ext4_match_ci, use the new libfs helper.
>>
>> It also adds a comment explaining why fname->cf_name.name must be
>> checked prior to the encryption hash optimization, because that tripped
>> me before.
>>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
>> Reviewed-by: Eric Biggers <ebiggers@google.com>
>> ---
>>  fs/ext4/namei.c | 91 +++++++++++++++----------------------------------
>>  1 file changed, 27 insertions(+), 64 deletions(-)
>>
>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>> index ec4c9bfc1057..20668741a23c 100644
>> --- a/fs/ext4/namei.c
>> +++ b/fs/ext4/namei.c
>> @@ -1390,58 +1390,6 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
>>  }
>>  
>>  #if IS_ENABLED(CONFIG_UNICODE)
>> -/*
>> - * Test whether a case-insensitive directory entry matches the filename
>> - * being searched for.  If quick is set, assume the name being looked up
>> - * is already in the casefolded form.
>> - *
>> - * Returns: 0 if the directory entry matches, more than 0 if it
>> - * doesn't match or less than zero on error.
>> - */
>> -static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
>> -			   u8 *de_name, size_t de_name_len, bool quick)
>> -{
>> -	const struct super_block *sb = parent->i_sb;
>> -	const struct unicode_map *um = sb->s_encoding;
>> -	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
>> -	struct qstr entry = QSTR_INIT(de_name, de_name_len);
>> -	int ret;
>> -
>> -	if (IS_ENCRYPTED(parent)) {
>> -		const struct fscrypt_str encrypted_name =
>> -				FSTR_INIT(de_name, de_name_len);
>> -
>> -		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
>> -		if (!decrypted_name.name)
>> -			return -ENOMEM;
>> -		ret = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
>> -						&decrypted_name);
>> -		if (ret < 0)
>> -			goto out;
>> -		entry.name = decrypted_name.name;
>> -		entry.len = decrypted_name.len;
>> -	}
>> -
>> -	if (quick)
>> -		ret = utf8_strncasecmp_folded(um, name, &entry);
>> -	else
>> -		ret = utf8_strncasecmp(um, name, &entry);
>> -	if (ret < 0) {
>> -		/* Handle invalid character sequence as either an error
>> -		 * or as an opaque byte sequence.
>> -		 */
>> -		if (sb_has_strict_encoding(sb))
>> -			ret = -EINVAL;
>> -		else if (name->len != entry.len)
>> -			ret = 1;
>> -		else
>> -			ret = !!memcmp(name->name, entry.name, entry.len);
>> -	}
>> -out:
>> -	kfree(decrypted_name.name);
>> -	return ret;
>> -}
>> -
>>  int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
>>  				  struct ext4_filename *name)
>>  {
>> @@ -1503,20 +1451,35 @@ static bool ext4_match(struct inode *parent,
>>  #if IS_ENABLED(CONFIG_UNICODE)
>>  	if (IS_CASEFOLDED(parent) &&
>>  	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
>> -		if (fname->cf_name.name) {
>> -			if (IS_ENCRYPTED(parent)) {
>> -				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
>> -					fname->hinfo.minor_hash !=
>> -						EXT4_DIRENT_MINOR_HASH(de)) {
>> +		int ret;
>>  
>> -					return false;
>> -				}
>> -			}
>> -			return !ext4_ci_compare(parent, &fname->cf_name,
>> -						de->name, de->name_len, true);
>> +		/*
>> +		 * Just checking IS_ENCRYPTED(parent) below is not
>> +		 * sufficient to decide whether one can use the hash for
>> +		 * skipping the string comparison, because the key might
>> +		 * have been added right after
>> +		 * ext4_fname_setup_ci_filename().  In this case, a hash
>> +		 * mismatch will be a false negative.  Therefore, make
>> +		 * sure cf_name was properly initialized before
>> +		 * considering the calculated hash.
>> +		 */
>> +		if (IS_ENCRYPTED(parent) && fname->cf_name.name &&
>> +		    (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
>> +		     fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de)))
>> +			return false;
>> +
>> +		ret = generic_ci_match(parent, fname->usr_fname,
>> +				       &fname->cf_name, de->name,
>> +				       de->name_len);
>> +		if (ret < 0) {
>> +			/*
>> +			 * Treat comparison errors as not a match.  The
>> +			 * only case where it happens is on a disk
>> +			 * corruption or ENOMEM.
>> +			 */
>> +			return false;
>>  		}
>> -		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
>> -						de->name_len, false);
> 
> With the changes to patch 3 in this iteration, This could become:
> 
> /*
>  * Treat comparison errors as not a match.  The
>  * only case where it happens is disk corruption
>  * or ENOMEM.
>  */
> return ext4_ci_compare(parent, fname->usr_fname, de->name,
> 		       de->name_len, false) > 0;
> 

Do you mean

return generic_ci_match(parent, fname->usr_fname,
		       &fname->cf_name, de->name,
		       de->name_len) > 0;

?

Because ext4_ci_compare was obsoleted with this series.

Thanks,
Eugen

