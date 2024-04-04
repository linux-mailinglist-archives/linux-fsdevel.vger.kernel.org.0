Return-Path: <linux-fsdevel+bounces-16120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E59898A6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 16:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE1F1F27118
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1290A12AAD5;
	Thu,  4 Apr 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4cb+Da5e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10EE12A16B;
	Thu,  4 Apr 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242234; cv=none; b=KSyItoCDDaCxkqAxS2z4XHdHVENq0PIpTBUkTKwZ4WNgFZS+QkmRNbkTtd1mmc9oIFXN3c1arYMd2vcsDKZlpUoqqNs45oZbuMS2oHStXQ1d4wxlFq2o6+ILE5WdtqWQmM+5VtXRbQ82OaFyLs9Sdftt/lCjw+zZKtW0nouxTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242234; c=relaxed/simple;
	bh=p7JS/JW9XXD3bMddSLVFax+q5+sw7d8SB0tPzkZxUCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHk4VbbHt2BSOC2w7G9WJcoo+2pfm9SIxe/ynzMjJBpJ8rT5KWjEg/wKtC8TBTDJlpnsr0mdMXPLOFGwYCwfzuEPnz03mOHctYpr0kwg6h62ZcKqQcy342cxGvTZngVkVIqRp7pX/vJSVhg7U8jMQs5UY59q40DhsBTwzgtG3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4cb+Da5e; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712242231;
	bh=p7JS/JW9XXD3bMddSLVFax+q5+sw7d8SB0tPzkZxUCE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=4cb+Da5eqnTgzFsMbel5Czpg0yxMD9Cj6yJ2vpwTHOXdMEdIBz4CBhF+/ZsV+CU6i
	 Dk2sHOTPShK29ZAITPiisvwR8WhbQ2JgohSYFVuE3atePxhCp7ww/igdnqJQkOW8Un
	 7IvkkSaxe0q17rJYaLc01oPe0QTES7GWBRGv/MFT0oTMkzf5obDgSfbP1I2lukorpr
	 gsSkEKfmZ97OxTIzC2WnAjno0669RcFpLpB2MjDH2iYFFV/6H6OwEWz/0yhmoCgjIT
	 XVoSirLSNumhV/WWVNvJPdNEgUHdD3qmJ7qUsK82aCTGhw477PwEJFKWa4XEJwkNCc
	 wYernkhbmyP0g==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 29A043780029;
	Thu,  4 Apr 2024 14:50:30 +0000 (UTC)
Message-ID: <e6d1ad0b-719a-4693-bd34-bea3cf6e4fa2@collabora.com>
Date: Thu, 4 Apr 2024 17:50:29 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v15 7/9] f2fs: Log error when lookup of encoded
 dentry fails
To: krisman@suse.de, Eric Biggers <ebiggers@kernel.org>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, kernel@collabora.com
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
 <20240402154842.508032-8-eugen.hristev@collabora.com>
 <20240403042503.GI2576@sol.localdomain>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240403042503.GI2576@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 07:25, Eric Biggers wrote:
> On Tue, Apr 02, 2024 at 06:48:40PM +0300, Eugen Hristev via Linux-f2fs-devel wrote:
>> If the volume is in strict mode, generi c_ci_compare can report a broken
>> encoding name.  This will not trigger on a bad lookup, which is caught
>> earlier, only if the actual disk name is bad.
>>
>> Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
>> ---
>>  fs/f2fs/dir.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 88b0045d0c4f..64286d80dd30 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -192,11 +192,16 @@ static inline int f2fs_match_name(const struct inode *dir,
>>  	struct fscrypt_name f;
>>  
>>  #if IS_ENABLED(CONFIG_UNICODE)
>> -	if (fname->cf_name.name)
>> -		return generic_ci_match(dir, fname->usr_fname,
>> -					&fname->cf_name,
>> -					de_name, de_name_len);
>> -
>> +	if (fname->cf_name.name) {
>> +		int ret = generic_ci_match(dir, fname->usr_fname,
>> +					   &fname->cf_name,
>> +					   de_name, de_name_len);
>> +		if (ret == -EINVAL)
>> +			f2fs_warn(F2FS_SB(dir->i_sb),
>> +				"Directory contains filename that is invalid UTF-8");
>> +
> 
> Shouldn't this use f2fs_warn_ratelimited?

f2fs_warn_ratelimited appears to be very new in the kernel,

Krisman do you think you can rebase your for-next on top of latest such that this
function is available ? I am basing the series on your for-next branch.

Thanks

> 
> - Eric
> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com


