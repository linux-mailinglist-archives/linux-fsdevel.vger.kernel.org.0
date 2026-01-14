Return-Path: <linux-fsdevel+bounces-73521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47498D1BDE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 01:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99EAB302D5F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 00:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647122D4E9;
	Wed, 14 Jan 2026 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6+ilgFQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C9EB67E;
	Wed, 14 Jan 2026 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351832; cv=none; b=LGdkSq7QedDejB2Lc7x/sUFWlhyVfRSFfvl4i54EX5EV5oGv722PiZ9VUxN5QU/VV33ILCgNkxFnjRG4L2ZgL8NXBUINQrYo1kKpvlAL7Aph1XkHw5R4G3UXPaHfYywkb1XOrNWfm7uc8e+etoqn4aElsJ59viBJbxBis0fjc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351832; c=relaxed/simple;
	bh=+9zYSMUTpSMrvV0FSgMPb55zEujWI6/QvhZDmkn6Hcw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j4gjXKJqtPMy/7LuRH2OfoEuE7T8Mv+R890Nom7PdVAjLDU9CoC+hAZOH4EUTVCmK3n5bp0bUMMlwN8XgACdYrdYJw0LsvXyGjMLM102/UAtgw1ThREvYsqwKsGNKQUiahsGuONd0nJ/jDMYQSWNCPKPlsgidvq6iopH2D7/5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6+ilgFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CCAC116C6;
	Wed, 14 Jan 2026 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768351832;
	bh=+9zYSMUTpSMrvV0FSgMPb55zEujWI6/QvhZDmkn6Hcw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=V6+ilgFQW43CxxB0Ex+ogsongMpvbfghBmxkSgrWphV0lnjygSgFjqLckjm/gnIYy
	 BwGcch325gDKgsJWHahl/rJlmW4p7BO4zv5sEv8yg5pHapsmUZqfsMcsHsmByLt+sl
	 OFR5YQ8dFV++SqdKVZof43IPvg3PwKwwTT61iQ06lFcpjzMWHRbSua7eflJOrMeQow
	 gLZY7HIu7oZ9DLWsHMgANHPS7tvpVr9yMB/8ZS7bBEUCxQCfczmw/FFe+LNnF0QKiN
	 3Sbca5hVHFORscf4aNpf6DgtrE/LdqIlofXsrn6El0ez2oSNS6I8PV7UueHTe+RjQ7
	 SxEP17tqGSImQ==
Message-ID: <dbc45ceb-a0d3-4046-8816-daeffad9cb38@kernel.org>
Date: Wed, 14 Jan 2026 08:50:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
 linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
 almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
 pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
 trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, hansg@kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 11/16] f2fs: Add case sensitivity reporting to
 fileattr_get
To: Chuck Lever <cel@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
References: <20260112174629.3729358-1-cel@kernel.org>
 <20260112174629.3729358-12-cel@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260112174629.3729358-12-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/2026 1:46 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> NFS and other remote filesystem protocols need to determine
> whether a local filesystem performs case-insensitive lookups
> so they can provide correct semantics to clients. Without
> this information, f2fs exports cannot properly advertise
> their filename case behavior.
> 
> Report f2fs case sensitivity behavior via the file_kattr
> boolean fields. Like ext4, f2fs supports per-directory case
> folding via the casefold flag (IS_CASEFOLDED). Files are
> always case-preserving.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

