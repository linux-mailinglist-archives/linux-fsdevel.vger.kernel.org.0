Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5A440D230
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 06:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhIPECw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 00:02:52 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6828 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229463AbhIPECw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 00:02:52 -0400
IronPort-Data: =?us-ascii?q?A9a23=3A357CzKBYh08fLxVW/1Liw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fBlW7gTxz1zcByjAaWj/XOf2LZDD8Kt1xbo208EIEsJOAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkExcwmj/3auK49Sgli/nRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZPEbpeSXeyfXXcu7iheun2HX6/lnEkA6FYMC/eNwG2t?=
 =?us-ascii?q?P6boTLzVlRg+Cg+an6LO9RPNliskqII/sJox3kn1py3fbS+knRZTCSqDRzd5ew?=
 =?us-ascii?q?Do0wMtJGJ72a8gGbjxgRBfNeRtCPhEQEp1WtOG2inj6dhVcqUmJvuwz4m7O3Ep?=
 =?us-ascii?q?93aaFGNreevSOXtkTkkvwjnjJ+GD1HQAcHMeC0jfD/n/EruvOmz7rHYwJGLCm+?=
 =?us-ascii?q?/pCnlKe3CoQBQcQWF/9puO24ma6WtRCOwkX9zAooKwa6kOmVJ/+Uge+rXrCuQQ?=
 =?us-ascii?q?TM/JUEusn+ESdxLH8/QmUHC4HQyRHZdhgs9U5LRQ010WOt8HkAz1x9rmUT2+Ns?=
 =?us-ascii?q?LCOonWvOkAowcUqDcMfZVJdpYC9/8do1VSSJuuP2ZWd1rXdcQwcCRjTxMTmu4g?=
 =?us-ascii?q?usA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AQbzQjKHfi1gB9f85pLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.85,297,1624291200"; 
   d="scan'208";a="114553827"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Sep 2021 12:01:30 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id B49994D0DC75;
        Thu, 16 Sep 2021 12:01:26 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 12:01:20 +0800
Received: from [127.0.0.1] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 16 Sep 2021 12:01:20 +0800
Subject: Re: [PATCH v9 8/8] xfs: Add dax dedupe support
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <hch@lst.de>, <linux-xfs@vger.kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rgoldwyn@suse.de>,
        <viro@zeniv.linux.org.uk>, <willy@infradead.org>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
 <20210915104501.4146910-9-ruansy.fnst@fujitsu.com>
 <20210916003008.GE34830@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <38eeee6f-aa11-4c13-b7c0-2e48927b85dc@fujitsu.com>
