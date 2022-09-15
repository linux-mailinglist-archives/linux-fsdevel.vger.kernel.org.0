Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BE15B925A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 03:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiIOBts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 21:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIOBtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:49:46 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE622186CA;
        Wed, 14 Sep 2022 18:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1663206582; i=@fujitsu.com;
        bh=rBcRdkltDnvoxKepJMU0xIuM7p8Qal0AgclNKzc3qas=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=ui6MUcF+UlH1/eAfKLJR7LCQlPX+3nv8qMWI2EEd22X6Xot61egARz4F3k3nMiOJ0
         SeexaM2gaQ0mcLeWOF13rkdY9x+QBOs7W//tnZZgK3xE0rEmgq7VDwnRz9gdnOvWex
         jbKf1OL5VxHuwn15pd+9l4DeyNW/lnh15ibTQg4UTil0by5ARECg+0mJ799c/CBA8U
         1GFWhkxesQiTM9i89rbLRxxW8nC2egkG10KDvpbL7j6LSCNSUsiwXsQceA0zB5aRF4
         /vV0JfMRho33AjNh0IlInpn1bi8twIalO01P9WLf8HHqVAfDL6cXfdcnwyBEABGnku
         byrqLgGn+6/Kw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRWlGSWpSXmKPExsViZ8ORqLulRSn
  ZYHanrsX0qRcYLbYcu8docfkJn8XpCYuYLHa/vslmsWfvSRaLy7vmsFncW/Of1WLXnx3sFit/
  /GF14PI4tUjCY/MKLY/Fe14yeWxa1cnmsenTJHaPF5tnMnp8fHqLxePzJrkAjijWzLyk/IoE1
  oyL6xcyF/xRq2i5PYetgfGifBcjF4eQwBZGib9di1ghnOVMEls+tTBDONsZJc6evMXSxcjJwS
  tgJ3Fm9g1GEJtFQFXi/tcGVoi4oMTJmU/AakQFkiXuHl4PZgsLeEns3/GICcQWEdCUOPLtGhP
  IUGaBT4wSM47/YYPYcJ5RovXoHnaQKjYBHYkLC/6CTeUU0JC43N4Mto1ZwEJi8ZuD7BC2vETz
  1tlA53FwSAgoSczsjgcJSwhUSDROP8QEYatJXD23iXkCo9AsJPfNQjJpFpJJCxiZVzFaJRVlp
  meU5CZm5ugaGhjoGhqa6hpb6loY6SVW6SbqpZbqlqcWl+gCueXFeqnFxXrFlbnJOSl6eaklmx
  iBEZlSrB60g/Hbip96hxglOZiURHmZ5JSShfiS8lMqMxKLM+KLSnNSiw8xynBwKEnwPq8Hygk
  WpaanVqRl5gCTA0xagoNHSYT3E0iat7ggMbc4Mx0idYrRmGNtw4G9zBxTZ//bzyzEkpeflyol
  zuvVBFQqAFKaUZoHNwiWtC4xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuaNbgSawpOZVwK37
  xXQKUxApxhZy4OcUpKIkJJqYHLYFNHWuCl4c/yfchGtZEH2RbrGorXGGzVDNK63//tirubEPq
  sqVb93SXeJ3L8Vsn/lee6d3mwe/kJYY8b3jlrjMIbc2w3TtDnCz7mrL+s8wr59KddkxpcMB/0
  Wv8uOKn6h8fyhp9C8q9dvPl5W+zG1K2jjqm2+D9c0Wpj18CrJZT40OGPylXf3Mvst7exbRVNy
  DLfeurbz2brHZxL+6/6/MOl9+asm432lmmdfr+NarXb3qc29H8Ea1xTvJ93QFHRcaOx/+Iily
  C3RCQ++X4/rvNzs9E/n9411bEsSghuj17xTnpabfKxm7krL0uM27YfZGGZJGQnOdzsg+I/hqk
  WA/YosFf9Tkf8cTr/UXqnEUpyRaKjFXFScCAAm/o6j1QMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-2.tower-548.messagelabs.com!1663206580!18747!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9520 invoked from network); 15 Sep 2022 01:49:40 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-2.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Sep 2022 01:49:40 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 60F7210018D;
        Thu, 15 Sep 2022 02:49:40 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 5442A100043;
        Thu, 15 Sep 2022 02:49:40 +0100 (BST)
