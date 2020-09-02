Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE35D25B2DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 19:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgIBRVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 13:21:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42508 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBRVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:21:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082HB2lA061738;
        Wed, 2 Sep 2020 17:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=4HLDigxdcpLn42CKisOd7x9w9Lj7LpnFjiH/mRSwaR4=;
 b=pxLIZs/oyQjC2pqkY7pXvRgr7avs+STY8s4EADNSE70alsQPlacPgUM5kAcxyC5tKNnL
 pVLiI/FPrxDSR+V1xhyuA3VMeZstDneo0hrJurObYt9hZ3NkFxDu+s0meH/Xa9PXXIZr
 QFdBz5pL1kROXZI0ikqOk+vnJs/4YT657ABrdGyuFesg+GFgVsWlYo+xgksqN104OQFQ
 K6WfSA3VJ8sqLAhfhaoIVFR+z2wBeAHOX6M1B9Ss1TCZnpRRctzccmXFtrij8amf79eB
 cy5JQ9I49tWtMODc66p7Y0ALVwnNiKZNU7pB5+XGXaE1ICDYITLHajqvxk6PymYy/SaF hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 337eer42ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 17:20:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082H9j0M020358;
        Wed, 2 Sep 2020 17:20:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3380y03hpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 17:20:51 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 082HKoo7030811;
        Wed, 2 Sep 2020 17:20:50 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 10:20:50 -0700
Date:   Wed, 2 Sep 2020 10:20:48 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Martijn Coenen <maco@android.com>,
        xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 4/4] writeback: Drop I_DIRTY_TIME_EXPIRE
Message-ID: <20200902172048.GI6090@magnolia>
References: <20200611075033.1248-1-jack@suse.cz>
 <20200611081203.18161-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611081203.18161-4-jack@suse.cz>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020164
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[add linux-xfs and xfsprogs maintainer to cc]

On Thu, Jun 11, 2020 at 10:11:55AM +0200, Jan Kara wrote:
> The only use of I_DIRTY_TIME_EXPIRE is to detect in
> __writeback_single_inode() that inode got there because flush worker
> decided it's time to writeback the dirty inode time stamps (either
> because we are syncing or because of age). However we can detect this
> directly in __writeback_single_inode() and there's no need for the
> strange propagation with I_DIRTY_TIME_EXPIRE flag.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c                  |  2 +-
>  fs/fs-writeback.c                | 28 +++++++++++-----------------
>  fs/xfs/libxfs/xfs_trans_inode.c  |  4 ++--

Urrk, so I only just noticed this when I rebased my development tree
onto 5.9-rc3.  If you're going to change things in fs/xfs/, please cc
the xfs list to keep us in the loop.  Changes to fs/xfs/libxfs/ have to
be ported to userspace.

--D

