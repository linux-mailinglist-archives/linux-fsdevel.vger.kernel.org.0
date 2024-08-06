Return-Path: <linux-fsdevel+bounces-25121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB894949E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5441C21D72
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA071CA9C;
	Tue,  6 Aug 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A916kK1G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826D8AD51;
	Tue,  6 Aug 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958537; cv=none; b=X6hxFg7NCymOb0LXhW/luPwKP9d5W00LtVPMZIkCgt0LYOsnq7GiVerQNZ8ErmpxFpMDJ+6HG2+p0lFpRAXtbM63DqPbpHbvDYJVN7VwFjhgC9J+iHYnN1ka3/coWNjRSo77prK2eAJM40rvvv3cgaqc01uI9gKvyAwPd84k9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958537; c=relaxed/simple;
	bh=dwECOMHevy5hC2nyMfLYm+3khACURkFf590a32nNV98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3SnSV5vUqcvzeETCdstDmRNmPLKZ05N+VW4CSUbAiNRyis779rikptLt2pFZtWGtu7haCoFlaC9GXS2//vnHrgM0mS7JiPU5BDuhwPGxSGecW60yPSBZA9QBkD1eU4nuWX31kL8NsoFH/0iVTrd/JYHiRvQRX2TAmh+pBjP/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A916kK1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A342C32786;
	Tue,  6 Aug 2024 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722958537;
	bh=dwECOMHevy5hC2nyMfLYm+3khACURkFf590a32nNV98=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A916kK1GTpBS8An1bhUMnFcUuabCWi7+E5i53NeKxiTCGZxxzjizVMt8fgvIjc0DP
	 5EPCkLLG9zUr0PDQFoxlAYBDpkevHrTPTo5dpfh8z6Ua/xIqv0b4ta8lIuMUjd7m/U
	 0ZwOB/2iFBx90ApymeiL9d3eKn69GMtf70BccvEhrT4rJM8eorJjyBdK4AN8VAg3Bz
	 kppfZ/Zf8yz93rYcR0fKlHyvcFO3UOCB6lflOT6w+bytcYtkGA/MydPbl1H+UrUfis
	 /17sGqEqFL7dY3OMnrUOFVyx3Xy2wpNVMSV8SG6wFPObwUxeXZl1pZ7qnHT8knxsna
	 qTj6PZ5MOoNBA==
Message-ID: <0d0cdc83-0195-4dd6-8346-eabd1159cabd@kernel.org>
Date: Tue, 6 Aug 2024 17:35:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] netfs: Revert "netfs: Switch debug logging to
 pr_debug()"
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1410685.1721333252@warthog.procyon.org.uk>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
In-Reply-To: <1410685.1721333252@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello David,

On 7/18/24 22:07, David Howells wrote:
>      
> Revert commit 163eae0fb0d4c610c59a8de38040f8e12f89fd43 to get back the
> original operation of the debugging macros.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Uwe Kleine-König <ukleinek@kernel.org>
> cc: Christian Brauner <brauner@kernel.org>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/20240608151352.22860-2-ukleinek@kernel.org
> ---
>   fs/netfs/buffered_read.c  |   14 +++++++-------
>   fs/netfs/buffered_write.c |   12 ++++++------
>   fs/netfs/direct_read.c    |    2 +-
>   fs/netfs/direct_write.c   |    8 ++++----
>   fs/netfs/fscache_cache.c  |    4 ++--
>   fs/netfs/fscache_cookie.c |   28 ++++++++++++++--------------
>   fs/netfs/fscache_io.c     |   12 ++++++------
>   fs/netfs/fscache_main.c   |    2 +-
>   fs/netfs/fscache_volume.c |    4 ++--
>   fs/netfs/internal.h       |   33 ++++++++++++++++++++++++++++++++-
>   fs/netfs/io.c             |   12 ++++++------
>   fs/netfs/main.c           |    4 ++++
>   fs/netfs/misc.c           |    4 ++--
>   fs/netfs/write_collect.c  |   16 ++++++++--------
>   fs/netfs/write_issue.c    |   36 ++++++++++++++++++------------------
>   15 files changed, 113 insertions(+), 78 deletions(-)

I just found this patch as commit 
a9d47a50cf257ff1019a4e30d573777882fd785c in mainline, missed the mail 
earlier, so I'm replying just now.

In my eyes the commit log is poor and it should better highlight what 
the advantage of the original debugging macros are.

After some more digging (which the commit log should ideally highlight) 
I found the next commit that addresses parts of the concerns mentioned 
in the reverted commit's description, by introducing CONFIG_NETFS_DEBUG.

I still don't get the advantage of reimplementing stuff that pr_debug() 
already does. Am I missing something? Isn't a generic deubg mechanism 
that most people know better than something invented for a specific driver?

Best regards
Uwe

