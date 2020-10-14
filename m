Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A013C28DC70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgJNJJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgJNJJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:09:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA23C04585D
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 22:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=0RdLnWdqLniXru95MsyVjh9zwMbeEReIgSPPac9ZFJM=; b=lWrIQk8P4mN5/kRF2M4whnSigo
        CLDH5QWbITTOzbEdVFh8wXS4hd4dJMQicu6DkH3Rs/lutIFKxC5/nZYceoCz/htv40QOR4qzYWCBR
        HOLGY2hLCgCBgjs3idGyCXOCUQ++39T7bQoVzKzryuC9ESgUKXFmSCX3zOjnQXkWEhM6eDDRPsy4n
        RWmlHTnwNqetZOJrV/Slg0nGVI3JXcK4oQWMsS0b/othPYFqnX46ZEtjHppgGfUUdz07GAPq+XGz4
        h0UQxMvYraoSJO4WJlFUNXlDqPh72IRuE5VpdwGkzWac8D6+EBYiOjkeNMRuD1A4Sq+6i2lis3f15
        RyA0xcfA==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSZMX-0008WR-Pr; Wed, 14 Oct 2020 05:30:10 +0000
Subject: Re: [PATCH] jfs: delete duplicated words + other fixes
To:     linux-fsdevel@vger.kernel.org
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
References: <20200805024901.12181-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8a632de9-d4ef-3f90-036a-7f9cc35eb8a9@infradead.org>
Date:   Tue, 13 Oct 2020 22:30:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200805024901.12181-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping.

On 8/4/20 7:49 PM, Randy Dunlap wrote:
> Delete repeated words in fs/jfs/.
> {for, allocation, if, the}
> Insert "is" in one place to correct the grammar.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> To: linux-fsdevel@vger.kernel.org
> Cc: Dave Kleikamp <shaggy@kernel.org>
> Cc: jfs-discussion@lists.sourceforge.net
> ---
>  fs/jfs/jfs_dmap.c   |    2 +-
>  fs/jfs/jfs_extent.c |    2 +-
>  fs/jfs/jfs_extent.h |    2 +-
>  fs/jfs/jfs_logmgr.h |    2 +-
>  fs/jfs/jfs_txnmgr.c |    2 +-
>  fs/jfs/jfs_xtree.c  |    2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> --- linux-next-20200804.orig/fs/jfs/jfs_dmap.c
> +++ linux-next-20200804/fs/jfs/jfs_dmap.c
> @@ -668,7 +668,7 @@ unlock:
>   *		this does not succeed, we finally try to allocate anywhere
>   *		within the aggregate.
>   *
> - *		we also try to allocate anywhere within the aggregate for
> + *		we also try to allocate anywhere within the aggregate
>   *		for allocation requests larger than the allocation group
>   *		size or requests that specify no hint value.
>   *
> --- linux-next-20200804.orig/fs/jfs/jfs_extent.c
> +++ linux-next-20200804/fs/jfs/jfs_extent.c
> @@ -575,7 +575,7 @@ extBalloc(struct inode *ip, s64 hint, s6
>   *	blkno	 - starting block number of the extents current allocation.
>   *	nblks	 - number of blocks within the extents current allocation.
>   *	newnblks - pointer to a s64 value.  on entry, this value is the
> - *		   the new desired extent size (number of blocks).  on
> + *		   new desired extent size (number of blocks).  on
>   *		   successful exit, this value is set to the extent's actual
>   *		   new size (new number of blocks).
>   *	newblkno - the starting block number of the extents new allocation.
> --- linux-next-20200804.orig/fs/jfs/jfs_extent.h
> +++ linux-next-20200804/fs/jfs/jfs_extent.h
> @@ -5,7 +5,7 @@
>  #ifndef	_H_JFS_EXTENT
>  #define _H_JFS_EXTENT
>  
> -/*  get block allocation allocation hint as location of disk inode */
> +/*  get block allocation hint as location of disk inode */
>  #define	INOHINT(ip)	\
>  	(addressPXD(&(JFS_IP(ip)->ixpxd)) + lengthPXD(&(JFS_IP(ip)->ixpxd)) - 1)
>  
> --- linux-next-20200804.orig/fs/jfs/jfs_logmgr.h
> +++ linux-next-20200804/fs/jfs/jfs_logmgr.h
> @@ -132,7 +132,7 @@ struct logpage {
>   * (this comment should be rewritten !)
>   * jfs uses only "after" log records (only a single writer is allowed
>   * in a page, pages are written to temporary paging space if
> - * if they must be written to disk before commit, and i/o is
> + * they must be written to disk before commit, and i/o is
>   * scheduled for modified pages to their home location after
>   * the log records containing the after values and the commit
>   * record is written to the log on disk, undo discards the copy
> --- linux-next-20200804.orig/fs/jfs/jfs_txnmgr.c
> +++ linux-next-20200804/fs/jfs/jfs_txnmgr.c
> @@ -1474,7 +1474,7 @@ static int diLog(struct jfs_log * log, s
>  		 * For the LOG_NOREDOINOEXT record, we need
>  		 * to pass the IAG number and inode extent
>  		 * index (within that IAG) from which the
> -		 * the extent being released.  These have been
> +		 * extent is being released.  These have been
>  		 * passed to us in the iplist[1] and iplist[2].
>  		 */
>  		lrd->log.noredoinoext.iagnum =
> --- linux-next-20200804.orig/fs/jfs/jfs_xtree.c
> +++ linux-next-20200804/fs/jfs/jfs_xtree.c
> @@ -3684,7 +3684,7 @@ s64 xtTruncate(tid_t tid, struct inode *
>   *
>   * function:
>   *	Perform truncate to zero length for deleted file, leaving the
> - *	the xtree and working map untouched.  This allows the file to
> + *	xtree and working map untouched.  This allows the file to
>   *	be accessed via open file handles, while the delete of the file
>   *	is committed to disk.
>   *
> 


-- 
~Randy

