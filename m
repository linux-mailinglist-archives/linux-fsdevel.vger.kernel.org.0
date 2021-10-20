Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3EE434598
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 08:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhJTHBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 03:01:02 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:4281 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229771AbhJTHBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:01:02 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AJ7EZiq4RTYnGDyHIPKdMvQxRtFPGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENSgzYCzGYWW2mGPPuMMWOjKop+Pt6x9RwCsMWExt9nHFc5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9bdANkVEmjfvRH+KmULa?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeCbm7JHMnhWun3zEhq8G4FsNFYER5Od7KW9?=
 =?us-ascii?q?U8vkfMjoMclaIgOfe6LKwSsFtgMo5JcXmNY9ZvWtvpRnVBPBgQ9bcQqHO5NZdx?=
 =?us-ascii?q?x8xgNxDGbDVYM9xQTZtcxPGbDVMN00RBZZ4m/2n7lH7cjtFuBeQoII0/WHYz0p?=
 =?us-ascii?q?2yreFGNzLdt2PQO1Rn12EvSTC/mLkElcWOcL34TiM9H/qje/StSThUYkWGfuz8?=
 =?us-ascii?q?fsCqFmSwHEDTRMNWValrP2RlEGzQZRcJlYS9y5oqrI9nGSvT9/gT1i7rWSCsxo?=
 =?us-ascii?q?0RdVdCas55RuLx66S5ByWbkAATzhceJk2utQeWzMnzBmKksnvCDgpt6eaIU9xX?=
 =?us-ascii?q?J/8QSiaYHBTdDFdI3RfC1Zt3jUqm6lr5jqnczqpOPfdYgXJJAzN?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A9g+zgKomESeEptiyULrMY2UaV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,166,1631548800"; 
   d="scan'208";a="116155790"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Oct 2021 14:58:46 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id EE0EA4D0DC95;
        Wed, 20 Oct 2021 14:58:44 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 20 Oct 2021 14:58:43 +0800
Received: from [10.167.216.64] (10.167.216.64) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 20 Oct 2021 14:58:44 +0800
Subject: Re: [PATCH v7 2/8] dax: Introduce holder for dax_device
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
 <20210924130959.2695749-3-ruansy.fnst@fujitsu.com>
 <20211014180025.GC24333@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <5d4fb139-ea0c-7b43-ba7d-ac52d1bb462c@fujitsu.com>
