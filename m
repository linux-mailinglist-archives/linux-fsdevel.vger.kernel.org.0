Return-Path: <linux-fsdevel+bounces-72124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAC5CDF33B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 02:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EDF4300ACD4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 01:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5669D1CEAA3;
	Sat, 27 Dec 2025 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GMn49GJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204C18E1F
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766798681; cv=none; b=gIU7WRqXDv+r3DQaieiDnq/7wFcSN+rGiXUDw4aJyj+VNYaQHUqJHm91LVnGPi0V0xDMnEuxl+a2k2+by7PH1FxTaI1p5U3sUeKIgHTUWoLSaeWID3ybQ9NxrZUdFQiYOAPtaan+IYYBow3rNj4udxfTp2ooPupoqcTUOtV/sTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766798681; c=relaxed/simple;
	bh=XuJ+VqquQkeSCQHJyIS16B0b4CgwSQF44DdNxPFaztc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X8bScPYpHox6ejkZXBEcX3lmsJdDslnb0J6+eLIHTN2KmFznkpWikslKONqCCQ0B871AMtA1zpwZOSrrFOAX9W4kG0DEbD5x1S2224uP6dm6SrFazo9ujZ830CitiS/BcbOksn4IIDLsh6PyVfLs7mAMG1bZArfXKeuizO3m8YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GMn49GJq; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ho5QV9/TnOp2NE1FOM+sYQerAf2ACztkwBtddDPusaI=;
	b=GMn49GJq/1bIXUv9aQ3x6KUZkCIcE0ds2NorFN8VczLqYae8LYkCnpR4F3AABmGX71AIT+wTz
	/UeqZwVF3ZhPzZk5cYWjgPFWk/oUDxte1kYR1O3FIlvf7PU1EOjRwlWAkJpuel1OviNSQj4gMez
	SCRvf8TPL7UaVrdSwQAYYy0=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4ddPns1fP5z1cySw;
	Sat, 27 Dec 2025 09:21:21 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 4817740565;
	Sat, 27 Dec 2025 09:24:29 +0800 (CST)
Received: from [10.174.179.179] (10.174.179.179) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 27 Dec 2025 09:24:28 +0800
Message-ID: <eefae4cc-ec75-4378-a153-c190fdc230c1@huawei.com>
Date: Sat, 27 Dec 2025 09:24:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] memory leak of xa_node in collapse_file() when
 rollbacks
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, "David Hildenbrand (Red
 Hat)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Matthew
 Wilcox <willy@infradead.org>, <ziy@nvidia.com>, <lorenzo.stoakes@oracle.com>,
	<baolin.wang@linux.alibaba.com>, <Liam.Howlett@oracle.com>,
	<npache@redhat.com>, <ryan.roberts@arm.com>, <dev.jain@arm.com>,
	<baohua@kernel.org>, <lance.yang@linux.dev>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>
CC: Kefeng Wang <wangkefeng.wang@huawei.com>, <shardulsb08@gmail.com>
References: <86834731-02ba-43ea-9def-8b8ca156ec4a@huawei.com>
 <32e4658f-d23b-4bae-9053-acdd5277bb17@kernel.org>
 <4b129453-97d1-4da4-9472-21c1634032d0@huawei.com>
 <05bbe26e-e71a-4a49-95d2-47373b828145@kernel.org>
 <a629d3bb-c7e2-41e0-87e0-7a7a6367c1b6@huawei.com>
 <308b7b3c4f6c74c46906e25d6069049c70222ed8.camel@mpiricsoftware.com>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <308b7b3c4f6c74c46906e25d6069049c70222ed8.camel@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500001.china.huawei.com (7.202.194.229)


在 2025/12/25 12:15, Shardul Bankar 写道:
> On Thu, 2025-12-18 at 21:11 +0800, Jinjiang Tu wrote:
>> 在 2025/12/18 20:49, David Hildenbrand (Red Hat) 写道:
>>   
>>>   Thanks for checking. I thought that was also discussed as part of
>>> the other fix.
>>>   
>>>   See [2] where we have
>>>   
>>>   "Note: This fixes the leak of pre-allocated nodes. A separate fix
>>> will
>>>   be needed to clean up empty nodes that were inserted into the tree
>>> by
>>>   xas_create_range() but never populated."
>>>   
>>>   Is that the issue you are describing? (sounds like it, but I only
>>> skimmed over the details).
>>>   
>>>   CCing Shardul.
>> Yes, the same issue. As I descirbed in the first email:
>> "
>> At first, I tried to destory the empty nodes when collapse_file()
>> goes to rollback path. However,
>> collapse_file() only holds xarray lock and may release the lock, so
>> we couldn't prevent concurrent
>> call of collapse_file(), so the deleted empty nodes may be needed by
>> other collapse_file() calls.
>> "
> Hi David, Jinjiang,
>
> As Jinjiang mentioned, this appears to address what I had originally
> referred to in the "Note:" in [1].
>
> Just to clarify the context of the "Note:", that was based on my
> assumption at the time that such empty nodes would be considered leaks.
> After Dev’s feedback in [2]:
> "No "fix" is needed in this case, the empty nodes are there in the tree
> and there is no leak."
>
> and looking at the older discussion in [3]:
> "There's nothing to free; if a node is allocated, then it's stored in
> the tree where it can later be found and reused. "

However, if the empty nodes aren't reused, When the file is deleted,
shmem_evict_inode()->shmem_truncate_range() traverses all entries and
calls xas_store(xas, NULL) to delete, if the leaf xa_node that stores
deleted entry becomes empty, xas_store() will automatically delete the
empty node and delete it's parent is empty too, until parent node isn't
empty. shmem_evict_inode() won't traverse the empty nodes created by
xas_create_range() due to these nodes doesn't store any entries.

>
> my updated understanding is that there is no leak in this case- the
> nodes remain valid and reusable, and therefore do not require a
> separate fix.
>
> David could you correct me if I am mistaken?
>
> [1]
> https://lore.kernel.org/linux-mm/20251123132727.3262731-1-shardul.b@mpiricsoftware.com/
>
> [2]
> https://lore.kernel.org/linux-mm/57cbf887-d181-418b-a6c7-9f3eff5d632a@arm.com/
>
> [3]
> https://lore.kernel.org/all/Ys1r06szkVi3QEai@casper.infradead.org/
>
> Thanks,
> Shardul
>

