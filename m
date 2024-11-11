Return-Path: <linux-fsdevel+bounces-34176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8441B9C35D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 02:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8433B21544
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 01:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45486C8F0;
	Mon, 11 Nov 2024 01:16:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C525A29
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 01:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731287792; cv=none; b=b/hVG/E6/33IxaglgvS3IqB/OZ8EvKGQ4/+xiyp1E0ELC0ECZrBVv7t+Keyopr+OUHrTw/lNxyDjmDmet/o0xXBv2yYfIKla210ZTgtUUaP9cnDUEqvxryhgN0ywRuq/TLPaU87qfVz4g76u9rnjrmfCUSOt0o7+oENICxhCqt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731287792; c=relaxed/simple;
	bh=q/RgfiowdVYBal1YZo+5v6hBAH9B26v4p8quWda7QgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t4zoK55TijUohNrfU2akTF7ZnDw8JTPTGkPtckQL3DUIIjSdgUgrqyG6AWuodZiDYaItAh/uKOTveifJ1DfqHCOrZao0y4P+dGOoPQg91YS5h6P1JJu9uAmrURrNIhIGqRCjDZKMS0xlNWdOdc4tJkaBtoPKV7bRoxFjFGk4uiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xms5j1Ymwz1hwRL;
	Mon, 11 Nov 2024 09:14:33 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id BACE91402D0;
	Mon, 11 Nov 2024 09:16:20 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 09:16:20 +0800
Message-ID: <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
Date: Mon, 11 Nov 2024 09:16:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML mount failure with Linux 6.11
To: <kzak@redhat.com>
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
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Hi Karel,

We are discussing about the hostfs mount with new mount API in [1]. And 
may need your help.

After finishing the conversion to the new mount API for hostfs, it 
encountered a situation where the old version supported only one mount 
option, and the whole mount option was used as the root path (it is also 
valid for the path to contain commas). But when switching to the new 
mount API, the option part will be split using commas (if I'm not 
mistaken, this step would be done in libmount), which could potentially 
split a complete path into multiple parts, and the call fsconfig syscall 
to set the mount options for underline filesystems. This is different 
from the original intention of hostfs. And this kind of situation is not 
common in other filesystems.

Is it necessary to handle the hostfs situation specially within libmount.

[1] 
https://lore.kernel.org/all/ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net/T/

Thanks,
Hongbo


On 2024/11/7 22:35, Johannes Berg wrote:
> On Thu, 2024-11-07 at 22:17 +0800, Hongbo Li wrote:
>>> There's only one option anyway, so I'd think we just need to fix this
>>> and not require the hostfs= key. Perhaps if and only if it starts with
>>> hostfs= we can treat it as a key, otherwise treat it all as a dir? But I
>>
>> May be we can do that (just record the unknown option in host_root_path
>> when fs_parse failed). But this lead us to consider the case in which we
>> should handle a long option -o unknown1,hostfs=xxx,unknow2, which one
>> should be treated as the root directory? For new mount api, it will call
>> fsconfig three times to set the root directory. For older one, if one
>> path with that name exactly, may be it can mount successfully.
> 
> Technically, comma _is_ valid in a dir name, as you say ... so perhaps
> the new mount API handling would need to be modified to have an escape
> for this and not split it automatically, if the underlying FS doesn't
> want that? Or we just revert cd140ce9f611 too?
> 
> I feel like perhaps we just found a corner case - clearly the new mount
> API assumes that mount options are always comma-separated, but, well,
> turns out that's simply not true since hostfs has only a single option
> and treats the whole thing as a single string.
> 
> johannes
> 

