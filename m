Return-Path: <linux-fsdevel+bounces-20000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865028CC2BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 16:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41800282152
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6BD13E40F;
	Wed, 22 May 2024 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RzWT3O3N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467B6AB9;
	Wed, 22 May 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386580; cv=none; b=CHLhs1Z1sx4JQUnY9zAk5/SXwJzUxCT4RRxexy8DCuV8W3ex12rNi3RbT6KlgWcZlIrIyuo0eXxUUdJRQT+ZvgQ74aBByGIOt5FkqedpptGU14xBLF1YOFWxkxzknPYxfJInP47Y8Z5KxyLdzmyTvMNWbVVVvlD/99CIGYvIlkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386580; c=relaxed/simple;
	bh=7kTG5ts3OQOCh1/2XvqX0aVjJCkbUUXFDVmo08IThCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RN9i224W7/nO0zPkOONx4qcvOQfzCY0Pk+9rg7BnU8hXlz3Ud+6oPEYf4Rd8Rlv4MMzZqL2TtKpCDJCSx7IFlCa7ARMFsgRXZZrUqscDu5sZYtk+bwhqfEA/u6QA1/FUeo733IHTlT3RI5DZcrFPIvsCtBHUqE2wFC9qg8PqORM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RzWT3O3N; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716386575;
	bh=7kTG5ts3OQOCh1/2XvqX0aVjJCkbUUXFDVmo08IThCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RzWT3O3NZ1dwV9M2JHbVSngE4q1VPMGXCXBpUQq11qZ2XeiDQmS47vXNKh45ByruT
	 Cm7JT6sfDFXS8Fa1W3bTnt3tZ9zNI/4VVsOPEWAheGA84yHB0+QR9/vD8ZNCY2muQ/
	 v20AlPXWqnAAZMWBoRd+unQh0zXE48VBkyjei/Zf3ZYkSL3XFlGcPWwHE8Ok//AO6Q
	 EPl3BQhtDjJXhDQI8sWI8BAIxBLQHJBirIfmH+vA9Mkyzu/ded0oeTF8nT7FYY4Trp
	 PMDbOHmF6JipmDBsBTOZtMmW4ktp9wbt35v3TgXmqkNsRi9LocM4J3Mc0RmJzFxtxt
	 SKCoSTO0+zKlA==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4991137821B3;
	Wed, 22 May 2024 14:02:54 +0000 (UTC)
Message-ID: <9afebadd-765f-42f3-a80b-366dd749bf48@collabora.com>
Date: Wed, 22 May 2024 17:02:53 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 3/9] libfs: Introduce case-insensitive string
 comparison helper
To: Gabriel Krisman Bertazi <krisman@suse.de>,
 Eric Biggers <ebiggers@kernel.org>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, Gabriel Krisman Bertazi <krisman@collabora.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-4-eugen.hristev@collabora.com>
 <20240510013330.GI1110919@google.com> <875xviyb3f.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <875xviyb3f.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/24 00:27, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
>> On Fri, Apr 05, 2024 at 03:13:26PM +0300, Eugen Hristev wrote:
> 
>>> +		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
>>> +			return -EINVAL;
>>> +
>>> +		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
>>> +		if (!decrypted_name.name)
>>> +			return -ENOMEM;
>>> +		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
>>> +						&decrypted_name);
>>> +		if (res < 0)
>>> +			goto out;
>>
>> If fscrypt_fname_disk_to_usr() returns an error and !sb_has_strict_encoding(sb),
>> then this function returns 0 (indicating no match) instead of the error code
>> (indicating an error).  Is that the correct behavior?  I would think that
>> strict_encoding should only have an effect on the actual name
>> comparison.
> 
> No. we *want* this return code to be propagated back to f2fs.  In ext4 it
> wouldn't matter since the error is not visible outside of ext4_match,
> but f2fs does the right thing and stops the lookup.

In the previous version which I sent, you told me that the error should be
propagated only in strict_mode, and if !strict_mode, it should just return no match.
Originally I did not understand that this should be done only for utf8_strncasecmp
errors, and not for all the errors. I will change it here to fix that.

> 
> Thinking about it, there is a second problem with this series.
> Currently, if we are on strict_mode, f2fs_match_ci_name does not
> propagate unicode errors back to f2fs. So, once a utf8 invalid sequence
> is found during lookup, it will be considered not-a-match but the lookup
> will continue.  This allows some lookups to succeed even in a corrupted
> directory.  With this patch, we will abort the lookup on the first
> error, breaking existing semantics.  Note that these are different from
> memory allocation failure and fscrypt_fname_disk_to_usr. For those, it
> makes sense to abort.

So , in the case of f2fs , we must not propagate utf8 errors ? It should just
return no match even in strict mode ?
If this helper is common for both f2fs and ext4, we have to do the same for ext4 ?
Or we are no longer able to commonize the code altogether ?
> 
> Also, once patch 6 and 7 are added, if fscrypt fails with -EINVAL for
> any reason unrelated to unicode (like in the WARN_ON above), we will
> incorrectly print the error message saying there is a bad UTF8 string.
> 
> My suggestion would be to keep the current behavior.  Make
> generic_ci_match only propagate non-unicode related errors back to the
> filesystem.  This means that we need to move the error messages in patch
> 6 and 7 into this function, so they only trigger when utf8_strncasecmp*
> itself fails.
> 

So basically unicode errors stop here, and print the error message here in that case.
Am I understanding it correctly ?
>>> +	/*
>>> +	 * Attempt a case-sensitive match first. It is cheaper and
>>> +	 * should cover most lookups, including all the sane
>>> +	 * applications that expect a case-sensitive filesystem.
>>> +	 */
>>> +	if (folded_name->name) {
>>> +		if (dirent.len == folded_name->len &&
>>> +		    !memcmp(folded_name->name, dirent.name, dirent.len))
>>> +			goto out;
>>> +		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
>>
>> Shouldn't the memcmp be done with the original user-specified name, not the
>> casefolded name?  I would think that the user-specified name is the one that's
>> more likely to match the on-disk name, because of case preservation.  In most
>> cases users will specify the same case on both file creation and later access.
> 
> Yes.
> 
so the utf8_strncasecmp_folded call here must use name->name instead of folded_name ?

Thanks for the review
Eugen


