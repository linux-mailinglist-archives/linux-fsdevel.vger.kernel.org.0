Return-Path: <linux-fsdevel+bounces-72596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D107CFCAF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 09:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C00B30399AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB92E5B21;
	Wed,  7 Jan 2026 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TC6Orfwj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A662DECCB;
	Wed,  7 Jan 2026 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775919; cv=none; b=NRxx0tdLlasgFuFUH6jzXSjaW9CJGWcBjpDgwTQWTelqOWPuJRqVZLPt0jfLq2cBK8+nEfYKSsAXtqAkI03iTx7XA3BMVW/5ZM75R3qqaLU0R0cHiud5VL1MQAxjue9tsM4z0IVDXu1IpW/7Cd/ceF+MjUqYjMEjyj7ltERB9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775919; c=relaxed/simple;
	bh=tqlt8znxd6J4lRsCg8/U+yJChlwMx4AMAHbrfXSZwHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IhUu2g4aV3YH/IYJ/yJdX4u1igGCu6AlFqfoioFyhV14xs3aBPjNj2/vQiQdhUxRhk2sueXhI6yB/1cYKOomsfNCayaQE1MirmXpAaQ75RpLDtJP+7eejNhzDMVTvrVHoClZOXn5lbdRLxhQtgiMWzWhO2XVgGJcXo59IzMKu2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TC6Orfwj; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=108JVCh9GjW5xEolruiVkAuLbJubn8gbsNhgLVBoKqk=;
	b=TC6OrfwjILeUR0KaiqaMcbO4w48VARs0s030Z2ePHb4C042l+lNMSEY4UOVf3It7FQzoGUqwE
	lGF4NhoysCpulm2w2SyOkk+vfiIymdRLydvpPBDq8pHNoIEk+f2HcqZJEnuLWP/0bj4NCYNPujK
	N/37crmhGe9aPhZEIh1vFIo=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dmMBp21pBz1cyQn;
	Wed,  7 Jan 2026 16:48:34 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 2989E40539;
	Wed,  7 Jan 2026 16:51:49 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 16:51:48 +0800
Message-ID: <eeb5efea-aa9c-449b-b2f8-157130b02aed@huawei.com>
Date: Wed, 7 Jan 2026 16:51:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/10] erofs: introduce the page cache share feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
	<brauner@kernel.org>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-8-lihongbo22@huawei.com>
 <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
 <b690d435-7e9c-4424-a681-d3f798176202@huawei.com>
 <df2889c0-6027-4f42-a013-b01357fd0005@linux.alibaba.com>
 <07212138-c0fc-4a64-a323-9cab978bf610@huawei.com>
 <9bacd58e-40be-4250-9fab-7fb8e2606ad8@linux.alibaba.com>
 <48755c73-323d-469e-9125-07051daf7c19@huawei.com>
 <d82c60eb-a170-48fe-9e50-e64c80681cb6@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <d82c60eb-a170-48fe-9e50-e64c80681cb6@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)



On 2026/1/7 15:53, Gao Xiang wrote:
> 
> 
> On 2026/1/7 15:32, Hongbo Li wrote:
>>
>>
>> On 2026/1/7 15:27, Gao Xiang wrote:
>>>
>>>
>>> On 2026/1/7 15:17, Hongbo Li wrote:
>>>> Hi, Xiang
>>>>
>>>
>>> ...
>>>
>>>>>>>> +
>>>>>>>> +bool erofs_ishare_fill_inode(struct inode *inode)
>>>>>>>> +{
>>>>>>>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>>>>>>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>>>>>>> +    struct erofs_inode_fingerprint fp;
>>>>>>>> +    struct inode *sharedinode;
>>>>>>>> +    unsigned long hash;
>>>>>>>> +
>>>>>>>> +    if (!test_opt(&sbi->opt, INODE_SHARE))
>>>>>>>> +        return false;
>>>>>>>> +    (void)erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id);
>>>>>>>> +    if (!fp.size)
>>>>>>>> +        return false;
>>>>>>>
>>>>>>> Why not just:
>>>>>>>
>>>>>>>      if (erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id))
>>>>>>>          return false;
>>>>>>>
>>>>>>
>>>>>> When erofs_sb_has_ishare_xattrs returns false, 
>>>>>> erofs_xattr_fill_ishare_fp also considers success.
>>>>>
>>>>> Then why !test_opt(&sbi->opt, INODE_SHARE) didn't return?
>>>>>
>>>>
>>>> The MOUNT_INODE_SHARE flag is passed from user's mount option. And 
>>>> it is controllered by CONFIG_EROFS_FS_PAGE_CACHE_SHARE. I doesn't do 
>>>> the check when the superblock without ishare_xattrs. (It seems the 
>>>> mount options is static, although it is useless for mounting with 
>>>> inode_share on one EROFS image without ishare_xattrs).
>>>> So should we check that if the superblock has not ishare_xattrs 
>>>> feature, and we return -ENOSUPP?
>>>
>>> I think you should just mask off the INODE_SHARE if the on-disk
>>> compat feature is unavailable, and print a warning just like
>>> FSDAX fallback.
>>>
>>
>> Ok, it seems reasonable, and also can remove the check logic in 
>> erofs_xattr_fill_ishare_fp. I will change in next version.
> 
> I think you should move
> 
> if (!test_opt(&sbi->opt, INODE_SHARE))
>      return -EOPNOTSUPP;
> 
> into erofs_xattr_fill_inode_fingerprint() directly.
> 

Ok.

Thanks,
Hongbo

> Thanks,
> Gao Xiang

