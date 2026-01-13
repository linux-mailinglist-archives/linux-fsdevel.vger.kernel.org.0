Return-Path: <linux-fsdevel+bounces-73432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC0D193E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 708E3303B171
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 13:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EA0392820;
	Tue, 13 Jan 2026 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHCBTIj9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3DC3921E9;
	Tue, 13 Jan 2026 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312735; cv=none; b=tprG+Jd2ALHQhbat6iA6+yVmg9Ayo94d2zlD3fvn/t1uVuzhuG1mW24qQPomHxY5VqG3/toMP0Rnho19feNH+0lUmSPOLKlQ6T77W9khWcISqSWeyO2JVl5oDksJwTvqTRaFxnrlb0SJdeZo37L4c+2s2u/iTbiIyLFFkDbX4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312735; c=relaxed/simple;
	bh=Mdtt2cEJZpAolbsyohBBtRFFKdaOQF7vilJVbgvlUGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smhH7rzVL/WLtxRLJ2NREqx0NSzCmVj6Vqr0hvD5xfCKEktUmXDdGjBlOuTLAtUYpWS0s1l7wFxrmdQOX+hzP+K6WVOm2a+BAQW+8Dqa7Aa5+fCq3gew3idzL5ZS8XMwwF829UtyUElqCa/jVJ/1GZHJjHLIx9BDV79zINTQE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHCBTIj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9631AC116C6;
	Tue, 13 Jan 2026 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768312734;
	bh=Mdtt2cEJZpAolbsyohBBtRFFKdaOQF7vilJVbgvlUGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IHCBTIj9UNV7zFILfsvU9XgyRBUFUE6V1XXitdJsXV4An6QT0u9i2rDGeRj289vt4
	 WkiQzfDRs5U6wYFLdweectESwFc4BRcilU+itHS6DCLfB7DAhWRozee85uqhuEjqlF
	 Prv9Hfrz6iNh61KNTwvjFiJs3keHSxpck+Gwzx2D8YrMgW+dctCS7kPQk2sR+wY3Ye
	 LVdXdKWUHDiQx93VDVxTV8xlHdDI5QYAJcuuO/W8J/CHNXaaxZsTvPy16ArXawSW3w
	 k9kverbXLU/aJEA2C9xjImlMARaL5kA/oeRmR1ID5IDE6jpqCg9Q35w4USUFRQJJvu
	 tdxB439zhtF1w==
Message-ID: <774aac29-837d-4692-b744-e168d969a221@kernel.org>
Date: Tue, 13 Jan 2026 08:58:45 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/16] Exposing case folding behavior
To: Christian Brauner <brauner@kernel.org>
Cc: vira@so61.smtp.subspace.kernel.org, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
	sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org,
	chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
References: <20260112174629.3729358-1-cel@kernel.org>
 <20260113-vorort-pudding-ef90f426d5cf@brauner>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20260113-vorort-pudding-ef90f426d5cf@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 4:04 AM, Christian Brauner wrote:
> On Mon, Jan 12, 2026 at 12:46:13PM -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Following on from
>>
>> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
>>
>> I'm attempting to implement enough support in the Linux VFS to
>> enable file services like NFSD and ksmbd (and user space
>> equivalents) to provide the actual status of case folding support
>> in local file systems. The default behavior for local file systems
>> not explicitly supported in this series is to reflect the usual
>> POSIX behaviors:
>>
>>   case-insensitive = false
>>   case-preserving = true
>>
>> The case-insensitivity and case-preserving booleans can be consumed
>> immediately by NFSD. These two booleans have been part of the NFSv3
>> and NFSv4 protocols for decades, in order to support NFS clients on
>> non-POSIX systems.
>>
>> Support for user space file servers is why this series exposes case
>> folding information via a user-space API. I don't know of any other
>> category of user-space application that requires access to case
>> folding info.
> 
> This all looks good to me.
> Just one question: This reads like you are exposing the new file attr
> bits via userspace but I can only see changes to the kernel internal
> headers not the uapi headers. So are you intentionally not exposing this
> as a new uapi extension to file attr or is this an accident?

The intention is to expose the new bits to user space. IIRC those got
removed from uapi headers when I converted from using statx. I can fix
that up and post a v4.


-- 
Chuck Lever

