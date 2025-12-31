Return-Path: <linux-fsdevel+bounces-72265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8FDCEB57A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 07:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F7C33008F7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 06:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5D930FC06;
	Wed, 31 Dec 2025 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hVRJCtJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20526ED37
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767162599; cv=none; b=rqWq8CKSl8IU5zDBIJfhh3hV48IoRF3Aj0MnZ/RA4j/cJp0616ao3NdAE1wPRrMHFYoC7F9BjNKOwq5w+SucAIfeVRPevFMvc+9FD7RAI2Y3q0kQ1RI9ikxPm68SDtJMzrVMk0WDCnNF8u124hZFO6HO5AdNcWKmT7WMJ8Vp/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767162599; c=relaxed/simple;
	bh=1RSfSYBNa7e0fH7t0XJCbuj43+2eUcd50rcvO7kGlus=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QyAn7Cp7skrZ9iC1KbK4DJmiyLJqRSf1ssSrCJFnnrKfwtJ+UA6y4endBexJvbSaCt2dlvDmP+IXdxPFo3MprHHiNbvC+Wa6yW/2U97n5L/Bf9L5WJyjCdQRQTYOV78B/UVkUkdCofpGZCQNlvBp+GPwxkEknvwflTbok0q22Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hVRJCtJg; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OBZ82aL9b7XNQ4dgrQ9a9vD5S2v4QAbv6HVlWFGJKqw=;
	b=hVRJCtJglHsECW5aMgKWBl5cpHeS/R1XL6hcv7f97eMiMbMMdCsnDZI3pbDmTEmHEguqOt9zU
	6SCFZT4tliZMGtJS7IIHlVuyBx3QG3pbzF718NMNPXQtYh8PG/YtEtTdhrW2sGDB9RrdfFTTnKW
	yyGhHnhsnKL1c/pbMFqVKFA=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dh0NG5zd5zpSvr;
	Wed, 31 Dec 2025 14:26:38 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 77A1520104;
	Wed, 31 Dec 2025 14:29:47 +0800 (CST)
Received: from [10.174.179.179] (10.174.179.179) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 31 Dec 2025 14:29:46 +0800
Message-ID: <43024ae3-4131-4381-a766-5ca674d3f87d@huawei.com>
Date: Wed, 31 Dec 2025 14:29:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] memory leak of xa_node in collapse_file() when
 rollbacks
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, Shardul Bankar
	<shardul.b@mpiricsoftware.com>, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, <ziy@nvidia.com>,
	<lorenzo.stoakes@oracle.com>, <baolin.wang@linux.alibaba.com>,
	<Liam.Howlett@oracle.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <lance.yang@linux.dev>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
CC: Kefeng Wang <wangkefeng.wang@huawei.com>, <shardulsb08@gmail.com>
References: <86834731-02ba-43ea-9def-8b8ca156ec4a@huawei.com>
 <32e4658f-d23b-4bae-9053-acdd5277bb17@kernel.org>
 <4b129453-97d1-4da4-9472-21c1634032d0@huawei.com>
 <05bbe26e-e71a-4a49-95d2-47373b828145@kernel.org>
 <a629d3bb-c7e2-41e0-87e0-7a7a6367c1b6@huawei.com>
 <308b7b3c4f6c74c46906e25d6069049c70222ed8.camel@mpiricsoftware.com>
 <eefae4cc-ec75-4378-a153-c190fdc230c1@huawei.com>
 <fc73a7a4-c66b-4437-b581-43bd7e5fae8d@kernel.org>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <fc73a7a4-c66b-4437-b581-43bd7e5fae8d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500001.china.huawei.com (7.202.194.229)


在 2025/12/31 5:03, David Hildenbrand (Red Hat) 写道:
> On 12/27/25 02:24, Jinjiang Tu wrote:
>>
>> 在 2025/12/25 12:15, Shardul Bankar 写道:
>>> On Thu, 2025-12-18 at 21:11 +0800, Jinjiang Tu wrote:
>>>> 在 2025/12/18 20:49, David Hildenbrand (Red Hat) 写道:
>>>>>    Thanks for checking. I thought that was also discussed as part of
>>>>> the other fix.
>>>>>       See [2] where we have
>>>>>       "Note: This fixes the leak of pre-allocated nodes. A 
>>>>> separate fix
>>>>> will
>>>>>    be needed to clean up empty nodes that were inserted into the tree
>>>>> by
>>>>>    xas_create_range() but never populated."
>>>>>       Is that the issue you are describing? (sounds like it, but I 
>>>>> only
>>>>> skimmed over the details).
>>>>>       CCing Shardul.
>>>> Yes, the same issue. As I descirbed in the first email:
>>>> "
>>>> At first, I tried to destory the empty nodes when collapse_file()
>>>> goes to rollback path. However,
>>>> collapse_file() only holds xarray lock and may release the lock, so
>>>> we couldn't prevent concurrent
>>>> call of collapse_file(), so the deleted empty nodes may be needed by
>>>> other collapse_file() calls.
>>>> "
>>> Hi David, Jinjiang,
>>>
>>> As Jinjiang mentioned, this appears to address what I had originally
>>> referred to in the "Note:" in [1].
>>>
>>> Just to clarify the context of the "Note:", that was based on my
>>> assumption at the time that such empty nodes would be considered leaks.
>>> After Dev’s feedback in [2]:
>>> "No "fix" is needed in this case, the empty nodes are there in the tree
>>> and there is no leak."
>>>
>>> and looking at the older discussion in [3]:
>>> "There's nothing to free; if a node is allocated, then it's stored in
>>> the tree where it can later be found and reused. "
>>
>> However, if the empty nodes aren't reused, When the file is deleted,
>> shmem_evict_inode()->shmem_truncate_range() traverses all entries and
>> calls xas_store(xas, NULL) to delete, if the leaf xa_node that stores
>> deleted entry becomes empty, xas_store() will automatically delete the
>> empty node and delete it's parent is empty too, until parent node isn't
>> empty. shmem_evict_inode() won't traverse the empty nodes created by
>> xas_create_range() due to these nodes doesn't store any entries.
>
> So you're saying that nothing/nobody would clean up these xarray 
> entries and we'd be leaking them?
Yes.
>
> "struct xarray" documents "If all of the entries in the array are 
> NULL, @xa_head is a NULL pointer.". So we depend on all entries being 
> set to NULL in order to properly cleanup/free the xarray automatically.
>
Yes

