Return-Path: <linux-fsdevel+bounces-72826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 284FBD03907
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 15:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76536307F2B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F38F4BE292;
	Thu,  8 Jan 2026 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GIpn2P3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8665A4B3A98;
	Thu,  8 Jan 2026 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874823; cv=none; b=e3me8roql8WLwgtjL/CEAor8F12HOHmPMJ6YSYUrLD2ttw4rNiZRaoXdxcOyRKt+eNnVBYjZ2OvuYQObmtz01XKJfxsy0k08bjxAC8x+d62nDPl1kVk1Dt8lkqesxk/HTyhnS1E2WWW0fFk7ieXUalVSqoowg+ly4PdIbpvmDvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874823; c=relaxed/simple;
	bh=01vIFrUicp9vIydw7PyfnDF2m4sKbRmWiMEaUWWxfeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sv6bbleLqK27ob1IPOOmlFqwunTkSbcNsVK84MZJW4Y4akxhQ0Kkgj905DOYu95K5ZB2l6hzCR8dCZmkGNnLHRaQNofjKjAIsaxXN5HTdqYE+PCNs4CVPDxHtX0sQrlrdrETmDQ6KGK+DF00rSU1BT2TgAnVKIw8hgWTOSKVs1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GIpn2P3f; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DokPCpI+DXeppXDY77AhxNya3KTD8hrJouXcEIui7k0=;
	b=GIpn2P3f0KYTczqlD5hfRTSljCiL0x5m4qHG3fqaAdXJNYsPunVQIu5oZNpKUbDElhXnflxh9
	eT9s5UfISoOb7shIwIbx8F3mG9VFrvezUZEQnV6VU8poNouPmFEexhq393oezRnTDO/p0Ky0Og/
	FRVsZPzngqetCFpCkNIxcWk=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dn3mj70FGzRhQT;
	Thu,  8 Jan 2026 20:16:53 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 520062012A;
	Thu,  8 Jan 2026 20:20:10 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 20:20:09 +0800
Message-ID: <bb8e14f4-dbab-4974-a180-b436a00625d1@huawei.com>
Date: Thu, 8 Jan 2026 20:20:08 +0800
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
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Hi, Xiang

On 2026/1/7 14:08, Gao Xiang wrote:
> 
> 
> On 2025/12/31 17:01, Hongbo Li wrote:

...

>> +
>> +static int erofs_ishare_file_release(struct inode *inode, struct file 
>> *file)
>> +{
>> +    struct file *realfile = file->private_data;
>> +
>> +    iput(realfile->f_inode);
>> +    fput(realfile);
>> +    file->private_data = NULL;
>> +    return 0;
>> +}
>> +
>> +static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
>> +                       struct iov_iter *to)
>> +{
>> +    struct file *realfile = iocb->ki_filp->private_data;
>> +    struct kiocb dedup_iocb;
>> +    ssize_t nread;
>> +
>> +    if (!iov_iter_count(to))
>> +        return 0;
>> +
>> +    /* fallback to the original file in DIRECT mode */
>> +    if (iocb->ki_flags & IOCB_DIRECT)
>> +        realfile = iocb->ki_filp;
>> +
>> +    kiocb_clone(&dedup_iocb, iocb, realfile);
>> +    nread = filemap_read(&dedup_iocb, to, 0);
>> +    iocb->ki_pos = dedup_iocb.ki_pos;
> 
> I think it will not work for the AIO cases.
> 
> In order to make it simplified, how about just
> allowing sync and non-direct I/O first, and
> defering DIO/AIO support later?
> 

Ok, but what about doing the fallback logic:

1. For direct io: fallback to the original file.
2. For AIO: initialize the sync io by init_sync_kiocb (May be we can 
just replace kiocb_clone with init_sync_kiocb).

Thanks,
Hongbo

>> +    file_accessed(iocb->ki_filp);
> 
> I don't think it's useful in practice.
> 

Just keep in consistent with filemap_read?

> 
>> +    return nread;
>> +}
>> +
>> +static int erofs_ishare_mmap(struct file *file, struct vm_area_struct 
>> *vma)
>> +{
>> +    struct file *realfile = file->private_data;
>> +
>> +    vma_set_file(vma, realfile);
>> +    return generic_file_readonly_mmap(file, vma);
>> +}
>> +

...

>> @@ -649,6 +659,16 @@ static int erofs_fc_fill_super(struct super_block 
>> *sb, struct fs_context *fc)
>>       sb->s_maxbytes = MAX_LFS_FILESIZE;
>>       sb->s_op = &erofs_sops;
>> +    if (sbi->domain_id &&
>> +        (!sbi->fsid && !test_opt(&sbi->opt, INODE_SHARE))) {
>> +        errorfc(fc, "domain_id should be with fsid or inode_share 
>> option");
>> +        return -EINVAL;
>> +    }
> 
> Is that really needed?
> 

Ok, I will remove it in next version.

Thanks,
Hongbo

> 
> 
>> +    if (test_opt(&sbi->opt, DAX_ALWAYS) && test_opt(&sbi->opt, 
>> INODE_SHARE)) {
>> +        errorfc(fc, "dax is not allowed when inode_share is on");
> 
>          errorfc(fc, "FSDAX is not allowed when inode_share is on");
> 
> Thanks,
> Gao Xiang

