Return-Path: <linux-fsdevel+bounces-36006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDE39DA96C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 14:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42868B23356
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236D1FCFC2;
	Wed, 27 Nov 2024 13:55:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBED41FA165
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715749; cv=none; b=p0j40Wa9s/ZH7iH0xSqAq+3t/0YIQqfJmYQp4/ik1Zw3S/qATgICqY1jWi9CdNRWcDAYO8/7eVwSf3ccei3qFwJRV294hFEvwy7LVq1LCeknYxfCB3Z9sas+aiQlDCFdZjWZZ5zLcof7bKQd65SLrLeE4leBlLwGc5qOraMfwx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715749; c=relaxed/simple;
	bh=gcf5dqFnJqlnQXl77MZDDkROdrbMCR+Pi0upIFJqN6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pVcMEmlePWljFw/xEzhSL3w8/ndqEbkDDfmvawvrM9E+uHr1v9YqEBxUHOgY+/Nis0YuGOvUseROogBdgS31qMyuXKuYpcB5kVrhY8MEpfek/HLL9vT/UwA3optXrRqYgy+wkkhng+VY7Nn79JwFxFWJ/cGsX1Pz6HudP7G57Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xz19G15C8z11LqD;
	Wed, 27 Nov 2024 21:52:50 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 06F9B1800A1;
	Wed, 27 Nov 2024 21:55:38 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 21:55:37 +0800
Message-ID: <992a1e43-67c5-4686-b10c-f82c9942daac@huawei.com>
Date: Wed, 27 Nov 2024 21:55:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML mount failure with Linux 6.11
To: Karel Zak <kzak@redhat.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>,
	<rrs@debian.org>
References: <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
 <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
 <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/11/27 20:02, Karel Zak wrote:
> On Wed, Nov 27, 2024 at 09:26:46AM GMT, Hongbo Li wrote:
>>
>>
>> On 2024/11/26 21:50, Johannes Berg wrote:
>>> On Mon, 2024-11-25 at 18:43 +0100, Karel Zak wrote:
>>>>
>>>> The long-term solution would be to clean up hostfs and use named
>>>> variables, such as "mount -t hostfs none -o 'path="/home/hostfs"'.
>>>
>>> That's what Hongbo's commit *did*, afaict, but it is a regression.
>>>
>>> Now most of the regression is that with fsconfig() call it was no longer
>>> possible to specify a bare folder, and then we got discussing what
>>> happens if the folder name actually contains a comma...
>>>
>>> But this is still a regression, so we need to figure out what to do
>>> short term?
>>>
>> So for short term, even long term, can we consider handling the hostfs
>> situation specially within libmount?
> 
> Yes (see reply to Johannes ).
> 
>> Such as treat the whole option as one
>> key(also may be with comma, even with equal)
> 
> There could be userspace specific options, VFS flags, etc.
> 
>    -o /home/hostfs,ro,noexec
> 
> Is it one path or path and two options?
> 
Interesting!
Perhaps more documentation is needed. VFS flags is filtered, but for 
hostfs, it is a valid path. The semantics seems not very complete. :)

Thanks,
Hongbo

>> in this case, libmount will
>> use it as FSCONFIG_SET_FLAG. We can do that because for hostfs, it only has
>> one mount option, and no need for extension.
> 
> We can automatically add a key (e.g. hostfs=) and use FSCONFIG_SET_FLAG.
> The goal should be to get the path as a value, because key is limited to
> 256 bytes.
> 
>      Karel
> 

