Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6055F4344A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 07:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJTF2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 01:28:38 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8438 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229920AbhJTF2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 01:28:38 -0400
IronPort-Data: =?us-ascii?q?A9a23=3ATCLa5qxnwle8kgihcut6t+ddxyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApGwmgzRTmGoaWzjQO/6CamDzfNhyYdjn90MFuZCGmtM2HQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kjF3oTJ9yEmjPjQH+ukVYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhhc14zs5c85K2U?=
 =?us-ascii?q?hsBMLDOmfgGTl9TFCQW0ahuoeaZeCXm4ZbPp6HBWz62qxl0N2k6NJMZ9s55G2Z?=
 =?us-ascii?q?L8uYSKSxLZReG78q2y7KTS+9inM0vIcDneoQFtRlIwTjfS/RgXpHHR6TD4MRw3?=
 =?us-ascii?q?TEsi8QIFvHbD+IVayVoahvoYBBVPFoTTpUkk4+Agnj5bi0drVe9prQ+6GuVyxZ?=
 =?us-ascii?q?+uJDrLtbUf9miQcROgl3eomPA4nS/DhwEXPSdwDyItHmsm8fIhyrwXI9UH7q9n?=
 =?us-ascii?q?tZugVuO1ikdExEbS1a/iee2h1T4WN9FLUEQvC00osAa8E2tU8m4XBCipnOAlgA?=
 =?us-ascii?q?TVsAWEOAg7gyJjK3O7G6xAmkCUy4EeNI9nNE5SCZs1VKTmd7tQzt1v9Wopdi1n?=
 =?us-ascii?q?luPhWrqf3FLcilZPmlZJTbpKuLL+Okb5i8jhP46TMZZVuHIJAw=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AkTiQOqM9kLBvgcBcTiWjsMiBIKoaSvp037Eq?=
 =?us-ascii?q?v3oedfUzSL3gqynOpoV86faaskdyZJhNo7C90ey7MBThHP1OkO0s1NWZLWrbUQ?=
 =?us-ascii?q?KTRekIh+bfKn/behEWndQw6U4PScdD4ZHLfD1HZNjBkXSFOudl0N+a67qpmOub?=
 =?us-ascii?q?639sSDthY6Zm4xwRMHfhLmRGABlBGYEiFIeRou5Opz+bc3wRacihQlYfWeyrna?=
 =?us-ascii?q?ywqLvWJQ4BGwU86BSDyReh6LvBGRCe2RsEFxNjqI1SiVT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,165,1631548800"; 
   d="scan'208";a="116151824"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Oct 2021 13:26:01 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 3AB984D0F907;
        Wed, 20 Oct 2021 13:25:58 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 20 Oct 2021 13:25:52 +0800
Received: from [10.167.216.64] (10.167.216.64) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 20 Oct 2021 13:25:52 +0800
Subject: Re: [PATCH v7 4/8] pagemap,pmem: Introduce ->memory_failure()
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
 <20210924130959.2695749-5-ruansy.fnst@fujitsu.com>
 <20211014180507.GG24307@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <543054d5-f779-02fa-95d1-4f2cd6efe111@fujitsu.com>
Date:   Wed, 20 Oct 2021 13:25:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211014180507.GG24307@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 3AB984D0F907.A0283
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2021/10/15 2:05, Darrick J. Wong 写道:
> On Fri, Sep 24, 2021 at 09:09:55PM +0800, Shiyang Ruan wrote:
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
>> ---
>>   drivers/nvdimm/pmem.c    | 11 +++++++++++
>>   include/linux/memremap.h |  9 +++++++++
>>   mm/memory-failure.c      | 14 ++++++++++++++
>>   3 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>> index 72de88ff0d30..0dfafad8fcc5 100644
>> --- a/drivers/nvdimm/pmem.c
>> +++ b/drivers/nvdimm/pmem.c
>> @@ -362,9 +362,20 @@ static void pmem_release_disk(void *__pmem)
>>   	del_gendisk(pmem->disk);
>>   }
>>   
>> +static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
>> +		unsigned long pfn, size_t size, int flags)
>> +{
>> +	struct pmem_device *pmem =
>> +			container_of(pgmap, struct pmem_device, pgmap);
>> +	loff_t offset = PFN_PHYS(pfn) - pmem->phys_addr - pmem->data_offset;
>> +
>> +	return dax_holder_notify_failure(pmem->dax_dev, offset, size, flags);
>> +}
>> +
>>   static const struct dev_pagemap_ops fsdax_pagemap_ops = {
>>   	.kill			= pmem_pagemap_kill,
>>   	.cleanup		= pmem_pagemap_cleanup,
>> +	.memory_failure		= pmem_pagemap_memory_failure,
>>   };
>>   
>>   static int pmem_attach_disk(struct device *dev,
>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> index c0e9d35889e8..36d47bacd46d 100644
>> --- a/include/linux/memremap.h
>> +++ b/include/linux/memremap.h
>> @@ -87,6 +87,15 @@ struct dev_pagemap_ops {
>>   	 * the page back to a CPU accessible page.
>>   	 */
>>   	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
>> +
>> +	/*
>> +	 * Handle the memory failure happens on a range of pfns.  Notify the
>> +	 * processes who are using these pfns, and try to recover the data on
>> +	 * them if necessary.  The flag is finally passed to the recover
>> +	 * function through the whole notify routine.
>> +	 */
>> +	int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
>> +			      size_t size, int flags);
>>   };
>>   
>>   #define PGMAP_ALTMAP_VALID	(1 << 0)
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 8ff9b52823c0..85eab206b68f 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1605,6 +1605,20 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>   	if (!pgmap_pfn_valid(pgmap, pfn))
>>   		goto out;
>>   
>> +	/*
>> +	 * Call driver's implementation to handle the memory failure, otherwise
>> +	 * fall back to generic handler.
>> +	 */
>> +	if (pgmap->ops->memory_failure) {
>> +		rc = pgmap->ops->memory_failure(pgmap, pfn, PAGE_SIZE, flags);
>> +		/*
>> +		 * Fall back to generic handler too if operation is not
>> +		 * supported inside the driver/device/filesystem.
>> +		 */
>> +		if (rc != EOPNOTSUPP)
> 
> -EOPNOTSUPP?  (negative errno)

Yes, my mistake. Thanks for pointing out.


--
Thanks,
Ruan.

> 
> --D
> 
>> +			goto out;
>> +	}
>> +
>>   	rc = mf_generic_kill_procs(pfn, flags, pgmap);
>>   out:
>>   	/* drop pgmap ref acquired in caller */
>> -- 
>> 2.33.0
>>
>>
>>


