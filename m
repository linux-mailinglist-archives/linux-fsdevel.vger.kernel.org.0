Return-Path: <linux-fsdevel+bounces-33864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F189BFE67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 07:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7746B283388
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 06:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AF919412E;
	Thu,  7 Nov 2024 06:22:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E316419
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730960544; cv=none; b=fj4dK6UHfJrINP3JEUj2h4ip0fH5JaQJU+VlKBrDZy+DcKIv3s6B95STWdKHJlCx3SzDg5z8CaMydqMCCvh0EjJI7oKv0qniLD6/eAOq5OuRkWjoNFZhj9TF2X+tMTfpLbQaRDOZVJq457mJRR35ZjmaWdLku6Ov996+cal84+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730960544; c=relaxed/simple;
	bh=3Mgu3QYFzA0jOlZXMXopERQ4wtIKpCX/uv8Ii+uvysQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=lJufJ9caCn6bK0r6NmBlVjQj4WLHTHZa6A6TVZlxXfRAzRyqDrVWhKJv5EbkGoxNaewXSpP2yyQJv9d2PjVMNLwj7COt7meAU+Bl6Jd0qwuu2ACsmNmTqdelqxUJDzFktmax0+syqkQzW0uPkl1sfIpchRC2+33evxQ+pEIrCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XkX4f06dtz1jx2q;
	Thu,  7 Nov 2024 14:20:34 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id EB08E1A0188;
	Thu,  7 Nov 2024 14:22:15 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 14:22:15 +0800
Message-ID: <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
Date: Thu, 7 Nov 2024 14:22:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML mount failure with Linux 6.11
To: <rrs@debian.org>, Benjamin Berg <benjamin@sipsolutions.net>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
 <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
Content-Language: en-US
CC: <linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)


Hi Ritesh and Benjamin,

I have read the context in [1]. It seems your tool has already used new 
mount api to mount the hostfs. It now rejects unknown mount options as 
many other filesystems do regardless of its earlier behavior (which 
treats any option as the root directory in hostfs).

This should be clarified for unknown option. For older hostfs (before 
new mount api), it treats the whole string behind -o as the root 
directory. This will allow any mount options, but also limit its 
extension. It is not the same as other mainline filesystems which will 
split the option string with ','. So for these filesystems, they can 
consider whether reject unknown mount options or not.

I'm not sure it is reasonable in this way. If we accept unknown option 
in the hostfs, it will be treated as root directory. But which one 
should be used (like mount -t hostfs -o unknown,/root/directory none 
/mnt). So in the conversion, we introduce the `hostfs` key to mark the 
root directory. May be we need more discussion about use case.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1086194


Thanks,
Hongbo

On 2024/11/7 3:25, Benjamin Berg wrote:
> Hi,
> 
> I am probably not the right person to talk to. Maybe Hongbo Li can say
> more?
> 
> That said, it looks like the filesystem now has the "hostfs" option. So
> you can probably just use
>    mount -t hostfs -o hostfs=/path none /mount/point
> which is nicer anyway. Just a bit annoying as you probably need to pass
> it differently for older kernels.
> 
> Benjamin
> 
> On Wed, 2024-11-06 at 17:22 +0530, Ritesh Raj Sarraf wrote:
>> Hello Benjamin,
>>
>> On Thu, 2024-10-31 at 11:07 +0100, Benjamin Berg wrote:
>>> Hi,
>>>
>>> Newer kernels have become more picky about that with the new mount
>>> API.
>>> This is relevant, see the discussion about "Unknown options":
>>>    https://lwn.net/Articles/979166/
>>>
>>> We only use hostfs for the root file system and in that case it
>>> works
>>> well if you pass the path using "hostfs=/path" on the kernel
>>> command
>>> line. Doing that avoids issues when remounting the file system
>>> later
>>> on.
>>>
>>
>> As upstream developers for UML, what would you conclude it as ?
>>
>> We've recommended using hostfs for the UML kernel modules as well.
>> What
>> would be the alternate approach to ensuring a proper boot for a
>> modular
>> UML kernel ?
>>
>>
>>> I suppose that currently it does not work to mount hostfs later on.
>>> No
>>> idea what the right fix is. Maybe the host directory should be an
>>> explicit option like "hostpath=..." or so to make it compatible
>>> with
>>> the new mount APIs.
>>
>> The ability to mount any hostfs mount point was/is a feature provided
>> by UML. We've used it and integrated with many tools like debos,
>> fakemachine etc; the Debian bug report has the details.
>>
>> There'll be more reports following once UML 6.11 hits Debian Testing.
>>
>> I hadn't expected a working feature to break with a newer Linux
>> release. :-(
>>
>> Thanks,
>> Ritesh
>>
> 
> 

