Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4629A4B67F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 10:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiBOJnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 04:43:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbiBOJnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:43:10 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D22B0E543E;
        Tue, 15 Feb 2022 01:42:58 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3AdtGk9q5vyiAqgAnEoCgAFQxRtFPGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS1zMBnzMdCz3Ubv+IZDOjLYglO9m2pBsPu8WAztc3QVc5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeyHi7J3LlBaun3zEhq8G4FsNFYER5Od7KW9?=
 =?us-ascii?q?U8vkfMjoMclaIgOfe6LKwSsFtgMo5JcXmNY9ZvWtvpRnVBPBgQ9bcQqHO5NZdx?=
 =?us-ascii?q?x8xgNxDGbDVYM9xQTZtcxPGbDVMN00RBZZ4m/2n7lH7cjtFuBeQoII0/WHYz0p?=
 =?us-ascii?q?2yreFGNzLdt2PQO1Rn12EvSTC/mLkElcWOcL34TiM9H/qje/StSThUYkWGfuz8?=
 =?us-ascii?q?fsCqFmSwHEDTRMNWValrP2RlEGzQZRcJlYS9y5oqrI9nGSvT9/gT1i7rWSCsxo?=
 =?us-ascii?q?0RdVdCas55RuLx66S5ByWbkAATzhceJk2utQeWzMnzBmKksnvCDgpt6eaIU9xX?=
 =?us-ascii?q?J/8QSiaYHBTdDFdI3RfC1Zt3jUqm6lr5jqnczqpOPfdYgXJJAzN?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AaaOxV6CchKL4qGvlHehAsceALOsnbusQ8zAX?=
 =?us-ascii?q?Ph9KJiC9I/b1qynxppkmPH/P6Qr4WBkb6LS90c67MAnhHP9OkPIs1NKZMjUO11?=
 =?us-ascii?q?HYSr2KgbGSoQEIeBeOidK1t50QCpSWYeeYZTMR7beY3ODRKadd/DDtytHOuQ6x?=
 =?us-ascii?q?9QYJcek8AJsQkjuRRzzrW3FedU1jP94UBZCc7s1Iq36JfmkWVN2yAj0gU/LYr9?=
 =?us-ascii?q?PGuZr6aVpebiRXozWmvHeN0vrXAhKY1hARX3dmxqojy3HMl0jc6r+4u/+25xfA?=
 =?us-ascii?q?3yv47ohQmvHm1txfbfb8wvQ9G3HJsEKFdY5hU7qNsHQcp/yu0k8jlJ32rxIpL6?=
 =?us-ascii?q?1ImgfsV1DwhSGo9xjr0T4o5XOn40Sfm2HfrcvwQy9/I9ZdhKpCGyGpp3YIjZVZ?=
 =?us-ascii?q?6uZmzmiZv51YAVfrhyLm/eXFUBlsiw6dvWciq+gOlHZSOLFuJYO5lbZvsn+9La?=
 =?us-ascii?q?1wXR4TsOscYalT5YDnlbxrmGqhHj/kVjIF+q3uYpwxdi32N3Tq9PblkQS+p0oJ?=
 =?us-ascii?q?vnfw8vZv7EvoxKhNNaWs2N60QpiA7Is+NvP+TZgNc9vpEvHHfFAkf3r3QRGvyB?=
 =?us-ascii?q?LcZeQ6B04=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="121559033"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Feb 2022 17:42:57 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id CE9FA4D15A57;
        Tue, 15 Feb 2022 17:42:53 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 15 Feb 2022 17:42:53 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 15 Feb 2022 17:42:53 +0800
Message-ID: <a1b9e96d-4517-99a8-877f-6de2b8375c88@fujitsu.com>
Date:   Tue, 15 Feb 2022 17:42:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v10.1 8/9] xfs: Implement ->notify_failure() for XFS
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
References: <20220201204140.GC8338@magnolia>
 <20220213130224.2723912-1-ruansy.fnst@fujitsu.com>
 <20220215014615.GA8269@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20220215014615.GA8269@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: CE9FA4D15A57.A6F15
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



