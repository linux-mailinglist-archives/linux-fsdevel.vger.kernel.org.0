Return-Path: <linux-fsdevel+bounces-23529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C3C92DC9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 01:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC061F27314
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 23:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A8115534D;
	Wed, 10 Jul 2024 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="caB/dvEL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F9156993
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653974; cv=none; b=kSDra68kJ2GcRY7GtYavBq45yiSD9a7AuSG9d+1J4bWgebaCP3vMy2PJDjZ42AzLn4sl+GPHERxEpX2pU+k8TwC2zPtaBSFZZpUAOEu0hYOcVIkWaOLP/frk9HVOsChyPx1Pg/y+pYZpiwNKQe3g3s91VwTnSW17cw5srkJGMqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653974; c=relaxed/simple;
	bh=jJuojDJkKVM0mSdix5fpD3/fkoozXZpH2UoKNPWTDZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgttl03K1XamzFy8wjCc3SVWx8sz0BBGhUaUoVzSpPQyRP9A+vVadGKui6AlFMoQrw5lO8QtsQn95r8YUrvACoLx/8EWbu7te01f9M+UiU7ZxAWY2p+WgeFUj7H6uEidY0l8PuTFfHj34fgyeypxw1aiY+bFq5BgTfidJx7myZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=caB/dvEL; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id RcXWs4D1BVpzpRghRsRuZf; Wed, 10 Jul 2024 23:26:13 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RghQsGhAJX56wRghRsL6N6; Wed, 10 Jul 2024 23:26:13 +0000
X-Authority-Analysis: v=2.4 cv=MY6nuI/f c=1 sm=1 tr=0 ts=668f1895
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=QdaU3yBqoJsCgmx-8bwA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fAOAkXV81GJSC1GjllVIjMD6JIIEOVrg4bHKVpSfYVc=; b=caB/dvEL+y+mrfzuPdAJU0c5+M
	rBis592lSUrxor4iU69dZb7v1oqUE2bJ4E+5y4kCzEcAGVvFLPh3zObKd5spN9Nlb8Y2et76fj02v
	gKFCZEnyPOEUlaL6Xz6b9dv5cwLNJcWKMOtkGfCeBVVk4S9IrlUCc0cf5PO7QQcH/+WomULuW9ZMu
	+ALrnZM5EdQMiCCZiL+lWul+DWEeSdqh0aRmgLhqc23yT64vE03xTHmxK42lyhrlFa3fVNACI1Cqo
	g7bkK2y1Uivuz9cOUU99oZujHlMJm3xPm4Pf4CLyVwRvNRmsWj6RPr78wRc7pgKrpfZKk0nyW2bGk
	S9rn1ZCA==;
Received: from [201.172.173.139] (port=58644 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRghQ-004MkP-1K;
	Wed, 10 Jul 2024 18:26:12 -0500
Message-ID: <1f3ad235-b2c7-47e8-bf70-b910d397d690@embeddedor.com>
Date: Wed, 10 Jul 2024 17:26:11 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/affs: struct affs_head: Replace 1-element array with
 flexible array
To: Kees Cook <kees@kernel.org>, David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240710225709.work.175-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240710225709.work.175-kees@kernel.org>
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
X-Exim-ID: 1sRghQ-004MkP-1K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:58644
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 40
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOVQSpFoKGsF+m6qJpiWMMPIYsolEZrXRIA25h0CukmQ0PTUQNiUkKkhBC5T30Kjl55YBHicx2Zi4UkPD3v/Sk2ocoPXqnPu5ycmc+APv9MBZwnTS/wq
 JBXSOujnccJ3iA8eOI4RZxqpWQGfP/weBAjTPE8lNmdh77EnB/yv209F/gdbF0DPN7YsbCjOCsCrSRcv485pWS9M/f7wE1movpNZstIwylLthZX4QYqB8qdo



On 10/07/24 16:57, Kees Cook wrote:
> AFFS uses struct affs_head's "table" array as a flexible array. Switch
> this to a proper flexible array[1]. There are no sizeof() uses; struct
> affs_head is only ever uses via direct casts. No binary output
> differences were found after this change.
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
> index 5509fbc98bc0..09dc23a644df 100644
> --- a/fs/affs/amigaffs.h
> +++ b/fs/affs/amigaffs.h
> @@ -80,7 +80,7 @@ struct affs_head {
>   	__be32 spare1;
>   	__be32 first_data;
>   	__be32 checksum;
> -	__be32 table[1];
> +	__be32 table[];
>   };
>   
>   struct affs_tail {

