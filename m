Return-Path: <linux-fsdevel+bounces-33908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F149C08AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 15:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09901F2422C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 14:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED1B212179;
	Thu,  7 Nov 2024 14:17:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87671E502
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989035; cv=none; b=FThfyJZ9TTejZmWupMt6yTbPxgAU9y2WyeqVf2V6BdwHZF3rEoalDDtsozDTNpv0LsSSSvsvCcNxuEHMVjNTeSHRQjAqM2bnqBH7TJ09O9oohsg8/aFdrwgA6wXZtMA4Dt2nnHzQOIJ6Hk2RkfApAVZuRJpMsObDyzVFGz3QBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989035; c=relaxed/simple;
	bh=ESEs8cjOlgay8TYK0zWf6mfRl0Dp+XGeRqucTaiwfmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mQi3BZGNG6GZL7dp30xaAesNiSvPKzwg9v9PNeIHSb8Kts+IQBfIlc8G6zbATrnUc5N1N6D+8/N5pHVqz5xkJA6Xnylkngy5s8ETv9ndfhM9ORn0er5jok/Jin36jzDWtYwRU6ZzomZiuaiBbsvxcuWw3notVOYsOtUe+ri8qto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XkkbX2HZdz923c;
	Thu,  7 Nov 2024 22:14:32 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id B58121402CB;
	Thu,  7 Nov 2024 22:17:09 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 22:17:09 +0800
Message-ID: <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
Date: Thu, 7 Nov 2024 22:17:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML mount failure with Linux 6.11
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <rrs@debian.org>
CC: <linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
 <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/11/7 21:09, Johannes Berg wrote:
> Hi,
> 
> So took me a while to grok the context, and to understand why it was
> working for me, and broken on another machine...
> 
> 
>> I have read the context in [1]. It seems your tool has already used new
>> mount api to mount the hostfs.
> 
> Yes, however, that's a default that's entirely transparent to the user.
> This is why I wasn't seeing the errors, depending on the machine I'm
> running this on, because the 'mount' tool either uses the old or new
> style and the user can never know.
> 
>> It now rejects unknown mount options as
>> many other filesystems do regardless of its earlier behavior (which
>> treats any option as the root directory in hostfs).
> 
> And that's clearly the root cause of this regression.
> 
> You can't even argue it's not a regression, because before cd140ce9f611
> ("hostfs: convert hostfs to use the new mount API") it still worked with
> the new fsconfig() API, but with the old mount options...
> 
>> I'm not sure it is reasonable in this way. If we accept unknown option
>> in the hostfs, it will be treated as root directory. But which one
>> should be used (like mount -t hostfs -o unknown,/root/directory none
>> /mnt). So in the conversion, we introduce the `hostfs` key to mark the
>> root directory. May be we need more discussion about use case.
> 
> There's only one option anyway, so I'd think we just need to fix this
> and not require the hostfs= key. Perhaps if and only if it starts with
> hostfs= we can treat it as a key, otherwise treat it all as a dir? But I

May be we can do that (just record the unknown option in host_root_path 
when fs_parse failed). But this lead us to consider the case in which we 
should handle a long option -o unknown1,hostfs=xxx,unknow2, which one 
should be treated as the root directory? For new mount api, it will call 
fsconfig three times to set the root directory. For older one, if one 
path with that name exactly, may be it can mount successfully.


Thanks,
Hongbo

> guess the API wouldn't make that easy.
> 
> Anyway, I dunno, but it seems like a regression to me and we should try
> to find a way to fix it.
> 
> johannes
> 

