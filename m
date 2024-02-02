Return-Path: <linux-fsdevel+bounces-10049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A789D8474CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F01BB2B4E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6447148314;
	Fri,  2 Feb 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jU5wubxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF992E3E1;
	Fri,  2 Feb 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891523; cv=none; b=Co3cJlzmd+RTVYVfTB6wiAIP7aXfPmajB5QYyuMvh1B1KDtui+VlvxoHnHZwcid+nSqGqNH8GRbeCrEmNCzVEdDIMRWgcH0C85RMv54Q4hDs+JHl7Vj+CAAdSm4aSzXhQ/jUtokeeSy8wBrVJq0Bg5dRVizeNMv9FzEauUd0PPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891523; c=relaxed/simple;
	bh=yma4nylgOoLjTOHrYgozp3WCHDCZs0kwIUYe+i7FJY8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XqaD8fldPUquXzFupiu5ohZsX1xAt5iejh+/6lyBanVhJ/44HIoH0vZO6+EUZDymuZZCFEBOqIkQeK6tLMqlIGtg1A/giLsAEeUUId9ZZ4H2TkypQnGQMS6E5pxDHoVhgLQinPzCAo6urW+NQInBaphmzc6ecYn22q1QTCa99cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jU5wubxj; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706891519;
	bh=yma4nylgOoLjTOHrYgozp3WCHDCZs0kwIUYe+i7FJY8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=jU5wubxjeRgWqLh+oXgXkt9L6ToIU6aLtIv74J33D94Z1bAuwUkYMDh43wTpgdlwk
	 ircon1WeA8O1VoQha723YG13bkUh50GNf7CmEu+/24b34xifpcw4D1fgeDOPHgVIIJ
	 jElb/7siEE49WZijpvj972viuZFA8YKRa2ImjRcEa53ZNXFUb4t5y6qyaTIWAWbO4X
	 uVKOqJy5aChedzSPk82AaYiwsp/3O6f8Uzr6Sw72XEkemnVbTSFWoCR24mWLF/NetX
	 lXurcKAzwiKzhXJX6flQLy6YgSDzTBoEnGPBZNJVJqHrjIA0JXKpYY22SQ9Si5VeJT
	 mK+yKNhrX75og==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TRLrt5bFczX6S;
	Fri,  2 Feb 2024 11:31:58 -0500 (EST)
Message-ID: <da4c7c2c-0400-40d7-8263-22d284ecca8c@efficios.com>
Date: Fri, 2 Feb 2024 11:32:00 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/4] dax: Check for data cache aliasing at runtime
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Russell King <linux@armlinux.org.uk>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@lists.linux.dev
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
 <20240131162533.247710-3-mathieu.desnoyers@efficios.com>
 <65bab567665f3_37ad2943c@dwillia2-xfh.jf.intel.com.notmuch>
 <0a38176b-c453-4be0-be83-f3e1bb897973@efficios.com>
 <65bac71a9659b_37ad29428@dwillia2-xfh.jf.intel.com.notmuch>
 <f1d14941-2d22-452a-99e6-42db806b6d7f@efficios.com>
In-Reply-To: <f1d14941-2d22-452a-99e6-42db806b6d7f@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-01 10:44, Mathieu Desnoyers wrote:
> On 2024-01-31 17:18, Dan Williams wrote:

[...]


>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>> index 5f1be1da92ce..11053a70f5ab 100644
>> --- a/fs/fuse/virtio_fs.c
>> +++ b/fs/fuse/virtio_fs.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/fs_context.h>
>>   #include <linux/fs_parser.h>
>>   #include <linux/highmem.h>
>> +#include <linux/cleanup.h>
>>   #include <linux/uio.h>
>>   #include "fuse_i.h"
>> @@ -795,8 +796,11 @@ static void virtio_fs_cleanup_dax(void *data)
>>       put_dax(dax_dev);
>>   }
>> +DEFINE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR_OR_NULL(_T)) 
>> virtio_fs_cleanup_dax(_T))
>> +
>>   static int virtio_fs_setup_dax(struct virtio_device *vdev, struct 
>> virtio_fs *fs)
> 
> So either I'm completely missing how ownership works in this function, or
> we should be really concerned about the fact that it does no actual
> cleanup of anything on any error.
[...]
> 
> Here what I'm seeing so far:
> 
> - devm_release_mem_region() is never called after 
> devm_request_mem_region(). Not
>    on error, neither on teardown,
> - pgmap is never freed on error after devm_kzalloc.

I was indeed missing something: the devm_ family of functions
keeps ownership at the device level, so we would not need explicit
teardown.

> 
>>   {
>> +    struct dax_device *dax_dev __free(cleanup_dax) = NULL;
>>       struct virtio_shm_region cache_reg;
>>       struct dev_pagemap *pgmap;
>>       bool have_cache;
>> @@ -804,6 +808,15 @@ static int virtio_fs_setup_dax(struct 
>> virtio_device *vdev, struct virtio_fs *fs)
>>       if (!IS_ENABLED(CONFIG_FUSE_DAX))
>>           return 0;
>> +    dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
>> +    if (IS_ERR(dax_dev)) {
>> +        int rc = PTR_ERR(dax_dev);
>> +
>> +        if (rc == -EOPNOTSUPP)
>> +            return 0;
>> +        return rc;
>> +    }
> 
> What is gained by moving this allocation here ?

I'm still concerned about moving the call to alloc_dax() before
the setup of the memory region it will use. Are those completely
independent ?

> 
>> +
>>       /* Get cache region */
>>       have_cache = virtio_get_shm_region(vdev, &cache_reg,
>>                          (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
>> @@ -849,10 +862,7 @@ static int virtio_fs_setup_dax(struct 
>> virtio_device *vdev, struct virtio_fs *fs)
>>       dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len 
>> 0x%llx\n",
>>           __func__, fs->window_kaddr, cache_reg.addr, cache_reg.len);
>> -    fs->dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
>> -    if (IS_ERR(fs->dax_dev))
>> -        return PTR_ERR(fs->dax_dev);
>> -
>> +    fs->dax_dev = no_free_ptr(dax_dev);
>>       return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
>>                       fs->dax_dev);
>>   }
> 

[...]

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


