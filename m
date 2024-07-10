Return-Path: <linux-fsdevel+bounces-23528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BB892DC9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 01:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8251F272FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 23:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619FB156968;
	Wed, 10 Jul 2024 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="PKXF+f4s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A69D155744
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653912; cv=none; b=I4lDG1ThJe2RyLhr9kLQ8n1bW+mWQ16ecCK39v8u6qGTzxrwiY5irIj3vt5ja/YeAXCwHBDwfDOCDzQaNN0aVXiCO2HMn3ox57A+DWwQP8N6D/qQtrbEkFhZ072VZF/eQDvtH4YRT5PVzasuHhbe29nxYNDmmsoRUlKoa8ez7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653912; c=relaxed/simple;
	bh=gw/MLm2hIT4+Tpb2VM+DAxnSIDoNHKfcf/mPwPe0CAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7OaYHJMyi0vkHeSPmBYa23utMD4ALeI5UO+hUdiR8pDPw7jxhsLCyyyqfUj+8RRAlrnlowckKo1FnoUcAYmsTAyWSJZu9uomrOp4bCrfYkmYWaznNu+G8iJ9dAAJhBgfFanae8ethC2HVbRYsR83sAViDHmJrOtfp23zL8I6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=PKXF+f4s; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id RcXGs4cIZnNFGRggQs97kF; Wed, 10 Jul 2024 23:25:10 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RggPstL9AFOowRggPsMc4C; Wed, 10 Jul 2024 23:25:10 +0000
X-Authority-Analysis: v=2.4 cv=Bbfe0Kt2 c=1 sm=1 tr=0 ts=668f1856
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=vS7kxI9omEbEOQks6BwA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5JTzYDV8HuQdO+rGyaS9OUcGkFAqlJYU3lF427AyccY=; b=PKXF+f4sBIZSdXNIUYQIXOOBsS
	XUytasohbtpTlT2vQc53it49tKfEgdptJRsoOyQTjMTaAzVj1cTETqrhldXCGKy6T6iIxXVUdYDL7
	z5Qn9EZrVqFi27IuD0nty6XwCCPFf8asS00sx4KUNlpM1n4690aA8zd7rBnN9shBVhe2fTbErJyd5
	JfZYy1ZyXTjrr5HRTfz4FGKCOrvqMmfDlmWkvzZrHZLLf7hGOQ8wdMzIfLyUOl/jfYrrxis5kkCJK
	2TU7uRLpJA7EhtNU9LDzJxnhVaXvpB+N4RhvXUp2OJgSnQyb+abVqmqsXXtFNhEdB/iPGQ0MsH4vA
	E2KdXE2A==;
Received: from [201.172.173.139] (port=36682 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRggP-004LFD-0j;
	Wed, 10 Jul 2024 18:25:09 -0500
Message-ID: <ee3b7adb-0f11-4650-ad1f-afc9dceedc8a@embeddedor.com>
Date: Wed, 10 Jul 2024 17:25:08 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/affs: struct affs_data_head: Replace 1-element array
 with flexible array
To: Kees Cook <kees@kernel.org>, David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240710225725.work.409-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240710225725.work.409-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sRggP-004LFD-0j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:36682
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 35
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNYPSzLRy2KIgHRUAZTiQUYuz9h/RINgjjI+KHjTHJ7Oa0xujUfBo9vtXeu57ePAwjyfy9BExSbBA9em2K8edGdZhci4asXC2xPOUTzC4n4pvVTjkfdT
 onX/3ANxWwVVlnnjVbBOmI9mhwj07dPQSaja+TToLMj/RmLA+o2rmXc6KIJolfxKgAXj6baa00hLnhKGGJLysbVWwHNAf4CoRWYzS19TxEiqbauEmXONmsiF



On 10/07/24 16:57, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct affs_data_head with a modern flexible array.
> 
> No binary differences are present after this conversion.
> 
> Link: https://github.com/KSPP/linux/issues/79 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/affs/amigaffs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
> index 09dc23a644df..1b973a669d23 100644
> --- a/fs/affs/amigaffs.h
> +++ b/fs/affs/amigaffs.h
> @@ -119,7 +119,7 @@ struct affs_data_head
>   	__be32 size;
>   	__be32 next;
>   	__be32 checksum;
> -	u8 data[1];	/* depends on block size */
> +	u8 data[];	/* depends on block size */
>   };
>   
>   /* Permission bits */

