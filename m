Return-Path: <linux-fsdevel+bounces-18610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F1E8BACF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D69B227A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B215382D;
	Fri,  3 May 2024 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ScwgviME"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3D14267;
	Fri,  3 May 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741302; cv=none; b=Lv2+REK0tC3Se2T4uuMz0VO+pzlqXV5srUDcQ527+hWG4xantXhtGUNpPHWeFm25eyLlLVxJhCGn2anPtnlWp/AmTOHK2VFSRrJoOP3yZyjFRSh8KqI3SUVdYNi7cfBHfc/WBQFo5Yhtxflfa4gm9o401OVroGZXQaQXRUw3cIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741302; c=relaxed/simple;
	bh=tkWOYpBTX1ragk+/y68Re0nzBv9+jwv8Ga7g1pbZG8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbI7PIM3DaZWr/1nzmq5hWzNkmciQBOXLiAFsu0jEHpl05SL85gZVqqg33uzhZHZ25Q/kH7Tf4WngYP1OFa7aXl5I2GE/2GYDQKzxRE0wbo25AgtBbm32AX5S9ZKjJeiJHbzu6Dm8j3uK/kbrsDyFi3Jbkk+uZNthhJepvG2GiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ScwgviME; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714741291; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EPeFenupyrKpMSg+17T/sYHi2YONSaQ4xhAfluC20hU=;
	b=ScwgviMETjcDXq7tAFJLALvgA50JAjbCWpZVT6WdTQm4UPlx2dr6DOQZ9l/FvVEvIqOU0GjO9NQiIbdQEb2lsM+PDJnMnobC9kuUF05DzFUNE5neqXwxr9erwxipjfR0j/rNAfwtSwaR07QbZ3gk/qFUVLwrviCKZTNBUnUDouY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5kRlML_1714741289;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5kRlML_1714741289)
          by smtp.aliyun-inc.com;
          Fri, 03 May 2024 21:01:30 +0800
Message-ID: <afe72011-e6d7-4ce6-9157-2d4a998b730f@linux.alibaba.com>
Date: Fri, 3 May 2024 21:01:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] z_erofs_pcluster_begin(): don't bother with rounding
 position down
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240503041542.GV2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/3 12:15, Al Viro wrote:
> On Fri, Apr 26, 2024 at 01:32:04PM +0800, Gao Xiang wrote:
>> Hi Al,
> 
>> This patch caused some corrupted failure, since
>> here erofs_read_metabuf() is EROFS_NO_KMAP and
>> it's no needed to get a maped-address since only
>> a page reference is needed.
>>
>>>    		if (IS_ERR(mptr)) {
>>>    			ret = PTR_ERR(mptr);
>>>    			erofs_err(sb, "failed to get inline data %d", ret);
>>> @@ -876,7 +876,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>>>    		}
>>>    		get_page(map->buf.page);
>>>    		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
>>> -		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
>>> +		fe->pcl->pageofs_in = offset_in_page(mptr);
>>
>> So it's unnecessary to change this line IMHO.
> 
> *nod*
> 
> thanks for catching that.
> 
>> BTW, would you mind routing this series through erofs tree
>> with other erofs patches for -next (as long as this series
>> isn't twisted with vfs and block stuffs...)?  Since I may
>> need to test more to ensure they don't break anything and
>> could fix them immediately by hand...
> 
> FWIW, my immediate interest here is the first couple of patches.

Yes, the first two patches are fine by me, you could submit
directly.

> 
> How about the following variant:
> 
> #misc.erofs (the first two commits) is put into never-rebased mode;
> you pull it into your tree and do whatever's convenient with the rest.
> I merge the same branch into block_device work; that way it doesn't
> cause conflicts whatever else happens in our trees.
> 
> Are you OK with that?  At the moment I have
> ; git shortlog v6.9-rc2^..misc.erofs
> Al Viro (2):
>        erofs: switch erofs_bread() to passing offset instead of block number
>        erofs_buf: store address_space instead of inode
> 
> Linus Torvalds (1):
>        Linux 6.9-rc2
> 
> IOW, it's those two commits, based at -rc2.  I can rebase that to other
> starting point if that'd be more convenient for you.

Yeah, thanks for that.  I think I will submit two pull requests for
the next cycle, and I will send the second pull request after your
vfs work is landed upstream and it will include the remaining
patches you sent (a bit off this week since we're on holiday here).

Thanks,
Gao Xiang

