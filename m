Return-Path: <linux-fsdevel+bounces-68628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38542C623A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 04:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DCEB4E5F47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 03:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE9B2D9EC7;
	Mon, 17 Nov 2025 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Op/bC3jP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8C2E8B8E;
	Mon, 17 Nov 2025 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763349289; cv=none; b=WbRnnPsXPJB3ZUe34WQJygmeiuTW+K8JjU6IMBrulJin/6Q20VxnOFucWhYc2+CSEFh7lmA4+GQWCT+eyBHwcp1UN/yXu7/CN3PX+nG+/MvcGUjan+ipllCOlH3dQDCK6W29Rq6zOPNh+2FJRshr66gx2b30JXkk/QBXW0lGs/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763349289; c=relaxed/simple;
	bh=fTn/JtnQ/aZk7ThZ3FLp4yduEz/mi4vvp602k3aW55s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ie9UsbRyxhHC6oM6Fck8jBs9SwmtUoXxkruD/lE1hfT+LskjggN8+8zxqtST7bxrb6HbHVePq6s85QIZvx7ADJffq5xIpfptfzildRrDBoNrH9EseLdODFIGyD3v0XDbKIuxh0vZSc4xCMvm+9KdUeAfP2Qo5+YeCJ+Mes4Ggvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Op/bC3jP; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wMsfYhg1aXUFUvFTMjtwy0+CEgBFMsKcyL7EqjPIMn8=;
	b=Op/bC3jPoNFVhV7JcxfgkaayLtrVj11xdxW4DZ7YIt9sApGFESOuOy+jNvbz6/oCyy4zohP2f
	BNuDKWRvF3jxrXfs2MmY0sKE7T+pot228856tnZE9cEcBrqjFd8hRq31tDfCnpNR/TT2BoWmK6B
	o5QgkUBawdC9yx/4h/B5qXg=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d8t9H1fwsz1T4GD;
	Mon, 17 Nov 2025 11:13:07 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 26A7818046E;
	Mon, 17 Nov 2025 11:14:37 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Nov 2025 11:14:36 +0800
Message-ID: <cb040afb-a025-4dbb-9866-4772b24a3b8e@huawei.com>
Date: Mon, 17 Nov 2025 11:14:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/9] erofs: introduce the page cache share feature
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <chao@kernel.org>,
	<brauner@kernel.org>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-7-lihongbo22@huawei.com>
 <ac1b5431-e71f-430d-8309-8d007dc449b9@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <ac1b5431-e71f-430d-8309-8d007dc449b9@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Hi Xiang

On 2025/11/17 11:06, Gao Xiang wrote:
> 
> 
> On 2025/11/14 17:55, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Currently, reading files with different paths (or names) but the same
>> content will consume multiple copies of the page cache, even if the
>> content of these page caches is the same. For example, reading
>> identical files (e.g., *.so files) from two different minor versions of
>> container images will cost multiple copies of the same page cache,
>> since different containers have different mount points. Therefore,
>> sharing the page cache for files with the same content can save memory.
>>
>> This introduces the page cache share feature in erofs. It allocate a
>> deduplicated inode and use its page cache as shared. Reads for files
>> with identical content will ultimately be routed to the page cache of
>> the deduplicated inode. In this way, a single page cache satisfies
>> multiple read requests for different files with the same contents.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
> 
> ...
> 
> 
>> +
>> +static int erofs_ishare_file_open(struct inode *inode, struct file 
>> *file)
>> +{
>> +    struct file *realfile;
>> +    struct inode *dedup;
>> +
>> +    dedup = EROFS_I(inode)->ishare;
>> +    if (!dedup)
>> +        return -EINVAL;
>> +
>> +    realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, 
>> "erofs_ishare_file",
>> +                     O_RDONLY, &erofs_file_fops);
>> +    if (IS_ERR(realfile))
>> +        return PTR_ERR(realfile);
>> +
>> +    file_ra_state_init(&realfile->f_ra, file->f_mapping);
>> +    realfile->private_data = EROFS_I(inode);
>> +    file->private_data = realfile;
>> +    return 0;
> 

My apologies, I got it wrong. The latest code wasn't synced. The most 
current version should be this one.

static int erofs_ishare_file_open(struct inode *inode, struct file *file)
{
	struct file *realfile;
	struct inode *dedup;
	char *buf, *filepath;

	dedup = EROFS_I(inode)->ishare;
	if (!dedup)
		return -EINVAL;

	buf = kmalloc(PATH_MAX, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;
	filepath = file_path(file, buf, PATH_MAX);
	if (IS_ERR(filepath)) {
		kfree(buf);
		return -PTR_ERR(filepath);
	}
	realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, filepath + 1,
				     O_RDONLY, &erofs_file_fops);
	kfree(buf);
	if (IS_ERR(realfile))
		return PTR_ERR(realfile);

	file_ra_state_init(&realfile->f_ra, file->f_mapping);
	ihold(dedup);
	realfile->private_data = EROFS_I(inode);
	file->private_data = realfile;
	return 0;
}

I changed the "erofs_ishare_file" with filepath + 1 to display the 
realpath of the original file.

Thanks,
Hongbo

> Again, as Amir mentioned before, it should be converted to use (at least)
> some of backing file interfaces, please see:
>    file_user_path() and file_user_inode() in include/linux/fs.h
> 
> Or are you sure /proc/<pid>/maps is shown as expected?
> 
> Thanks,
> Gao Xiang

