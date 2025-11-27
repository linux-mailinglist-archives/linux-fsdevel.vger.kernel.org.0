Return-Path: <linux-fsdevel+bounces-69939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2BCC8C71E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8D114E17CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558CA243956;
	Thu, 27 Nov 2025 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dx563oX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F022FF22;
	Thu, 27 Nov 2025 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204205; cv=none; b=hfvbg493qNqYD7HgJMnYxvP/zHoSOZw020GKmje+LvpEeI9V+GD1HiLjE8FWOaT/BnT2N/2IKt3NlXpra5CWqp3VPWwkOSWlJdM9sae6Ry5umGe1MV5qD3e3W0Q5Ga24bU5FW8B/xNjPKcIRcZI9SHTx8DMQpf/nDWfoQ9+5JdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204205; c=relaxed/simple;
	bh=Qj0EP0glRU1WGGjfrJCi42a3hyM8pK/ruoiNSmUPh5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1tKT9/nFVVlYwNmhml92lUO695q8hmfB3vuQpnOhRbsUVu0SVGZRhkRd71znD7yOQepgzxUO+MzeIfVgDfHqpVoEym19COSDuKqoKmY2GZicK5U27EV6+SC9NWOhadfnKRitD014UOVZ14AH32MuCangKug0p9mSot++8oR6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dx563oX3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=4RhhCAGU/XOvOgyvYfmVxOLy/WZfHodSagWFrvOL8yI=; b=Dx563oX3LqYJ0SrU0EFZsQ+c7X
	0NudHnIiekbMfOnAkxn/rW75IvGlSl3AUXwGUySI4Bb0DzbjbA04hS3OOM0/QXR7XzBfZryke2/Zw
	AHLolSHlwf1vi1MpjRbNnNh6xgvwti8yahMe+YtJwjX6j6wPCXDJAekl5iHNMLAqZcqWO9b5KqWru
	7eebGMgZqBla9P9U3Xs2ip+8VpsCn8uyArQ3qEjMV0hvd2/bpFVZQMwrwzdouAeKAETuOZ9gjWTy1
	Nnmomrj6EmZ/bSDDAYdEVDZr2ja5hM7sIT8FYdAn54b0nt2RzQa3739sOnhHg7vKCCKlOZ3nIUuOh
	zHsZvPSQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOQ6U-0000000Fo95-25Cy;
	Thu, 27 Nov 2025 00:43:22 +0000
Message-ID: <a135eb8a-f50d-4033-a5c0-9257c152162e@infradead.org>
Date: Wed, 26 Nov 2025 16:43:21 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Documentation: afs: Use proper bullet for bullet
 lists
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux AFS <linux-afs@lists.infradead.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, Jonathan Corbet <corbet@lwn.net>,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Daniel Palmer <daniel.palmer@sony.com>
References: <20251126025511.25188-1-bagasdotme@gmail.com>
 <20251126025511.25188-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251126025511.25188-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/25/25 6:55 PM, Bagas Sanjaya wrote:
> The lists use an asterisk in parentheses (``(*)``) as the bullet marker,
> which isn't recognized by Sphinx as the proper bullet. Replace with just
> an asterisk.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/filesystems/afs.rst | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/filesystems/afs.rst b/Documentation/filesystems/afs.rst
> index f15ba388bbde79..6135d64ada6372 100644
> --- a/Documentation/filesystems/afs.rst
> +++ b/Documentation/filesystems/afs.rst
> @@ -23,17 +23,14 @@ This filesystem provides a fairly simple secure AFS filesystem driver. It is
>  under development and does not yet provide the full feature set.  The features
>  it does support include:
>  
> - (*) Security (currently only AFS kaserver and KerberosIV tickets).
> -
> - (*) File reading and writing.
> -
> - (*) Automounting.
> -
> - (*) Local caching (via fscache).
> + * Security (currently only AFS kaserver and KerberosIV tickets).
> + * File reading and writing.
> + * Automounting.
> + * Local caching (via fscache).
>  
>  It does not yet support the following AFS features:
>  
> - (*) pioctl() system call.
> + * pioctl() system call.
>  
>  
>  Compilation
> @@ -146,15 +143,15 @@ Proc Filesystem
>  
>  The AFS module creates a "/proc/fs/afs/" directory and populates it:
>  
> -  (*) A "cells" file that lists cells currently known to the afs module and
> -      their usage counts::
> +  * A "cells" file that lists cells currently known to the afs module and
> +    their usage counts::
>  
>  	[root@andromeda ~]# cat /proc/fs/afs/cells
>  	USE NAME
>  	  3 cambridge.redhat.com
>  
> -  (*) A directory per cell that contains files that list volume location
> -      servers, volumes, and active servers known within that cell::
> +  * A directory per cell that contains files that list volume location
> +    servers, volumes, and active servers known within that cell::
>  
>  	[root@andromeda ~]# cat /proc/fs/afs/cambridge.redhat.com/servers
>  	USE ADDR            STATE

-- 
~Randy

