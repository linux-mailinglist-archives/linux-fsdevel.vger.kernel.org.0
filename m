Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78513EA24A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 18:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfJ3RIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 13:08:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56642 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfJ3RIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:08:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UH4nuM134508;
        Wed, 30 Oct 2019 17:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=w5NxvYKjEYCfNJ7W5YyboDZSWiIoO9e09L0+NpAonc0=;
 b=sgJTl1hjenETeET4AXrr9AmQNA+IJsCeqvcpeDiBCtQU1EbG1ZWS6gPr1xFT1o3fH+WD
 /4uuS5aE0mWNhO31VwE7TMnnARd7nos8TRpPf3mLLq18mIKqBjCjUEkTaEdHwDbSEls6
 0QXvhDt1ttEhtDzbQLH6ZN93JRbLZftAtxncBfTNPfZZVWuq4qOjkP1C8tiRBAF2MYVU
 GKxQQ1mghP2DlEaopc6ZHeDvvG6oQxLQN4Uk/s8iEc9VK9IPwsMEp6d+ZPYqoGRxaSCb
 emmvmwVymtWhceLigrk7NnkDWdiVtlbSEYdKLMWEo+bL1x/YkuVMUQsQSM4Znced6iex ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vxwhfnqx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 17:08:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UGrYOw116014;
        Wed, 30 Oct 2019 17:08:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vxwjab2ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 17:08:37 +0000
Received: from abhmp0021.oracle.com (abhmp0021.oracle.com [141.146.116.27])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9UH8ZYJ013475;
        Wed, 30 Oct 2019 17:08:35 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 10:08:34 -0700
Date:   Wed, 30 Oct 2019 10:08:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/26] xfs: Lower CIL flush limit for large logs
Message-ID: <20191030170833.GL15222@magnolia>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-2-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-2-david@fromorbit.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300151
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:20:59PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The current CIL size aggregation limit is 1/8th the log size. This
> means for large logs we might be aggregating at least 250MB of dirty objects
> in memory before the CIL is flushed to the journal. With CIL shadow
> buffers sitting around, this means the CIL is often consuming >500MB
> of temporary memory that is all allocated under GFP_NOFS conditions.
> 
> Flushing the CIL can take some time to do if there is other IO
> ongoing, and can introduce substantial log force latency by itself.
> It also pins the memory until the objects are in the AIL and can be
> written back and reclaimed by shrinkers. Hence this threshold also
> tends to determine the minimum amount of memory XFS can operate in
> under heavy modification without triggering the OOM killer.
> 
> Modify the CIL space limit to prevent such huge amounts of pinned
> metadata from aggregating. We can have 2MB of log IO in flight at
> once, so limit aggregation to 16x this size. This threshold was
> chosen as it little impact on performance (on 16-way fsmark) or log
> traffic but pins a lot less memory on large logs especially under
> heavy memory pressure.  An aggregation limit of 8x had 5-10%
> performance degradation and a 50% increase in log throughput for
> the same workload, so clearly that was too small for highly
> concurrent workloads on large logs.
> 
> This was found via trace analysis of AIL behaviour. e.g. insertion
> from a single CIL flush:
> 
> xfs_ail_insert: old lsn 0/0 new lsn 1/3033090 type XFS_LI_INODE flags IN_AIL
> 
> $ grep xfs_ail_insert /mnt/scratch/s.t |grep "new lsn 1/3033090" |wc -l
> 1721823
> $
> 
> So there were 1.7 million objects inserted into the AIL from this
> CIL checkpoint, the first at 2323.392108, the last at 2325.667566 which
> was the end of the trace (i.e. it hadn't finished). Clearly a major
> problem.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_log_priv.h | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
> index b880c23cb6e4..a3cc8a9a16d9 100644
> --- a/fs/xfs/xfs_log_priv.h
> +++ b/fs/xfs/xfs_log_priv.h
> @@ -323,13 +323,30 @@ struct xfs_cil {
>   * tries to keep 25% of the log free, so we need to keep below that limit or we
>   * risk running out of free log space to start any new transactions.
>   *
> - * In order to keep background CIL push efficient, we will set a lower
> - * threshold at which background pushing is attempted without blocking current
> - * transaction commits.  A separate, higher bound defines when CIL pushes are
> - * enforced to ensure we stay within our maximum checkpoint size bounds.
> - * threshold, yet give us plenty of space for aggregation on large logs.
> + * In order to keep background CIL push efficient, we only need to ensure the
> + * CIL is large enough to maintain sufficient in-memory relogging to avoid
> + * repeated physical writes of frequently modified metadata. If we allow the CIL
> + * to grow to a substantial fraction of the log, then we may be pinning hundreds
> + * of megabytes of metadata in memory until the CIL flushes. This can cause
> + * issues when we are running low on memory - pinned memory cannot be reclaimed,
> + * and the CIL consumes a lot of memory. Hence we need to set an upper physical
> + * size limit for the CIL that limits the maximum amount of memory pinned by the
> + * CIL but does not limit performance by reducing relogging efficiency
> + * significantly.
> + *
> + * As such, the CIL push threshold ends up being the smaller of two thresholds:
> + * - a threshold large enough that it allows CIL to be pushed and progress to be
> + *   made without excessive blocking of incoming transaction commits. This is
> + *   defined to be 12.5% of the log space - half the 25% push threshold of the
> + *   AIL.
> + * - small enough that it doesn't pin excessive amounts of memory but maintains
> + *   close to peak relogging efficiency. This is defined to be 16x the iclog
> + *   buffer window (32MB) as measurements have shown this to be roughly the
> + *   point of diminishing performance increases under highly concurrent
> + *   modification workloads.
>   */
> -#define XLOG_CIL_SPACE_LIMIT(log)	(log->l_logsize >> 3)
> +#define XLOG_CIL_SPACE_LIMIT(log)	\
> +	min_t(int, (log)->l_logsize >> 3, BBTOB(XLOG_TOTAL_REC_SHIFT(log)) << 4)
>  
>  /*
>   * ticket grant locks, queues and accounting have their own cachlines
> -- 
> 2.23.0.rc1
> 