在 2022/2/15 9:46, Darrick J. Wong 写道:
> On Sun, Feb 13, 2022 at 09:02:24PM +0800, Shiyang Ruan wrote:
>> v10.1 update:
>>   - Handle the error code returns by dax_register_holder()
>>   - In v10.1, dax_register_holder() will hold a write lock so XFS
>>       doesn't need to hold a lock
>>   - Fix the mistake in failure notification over two AGs
>>   - Fix the year in copyright message
>>
>> Introduce xfs_notify_failure.c to handle failure related works, such as
>> implement ->notify_failure(), register/unregister dax holder in xfs, and
>> so on.
>>
>> If the rmap feature of XFS enabled, we can query it to find files and
>> metadata which are associated with the corrupt data.  For now all we do
>> is kill processes with that file mapped into their address spaces, but
>> future patches could actually do something about corrupt metadata.
>>
>> After that, the memory failure needs to notify the processes who are
>> using those files.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   fs/xfs/Makefile             |   1 +
>>   fs/xfs/xfs_buf.c            |  12 ++
>>   fs/xfs/xfs_fsops.c          |   3 +
>>   fs/xfs/xfs_mount.h          |   1 +
>>   fs/xfs/xfs_notify_failure.c | 225 ++++++++++++++++++++++++++++++++++++
>>   fs/xfs/xfs_notify_failure.h |  10 ++
>>   6 files changed, 252 insertions(+)
>>   create mode 100644 fs/xfs/xfs_notify_failure.c
>>   create mode 100644 fs/xfs/xfs_notify_failure.h
>>
>> diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
>> index 04611a1068b4..389970b3e13b 100644
>> --- a/fs/xfs/Makefile
>> +++ b/fs/xfs/Makefile
>> @@ -84,6 +84,7 @@ xfs-y				+= xfs_aops.o \
>>   				   xfs_message.o \
>>   				   xfs_mount.o \
>>   				   xfs_mru_cache.o \
>> +				   xfs_notify_failure.o \
>>   				   xfs_pwork.o \
>>   				   xfs_reflink.o \
>>   				   xfs_stats.o \
>> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
>> index b45e0d50a405..941e8825cee6 100644
>> --- a/fs/xfs/xfs_buf.c
>> +++ b/fs/xfs/xfs_buf.c
>> @@ -19,6 +19,7 @@
>>   #include "xfs_errortag.h"
>>   #include "xfs_error.h"
>>   #include "xfs_ag.h"
>> +#include "xfs_notify_failure.h"
>>   
>>   static struct kmem_cache *xfs_buf_cache;
>>   
>> @@ -1892,6 +1893,8 @@ xfs_free_buftarg(
>>   	list_lru_destroy(&btp->bt_lru);
>>   
>>   	blkdev_issue_flush(btp->bt_bdev);
>> +	if (btp->bt_daxdev)
>> +		dax_unregister_holder(btp->bt_daxdev);
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
>>   
>>   	/*
>>   	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
>> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
>> index 33e26690a8c4..d4d36c5bef11 100644
>> --- a/fs/xfs/xfs_fsops.c
>> +++ b/fs/xfs/xfs_fsops.c
>> @@ -542,6 +542,9 @@ xfs_do_force_shutdown(
>>   	} else if (flags & SHUTDOWN_CORRUPT_INCORE) {
>>   		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
>>   		why = "Corruption of in-memory data";
>> +	} else if (flags & SHUTDOWN_CORRUPT_ONDISK) {
>> +		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
>> +		why = "Corruption of on-disk metadata";
>>   	} else {
>>   		tag = XFS_PTAG_SHUTDOWN_IOERROR;
>>   		why = "Metadata I/O Error";
>> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
>> index 00720a02e761..47ff4ac53c4c 100644
>> --- a/fs/xfs/xfs_mount.h
>> +++ b/fs/xfs/xfs_mount.h
>> @@ -435,6 +435,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
>>   #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
>>   #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
>>   #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
>> +#define SHUTDOWN_CORRUPT_ONDISK	0x0010  /* corrupt metadata on device */
>>   
>>   #define XFS_SHUTDOWN_STRINGS \
>>   	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
>> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
>> new file mode 100644
>> index 000000000000..aa67662210a1
>> --- /dev/null
>> +++ b/fs/xfs/xfs_notify_failure.c
>> @@ -0,0 +1,225 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Fujitsu.  All Rights Reserved.
>> + */
>> +
>> +#include "xfs.h"
>> +#include "xfs_shared.h"
>> +#include "xfs_format.h"
>> +#include "xfs_log_format.h"
>> +#include "xfs_trans_resv.h"
>> +#include "xfs_mount.h"
>> +#include "xfs_alloc.h"
>> +#include "xfs_bit.h"
>> +#include "xfs_btree.h"
>> +#include "xfs_inode.h"
>> +#include "xfs_icache.h"
>> +#include "xfs_rmap.h"
>> +#include "xfs_rmap_btree.h"
>> +#include "xfs_rtalloc.h"
>> +#include "xfs_trans.h"
>> +
>> +#include <linux/mm.h>
>> +#include <linux/dax.h>
>> +
>> +struct failure_info {
>> +	xfs_agblock_t		startblock;
>> +	xfs_extlen_t		blockcount;
>> +	int			mf_flags;
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_MEMORY_FAILURE) && IS_ENABLED(CONFIG_FS_DAX)
>> +static pgoff_t
>> +xfs_failure_pgoff(
>> +	struct xfs_mount		*mp,
>> +	const struct xfs_rmap_irec	*rec,
>> +	const struct failure_info	*notify)
>> +{
>> +	uint64_t			pos = rec->rm_offset;
>> +
>> +	if (notify->startblock > rec->rm_startblock)
>> +		pos += XFS_FSB_TO_B(mp,
>> +				notify->startblock - rec->rm_startblock);
>> +	return pos >> PAGE_SHIFT;
>> +}
>> +
>> +static unsigned long
>> +xfs_failure_pgcnt(
>> +	struct xfs_mount		*mp,
>> +	const struct xfs_rmap_irec	*rec,
>> +	const struct failure_info	*notify)
>> +{
>> +	xfs_agblock_t			end_rec;
>> +	xfs_agblock_t			end_notify;
>> +	xfs_agblock_t			start_cross;
>> +	xfs_agblock_t			end_cross;
>> +
>> +	start_cross = max(rec->rm_startblock, notify->startblock);
>> +
>> +	end_rec = rec->rm_startblock + rec->rm_blockcount;
>> +	end_notify = notify->startblock + notify->blockcount;
>> +	end_cross = min(end_rec, end_notify);
>> +
>> +	return XFS_FSB_TO_B(mp, end_cross - start_cross) >> PAGE_SHIFT;
>> +}
>> +
>> +static int
>> +xfs_dax_failure_fn(
>> +	struct xfs_btree_cur		*cur,
>> +	const struct xfs_rmap_irec	*rec,
>> +	void				*data)
>> +{
>> +	struct xfs_mount		*mp = cur->bc_mp;
>> +	struct xfs_inode		*ip;
>> +	struct failure_info		*notify = data;
>> +	int				error = 0;
>> +
>> +	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>> +	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
>> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>> +		return -EFSCORRUPTED;
>> +	}
>> +
>> +	/* Get files that incore, filter out others that are not in use. */
>> +	error = xfs_iget(mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE,
>> +			 0, &ip);
>> +	/* Continue the rmap query if the inode isn't incore */
>> +	if (error == -ENODATA)
>> +		return 0;
>> +	if (error)
>> +		return error;
>> +
>> +	error = mf_dax_kill_procs(VFS_I(ip)->i_mapping,
>> +				  xfs_failure_pgoff(mp, rec, notify),
>> +				  xfs_failure_pgcnt(mp, rec, notify),
>> +				  notify->mf_flags);
>> +	xfs_irele(ip);
>> +	return error;
>> +}
>> +#else
>> +static int
>> +xfs_dax_failure_fn(
>> +	struct xfs_btree_cur		*cur,
>> +	const struct xfs_rmap_irec	*rec,
>> +	void				*data)
>> +{
>> +	struct xfs_mount		*mp = cur->bc_mp;
>> +
>> +	/* No other option besides shutting down the fs. */
>> +	xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>> +	return -EFSCORRUPTED;
>> +}
>> +#endif /* CONFIG_MEMORY_FAILURE && CONFIG_FS_DAX */
>> +
>> +static int
>> +xfs_dax_notify_ddev_failure(
>> +	struct xfs_mount	*mp,
>> +	xfs_daddr_t		daddr,
>> +	xfs_daddr_t		bblen,
>> +	int			mf_flags)
>> +{
>> +	struct xfs_trans	*tp = NULL;
>> +	struct xfs_btree_cur	*cur = NULL;
>> +	struct xfs_buf		*agf_bp = NULL;
>> +	int			error = 0;
>> +	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
>> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
>> +	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen);
>> +	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
>> +
>> +	error = xfs_trans_alloc_empty(mp, &tp);
>> +	if (error)
>> +		return error;
>> +
>> +	for (; agno <= end_agno; agno++) {
>> +		struct xfs_rmap_irec	ri_low = { };
>> +		struct xfs_rmap_irec	ri_high;
>> +		struct failure_info	notify;
>> +		struct xfs_agf		*agf;
>> +		xfs_agblock_t		agend;
>> +
>> +		error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
>> +		if (error)
>> +			break;
>> +
>> +		cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agf_bp->b_pag);
>> +
>> +		/*
>> +		 * Set the rmap range from ri_low to ri_high, which represents
>> +		 * a [start, end] where we looking for the files or metadata.
>> +		 * The part of range out of a AG will be ignored.  So, it's fine
>> +		 * to set ri_low to "startblock" in all loops.  When it reaches
>> +		 * the last AG, set the ri_high to "endblock" to make sure we
>> +		 * actually end at the end.
>> +		 */
>> +		memset(&ri_high, 0xFF, sizeof(ri_high));
>> +		ri_low.rm_startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
>> +		if (agno == end_agno)
>> +			ri_high.rm_startblock = XFS_FSB_TO_AGBNO(mp, end_fsbno);
>> +
>> +		agf = agf_bp->b_addr;
>> +		agend = min(be32_to_cpu(agf->agf_length),
>> +				ri_high.rm_startblock);
>> +		notify.startblock = ri_low.rm_startblock;
>> +		notify.blockcount = agend - ri_low.rm_startblock;
>> +
>> +		error = xfs_rmap_query_range(cur, &ri_low, &ri_high,
>> +				xfs_dax_failure_fn, &notify);
>> +		xfs_btree_del_cursor(cur, error);
>> +		xfs_trans_brelse(tp, agf_bp);
>> +		if (error)
>> +			break;
>> +
>> +		fsbno = XFS_AGB_TO_FSB(mp, agno + 1, 0);
>> +	}
>> +
>> +	xfs_trans_cancel(tp);
>> +	return error;
>> +}
>> +
>> +static int
>> +xfs_dax_notify_failure(
>> +	struct dax_device	*dax_dev,
>> +	u64			offset,
>> +	u64			len,
>> +	int			mf_flags)
>> +{
>> +	struct xfs_mount	*mp = dax_holder(dax_dev);
>> +
>> +	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
>> +		xfs_warn(mp,
>> +			 "notify_failure() not supported on realtime device!");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>> +	    mp->m_logdev_targp != mp->m_ddev_targp) {
>> +		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>> +		return -EFSCORRUPTED;
>> +	}
>> +
>> +	if (!xfs_has_rmapbt(mp)) {
>> +		xfs_warn(mp, "notify_failure() needs rmapbt enabled!");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	/* Ignore the range out of filesystem area */
>> +	if ((offset + len) < mp->m_ddev_targp->bt_dax_part_off)
>> +		return -ENXIO;
>> +	if (offset > (mp->m_ddev_targp->bt_dax_part_off +
>> +			mp->m_ddev_targp->bt_bdev->bd_nr_sectors))
>> +		return -ENXIO;
>> +
>> +	if (offset > mp->m_ddev_targp->bt_dax_part_off)
>> +		offset -= mp->m_ddev_targp->bt_dax_part_off;
>> +	else
>> +		offset = 0;
> 
> I think you need to adjust len if you adjust @offset.
> 
> You might also want to clamp len so that it doesn't go beyond the end of
> the filesystem.

Yes, I forgot to think of that.  Will fix it.


--
Thanks,
Ruan.

> 
> --D
> 
>> +
>> +	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
>> +			mf_flags);
>> +}
>> +
>> +const struct dax_holder_operations xfs_dax_holder_operations = {
>> +	.notify_failure		= xfs_dax_notify_failure,
>> +};
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
>> -- 
>> 2.34.1
>>
>>
>>


