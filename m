Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B357C50B115
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 09:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444645AbiDVHJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 03:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386931AbiDVHJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:09:11 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24BF5275EB;
        Fri, 22 Apr 2022 00:06:17 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AR6sMDq8uXGMKuPNHcCPcDrUDlX+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUpx0TQDxzYbWWqPOq2KNDSgLttyb4uwpkwOsZfczIRjS1dlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQHOKlULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0Oadeifi6JDKliUqdFOpmZ2CFnoeMYQG++pfD3t?=
 =?us-ascii?q?J8PsCIjERKBuEgoqexLO9T+hlgcQuBMn2NZwSuzdryjSxJfYtQbjCRavQ7NNV1?=
 =?us-ascii?q?Tt2gdpBdd7Sbsxfa3xwbRDEYhRKIX8WDo4zmKGjgXyXWzFat1WTqoI07nLVwQg?=
 =?us-ascii?q?316LiWPLRe9qXVYBQm26buGvN/CL+GB5yHNqBxTuA91qoh/TThmX/WYQPBPu0+?=
 =?us-ascii?q?+ACqF2YxkQXEwFQWVbTifuwjEP4UNJCA0sO8yEqoO4580nDZt38WQCo5XCfshM?=
 =?us-ascii?q?CVt54DeI38keOx7DS7gLfAXILJhZFado7pIo1SCYs21uhgdzkH3psvaeTRHbb8?=
 =?us-ascii?q?a2bxRu2OC4IPSoSazQsUwQI+Z/grZs1gxaJScxseJNZJPWd9SrYmmjM9XZhwe5?=
 =?us-ascii?q?Iy5Nj6klyxnif6xrEm3QDZlRdCt3rY1+Y?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AHzrpH68EDCrr+Uz560Buk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123751411"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Apr 2022 15:06:17 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1CE444D17172;
        Fri, 22 Apr 2022 15:06:16 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 22 Apr 2022 15:06:16 +0800