>  include/linux/fs.h               |  1 -
>  include/trace/events/writeback.h |  1 -
>  5 files changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 40ec5c7ef0d3..4db497f02ffb 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4887,7 +4887,7 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
>  	    (inode->i_state & I_DIRTY_TIME)) {
>  		struct ext4_inode_info	*ei = EXT4_I(inode);
>  
> -		inode->i_state &= ~(I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED);
> +		inode->i_state &= ~I_DIRTY_TIME;
>  		spin_unlock(&inode->i_lock);
>  
>  		spin_lock(&ei->i_raw_lock);
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index ae17d64a3e18..149227160ff0 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1238,7 +1238,7 @@ static bool inode_dirtied_after(struct inode *inode, unsigned long t)
>   */
>  static int move_expired_inodes(struct list_head *delaying_queue,
>  			       struct list_head *dispatch_queue,
> -			       int flags, unsigned long dirtied_before)
> +			       unsigned long dirtied_before)
>  {
>  	LIST_HEAD(tmp);
>  	struct list_head *pos, *node;
> @@ -1254,8 +1254,6 @@ static int move_expired_inodes(struct list_head *delaying_queue,
>  		list_move(&inode->i_io_list, &tmp);
>  		moved++;
>  		spin_lock(&inode->i_lock);
> -		if (flags & EXPIRE_DIRTY_ATIME)
> -			inode->i_state |= I_DIRTY_TIME_EXPIRED;
>  		inode->i_state |= I_SYNC_QUEUED;
>  		spin_unlock(&inode->i_lock);
>  		if (sb_is_blkdev_sb(inode->i_sb))
> @@ -1303,11 +1301,11 @@ static void queue_io(struct bdi_writeback *wb, struct wb_writeback_work *work,
>  
>  	assert_spin_locked(&wb->list_lock);
>  	list_splice_init(&wb->b_more_io, &wb->b_io);
> -	moved = move_expired_inodes(&wb->b_dirty, &wb->b_io, 0, dirtied_before);
> +	moved = move_expired_inodes(&wb->b_dirty, &wb->b_io, dirtied_before);
>  	if (!work->for_sync)
>  		time_expire_jif = jiffies - dirtytime_expire_interval * HZ;
>  	moved += move_expired_inodes(&wb->b_dirty_time, &wb->b_io,
> -				     EXPIRE_DIRTY_ATIME, time_expire_jif);
> +				     time_expire_jif);
>  	if (moved)
>  		wb_io_lists_populated(wb);
>  	trace_writeback_queue_io(wb, work, dirtied_before, moved);
> @@ -1483,18 +1481,14 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  	spin_lock(&inode->i_lock);
>  
>  	dirty = inode->i_state & I_DIRTY;
> -	if (inode->i_state & I_DIRTY_TIME) {
> -		if ((dirty & I_DIRTY_INODE) ||
> -		    wbc->sync_mode == WB_SYNC_ALL ||
> -		    unlikely(inode->i_state & I_DIRTY_TIME_EXPIRED) ||
> -		    unlikely(time_after(jiffies,
> -					(inode->dirtied_time_when +
> -					 dirtytime_expire_interval * HZ)))) {
> -			dirty |= I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED;
> -			trace_writeback_lazytime(inode);
> -		}
> -	} else
> -		inode->i_state &= ~I_DIRTY_TIME_EXPIRED;
> +	if ((inode->i_state & I_DIRTY_TIME) &&
> +	    ((dirty & I_DIRTY_INODE) ||
> +	     wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
> +	     time_after(jiffies, inode->dirtied_time_when +
> +			dirtytime_expire_interval * HZ))) {
> +		dirty |= I_DIRTY_TIME;
> +		trace_writeback_lazytime(inode);
> +	}
>  	inode->i_state &= ~dirty;
>  
>  	/*
> diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> index b5dfb6654842..1b4df6636944 100644
> --- a/fs/xfs/libxfs/xfs_trans_inode.c
> +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> @@ -96,9 +96,9 @@ xfs_trans_log_inode(
>  	 * to log the timestamps, or will clear already cleared fields in the
>  	 * worst case.
>  	 */
> -	if (inode->i_state & (I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED)) {
> +	if (inode->i_state & I_DIRTY_TIME) {
>  		spin_lock(&inode->i_lock);
> -		inode->i_state &= ~(I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED);
> +		inode->i_state &= ~I_DIRTY_TIME;
>  		spin_unlock(&inode->i_lock);
>  	}
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 48556efcdcf0..45eadf5bea5d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2178,7 +2178,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>  #define I_DIO_WAKEUP		(1 << __I_DIO_WAKEUP)
>  #define I_LINKABLE		(1 << 10)
>  #define I_DIRTY_TIME		(1 << 11)
> -#define I_DIRTY_TIME_EXPIRED	(1 << 12)
>  #define I_WB_SWITCH		(1 << 13)
>  #define I_OVL_INUSE		(1 << 14)
>  #define I_CREATING		(1 << 15)
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 7565dcd59697..e7cbccc7c14c 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -20,7 +20,6 @@
>  		{I_CLEAR,		"I_CLEAR"},		\
>  		{I_SYNC,		"I_SYNC"},		\
>  		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
> -		{I_DIRTY_TIME_EXPIRED,	"I_DIRTY_TIME_EXPIRED"}, \
>  		{I_REFERENCED,		"I_REFERENCED"}		\
>  	)
>  
> -- 
> 2.16.4
> 