Received: from [192.168.22.78] (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 15 Sep 2022 02:49:36 +0100
Message-ID: <048b5294-b60d-cbb7-76b7-8f0c69dba23b@fujitsu.com>
Date:   Thu, 15 Sep 2022 09:49:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
References: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
 <1662114961-66-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1662114961-66-4-git-send-email-ruansy.fnst@fujitsu.com>
 <YyIaP4EFNaYhqKkQ@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YyIaP4EFNaYhqKkQ@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/9/15 2:15, Darrick J. Wong 写道:
> On Fri, Sep 02, 2022 at 10:36:01AM +0000, Shiyang Ruan wrote:
>> This patch is inspired by Dan's "mm, dax, pmem: Introduce
>> dev_pagemap_failure()"[1].  With the help of dax_holder and
>> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
>> (or mapped device) on it to unmap all files in use and notify processes
>> who are using those files.
>>
>> Call trace:
>> trigger unbind
>>   -> unbind_store()
>>    -> ... (skip)
>>     -> devres_release_all()   # was pmem driver ->remove() in v1
>>      -> kill_dax()
>>       -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
>>        -> xfs_dax_notify_failure()
>>
>> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
>> event.  So do not shutdown filesystem directly if something not
>> supported, or if failure range includes metadata area.  Make sure all
>> files and processes are handled correctly.
>>
>> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/dax/super.c         |  3 ++-
>>   fs/xfs/xfs_notify_failure.c | 23 +++++++++++++++++++++++
>>   include/linux/mm.h          |  1 +
>>   3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
>> index 9b5e2a5eb0ae..cf9a64563fbe 100644
>> --- a/drivers/dax/super.c
>> +++ b/drivers/dax/super.c
>> @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
>>   		return;
>>   
>>   	if (dax_dev->holder_data != NULL)
>> -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
>> +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
>> +				MF_MEM_PRE_REMOVE);
>>   
>>   	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
>>   	synchronize_srcu(&dax_srcu);
>> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
>> index 3830f908e215..5e04ba7fa403 100644
>> --- a/fs/xfs/xfs_notify_failure.c
>> +++ b/fs/xfs/xfs_notify_failure.c
>> @@ -22,6 +22,7 @@
>>   
>>   #include <linux/mm.h>
>>   #include <linux/dax.h>
>> +#include <linux/fs.h>
>>   
>>   struct xfs_failure_info {
>>   	xfs_agblock_t		startblock;
>> @@ -77,6 +78,9 @@ xfs_dax_failure_fn(
>>   
>>   	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>>   	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
>> +		/* The device is about to be removed.  Not a really failure. */
>> +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
>> +			return 0;
>>   		notify->want_shutdown = true;
>>   		return 0;
>>   	}
>> @@ -182,12 +186,23 @@ xfs_dax_notify_failure(
>>   	struct xfs_mount	*mp = dax_holder(dax_dev);
>>   	u64			ddev_start;
>>   	u64			ddev_end;
>> +	int			error;
>>   
>>   	if (!(mp->m_super->s_flags & SB_BORN)) {
>>   		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
>>   		return -EIO;
>>   	}
>>   
>> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
>> +		xfs_info(mp, "device is about to be removed!");
>> +		down_write(&mp->m_super->s_umount);
>> +		error = sync_filesystem(mp->m_super);
>> +		drop_pagecache_sb(mp->m_super, NULL);
>> +		up_write(&mp->m_super->s_umount);
>> +		if (error)
>> +			return error;
>> +	}
>> +
>>   	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
>>   		xfs_debug(mp,
>>   			 "notify_failure() not supported on realtime device!");
>> @@ -196,6 +211,8 @@ xfs_dax_notify_failure(
>>   
>>   	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>>   	    mp->m_logdev_targp != mp->m_ddev_targp) {
>> +		if (mf_flags & MF_MEM_PRE_REMOVE)
>> +			return 0;
>>   		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>>   		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>>   		return -EFSCORRUPTED;
>> @@ -209,6 +226,12 @@ xfs_dax_notify_failure(
>>   	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
>>   	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
>>   
>> +	/* Notify failure on the whole device */
>> +	if (offset == 0 && len == U64_MAX) {
>> +		offset = ddev_start;
>> +		len = bdev_nr_bytes(mp->m_ddev_targp->bt_bdev);
>> +	}
> 
> I wonder, won't the trimming code below take care of this?

The len is U64_MAX, so 'offset + len - 1' will overflow.  That can't be 
handled correctly by the trimming code below.


--
Thanks,
Ruan.

> 
> The rest of the patch looks ok to me.
> 
> --D
> 
>> +
>>   	/* Ignore the range out of filesystem area */
>>   	if (offset + len - 1 < ddev_start)
>>   		return -ENXIO;
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 21f8b27bd9fd..9122a1c57dd2 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3183,6 +3183,7 @@ enum mf_flags {
>>   	MF_UNPOISON = 1 << 4,
>>   	MF_SW_SIMULATED = 1 << 5,
>>   	MF_NO_RETRY = 1 << 6,
>> +	MF_MEM_PRE_REMOVE = 1 << 7,
>>   };
>>   int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>>   		      unsigned long count, int mf_flags);
>> -- 
>> 2.37.2
>>