Date:   Thu, 16 Sep 2021 12:01:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916003008.GE34830@magnolia>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-yoursite-MailScanner-ID: B49994D0DC75.A3825
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/9/16 8:30, Darrick J. Wong wrote:
> On Wed, Sep 15, 2021 at 06:45:01PM +0800, Shiyang Ruan wrote:
>> Introduce xfs_mmaplock_two_inodes_and_break_dax_layout() for dax files
>> who are going to be deduped.  After that, call compare range function
>> only when files are both DAX or not.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   fs/xfs/xfs_file.c    |  2 +-
>>   fs/xfs/xfs_inode.c   | 80 +++++++++++++++++++++++++++++++++++++++++---
>>   fs/xfs/xfs_inode.h   |  1 +
>>   fs/xfs/xfs_reflink.c |  4 +--
>>   4 files changed, 80 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index 2ef1930374d2..c3061723613c 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -846,7 +846,7 @@ xfs_wait_dax_page(
>>   	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
>>   }
>>   
>> -static int
>> +int
>>   xfs_break_dax_layouts(
>>   	struct inode		*inode,
>>   	bool			*retry)
>> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>> index a4f6f034fb81..bdc084cdbf46 100644
>> --- a/fs/xfs/xfs_inode.c
>> +++ b/fs/xfs/xfs_inode.c
>> @@ -3790,6 +3790,61 @@ xfs_iolock_two_inodes_and_break_layout(
>>   	return 0;
>>   }
>>   
>> +static int
>> +xfs_mmaplock_two_inodes_and_break_dax_layout(
>> +	struct xfs_inode	*ip1,
>> +	struct xfs_inode	*ip2)
>> +{
>> +	int			error, attempts = 0;
>> +	bool			retry;
>> +	struct page		*page;
>> +	struct xfs_log_item	*lp;
>> +
>> +	if (ip1->i_ino > ip2->i_ino)
>> +		swap(ip1, ip2);
>> +
>> +again:
>> +	retry = false;
>> +	/* Lock the first inode */
>> +	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
>> +	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
>> +	if (error || retry) {
>> +		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
>> +		if (error == 0 && retry)
>> +			goto again;
>> +		return error;
>> +	}
>> +
>> +	if (ip1 == ip2)
>> +		return 0;
>> +
>> +	/* Nested lock the second inode */
>> +	lp = &ip1->i_itemp->ili_item;
>> +	if (lp && test_bit(XFS_LI_IN_AIL, &lp->li_flags)) {
>> +		if (!xfs_ilock_nowait(ip2,
>> +		    xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1))) {
>> +			xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
>> +			if ((++attempts % 5) == 0)
>> +				delay(1); /* Don't just spin the CPU */
>> +			goto again;
>> +		}
> 
> I suspect we don't need this part for grabbing the MMAPLOCK^W pagecache
> invalidatelock.  The AIL only grabs the ILOCK, never the IOLOCK or the
> MMAPLOCK.

Maybe I have misunderstood this part.

What I want is to lock the two inode nestedly.  This code is copied from 
xfs_lock_two_inodes(), which checks this AIL during locking two inode 
with each of the three kinds of locks.

But I also found the recent merged function: 
filemap_invalidate_lock_two() just locks two inode directly without 
checking AIL.  So, I am not if the AIL check is needed in this case.

> 
>> +	} else
>> +		xfs_ilock(ip2, xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1));
>> +	/*
>> +	 * We cannot use xfs_break_dax_layouts() directly here because it may
>> +	 * need to unlock & lock the XFS_MMAPLOCK_EXCL which is not suitable
>> +	 * for this nested lock case.
>> +	 */
>> +	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
>> +	if (page && page_ref_count(page) != 1) {
> 
> Do you think the patch "ext4/xfs: add page refcount helper" would be a
> good cleanup to head this series?
> 
> https://lore.kernel.org/linux-xfs/20210913161604.31981-1-alex.sierra@amd.com/T/#m59cf7cd5c0d521ad487fa3a15d31c3865db88bdf

Got it.


--
Thanks,
Ruan

> 
> The rest of the logic looks ok.
> 
> --D
> 
>> +		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
>> +		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
>> +		goto again;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * Lock two inodes so that userspace cannot initiate I/O via file syscalls or
>>    * mmap activity.
>> @@ -3804,8 +3859,19 @@ xfs_ilock2_io_mmap(
>>   	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
>>   	if (ret)
>>   		return ret;
>> -	filemap_invalidate_lock_two(VFS_I(ip1)->i_mapping,
>> -				    VFS_I(ip2)->i_mapping);
>> +
>> +	if (IS_DAX(VFS_I(ip1)) && IS_DAX(VFS_I(ip2))) {
>> +		ret = xfs_mmaplock_two_inodes_and_break_dax_layout(ip1, ip2);
>> +		if (ret) {
>> +			inode_unlock(VFS_I(ip2));
>> +			if (ip1 != ip2)
>> +				inode_unlock(VFS_I(ip1));
>> +			return ret;
>> +		}
>> +	} else
>> +		filemap_invalidate_lock_two(VFS_I(ip1)->i_mapping,
>> +					    VFS_I(ip2)->i_mapping);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -3815,8 +3881,14 @@ xfs_iunlock2_io_mmap(
>>   	struct xfs_inode	*ip1,
>>   	struct xfs_inode	*ip2)
>>   {
>> -	filemap_invalidate_unlock_two(VFS_I(ip1)->i_mapping,
>> -				      VFS_I(ip2)->i_mapping);
>> +	if (IS_DAX(VFS_I(ip1)) && IS_DAX(VFS_I(ip2))) {
>> +		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
>> +		if (ip1 != ip2)
>> +			xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
>> +	} else
>> +		filemap_invalidate_unlock_two(VFS_I(ip1)->i_mapping,
>> +					      VFS_I(ip2)->i_mapping);
>> +
>>   	inode_unlock(VFS_I(ip2));
>>   	if (ip1 != ip2)
>>   		inode_unlock(VFS_I(ip1));
>> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
>> index b21b177832d1..f7e26fe31a26 100644
>> --- a/fs/xfs/xfs_inode.h
>> +++ b/fs/xfs/xfs_inode.h
>> @@ -472,6 +472,7 @@ enum xfs_prealloc_flags {
>>   
>>   int	xfs_update_prealloc_flags(struct xfs_inode *ip,
>>   				  enum xfs_prealloc_flags flags);
>> +int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
>>   int	xfs_break_layouts(struct inode *inode, uint *iolock,
>>   		enum layout_break_reason reason);
>>   
>> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
>> index 9d876e268734..3b99c9dfcf0d 100644
>> --- a/fs/xfs/xfs_reflink.c
>> +++ b/fs/xfs/xfs_reflink.c
>> @@ -1327,8 +1327,8 @@ xfs_reflink_remap_prep(
>>   	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
>>   		goto out_unlock;
>>   
>> -	/* Don't share DAX file data for now. */
>> -	if (IS_DAX(inode_in) || IS_DAX(inode_out))
>> +	/* Don't share DAX file data with non-DAX file. */
>> +	if (IS_DAX(inode_in) != IS_DAX(inode_out))
>>   		goto out_unlock;
>>   
>>   	if (!IS_DAX(inode_in))
>> -- 
>> 2.33.0
>>
>>
>>


