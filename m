Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C633558D04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 03:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiFXBvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 21:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFXBvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 21:51:21 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFC39522EF;
        Thu, 23 Jun 2022 18:51:19 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3Aprsgz6h6yUXcqEkp9ze+PJzbX161CxEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUAzGseXG7QbqyNNmb3ct1zaN7ioUkGsJPcz4MxGQU+qHw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUra?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHl7JLOlhOYKRMAxN0rVinaJ7Yw9u9pAG1?=
 =?us-ascii?q?m++YfLTcXZBGfwemxxdqTSuJsrsUlItPiMI4Wtjdn1z6xJfovR9bBBbrL4dtZ1?=
 =?us-ascii?q?TIrrsFIAfvaIcEebFJHYBbfZBtAElQaEpQzmKGvnHaXWzlZrk+F4K8yy2vNxQd?=
 =?us-ascii?q?ylr/3P7L9fMKGRMBQtkKZvX7duWD4BAwKctCS11Kt8Huqi6nEnT7TX5gbH7m1s?=
 =?us-ascii?q?PVthTW7wm0VFQ1TW0C3rOe0jmagVN9FbU8Z4Cwjqe417kPDZt38WQCo5X2JpBg?=
 =?us-ascii?q?RX/JOHOAgrgKA0KzZ50CeHGdsZjpAbsE28d84XhQ02VKT2dDkHzpitPuSU331y?=
 =?us-ascii?q?1s+hVteIgBMdSlbO3BCFlBDvrHeTEgIpkqnZr5e/GSd1bUZwQ3N/g0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AlyTdK6lnjpYGEdXB9WiKkMqV/0bpDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="125651662"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Jun 2022 09:51:18 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 178174D17189;
        Fri, 24 Jun 2022 09:51:16 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 24 Jun 2022 09:51:16 +0800
Received: from [192.168.22.78] (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 24 Jun 2022 09:51:15 +0800
Message-ID: <fe991e58-f86b-d0b4-65c7-de8c3f65e835@fujitsu.com>
Date:   Fri, 24 Jun 2022 09:51:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
 <20220615125400.880067-1-ruansy.fnst@fujitsu.com> <YrNIGGBK7/cztV8c@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YrNIGGBK7/cztV8c@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 178174D17189.A3973
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



在 2022/6/23 0:49, Darrick J. Wong 写道:
> On Wed, Jun 15, 2022 at 08:54:00PM +0800, Shiyang Ruan wrote:
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
>>       -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_REMOVE)
>>        -> xfs_dax_notify_failure()
>>
>> Introduce MF_MEM_REMOVE to let filesystem know this is a remove event.
>> So do not shutdown filesystem directly if something not supported, or if
>> failure range includes metadata area.  Make sure all files and processes
>> are handled correctly.
>>
>> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>>
>> ==
>> Changes since v2:
>>    1. Rebased on next-20220615
>>
>> Changes since v1:
>>    1. Drop the needless change of moving {kill,put}_dax()
>>    2. Rebased on '[PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink'[2]
>>
>> ---
>>   drivers/dax/super.c         | 2 +-
>>   fs/xfs/xfs_notify_failure.c | 6 +++++-
>>   include/linux/mm.h          | 1 +
>>   3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
>> index 9b5e2a5eb0ae..d4bc83159d46 100644
>> --- a/drivers/dax/super.c
>> +++ b/drivers/dax/super.c
>> @@ -323,7 +323,7 @@ void kill_dax(struct dax_device *dax_dev)
>>   		return;
>>   
>>   	if (dax_dev->holder_data != NULL)
>> -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
>> +		dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_REMOVE);
> 
> At the point we're initiating a MEM_REMOVE call, is the pmem already
> gone, or is it about to be gone?

It's about to be gone.

I found two cases:
   1. exec `unbind` by user, who wants to unplug the pmem
   2. handle failures during initialization

> 
>>   
>>   	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
>>   	synchronize_srcu(&dax_srcu);
>> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
>> index aa8dc27c599c..91d3f05d4241 100644
>> --- a/fs/xfs/xfs_notify_failure.c
>> +++ b/fs/xfs/xfs_notify_failure.c
>> @@ -73,7 +73,9 @@ xfs_dax_failure_fn(
>>   	struct failure_info		*notify = data;
>>   	int				error = 0;
>>   
>> -	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>> +	/* Do not shutdown so early when device is to be removed */
>> +	if (!(notify->mf_flags & MF_MEM_REMOVE) ||
>> +	    XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>>   	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
>>   		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>>   		return -EFSCORRUPTED;
>> @@ -182,6 +184,8 @@ xfs_dax_notify_failure(
>>   
>>   	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>>   	    mp->m_logdev_targp != mp->m_ddev_targp) {
>> +		if (mf_flags & MF_MEM_REMOVE)
>> +			return -EOPNOTSUPP;
> 
> The reason I ask is that if the pmem is *about to be* but not yet
> removed from the system, shouldn't we at least try to flush all dirty
> files and the log to reduce data loss and minimize recovery time?

Yes, they should be flushed.  Will add it.


--
Thanks,
Ruan.

> 
> If it's already gone, then you might as well shut down immediately,
> unless there's a chance the pmem will come back(?)
> 
> --D
> 
>>   		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>>   		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>>   		return -EFSCORRUPTED;
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 623c2ee8330a..bbeb31883362 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3249,6 +3249,7 @@ enum mf_flags {
>>   	MF_SOFT_OFFLINE = 1 << 3,
>>   	MF_UNPOISON = 1 << 4,
>>   	MF_NO_RETRY = 1 << 5,
>> +	MF_MEM_REMOVE = 1 << 6,
>>   };
>>   int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>>   		      unsigned long count, int mf_flags);
>> -- 
>> 2.36.1
>>
>>
>>


