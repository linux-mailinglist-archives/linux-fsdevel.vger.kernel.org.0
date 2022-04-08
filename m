Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11214F8ECE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 08:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiDHGHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 02:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiDHGHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:07:09 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 948034D614;
        Thu,  7 Apr 2022 23:05:04 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AGYlHna/+/oaHGwtkw4IODrUD63+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUor1DECympJXmGDOfaLYGLzctBzPdzg80oH6JHXnd5gG1dlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQHOKlULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0OadeiTm65XIkSUqdFOpmZ2CFnoeMYQG++pfD3t?=
 =?us-ascii?q?J8PsCIjERKBuEgoqewLm7YuhqiN4qIMTiMMUYoH4I5T3QC7AkB4/CR6HL7NpD9?=
 =?us-ascii?q?DY2ms1KW/3ZYqIxZThwaxLPSx5CIFEaDNQ5hujArn3+dSBI7VeQjakp6mPQigt?=
 =?us-ascii?q?r39DFNsTZe9mPbcFUhVqD4GbH+XnpRB0XKrS3yzOD/zSnhvLnmjnyU4YfUra/8?=
 =?us-ascii?q?5ZChFyV23xWBgYaWEW2pdGnhUOkHdFSMUoZ/mwpt6da3EiqSMTtGh61uniJujY?=
 =?us-ascii?q?CVNdKVe438geAzuzT+QnxLmwFSCNRLcwor+coSjEwkFyEhdXkAXpoqrL9dJ433?=
 =?us-ascii?q?t94thvrYW5MczBEPnRCEGM4DxDYiNlbpnryohxLTcZZVuHIJAw=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AClRFn6rdr0epIOf70T8LNP4aV5rPeYIsimQD?=
 =?us-ascii?q?101hICG8cqSj5qKTdZMgpGbJYVcqKRcdcL+7V5VoLUmskaKdpLNhWotKPzOJhI?=
 =?us-ascii?q?LLFu1fBOLZqlWKcUDDH6xmpMJdmsNFaOEYY2IK7voSrDPYLz8/+qj7zImYwffZ?=
 =?us-ascii?q?02x2TRxnL4Vp7wJCAA6dFUFsLTM2fqYRJd6N4NZdvTq8dTAyZsS/PHMMWO/OvJ?=
 =?us-ascii?q?nlj5TjCCR2fSIP2U2fiy+y8r7mH1y91hcaaTlGxrAv6izkvmXCl92ej80=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123412136"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Apr 2022 14:05:03 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 455684D17163;
        Fri,  8 Apr 2022 14:04:59 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 8 Apr 2022 14:05:01 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 8 Apr 2022 14:04:57 +0800
Message-ID: <8f1931d2-b224-de98-4593-df136f397eb4@fujitsu.com>
Date:   Fri, 8 Apr 2022 14:04:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v11 7/8] xfs: Implement ->notify_failure() for XFS
To:     <dan.j.williams@intel.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <david@fromorbit.com>, <jane.chu@oracle.com>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-8-ruansy.fnst@fujitsu.com>
 <YkPyBQer+KRiregd@infradead.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YkPyBQer+KRiregd@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 455684D17163.A03E3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
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

Hi Dan,

Could you give some advise on this API?  Is it needed to move 
dax_register_holder's job into fs_dax_get_by_bdev()?


--
Thanks,
Ruan

> 
>> +#if IS_ENABLED(CONFIG_MEMORY_FAILURE) && IS_ENABLED(CONFIG_FS_DAX)
> 
> No real need for the IS_ENABLED.  Also any reason to even build this
> file if the options are not set?  It seems like
> xfs_dax_holder_operations should just be defined to NULL and the
> whole file not supported if we can't support the functionality.
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


