Return-Path: <linux-fsdevel+bounces-19634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A44A8C7FDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 04:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1401C2113B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 02:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3B7490;
	Fri, 17 May 2024 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gFMGmlrI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB121C3D;
	Fri, 17 May 2024 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715912676; cv=none; b=mBtiyEUF5L5+5jZuSVRG3LUNRUd8CARBHtr3cl9cuzAPqmw+pJP3HmrVjG+6UJ81I5myp6fbeBw9F9N1Cna0+ikqOtbde/oawOaY68p6k7uR4XnWt7T4Gt0zarfBHvHNdIzlUpBaGfihTfav8sd/PlkNN0L/KGijIrqfoLWfFaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715912676; c=relaxed/simple;
	bh=tID2YOX1SLQYMBtuqaiQ+jX3nReh6kztXg0zCFxQK20=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iJ5jOXL9AEMExzQEtn5n3t+0X3bilbkQRwqZYIaHAMQVTercYY/8mwUH5ZwnQtPiF+z8UggCXL7/2BlRPG8Ym6P6L1+DLq7E8/EfWb6Kf35NHHyjnrkSkFEOWVLDEa8JfupbCFW1lr5FZGZmiieh5xSEZblxGmw+BUB6zo20Smw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gFMGmlrI; arc=none smtp.client-ip=47.90.199.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715912655; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=WS//wqLveW3F48jzVliMuggkRGFd5j+A30Z6LBwqWC8=;
	b=gFMGmlrIeEYyzUjnRLLpw78oZKiwVmcn6kd/+VYtnIFqPHFxYgYrVIVhmhNJNyFbwbc9vqY7btLa51adUmNAoS91FE5nl5i+Lfi92w4bSscRtYZJxWnpT90ebxIriwFeJn7WKEin8f7b9+CeT0BGbBLNmCcn0C9wVBTPNRUJChY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W6ctotk_1715912653;
Received: from 30.97.48.179(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6ctotk_1715912653)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 10:24:14 +0800
Message-ID: <d8555836-a82a-4305-9221-ac8be18757cc@linux.alibaba.com>
Date: Fri, 17 May 2024 10:24:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] z_erofs_pcluster_begin(): don't bother with rounding
 position down
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
 brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 yukuai3@huawei.com
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
 <20240425195641.GJ2118490@ZenIV> <20240425200017.GF1031757@ZenIV>
 <7ba8c1a3-be59-4a2f-b88a-23b6ab23e1c8@linux.alibaba.com>
 <20240503041542.GV2118490@ZenIV>
 <afe72011-e6d7-4ce6-9157-2d4a998b730f@linux.alibaba.com>
In-Reply-To: <afe72011-e6d7-4ce6-9157-2d4a998b730f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Al,

On 2024/5/3 21:01, Gao Xiang wrote:
> 
> 
> On 2024/5/3 12:15, Al Viro wrote:
>> On Fri, Apr 26, 2024 at 01:32:04PM +0800, Gao Xiang wrote:
>>> Hi Al,
>>
>>> This patch caused some corrupted failure, since
>>> here erofs_read_metabuf() is EROFS_NO_KMAP and
>>> it's no needed to get a maped-address since only
>>> a page reference is needed.
>>>
>>>>            if (IS_ERR(mptr)) {
>>>>                ret = PTR_ERR(mptr);
>>>>                erofs_err(sb, "failed to get inline data %d", ret);
>>>> @@ -876,7 +876,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>>>>            }
>>>>            get_page(map->buf.page);
>>>>            WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
>>>> -        fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
>>>> +        fe->pcl->pageofs_in = offset_in_page(mptr);
>>>
>>> So it's unnecessary to change this line IMHO.
>>
>> *nod*
>>
>> thanks for catching that.
>>
>>> BTW, would you mind routing this series through erofs tree
>>> with other erofs patches for -next (as long as this series
>>> isn't twisted with vfs and block stuffs...)?  Since I may
>>> need to test more to ensure they don't break anything and
>>> could fix them immediately by hand...
>>
>> FWIW, my immediate interest here is the first couple of patches.
> 
> Yes, the first two patches are fine by me, you could submit
> directly.
> 
>>
>> How about the following variant:
>>
>> #misc.erofs (the first two commits) is put into never-rebased mode;
>> you pull it into your tree and do whatever's convenient with the rest.
>> I merge the same branch into block_device work; that way it doesn't
>> cause conflicts whatever else happens in our trees.
>>
>> Are you OK with that?  At the moment I have
>> ; git shortlog v6.9-rc2^..misc.erofs
>> Al Viro (2):
>>        erofs: switch erofs_bread() to passing offset instead of block number
>>        erofs_buf: store address_space instead of inode
>>
>> Linus Torvalds (1):
>>        Linux 6.9-rc2
>>
>> IOW, it's those two commits, based at -rc2.  I can rebase that to other
>> starting point if that'd be more convenient for you.
> 
> Yeah, thanks for that.  I think I will submit two pull requests for
> the next cycle, and I will send the second pull request after your
> vfs work is landed upstream and it will include the remaining
> patches you sent (a bit off this week since we're on holiday here).

Sorry for a bit delay...

I will add #misc.erofs and the following patches with some fix
to -next soon.

Thanks,
Gao Xiang

