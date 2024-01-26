Return-Path: <linux-fsdevel+bounces-9104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4D83E34F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D862886C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 20:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EF122F12;
	Fri, 26 Jan 2024 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="S7Fn+2q7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288023742;
	Fri, 26 Jan 2024 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300662; cv=none; b=NvQEpN6tgb7Fbmnuv+cyM3UUmqrcN54wJsCzgwU9C5mUrlMQ+1mprq3QuELkga6zraiYJi5VaDATSqREAMtSx8zkkuJ+Ene9PbiBG23CTr17SFMg7zGwijLTj40sP2RA/ovSVKLRGv/7RDS8eEkMtVDfUalsf9MJ+viLV5yTdYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300662; c=relaxed/simple;
	bh=MewhNM/AnMv4gHjnvJ36YA4iTJBmyf65fpyPqm7gGSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzkXHZnCKDn+ZIwd/Jq5WGt3IZWQJlKyTfB7I4dDdjuE2A+MlEtscECYfjumeHET+VawHY7yodu7wddHANYelX+gw5E5apnuTDVu7qgSRUgECCbErauAxVlL1MIb2c7Asa9iUmIJPbMLmMwAaEncxVi2uv792HdOEhvexjdvMBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=S7Fn+2q7; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706300657;
	bh=MewhNM/AnMv4gHjnvJ36YA4iTJBmyf65fpyPqm7gGSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S7Fn+2q7L/WWRHKaUQXYUdCAsI6rfmQG4XyHNpKQPkFyVLEAJNq2z2HSZjCtpUqkf
	 U9B0tYXTnMcrRX0KND/ckeT8yez4CcuGxQ/QWstKiniki8Q4bz3agUHSljiU+a4n4i
	 T+alU+hcHOfcTUTy47nhW6PNk91A2jtZcVHqVzmwTRC4RVwvX+Gow5EanLbhKmdbx0
	 Zf0QGltHsQABkO40/h+PRbdnUPPFKuXxuQcQLUoEbz97nInjR2iHPWtHJNmH52nzKi
	 XiBHWUj9xGkSOxa1J/yfokY2BmurjSI7Xpn1d2NuQWonWT7LV2SAs7HxqkSU5zUwJM
	 0+ZQVOBmeZwUg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TM8L93yJYzV3h;
	Fri, 26 Jan 2024 15:24:17 -0500 (EST)
Message-ID: <e3548c86-7422-432c-8b72-8de99fa9772f@efficios.com>
Date: Fri, 26 Jan 2024 15:24:17 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] [PATCH] eventfs: Have inodes have unique inode numbers
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240126151251.74cb9285@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240126151251.74cb9285@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-26 15:12, Steven Rostedt wrote:
[...]
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index e1b172c0e091..2187be6d7b23 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -223,13 +223,41 @@ static const struct inode_operations tracefs_file_inode_operations = {
>   	.setattr	= tracefs_setattr,
>   };
>   
> +/* Copied from get_next_ino() but adds allocation for multiple inodes */
> +#define LAST_INO_BATCH 1024
> +#define LAST_INO_MASK (~(LAST_INO_BATCH - 1))
> +static DEFINE_PER_CPU(unsigned int, last_ino);
> +
> +unsigned int tracefs_get_next_ino(int files)
> +{
> +	unsigned int *p = &get_cpu_var(last_ino);
> +	unsigned int res = *p;
> +
> +#ifdef CONFIG_SMP
> +	/* Check if adding files+1 overflows */

How does it handle a @files input where:

* (files+1 > LAST_INO_BATCH) ?

* (files+1 == LAST_INO_BATCH) ?

> +	if (unlikely(!res || (res & LAST_INO_MASK) != ((res + files + 1) & LAST_INO_MASK))) {
> +		static atomic_t shared_last_ino;
> +		int next = atomic_add_return(LAST_INO_BATCH, &shared_last_ino);
> +
> +		res = next - LAST_INO_BATCH;
> +	}
> +#endif
> +
> +	res++;
> +	/* get_next_ino should not provide a 0 inode number */
> +	if (unlikely(!res))
> +		res++;

I suspect that bumping this res++ in the 0 case can cause inode range
reservation issues at (files+1 == LAST_INO_BATCH-1).

Thanks,

Mathieu

> +	*p = res + files;
> +	put_cpu_var(last_ino);
> +	return res;
> +}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


