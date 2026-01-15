Return-Path: <linux-fsdevel+bounces-73856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEF5D220A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF076302510D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 01:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F58246798;
	Thu, 15 Jan 2026 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5Aqrc6hM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410322745C;
	Thu, 15 Jan 2026 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768440976; cv=none; b=rulu1NsNJP5THzD8Dp5Q9omMnFV9gzsWF93u5V+5vinowDrE1TpR/xvUhfpdnx3tDTzRYIB3JL2/0dHZ9uqhwPolulbgE8hlmHX6DMf5mI8hfuOk7FS9a7JljrxOnZktGc1kyelGC1aWEutTfGCRJSNnLVSGNCDCfNTchwFHLG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768440976; c=relaxed/simple;
	bh=0XBeZzNPeN3JM7RP2yW3y73LYfPE5WJGmuYip0PKvtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j6lPRDaU6giHALklQCOrECJaK7lepaer1Viwtt/MpofUOyWSDmgcmiLSSiST5wMXN5Dae3rKcnuhShN0J96s/VMQgQCFAIoHoQChrWQVetdNpD0yWwS+VoTXGrZErHrn99hnmhLi3GIKYJiivw8Aupr2mKOThMZZLk93EKJaqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5Aqrc6hM; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=63L59MWlYvf8NPePrI0+yVoNuGGGBNGasjBzGUBsKy8=;
	b=5Aqrc6hMyfywSV+uvMIIpEAmEvd64pc8GcZzEaUVBFMh441qIl4iIPugyvygZGyfajbB1R1E1
	Z4xPvTKZL8RdtDb1Ouqagp8120iU3svliTy+wjVZkJB7V1dFHu04kvDM7UAPug5egobgG4pPlHC
	o8fYXWROchvABb1wfGodbAM=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4ds58B1nPkz1prmM;
	Thu, 15 Jan 2026 09:32:42 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 2EE6140537;
	Thu, 15 Jan 2026 09:36:04 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 09:36:03 +0800
Message-ID: <4152e93b-3f7d-4861-aad9-b7dc1ef71470@huawei.com>
Date: Thu, 15 Jan 2026 09:36:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/10] erofs: support unencoded inodes for page cache
 share
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-9-lihongbo22@huawei.com>
 <2d33cc2f-8188-4e62-b0be-bf985237bf24@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <2d33cc2f-8188-4e62-b0be-bf985237bf24@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Hi,Xiang

On 2026/1/14 22:51, Gao Xiang wrote:
> 
> 
> On 2026/1/9 18:28, Hongbo Li wrote:
>> This patch adds inode page cache sharing functionality for unencoded
>> files.
>>
>> I conducted experiments in the container environment. Below is the

...
>>               iomap->inline_data = ptr;
>> @@ -383,11 +385,16 @@ static int erofs_read_folio(struct file *file, 
>> struct folio *folio)
>>           .ops        = &iomap_bio_read_ops,
>>           .cur_folio    = folio,
>>       };
>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>> +    bool need_iput;
>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>> +        .realinode = erofs_real_inode(folio_inode(folio), &need_iput),
>> +    };
>> -    trace_erofs_read_folio(folio, true);
>> +    trace_erofs_read_folio(iter_ctx.realinode, folio, true);
>>       iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>> +    if (need_iput)
>> +        iput(iter_ctx.realinode);
>>       return 0;
>>   }
>> @@ -397,12 +404,17 @@ static void erofs_readahead(struct 
>> readahead_control *rac)
>>           .ops        = &iomap_bio_read_ops,
>>           .rac        = rac,
>>       };
>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>> +    bool need_iput;
>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>> +        .realinode = erofs_real_inode(rac->mapping->host, &need_iput),
>> +    };
>> -    trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>> +    trace_erofs_readahead(iter_ctx.realinode, readahead_index(rac),
>>                       readahead_count(rac), true);
> 
> Is it possible to add a commit to update the tracepoints
> to add the new realinode first?

Yeah, so should we put the update on trace_erofs_read_folio and 
trace_erofs_readahead in a single patch after "[PATCH v14 03/10] fs: 
Export alloc_empty_backing_file"?

  Since the first two patches in this series has merged in vfs tree 
(thanks Christian), should we reorder the left patches?

Thanks,
Hongbo


> 
> Also please fix the indentation in that commit together.
> 
>>       iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>> +    if (need_iput)
>> +        iput(iter_ctx.realinode);
>>   }
>>   static sector_t erofs_bmap(struct address_space *mapping, sector_t 
>> block)
>> @@ -423,7 +435,9 @@ static ssize_t erofs_file_read_iter(struct kiocb 

...
>>   }
>>   const struct address_space_operations erofs_fileio_aops = {
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index bce98c845a18..52179b706b5b 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -215,6 +215,8 @@ static int erofs_fill_inode(struct inode *inode)
>>       case S_IFREG:
>>           inode->i_op = &erofs_generic_iops;
>>           inode->i_fop = &erofs_file_fops;
>> +        if (erofs_ishare_fill_inode(inode))
>> +            inode->i_fop = &erofs_ishare_fops;
> 
>          inode->i_fop = erofs_ishare_fill_inode(inode) ?
>              &erofs_ishare_fops : &erofs_file_fops;

Ok, will update.

> 
> Otherwise it looks good to me.
> 
> Thanks,
> Gao Xiang

