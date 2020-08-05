Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDE723CD1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 19:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgHERUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 13:20:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56120 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbgHERS6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:18:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075HI7rO061275;
        Wed, 5 Aug 2020 17:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JiAw/fKRsU9hjr0ncYl8BuGaFflH5ZiU4ThvmIWiAqg=;
 b=daRnkiwleWy5SiPk6pxKvSkZsxbkFeeNX3BPXsoST6YpSmGtJ6fcG+cyBML4ki6CPunQ
 Oc79EF8n4qKQN4/baSwr/xnjv+1SxiqyDatKRZS+AZgICPwwCllB8HyIIvGO6uwm9lt6
 ntH7Xz6byp0+xSLAM9jNTf9MPhgWicdpgJx+kdZQS7RiN82Ps6GL9bu+7DtR/Nmiifpl
 RmZTlOBIXNyd4EHiAy0wSVmGarY+uYe6RbvnG20xoQQfkVpUkSWyue7j6/Q/4br7sHbv
 o7XR8VV8mRehSkU+EAAojYsqQlG+DCpGbh+8WDAroOXKdNsg9oNgLI2WorzA2BmY8N6T wQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32qnd43n2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 17:18:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075H9Duo063861;
        Wed, 5 Aug 2020 17:18:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32p5gu3k5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 17:18:53 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 075HIq07030496;
        Wed, 5 Aug 2020 17:18:52 GMT