Received: from [10.167.216.24] (10.167.216.24) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 22 Apr 2022 15:06:15 +0800
Message-ID: <4a808b12-9215-9421-d114-951e70764778@fujitsu.com>
Date:   Fri, 22 Apr 2022 15:06:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v13 3/7] pagemap,pmem: Introduce ->memory_failure()
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220419045045.1664996-4-ruansy.fnst@fujitsu.com>
 <f173f091-d5ca-b049-a8ed-6616032ca83e@huawei.com>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <f173f091-d5ca-b049-a8ed-6616032ca83e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 1CE444D17172.A0528
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/4/21 16:24, Miaohe Lin 写道:
> On 2022/4/19 12:50, Shiyang Ruan wrote:
>> When memory-failure occurs, we call this function which is implemented
>> by each kind of devices.  For the fsdax case, pmem device driver
>> implements it.  Pmem device driver will find out the filesystem in which
>> the corrupted page located in.
>>
>> With dax_holder notify support, we are able to notify the memory failure
>> from pmem driver to upper layers.  If there is something not support in
>> the notify routine, memory_failure will fall back to the generic hanlder.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/nvdimm/pmem.c    | 17 +++++++++++++++++
>>   include/linux/memremap.h | 12 ++++++++++++
>>   mm/memory-failure.c      | 14 ++++++++++++++
>>   3 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>> index 58d95242a836..bd502957cfdf 100644
>> --- a/drivers/nvdimm/pmem.c
>> +++ b/drivers/nvdimm/pmem.c
>> @@ -366,6 +366,21 @@ static void pmem_release_disk(void *__pmem)
>>   	blk_cleanup_disk(pmem->disk);
>>   }
>>   
>> +static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
>> +		unsigned long pfn, unsigned long nr_pages, int mf_flags)
>> +{
>> +	struct pmem_device *pmem =
>> +			container_of(pgmap, struct pmem_device, pgmap);
>> +	u64 offset = PFN_PHYS(pfn) - pmem->phys_addr - pmem->data_offset;
>> +	u64 len = nr_pages << PAGE_SHIFT;
>> +
>> +	return dax_holder_notify_failure(pmem->dax_dev, offset, len, mf_flags);
>> +}
>> +
>> +static const struct dev_pagemap_ops fsdax_pagemap_ops = {
>> +	.memory_failure		= pmem_pagemap_memory_failure,
>> +};
>> +
>>   static int pmem_attach_disk(struct device *dev,
>>   		struct nd_namespace_common *ndns)
>>   {
>> @@ -427,6 +442,7 @@ static int pmem_attach_disk(struct device *dev,
>>   	pmem->pfn_flags = PFN_DEV;
>>   	if (is_nd_pfn(dev)) {
>>   		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
>> +		pmem->pgmap.ops = &fsdax_pagemap_ops;
>>   		addr = devm_memremap_pages(dev, &pmem->pgmap);
>>   		pfn_sb = nd_pfn->pfn_sb;
>>   		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
>> @@ -440,6 +456,7 @@ static int pmem_attach_disk(struct device *dev,
>>   		pmem->pgmap.range.end = res->end;
>>   		pmem->pgmap.nr_range = 1;
>>   		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
>> +		pmem->pgmap.ops = &fsdax_pagemap_ops;
>>   		addr = devm_memremap_pages(dev, &pmem->pgmap);
>>   		pmem->pfn_flags |= PFN_MAP;
>>   		bb_range = pmem->pgmap.range;
>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> index ad6062d736cd..bcfb6bf4ce5a 100644
>> --- a/include/linux/memremap.h
>> +++ b/include/linux/memremap.h
>> @@ -79,6 +79,18 @@ struct dev_pagemap_ops {
>>   	 * the page back to a CPU accessible page.
>>   	 */
>>   	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
>> +
>> +	/*
>> +	 * Handle the memory failure happens on a range of pfns.  Notify the
>> +	 * processes who are using these pfns, and try to recover the data on
>> +	 * them if necessary.  The mf_flags is finally passed to the recover
>> +	 * function through the whole notify routine.
>> +	 *
>> +	 * When this is not implemented, or it returns -EOPNOTSUPP, the caller
>> +	 * will fall back to a common handler called mf_generic_kill_procs().
>> +	 */
>> +	int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
>> +			      unsigned long nr_pages, int mf_flags);
>>   };
>>   
>>   #define PGMAP_ALTMAP_VALID	(1 << 0)
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 7c8c047bfdc8..a40e79e634a4 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1741,6 +1741,20 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>   	if (!pgmap_pfn_valid(pgmap, pfn))
>>   		goto out;
>>   
>> +	/*
>> +	 * Call driver's implementation to handle the memory failure, otherwise
>> +	 * fall back to generic handler.
>> +	 */
>> +	if (pgmap->ops->memory_failure) {
>> +		rc = pgmap->ops->memory_failure(pgmap, pfn, 1, flags);
>> +		/*
>> +		 * Fall back to generic handler too if operation is not
>> +		 * supported inside the driver/device/filesystem.
>> +		 */
>> +		if (rc != -EOPNOTSUPP)
>> +			goto out;
>> +	}
>> +
> 
> Thanks for your patch. There are two questions:
> 
> 1.Is dax_lock_page + dax_unlock_page pair needed here?

They are moved into mf_generic_kill_procs() in Patch2.  Callback will 
implement its own dax lock/unlock method.  For example, for 
mf_dax_kill_procs() in Patch4, we implemented 
dax_lock_mapping_entry()/dax_unlock_mapping_entry() for it.

> 2.hwpoison_filter and SetPageHWPoison will be handled by the callback or they're just ignored deliberately?

SetPageHWPoison() will be handled by callback or by mf_generic_kill_procs().

hwpoison_filter() is moved into mf_generic_kill_procs() too.  The 
callback will make sure the page is correct, so it is ignored.


--
Thanks,
Ruan.

> 
> Thanks!
> 
>>   	rc = mf_generic_kill_procs(pfn, flags, pgmap);
>>   out:
>>   	/* drop pgmap ref acquired in caller */
>>
> 


