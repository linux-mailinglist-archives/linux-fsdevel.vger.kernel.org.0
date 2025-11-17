Return-Path: <linux-fsdevel+bounces-68630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9781BC623B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 04:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 564324E7A6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 03:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E06313287;
	Mon, 17 Nov 2025 03:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6g4xZ9CJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E7312812;
	Mon, 17 Nov 2025 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763349520; cv=none; b=KW+BFRD7VFoLXapvE/H36dNexAfU64mwS/0gBH6wDJQyQWhnFEEXI5DKmSBbLJpIb9/LycBdbWXrmwA7Bjguh/quiYO/kQ1KqSSe9dgJZFPfPd6OSqYcxLuLtRKNlnAa5BDQa0JnEkfswNeQl7rGiwQuq47AdRrDnZPMyLvMvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763349520; c=relaxed/simple;
	bh=2a94VCbqQ62AkdA9jZX9mFesIZIt5cKIfoLq0daghAs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=cm6Q+57uVSjQd30aS17epO+9F6eM4Avfs3fNV1d0J+RHolj3Xj4xeYX6W7c3lmaDqA8yNaJu/oNAEZfn2Zy8sjGE16A3LkBxReRv2H6+ZS5iqKK9nGgftnHgyJkwO2B8N3i2TjHQXXF0iWEhnkpz0rRG25rsKvHSm05QEZaplJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6g4xZ9CJ; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KcqldnQO99Dt0eNgZSr03e8StJZi0LhuLtgHczO6QyI=;
	b=6g4xZ9CJ7mxzPkOleAkmdNLDYD2GYA5FTOdxPs5pRJOuj9uQDdZ1BFB+1vNB23tvZoZd1f66C
	IpXWy0jOS3P4hgK53J6IX2UBCc7dE0OxY3xxezKzfT4dgK0aan97azlLC4DFfTQJWb5rEj23Ua3
	bpftPBfmh+VFpvlBZf87gJo=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8tFs5HZCznTyL;
	Mon, 17 Nov 2025 11:17:05 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 80424140296;
	Mon, 17 Nov 2025 11:18:34 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Nov 2025 11:18:33 +0800
Message-ID: <ba6b9ead-5836-465f-8ba9-f2ea9f9ff2f4@huawei.com>
Date: Mon, 17 Nov 2025 11:18:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/9] erofs: introduce the page cache share feature
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <chao@kernel.org>,
	<brauner@kernel.org>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-7-lihongbo22@huawei.com>
 <ac1b5431-e71f-430d-8309-8d007dc449b9@linux.alibaba.com>
 <cb040afb-a025-4dbb-9866-4772b24a3b8e@huawei.com>
In-Reply-To: <cb040afb-a025-4dbb-9866-4772b24a3b8e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Hi Xiang,

On 2025/11/17 11:14, Hongbo Li wrote:
> Hi Xiang
> 
> On 2025/11/17 11:06, Gao Xiang wrote:
>>
>>
>> On 2025/11/14 17:55, Hongbo Li wrote:
>>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>>
>>> Currently, reading files with different paths (or names) but the same
>>> content will consume multiple copies of the page cache, even if the
>>> content of these page caches is the same. For example, reading
>>> identical files (e.g., *.so files) from two different minor versions of
>>> container images will cost multiple copies of the same page cache,
>>> since different containers have different mount points. Therefore,
>>> sharing the page cache for files with the same content can save memory.
>>>
>>> This introduces the page cache share feature in erofs. It allocate a
>>> deduplicated inode and use its page cache as shared. Reads for files
>>> with identical content will ultimately be routed to the page cache of
>>> the deduplicated inode. In this way, a single page cache satisfies
>>> multiple read requests for different files with the same contents.
>>>
>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>> ---
>>
>> ...
>>
>>
>>> +
>>> +static int erofs_ishare_file_open(struct inode *inode, struct file 
>>> *file)
>>> +{
>>> +    struct file *realfile;
>>> +    struct inode *dedup;
>>> +
>>> +    dedup = EROFS_I(inode)->ishare;
>>> +    if (!dedup)
>>> +        return -EINVAL;
>>> +
>>> +    realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, 
>>> "erofs_ishare_file",
>>> +                     O_RDONLY, &erofs_file_fops);
>>> +    if (IS_ERR(realfile))
>>> +        return PTR_ERR(realfile);
>>> +
>>> +    file_ra_state_init(&realfile->f_ra, file->f_mapping);
>>> +    realfile->private_data = EROFS_I(inode);
>>> +    file->private_data = realfile;
>>> +    return 0;
>>
> 
> My apologies, I got it wrong. The latest code wasn't synced. The most 
> current version should be this one.
> 
> static int erofs_ishare_file_open(struct inode *inode, struct file *file)
> {
>      struct file *realfile;
>      struct inode *dedup;
>      char *buf, *filepath;
> 
>      dedup = EROFS_I(inode)->ishare;
>      if (!dedup)
>          return -EINVAL;
> 
>      buf = kmalloc(PATH_MAX, GFP_KERNEL);
>      if (!buf)
>          return -ENOMEM;
>      filepath = file_path(file, buf, PATH_MAX);
>      if (IS_ERR(filepath)) {
>          kfree(buf);
>          return -PTR_ERR(filepath);
>      }
>      realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, filepath + 1,
>                       O_RDONLY, &erofs_file_fops);
>      kfree(buf);
>      if (IS_ERR(realfile))
>          return PTR_ERR(realfile);
> 
>      file_ra_state_init(&realfile->f_ra, file->f_mapping);
>      ihold(dedup);
>      realfile->private_data = EROFS_I(inode);
>      file->private_data = realfile;
>      return 0;
> }
> 
> I changed the "erofs_ishare_file" with filepath + 1 to display the 
> realpath of the original file.

I made this change in patch 7 which caused the misunderstanding here.

Thanks,
Hongbo

> 
> Thanks,
> Hongbo
> 
>> Again, as Amir mentioned before, it should be converted to use (at least)
>> some of backing file interfaces, please see:
>>    file_user_path() and file_user_inode() in include/linux/fs.h
>>
>> Or are you sure /proc/<pid>/maps is shown as expected?
>>
>> Thanks,
>> Gao Xiang