Date:   Wed, 20 Oct 2021 14:58:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211014180025.GC24333@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: EE0EA4D0DC95.A3002
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2021/10/15 2:00, Darrick J. Wong 写道:
> On Fri, Sep 24, 2021 at 09:09:53PM +0800, Shiyang Ruan wrote:
>> To easily track filesystem from a pmem device, we introduce a holder for
>> dax_device structure, and also its operation.  This holder is used to
>> remember who is using this dax_device:
>>   - When it is the backend of a filesystem, the holder will be the
>>     superblock of this filesystem.
>>   - When this pmem device is one of the targets in a mapped device, the
>>     holder will be this mapped device.  In this case, the mapped device
>>     has its own dax_device and it will follow the first rule.  So that we
>>     can finally track to the filesystem we needed.
>>
>> The holder and holder_ops will be set when filesystem is being mounted,
>> or an target device is being activated.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/dax/super.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/dax.h | 29 ++++++++++++++++++++++
>>   2 files changed, 88 insertions(+)
>>
>> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
>> index 48ce86501d93..7d4a11dcba90 100644
>> --- a/drivers/dax/super.c
>> +++ b/drivers/dax/super.c
>> @@ -23,7 +23,10 @@
>>    * @cdev: optional character interface for "device dax"
>>    * @host: optional name for lookups where the device path is not available
>>    * @private: dax driver private data
>> + * @holder_data: holder of a dax_device: could be filesystem or mapped device
>>    * @flags: state and boolean properties
>> + * @ops: operations for dax_device
>> + * @holder_ops: operations for the inner holder
>>    */
>>   struct dax_device {
>>   	struct hlist_node list;
>> @@ -31,8 +34,10 @@ struct dax_device {
>>   	struct cdev cdev;
>>   	const char *host;
>>   	void *private;
>> +	void *holder_data;
>>   	unsigned long flags;
>>   	const struct dax_operations *ops;
>> +	const struct dax_holder_operations *holder_ops;
>>   };
>>   
>>   static dev_t dax_devt;
>> @@ -374,6 +379,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>>   }
>>   EXPORT_SYMBOL_GPL(dax_zero_page_range);
>>   
>> +int dax_holder_notify_failure(struct dax_device *dax_dev, loff_t offset,
>> +			      size_t size, int flags)
>> +{
>> +	int rc;
>> +
>> +	dax_read_lock();
>> +	if (!dax_alive(dax_dev)) {
>> +		rc = -ENXIO;
>> +		goto out;
>> +	}
>> +
>> +	if (!dax_dev->holder_data) {
>> +		rc = -EOPNOTSUPP;
>> +		goto out;
>> +	}
>> +
>> +	rc = dax_dev->holder_ops->notify_failure(dax_dev, offset, size, flags);
> 
> Shouldn't this check if dax_dev->holder_ops != NULL before dereferencing
> it for the function call?  Imagine an implementation that wants to
> attach a ->notify_failure function to a dax_device, maintains its own
> lookup table, and decides that it doesn't need to set holder_data.
> 
> (Or, imagine someone who writes a garbage into holder_data and *boom*)

My mistake. I should check @holder_ops instead of @holder_data.

> 
> How does the locking work here?  If there's a media failure, we'll take
> dax_rwsem and call ->notify_failure.  If the ->notify_failure function
> wants to access the pmem to handle the error by calling back into the
> dax code, will that cause nested locking on dax_rwsem?

Won't for now.  I have tested it with my simple testcases.
> 
> Jumping ahead a bit, I think the rmap btree accesses that the xfs
> implementation performs can cause xfs_buf(fer) cache IO, which would
> trigger that if the buffers aren't already in memory, if I'm reading
> this correctly?

I didn't think of this case.  But I think this uses read lock too.  It 
won't be blocked.  Only dax_set_holder() takes write lock.

> 
>> +out:
>> +	dax_read_unlock();
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
>> +
>>   #ifdef CONFIG_ARCH_HAS_PMEM_API
>>   void arch_wb_cache_pmem(void *addr, size_t size);
>>   void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
>> @@ -618,6 +646,37 @@ void put_dax(struct dax_device *dax_dev)
>>   }
>>   EXPORT_SYMBOL_GPL(put_dax);
>>   
>> +void dax_set_holder(struct dax_device *dax_dev, void *holder,
>> +		const struct dax_holder_operations *ops)
>> +{
>> +	dax_write_lock();
>> +	if (!dax_alive(dax_dev)) {
>> +		dax_write_unlock();
>> +		return;
>> +	}
>> +
>> +	dax_dev->holder_data = holder;
>> +	dax_dev->holder_ops = ops;
>> +	dax_write_unlock();
> 
> I guess this means that the holder has to detach itself before anyone
> calls kill_dax, or else a dead dax device ends up with a dangling
> reference to the holder?

Yes.

> 
>> +}
>> +EXPORT_SYMBOL_GPL(dax_set_holder);
>> +
>> +void *dax_get_holder(struct dax_device *dax_dev)
>> +{
>> +	void *holder;
>> +
>> +	dax_read_lock();
>> +	if (!dax_alive(dax_dev)) {
>> +		dax_read_unlock();
>> +		return NULL;
>> +	}
>> +
>> +	holder = dax_dev->holder_data;
>> +	dax_read_unlock();
>> +	return holder;
>> +}
>> +EXPORT_SYMBOL_GPL(dax_get_holder);
>> +
>>   /**
>>    * inode_dax: convert a public inode into its dax_dev
>>    * @inode: An inode with i_cdev pointing to a dax_dev
>> diff --git a/include/linux/dax.h b/include/linux/dax.h
>> index 097b3304f9b9..d273d59723cd 100644
>> --- a/include/linux/dax.h
>> +++ b/include/linux/dax.h
>> @@ -38,9 +38,24 @@ struct dax_operations {
>>   	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
>>   };
>>   
>> +struct dax_holder_operations {
>> +	/*
>> +	 * notify_failure - notify memory failure into inner holder device
>> +	 * @dax_dev: the dax device which contains the holder
>> +	 * @offset: offset on this dax device where memory failure occurs
>> +	 * @size: length of this memory failure event
>> +	 * @flags: action flags for memory failure handler
>> +	 */
>> +	int (*notify_failure)(struct dax_device *dax_dev, loff_t offset,
>> +			size_t size, int flags);
> 
> Shouldn't size be u64 or something?  Let's say that 8GB of your pmem go
> bad, wouldn't you want a single call?  Though I guess the current
> implementation only goes a single page at a time, doesn't it?

Right.

> 
>> +};
>> +
>>   extern struct attribute_group dax_attribute_group;
>>   
>>   #if IS_ENABLED(CONFIG_DAX)
>> +void dax_set_holder(struct dax_device *dax_dev, void *holder,
>> +		const struct dax_holder_operations *ops);
>> +void *dax_get_holder(struct dax_device *dax_dev);
>>   struct dax_device *alloc_dax(void *private, const char *host,
>>   		const struct dax_operations *ops, unsigned long flags);
>>   void put_dax(struct dax_device *dax_dev);
>> @@ -70,6 +85,18 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>>   	return dax_synchronous(dax_dev);
>>   }
>>   #else
>> +static inline struct dax_device *dax_get_by_host(const char *host)
> 
> Not sure why this is being added here?  AFAICT none of the patches call
> this function...?

It's mistake when I rebase my code to the latest.  These lines were 
deleted but I didn't notice.  Will fix it.


--
Thanks,
Ruan.

> 
> --D
> 
>> +{
>> +	return NULL;
>> +}
>> +static inline void dax_set_holder(struct dax_device *dax_dev, void *holder,
>> +		const struct dax_holder_operations *ops)
>> +{
>> +}
>> +static inline void *dax_get_holder(struct dax_device *dax_dev)
>> +{
>> +	return NULL;
>> +}
>>   static inline struct dax_device *alloc_dax(void *private, const char *host,
>>   		const struct dax_operations *ops, unsigned long flags)
>>   {
>> @@ -198,6 +225,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>>   		size_t bytes, struct iov_iter *i);
>>   int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>>   			size_t nr_pages);
>> +int dax_holder_notify_failure(struct dax_device *dax_dev, loff_t offset,
>> +		size_t size, int flags);
>>   void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
>>   
>>   ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>> -- 
>> 2.33.0
>>
>>
>>


