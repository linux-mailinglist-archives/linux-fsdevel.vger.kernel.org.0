Return-Path: <linux-fsdevel+bounces-67374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 489DCC3D518
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 21:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E997D35105B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 20:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2F934E75E;
	Thu,  6 Nov 2025 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mobintestserver.ir header.i=@mobintestserver.ir header.b="w29sWdar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mobintestserver.ir (mobintestserver.ir [185.204.170.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103231DD97;
	Thu,  6 Nov 2025 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.204.170.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459400; cv=none; b=e5sOPSTzgmlHgoVMVbTHzj5c9VTpAib8gH9s3aCZvkn8kaq5nFzR572KHcSrWhIwdTlolQa0MmlArN972nmXoXpjv6AU+YBojxziIelyzWHsf79morqG7IDGsHXqcmczb7Om0XEeCpvsuTnr109NRaKKCnQdY1eK5/hw4XKmGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459400; c=relaxed/simple;
	bh=+0k3b3CsL9Tmy7H4Qx3A27FFUhgXBl9Wm7mUoElHWnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXP0NloG4f5cWURAdcUIpeMCPr/m/Ff7BzXidB/gObNr6qX4OV6wP5RdRayWtH7TEQ2htRnP2Z+jPBWnhmuFMbCrqXH2eOI0NjzWIxpOsyHgTs3CgVXiFwYzZ4jUfGbaM0iaHwOJMT2b8SnpOOIzaE0zirxit38q18tYQYS6KKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mobintestserver.ir; spf=pass smtp.mailfrom=mobintestserver.ir; dkim=pass (2048-bit key) header.d=mobintestserver.ir header.i=@mobintestserver.ir header.b=w29sWdar; arc=none smtp.client-ip=185.204.170.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mobintestserver.ir
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobintestserver.ir
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=dkim; bh=+0k3b3CsL9Tmy7H
	4Qx3A27FFUhgXBl9Wm7mUoElHWnc=; h=in-reply-to:from:references:cc:to:
	subject:date; d=mobintestserver.ir; b=w29sWdar6B4vZKMRhfRUbD4XcBzkkQyf
	ieRbY3VqvxN7NyYi8LEZcXLQSym4ROxgaUyRPF8pePjYmvlPAm2QPMz8B/iwZn/ShOL6Y9
	vxf5isKTZRHIX/aWliBOSybtnYQLnFIE2QIdq7Yi7hh3JQD5ZbExxCUfqj+l+LKUaDYvm5
	bm18zmA8pqVonJZ3kBm8apg+WwlWol5UZm7fpcE1YB9GXqMSf6LNwI523778ocXtgJ7m4x
	4R3jEnPJN8g2gSWer0eV7n38HCdq4bDWak87TU8kE0lG+xjgNyeelRqGfrqkrgj0Xm90A2
	z4UfyaPlWrnmsYSZFotG5j2HzTVjyg==
Received: 
	by mobintestserver.ir (OpenSMTPD) with ESMTPSA id 160d2a2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Nov 2025 19:47:33 +0000 (UTC)
Message-ID: <46ebc4d5-5478-4c22-8f17-069fe40ebe44@mobintestserver.ir>
Date: Thu, 6 Nov 2025 23:26:31 +0330
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] ntfsplus: add super block operations
To: Namjae Jeon <linkinjeon@kernel.org>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, hch@infradead.org, hch@lst.de, tytso@mit.edu,
 willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com,
 sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
 pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
References: <20251020020749.5522-1-linkinjeon@kernel.org>
 <20251020020749.5522-3-linkinjeon@kernel.org>
Content-Language: en-US
From: Mobin Aydinfar <mobin@mobintestserver.ir>
In-Reply-To: <20251020020749.5522-3-linkinjeon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Namjae, I built your new driver (as DKMS) and I'm using it and it 
went smooth so far. Thanks for this good driver (and also really 
practical userspace tools) but something in dmesg caught my eye:

On 10/20/25 05:37, Namjae Jeon wrote:
> This adds the implementation of superblock operations for ntfsplus.
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>   fs/ntfsplus/super.c | 2716 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 2716 insertions(+)
>   create mode 100644 fs/ntfsplus/super.c
> 
> diff --git a/fs/ntfsplus/super.c b/fs/ntfsplus/super.c
> new file mode 100644
> index 000000000000..1803eeec5618
> --- /dev/null
> +++ b/fs/ntfsplus/super.c
> @@ -0,0 +1,2716 @@
> ...
> +	pr_info("volume version %i.%i, dev %s, cluster size %d\n",
> +		vol->major_ver, vol->minor_ver, sb->s_id, vol->cluster_size);
> +
 > ...

Shouldn't pr_info() messages have "ntfsplus: " prefix? I mean most 
drivers do so and it is weird to me to have something like this:

[    5.431662] volume version 3.1, dev sda3, cluster size 4096
[    5.444801] volume version 3.1, dev sdb1, cluster size 4096

instead of this:

[    5.431662] ntfsplus: volume version 3.1, dev sda3, cluster size 4096
[    5.444801] ntfsplus: volume version 3.1, dev sdb1, cluster size 4096

in my dmesg. What do you think? It wouldn't be better to include 
"ntfsplus: " prefix for pr_info messages?

Best Regards

