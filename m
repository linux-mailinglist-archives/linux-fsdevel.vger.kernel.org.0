Return-Path: <linux-fsdevel+bounces-34585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EDE9C66A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 02:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEAE1B28542
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BD917BD9;
	Wed, 13 Nov 2024 01:23:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC245382
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461033; cv=none; b=rcGudBK/zakNEegvedf9zDbnYA4S7af3+mNdxlEdv3FiXUetxgH/FLxECjKX22emXY0GwK9j3gKMoopcYFQEsqODYPlc5oDLSU7UOulFisnuH4+dHk7Hx65mrEvAB/CAxmeAYINoDfkwOHl6ZU3sbraUQNdX0GwvgvgHMtN966I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461033; c=relaxed/simple;
	bh=WXTS22Gi8E3G86TOGsUW6pD4W8Uw3SDLxlF5+ZmX4bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c4TpAvYl5Rxm1HTxdRDJlPRmxafzyo6O+1qgNpTM+cEcdpZQlsfP7UioyvPFZqc0Ug6TpG6gWTDHnlBQoQEz5t0cxJtfs3lH3uu8gAiAjQa0Z92wTDiSBh1qmto8rlUL/WaFPVR1GbJ4G2lhpGPauF6S0Dr5fuoYJC7tF9FwlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xp59J5KBtz1SGMp;
	Wed, 13 Nov 2024 09:21:56 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D2C71180042;
	Wed, 13 Nov 2024 09:23:46 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 09:23:46 +0800
Message-ID: <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
Date: Wed, 13 Nov 2024 09:23:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML mount failure with Linux 6.11
To: Karel Zak <kzak@redhat.com>
CC: <linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>,
	Johannes Berg <johannes@sipsolutions.net>, <rrs@debian.org>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
 <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/11/13 4:10, Karel Zak wrote:
> 
>   Hi,
> 
> On Mon, Nov 11, 2024 at 09:16:18AM GMT, Hongbo Li wrote:
>> We are discussing about the hostfs mount with new mount API in [1]. And may
>> need your help.
>>
>> After finishing the conversion to the new mount API for hostfs, it
>> encountered a situation where the old version supported only one mount
>> option, and the whole mount option was used as the root path (it is also
>> valid for the path to contain commas). But when switching to the new mount
>> API, the option part will be split using commas (if I'm not mistaken, this
>> step would be done in libmount), which could potentially split a complete
>> path into multiple parts, and the call fsconfig syscall to set the mount
>> options for underline filesystems. This is different from the original
>> intention of hostfs. And this kind of situation is not common in other
>> filesystems.
> 
> The options has been always parsed by mount(8) and it's very fragile
> to assume that kernel get as in the original order (etc.).
> 
> For decades, commas have been supported in mount options. For example,
> SeLinux uses them frequently in context settings. All you need to do
> is use quotes, but be careful because the shell will strip them off.
> Therefore, double quoting is required.
>

Thanks for your reply!

If I'm not mistaken, we should add double quoting explicitly if we need 
commas in mount options. However, it seems different for hostfs. For 
example, with hostfs, if we use "mount -t hostfs none -o 
/home/hostfs,dir /mnt" in the older interface, which can successfully 
mount the host directory `/home/hostfs,dir`, then we should use "mount 
-t hostfs none -o '"/home/hostfs,dir"' /mnt" in the new interface. If 
that is the case, we should change the mount command which is hardcoded 
in the original project.

Thanks,
Hongbo

>     mount -o 'rw,bbb="this,is,value",ccc'
> 
> It's also supported in fstab, just use name="v,a,l,u,e"
> 
> You can try it:
> 
>   # strace -e fsconfig mount -t tmpfs -o 'rw,bbb="this,is,value",ccc' tmpfs /dontexist
> 
>   fsconfig(3, FSCONFIG_SET_STRING, "source", "tmpfs", 0) = 0
>   fsconfig(3, FSCONFIG_SET_FLAG, "rw", NULL, 0) = 0
>   fsconfig(3, FSCONFIG_SET_STRING, "bbb", "this,is,value", 0) = -1 EINVAL
> 
> You can see the expected result when using fsconfig().
> 
>   Karel
> 
> 

