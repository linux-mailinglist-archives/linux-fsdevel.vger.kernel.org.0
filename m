Return-Path: <linux-fsdevel+bounces-73859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E78D220FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA5E230549A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 01:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7EC242925;
	Thu, 15 Jan 2026 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="N9k0wpAC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F204741C63;
	Thu, 15 Jan 2026 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768441680; cv=none; b=E3xVKiyhrBwnTn+Hc5XfUnlEvz8QP19gjUsnD+OpLOrqeYg5LqiOn728oXJXDhF/p2uCeKmluNwqpMLFHc/4Dc7XvvVsY6LGuxdBr1ZIqDDXxGrzCZOSu6Ytds4oOBlDSk9xzZ7hlczAmq+iGcFfJE/aDaTCCiND5mNHfglKQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768441680; c=relaxed/simple;
	bh=2V1nvjveLnLp/kZv5iMsAfgFoU/5mK6C0/O1KX+30Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hUfM16FIsB/pcueIzKNpKrjnSFn8M24UEtWFcXjna4laazvQuKcggwUmsd1XX2VnhHxgjT1g89Sp0H06XRO3XxT6nvWVdDlHIMAL0xbJ5cMBdXvHO1uaQqyPc2MLSN2JLA2VUUaBRFkZd6V9erMAmQdrcRxhjKQD594xOjSX//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=N9k0wpAC; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=C01OnGYG1L1pGK2zAThg6CrCN92Wwfy4Y4Qle2Tht9c=;
	b=N9k0wpACInb9szt+0RbGoN/5ovo8SZ0Jp/T/dxpw2H7DlTzctJ1ZP39Lj0NnmNlbIKu9EWRq5
	bhncrOsxRMAydy2dx6wuNQljJTxd1UYRxN4cEgaCsz4Qb+7Du4y6j8M3SLTL+3aos5168/I87yo
	jHyS9Xk2B+YZ+TakkNBolj4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ds5Ps51gwzKmSg;
	Thu, 15 Jan 2026 09:44:33 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E30540565;
	Thu, 15 Jan 2026 09:47:54 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 09:47:53 +0800
Message-ID: <ff6f1338-05aa-49af-a371-69e1d02f7e53@huawei.com>
Date: Thu, 15 Jan 2026 09:47:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/10] erofs: support unencoded inodes for page cache
 share
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-9-lihongbo22@huawei.com>
 <2d33cc2f-8188-4e62-b0be-bf985237bf24@linux.alibaba.com>
 <4152e93b-3f7d-4861-aad9-b7dc1ef71470@huawei.com>
 <2cec78b5-671a-447f-abbe-2b77c1f5d0da@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <2cec78b5-671a-447f-abbe-2b77c1f5d0da@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)



On 2026/1/15 9:46, Gao Xiang wrote:
> 
> 
> On 2026/1/15 09:36, Hongbo Li wrote:
>> Hi,Xiang
>>
>> On 2026/1/14 22:51, Gao Xiang wrote:
>>>
>>>
>>> On 2026/1/9 18:28, Hongbo Li wrote:
>>>> This patch adds inode page cache sharing functionality for unencoded
>>>> files.
>>>>
>>>> I conducted experiments in the container environment. Below is the
>>
>> ...
>>>>               iomap->inline_data = ptr;
>>>> @@ -383,11 +385,16 @@ static int erofs_read_folio(struct file *file, 
>>>> struct folio *folio)
>>>>           .ops        = &iomap_bio_read_ops,
>>>>           .cur_folio    = folio,
>>>>       };
>>>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>>>> +    bool need_iput;
>>>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>>>> +        .realinode = erofs_real_inode(folio_inode(folio), &need_iput),
>>>> +    };
>>>> -    trace_erofs_read_folio(folio, true);
>>>> +    trace_erofs_read_folio(iter_ctx.realinode, folio, true);
>>>>       iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>>>> +    if (need_iput)
>>>> +        iput(iter_ctx.realinode);
>>>>       return 0;
>>>>   }
>>>> @@ -397,12 +404,17 @@ static void erofs_readahead(struct 
>>>> readahead_control *rac)
>>>>           .ops        = &iomap_bio_read_ops,
>>>>           .rac        = rac,
>>>>       };
>>>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>>>> +    bool need_iput;
>>>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>>>> +        .realinode = erofs_real_inode(rac->mapping->host, &need_iput),
>>>> +    };
>>>> -    trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>>>> +    trace_erofs_readahead(iter_ctx.realinode, readahead_index(rac),
>>>>                       readahead_count(rac), true);
>>>
>>> Is it possible to add a commit to update the tracepoints
>>> to add the new realinode first?
>>
>> Yeah, so should we put the update on trace_erofs_read_folio and 
>> trace_erofs_readahead in a single patch after "[PATCH v14 03/10] fs: 
>> Export alloc_empty_backing_file"?
> 
> I think the tracepoint one should be just before this patch.
> 
>>
>>   Since the first two patches in this series has merged in vfs tree 
>> (thanks Christian), should we reorder the left patches?
> 
> I think you just send the new patchset version
> in the future without the first two patches
> in the version.
> 

Ok,

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
>>

