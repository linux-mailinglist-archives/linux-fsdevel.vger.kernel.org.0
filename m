Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9741B4EC7FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbiC3PS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 11:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348100AbiC3PSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:18:01 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77E261480F2;
        Wed, 30 Mar 2022 08:16:15 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AtwvaI6h4vvUoVt85m0RQnGMKX161CxEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUEmGUWCmHVOa6OZTCnKNAnPovk908P7ZPRndZqHAtsrHw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUra?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHl6pTCnx2XIhMAxN0rVinaJ7Yw9u9pAG1?=
 =?us-ascii?q?m++YfLTcXZBGfwemxxdqTSuJsrsUlItPiMI4Wtjdn1z6xJfovR9bBBbrL4dtZ1?=
 =?us-ascii?q?TIrrsFIAfvaIcEebFJHYBbfZBtAElQaEpQzmKGvnHaXWzlZrk+F4K8yy2vNxQd?=
 =?us-ascii?q?ylr/3P7L9fMKGRMBQtkKZvX7duWD4BAwKctCS11Kt8Huqi6nEnT7TX5gbH7m1s?=
 =?us-ascii?q?PVthTW7wm0VFQ1TW0C3rOe0jmagVN9FbU8Z4Cwjqe417kPDZt38WQCo5X2JpBg?=
 =?us-ascii?q?RX/JOHOAgrgKA0KzZ50CeHGdsZjpAbsE28d84XhQ02VKT2dDkHzpitPuSU331y?=
 =?us-ascii?q?1s+hVteIgBMdSlbO3BCFlBDvrHeTEgIpkqnZr5e/GSd17UZwQ3N/g0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AMHdCR6lcfaT+oQuP8yxoprJboKPpDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123098899"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Mar 2022 23:16:14 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id AEC9B4D16FF5;
        Wed, 30 Mar 2022 23:16:11 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 30 Mar 2022 23:16:11 +0800
Received: from [10.167.201.8] (10.167.201.8) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 30 Mar 2022 23:16:11 +0800
Message-ID: <894ed00b-b174-6a10-ee45-320007957ea4@fujitsu.com>
Date:   Wed, 30 Mar 2022 23:16:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v11 7/8] xfs: Implement ->notify_failure() for XFS
To:     Christoph Hellwig <hch@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>,
        <jane.chu@oracle.com>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-8-ruansy.fnst@fujitsu.com>
 <YkPyBQer+KRiregd@infradead.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YkPyBQer+KRiregd@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: AEC9B4D16FF5.A4774
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/3/30 14:00, Christoph Hellwig 写道:
>> @@ -1892,6 +1893,8 @@ xfs_free_buftarg(
>>   	list_lru_destroy(&btp->bt_lru);
>>   
>>   	blkdev_issue_flush(btp->bt_bdev);
>> +	if (btp->bt_daxdev)
>> +		dax_unregister_holder(btp->bt_daxdev, btp->bt_mount);
>>   	fs_put_dax(btp->bt_daxdev);
>>   
>>   	kmem_free(btp);
>> @@ -1939,6 +1942,7 @@ xfs_alloc_buftarg(
>>   	struct block_device	*bdev)
>>   {
>>   	xfs_buftarg_t		*btp;
>> +	int			error;
>>   
>>   	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
>>   
>> @@ -1946,6 +1950,14 @@ xfs_alloc_buftarg(
>>   	btp->bt_dev =  bdev->bd_dev;
>>   	btp->bt_bdev = bdev;
>>   	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
>> +	if (btp->bt_daxdev) {
>> +		error = dax_register_holder(btp->bt_daxdev, mp,
>> +				&xfs_dax_holder_operations);
>> +		if (error) {
>> +			xfs_err(mp, "DAX device already in use?!");
>> +			goto error_free;
>> +		}
>> +	}
> 
> It seems to me that just passing the holder and holder ops to
> fs_dax_get_by_bdev and the holder to dax_unregister_holder would
> significantly simply the interface here.
> 
> Dan, what do you think?
> 
>> +#if IS_ENABLED(CONFIG_MEMORY_FAILURE) && IS_ENABLED(CONFIG_FS_DAX)
> 
> No real need for the IS_ENABLED.  Also any reason to even build this
> file if the options are not set?  It seems like
> xfs_dax_holder_operations should just be defined to NULL and the
> whole file not supported if we can't support the functionality.

Got it.  These two CONFIG seem not related for now.  So, I think I 
should wrap these code with #ifdef CONFIG_MEMORY_FAILURE here, and add 
`xfs-$(CONFIG_FS_DAX) += xfs_notify_failure.o` in the makefile.

> 
> Dan: not for this series, but is there any reason not to require
> MEMORY_FAILURE for DAX to start with?
> 
>> +
>> +	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
>> +	ddev_end = ddev_start +
>> +		(mp->m_ddev_targp->bt_bdev->bd_nr_sectors << SECTOR_SHIFT) - 1;
> 
> This should use bdev_nr_bytes.

OK.

> 
> But didn't we say we don't want to support notifications on partitioned
> devices and thus don't actually need all this?
> 
>> +
>> +	/* Ignore the range out of filesystem area */
>> +	if ((offset + len) < ddev_start)
> 
> No need for the inner braces.
> 
>> +	if ((offset + len) > ddev_end)
> 
> No need for the braces either.

Really no need?  It is to make sure the range to be handled won't out of 
the filesystem area.  And make sure the @offset and @len are valid and 
correct after subtract the bbdev_start.

> 
>> diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
>> new file mode 100644
>> index 000000000000..76187b9620f9
>> --- /dev/null
>> +++ b/fs/xfs/xfs_notify_failure.h
>> @@ -0,0 +1,10 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Fujitsu.  All Rights Reserved.
>> + */
>> +#ifndef __XFS_NOTIFY_FAILURE_H__
>> +#define __XFS_NOTIFY_FAILURE_H__
>> +
>> +extern const struct dax_holder_operations xfs_dax_holder_operations;
>> +
>> +#endif  /* __XFS_NOTIFY_FAILURE_H__ */
> 
> Dowe really need a new header for this vs just sequeezing it into
> xfs_super.h or something like that?

Yes, I'll move it into xfs_super.h.  The xfs_notify_failure.c was 
splitted from xfs_super.c in the old patch.  There is no need to create 
a header file for only single line of code.

> 
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index e8f37bdc8354..b8de6ed2c888 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -353,6 +353,12 @@ xfs_setup_dax_always(
>>   		return -EINVAL;
>>   	}
>>   
>> +	if (xfs_has_reflink(mp) && !xfs_has_rmapbt(mp)) {
>> +		xfs_alert(mp,
>> +			"need rmapbt when both DAX and reflink enabled.");
>> +		return -EINVAL;
>> +	}
> 
> Right now we can't even enable reflink with DAX yet, so adding this
> here seems premature - it should go into the patch allowing DAX+reflink.
> 

Yes.  I'll remove it for now.


--
Thanks,
Ruan.