Received: from localhost (/10.159.157.126)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 10:18:52 -0700
Date:   Wed, 5 Aug 2020 10:18:50 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: delete duplicated words + other fixes
Message-ID: <20200805171850.GB6096@magnolia>
References: <20200805024945.12381-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805024945.12381-1-rdunlap@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=5 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 clxscore=1015 mlxscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050138
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 04, 2020 at 07:49:45PM -0700, Randy Dunlap wrote:
> Delete repeated words in fs/xfs/.
> {we, that, the, a, to, fork}
> Change "it it" to "it is" in one location.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> To: linux-fsdevel@vger.kernel.org
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/libxfs/xfs_sb.c        |    2 +-
>  fs/xfs/xfs_attr_list.c        |    2 +-
>  fs/xfs/xfs_buf_item.c         |    2 +-
>  fs/xfs/xfs_buf_item_recover.c |    2 +-
>  fs/xfs/xfs_dquot.c            |    2 +-
>  fs/xfs/xfs_export.c           |    2 +-
>  fs/xfs/xfs_inode.c            |    4 ++--
>  fs/xfs/xfs_inode_item.c       |    4 ++--
>  fs/xfs/xfs_iomap.c            |    2 +-
>  fs/xfs/xfs_log_cil.c          |    2 +-
>  fs/xfs/xfs_log_recover.c      |    2 +-
>  fs/xfs/xfs_refcount_item.c    |    2 +-
>  fs/xfs/xfs_reflink.c          |    2 +-
>  fs/xfs/xfs_trans_ail.c        |    4 ++--
>  14 files changed, 17 insertions(+), 17 deletions(-)
> 
> --- linux-next-20200804.orig/fs/xfs/xfs_attr_list.c
> +++ linux-next-20200804/fs/xfs/xfs_attr_list.c
> @@ -44,7 +44,7 @@ xfs_attr_shortform_compare(const void *a
>  /*
>   * Copy out entries of shortform attribute lists for attr_list().
>   * Shortform attribute lists are not stored in hashval sorted order.
> - * If the output buffer is not large enough to hold them all, then we
> + * If the output buffer is not large enough to hold them all, then
>   * we have to calculate each entries' hashvalue and sort them before
>   * we can begin returning them to the user.
>   */
> --- linux-next-20200804.orig/fs/xfs/xfs_buf_item.c
> +++ linux-next-20200804/fs/xfs/xfs_buf_item.c
> @@ -127,7 +127,7 @@ xfs_buf_item_size_segment(
>   * stretch of non-contiguous chunks to be logged.  Contiguous chunks are logged
>   * in a single iovec.
>   *
> - * Discontiguous buffers need a format structure per region that that is being
> + * Discontiguous buffers need a format structure per region that is being
>   * logged. This makes the changes in the buffer appear to log recovery as though
>   * they came from separate buffers, just like would occur if multiple buffers
>   * were used instead of a single discontiguous buffer. This enables
> --- linux-next-20200804.orig/fs/xfs/xfs_buf_item_recover.c
> +++ linux-next-20200804/fs/xfs/xfs_buf_item_recover.c
> @@ -948,7 +948,7 @@ xlog_recover_buf_commit_pass2(
>  	 * or inode_cluster_size bytes, whichever is bigger.  The inode
>  	 * buffers in the log can be a different size if the log was generated
>  	 * by an older kernel using unclustered inode buffers or a newer kernel
> -	 * running with a different inode cluster size.  Regardless, if the
> +	 * running with a different inode cluster size.  Regardless, if
>  	 * the inode buffer size isn't max(blocksize, inode_cluster_size)
>  	 * for *our* value of inode_cluster_size, then we need to keep
>  	 * the buffer out of the buffer cache so that the buffer won't
> --- linux-next-20200804.orig/fs/xfs/xfs_dquot.c
> +++ linux-next-20200804/fs/xfs/xfs_dquot.c
> @@ -807,7 +807,7 @@ xfs_qm_dqget_checks(
>  }
>  
>  /*
> - * Given the file system, id, and type (UDQUOT/GDQUOT), return a a locked
> + * Given the file system, id, and type (UDQUOT/GDQUOT), return a locked
>   * dquot, doing an allocation (if requested) as needed.
>   */
>  int
> --- linux-next-20200804.orig/fs/xfs/xfs_export.c
> +++ linux-next-20200804/fs/xfs/xfs_export.c
> @@ -56,7 +56,7 @@ xfs_fs_encode_fh(
>  		fileid_type = FILEID_INO32_GEN_PARENT;
>  
>  	/*
> -	 * If the the filesystem may contain 64bit inode numbers, we need
> +	 * If the filesystem may contain 64bit inode numbers, we need
>  	 * to use larger file handles that can represent them.
>  	 *
>  	 * While we only allocate inodes that do not fit into 32 bits any
> --- linux-next-20200804.orig/fs/xfs/xfs_inode.c
> +++ linux-next-20200804/fs/xfs/xfs_inode.c
> @@ -451,7 +451,7 @@ xfs_lock_inodes(
>  	/*
>  	 * Currently supports between 2 and 5 inodes with exclusive locking.  We
>  	 * support an arbitrary depth of locking here, but absolute limits on
> -	 * inodes depend on the the type of locking and the limits placed by
> +	 * inodes depend on the type of locking and the limits placed by
>  	 * lockdep annotations in xfs_lock_inumorder.  These are all checked by
>  	 * the asserts.
>  	 */
> @@ -3105,7 +3105,7 @@ out_trans_abort:
>  /*
>   * xfs_rename_alloc_whiteout()
>   *
> - * Return a referenced, unlinked, unlocked inode that that can be used as a
> + * Return a referenced, unlinked, unlocked inode that can be used as a
>   * whiteout in a rename transaction. We use a tmpfile inode here so that if we
>   * crash between allocating the inode and linking it into the rename transaction
>   * recovery will free the inode and we won't leak it.
> --- linux-next-20200804.orig/fs/xfs/xfs_inode_item.c
> +++ linux-next-20200804/fs/xfs/xfs_inode_item.c
> @@ -191,7 +191,7 @@ xfs_inode_item_format_data_fork(
>  		    ip->i_df.if_bytes > 0) {
>  			/*
>  			 * Round i_bytes up to a word boundary.
> -			 * The underlying memory is guaranteed to
> +			 * The underlying memory is guaranteed
>  			 * to be there by xfs_idata_realloc().
>  			 */
>  			data_bytes = roundup(ip->i_df.if_bytes, 4);
> @@ -275,7 +275,7 @@ xfs_inode_item_format_attr_fork(
>  		    ip->i_afp->if_bytes > 0) {
>  			/*
>  			 * Round i_bytes up to a word boundary.
> -			 * The underlying memory is guaranteed to
> +			 * The underlying memory is guaranteed
>  			 * to be there by xfs_idata_realloc().
>  			 */
>  			data_bytes = roundup(ip->i_afp->if_bytes, 4);
> --- linux-next-20200804.orig/fs/xfs/xfs_iomap.c
> +++ linux-next-20200804/fs/xfs/xfs_iomap.c
> @@ -865,7 +865,7 @@ xfs_buffered_write_iomap_begin(
>  	}
>  
>  	/*
> -	 * Search the data fork fork first to look up our source mapping.  We
> +	 * Search the data fork first to look up our source mapping.  We
>  	 * always need the data fork map, as we have to return it to the
>  	 * iomap code so that the higher level write code can read data in to
>  	 * perform read-modify-write cycles for unaligned writes.
> --- linux-next-20200804.orig/fs/xfs/xfs_log_cil.c
> +++ linux-next-20200804/fs/xfs/xfs_log_cil.c
> @@ -239,7 +239,7 @@ xfs_cil_prepare_item(
>  	 * this CIL context and so we need to pin it. If we are replacing the
>  	 * old_lv, then remove the space it accounts for and make it the shadow
>  	 * buffer for later freeing. In both cases we are now switching to the
> -	 * shadow buffer, so update the the pointer to it appropriately.
> +	 * shadow buffer, so update the pointer to it appropriately.
>  	 */
>  	if (!old_lv) {
>  		if (lv->lv_item->li_ops->iop_pin)
> --- linux-next-20200804.orig/fs/xfs/xfs_log_recover.c
> +++ linux-next-20200804/fs/xfs/xfs_log_recover.c
> @@ -1100,7 +1100,7 @@ xlog_verify_head(
>  		 *
>  		 * Note that xlog_find_tail() clears the blocks at the new head
>  		 * (i.e., the records with invalid CRC) if the cycle number
> -		 * matches the the current cycle.
> +		 * matches the current cycle.
>  		 */
>  		found = xlog_rseek_logrec_hdr(log, first_bad, *tail_blk, 1,
>  				buffer, rhead_blk, rhead, wrapped);
> --- linux-next-20200804.orig/fs/xfs/xfs_refcount_item.c
> +++ linux-next-20200804/fs/xfs/xfs_refcount_item.c
> @@ -485,7 +485,7 @@ xfs_cui_item_recover(
>  	 * transaction.  Normally, any work that needs to be deferred
>  	 * gets attached to the same defer_ops that scheduled the
>  	 * refcount update.  However, we're in log recovery here, so we
> -	 * we use the passed in defer_ops and to finish up any work that
> +	 * use the passed in defer_ops and to finish up any work that
>  	 * doesn't fit.  We need to reserve enough blocks to handle a
>  	 * full btree split on either end of the refcount range.
>  	 */
> --- linux-next-20200804.orig/fs/xfs/xfs_reflink.c
> +++ linux-next-20200804/fs/xfs/xfs_reflink.c
> @@ -721,7 +721,7 @@ xfs_reflink_end_cow(
>  	 * repeatedly cycles the ILOCK to allocate one transaction per remapped
>  	 * extent.
>  	 *
> -	 * If we're being called by writeback then the the pages will still
> +	 * If we're being called by writeback then the pages will still
>  	 * have PageWriteback set, which prevents races with reflink remapping
>  	 * and truncate.  Reflink remapping prevents races with writeback by
>  	 * taking the iolock and mmaplock before flushing the pages and
> --- linux-next-20200804.orig/fs/xfs/xfs_trans_ail.c
> +++ linux-next-20200804/fs/xfs/xfs_trans_ail.c
> @@ -480,7 +480,7 @@ xfsaild_push(
>  			 * inode buffer is locked because we already pushed the
>  			 * updates to it as part of inode clustering.
>  			 *
> -			 * We do not want to to stop flushing just because lots
> +			 * We do not want to stop flushing just because lots
>  			 * of items are already being flushed, but we need to
>  			 * re-try the flushing relatively soon if most of the
>  			 * AIL is being flushed.
> @@ -515,7 +515,7 @@ xfsaild_push(
>  		/*
>  		 * Are there too many items we can't do anything with?
>  		 *
> -		 * If we we are skipping too many items because we can't flush
> +		 * If we are skipping too many items because we can't flush
>  		 * them or they are already being flushed, we back off and
>  		 * given them time to complete whatever operation is being
>  		 * done. i.e. remove pressure from the AIL while we can't make
> --- linux-next-20200804.orig/fs/xfs/libxfs/xfs_sb.c
> +++ linux-next-20200804/fs/xfs/libxfs/xfs_sb.c
> @@ -600,7 +600,7 @@ xfs_sb_quota_to_disk(
>  	 * disk. If neither are active, we should NULL the inode.
>  	 *
>  	 * In all cases, the separate pquotino must remain 0 because it
> -	 * it beyond the "end" of the valid non-pquotino superblock.
> +	 * is beyond the "end" of the valid non-pquotino superblock.
>  	 */
>  	if (from->sb_qflags & XFS_GQUOTA_ACCT)
>  		to->sb_gquotino = cpu_to_be64(from->sb_gquotino);
