Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F475412E85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 08:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhIUGMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 02:12:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31664 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhIUGMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:12:31 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18L59PNU023247;
        Tue, 21 Sep 2021 02:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=9TxeeBAI+lO+bjNrxKdv4E37yA0ac3EDTTsg2HJLnTo=;
 b=EgEUYQCNBU7LNQCPZn0hxbTxJyjGeTH88TMVpWyfiEKMFK4nBLR039aQEGmUx8GzUjdL
 YfUVPUXB27NadFf5mzmR1Japij0q2KUw8C9InFuLLS8tES/q8x9jcPkkRDyuIoKX5KoP
 RdKeclvYHBeN2ogN9dBketJAU5Y7OD+a849EmwYaWkMFRacKvSEy2QmknB9Wxanknbxk
 Z6nImsbSNeeJt1T6Bgix8CCoxQKgioHUiQSgOP45Qv8Kb7Pamg8q6M47B7CDwCSjGetk
 OhDo406s+pui5HbZzbVjdnYcf8ZygdH+BDF7Kj5lthTd1HcytCJFRZWo9yHtHXqqpskf DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b75ud48tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 02:10:55 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18L5Ad5d030707;
        Tue, 21 Sep 2021 02:10:55 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b75ud48sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 02:10:54 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18L63Cv4018832;
        Tue, 21 Sep 2021 06:10:53 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3b57r9763j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 06:10:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18L6AohU30998824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 06:10:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BEFD52059;
        Tue, 21 Sep 2021 06:10:50 +0000 (GMT)
Received: from localhost (unknown [9.43.105.212])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DA9F152050;
        Tue, 21 Sep 2021 06:10:49 +0000 (GMT)
Date:   Tue, 21 Sep 2021 11:40:48 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 5/5] ext4: implement FALLOC_FL_ZEROINIT_RANGE
Message-ID: <20210921061048.bv7ut3x3sugfrt5t@riteshh-domain>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192867220.417973.4913917281472586603.stgit@magnolia>
 <20210918170757.j5yjxo34thzks5iv@riteshh-domain>
 <20210920181159.GA570565@magnolia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920181159.GA570565@magnolia>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KLAs31-pUXC2yNkVx4L-jD_Ensa_rAM2
X-Proofpoint-ORIG-GUID: OD1PclyN1GMLC71jyR-ft5eG8-loDYPg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_01,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210039
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/09/20 11:11AM, Darrick J. Wong wrote:
> On Sat, Sep 18, 2021 at 10:37:57PM +0530, riteshh wrote:
> > +cc linux-ext4
> >
> > [Thread]: https://lore.kernel.org/linux-xfs/163192864476.417973.143014658064006895.stgit@magnolia/T/#t
> >
> > On 21/09/17 06:31PM, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Implement this new fallocate mode so that persistent memory users can,
> > > upon receipt of a pmem poison notification, cause the pmem to be
> > > reinitialized to a known value (zero) and clear any hardware poison
> > > state that might be lurking.
> > >
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  fs/ext4/extents.c           |   93 +++++++++++++++++++++++++++++++++++++++++++
> > >  include/trace/events/ext4.h |    7 +++
> > >  2 files changed, 99 insertions(+), 1 deletion(-)
> > >
> > >
> > > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > > index c0de30f25185..c345002e2da6 100644
> > > --- a/fs/ext4/extents.c
> > > +++ b/fs/ext4/extents.c
> > > @@ -29,6 +29,7 @@
> > >  #include <linux/fiemap.h>
> > >  #include <linux/backing-dev.h>
> > >  #include <linux/iomap.h>
> > > +#include <linux/dax.h>
> > >  #include "ext4_jbd2.h"
> > >  #include "ext4_extents.h"
> > >  #include "xattr.h"
> > > @@ -4475,6 +4476,90 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len);
> > >
> > >  static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len);
> > >
> > > +static long ext4_zeroinit_range(struct file *file, loff_t offset, loff_t len)
> > > +{
> > > +	struct inode *inode = file_inode(file);
> > > +	struct address_space *mapping = inode->i_mapping;
> > > +	handle_t *handle = NULL;
> > > +	loff_t end = offset + len;
> > > +	long ret;
> > > +
> > > +	trace_ext4_zeroinit_range(inode, offset, len,
> > > +			FALLOC_FL_ZEROINIT_RANGE | FALLOC_FL_KEEP_SIZE);
> > > +
> > > +	/* We don't support data=journal mode */
> > > +	if (ext4_should_journal_data(inode))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	inode_lock(inode);
> > > +
> > > +	/*
> > > +	 * Indirect files do not support unwritten extents
> > > +	 */
> > > +	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
> > > +		ret = -EOPNOTSUPP;
> > > +		goto out_mutex;
> > > +	}
> > > +
> > > +	/* Wait all existing dio workers, newcomers will block on i_mutex */
> > > +	inode_dio_wait(inode);
> > > +
> > > +	/*
> > > +	 * Prevent page faults from reinstantiating pages we have released from
> > > +	 * page cache.
> > > +	 */
> > > +	filemap_invalidate_lock(mapping);
> > > +
> > > +	ret = ext4_break_layouts(inode);
> > > +	if (ret)
> > > +		goto out_mmap;
> > > +
> > > +	/* Now release the pages and zero block aligned part of pages */
> > > +	truncate_pagecache_range(inode, offset, end - 1);
> > > +	inode->i_mtime = inode->i_ctime = current_time(inode);
> > > +
> > > +	if (IS_DAX(inode))
> > > +		ret = dax_zeroinit_range(inode, offset, len,
> > > +				&ext4_iomap_report_ops);
> > > +	else
> > > +		ret = iomap_zeroout_range(inode, offset, len,
> > > +				&ext4_iomap_report_ops);
> > > +	if (ret == -ECANCELED)
> > > +		ret = -EOPNOTSUPP;
> > > +	if (ret)
> > > +		goto out_mmap;
> > > +
> > > +	/*
> > > +	 * In worst case we have to writeout two nonadjacent unwritten
> > > +	 * blocks and update the inode
> > > +	 */
> >
> > Is this comment true? We are actually not touching IOMAP_UNWRITTEN blocks no?
> > So is there any need for journal transaction for this?
> > We are essentially only writing to blocks which are already allocated on disk
> > and zeroing it out in both dax_zeroinit_range() and iomap_zeroinit_range().
>
> Oops.  Yeah, the comment is wrong.  Deleted.
>
> > > +	handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);
> >
> > I guess credits is 1 here since only inode is getting modified.
>
> Yep.
>
> >
> > > +	if (IS_ERR(handle)) {
> > > +		ret = PTR_ERR(handle);
> > > +		ext4_std_error(inode->i_sb, ret);
> > > +		goto out_mmap;
> > > +	}
> > > +
> > > +	inode->i_mtime = inode->i_ctime = current_time(inode);
> > > +	ret = ext4_mark_inode_dirty(handle, inode);
> > > +	if (unlikely(ret))
> > > +		goto out_handle;
> > > +	ext4_fc_track_range(handle, inode, offset >> inode->i_sb->s_blocksize_bits,
> > > +			(offset + len - 1) >> inode->i_sb->s_blocksize_bits);
> >
> > I am not sure whether we need ext4_fc_track_range() here?
> > We are not doing any metadata operation except maybe updating inode timestamp
> > right?
>
> I wasn't sure what fastcommit needs to track about the range.  Is it
> /only/ tracking changes to the file mapping?

cc'ing Harshad as well (to correct if any of below is incorrect/incomplete).

I guess so yes, from reading this [1].
ext4_fc_track_range() - Track _changed_ logical block offsets inodes

For only inode update, I guess fastcommit uses ext4_fc_track_inode(), which is
implicit when we call ext4_mark_inode_dirty().

[1]: https://lore.kernel.org/all/20201015203802.3597742-6-harshadshirwadkar@gmail.com/

>
> /me is sadly falling further and further behind on where ext4 is these
> days... :/
>
> >
> > > +	ext4_update_inode_fsync_trans(handle, inode, 1);

Then do we even need above?

-ritesh


> > > +
> > > +	if (file->f_flags & O_SYNC)
> > > +		ext4_handle_sync(handle);
> > > +
> > > +out_handle:
> > > +	ext4_journal_stop(handle);
> > > +out_mmap:
> > > +	filemap_invalidate_unlock(mapping);
> > > +out_mutex:
> > > +	inode_unlock(inode);
> > > +	return ret;
> > > +}
> > > +
> > >  static long ext4_zero_range(struct file *file, loff_t offset,
> > >  			    loff_t len, int mode)
> > >  {
> > > @@ -4659,7 +4744,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> > >  	/* Return error if mode is not supported */
> > >  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
> > >  		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
> > > -		     FALLOC_FL_INSERT_RANGE))
> > > +		     FALLOC_FL_INSERT_RANGE | FALLOC_FL_ZEROINIT_RANGE))
> > >  		return -EOPNOTSUPP;
> > >
> > >  	ext4_fc_start_update(inode);
> > > @@ -4687,6 +4772,12 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> > >  		ret = ext4_zero_range(file, offset, len, mode);
> > >  		goto exit;
> > >  	}
> > > +
> > > +	if (mode & FALLOC_FL_ZEROINIT_RANGE) {
> > > +		ret = ext4_zeroinit_range(file, offset, len);
> > > +		goto exit;
> > > +	}
> > > +
> > >  	trace_ext4_fallocate_enter(inode, offset, len, mode);
> > >  	lblk = offset >> blkbits;
> > >
> > > diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> > > index 0ea36b2b0662..282f1208067f 100644
> > > --- a/include/trace/events/ext4.h
> > > +++ b/include/trace/events/ext4.h
> > > @@ -1407,6 +1407,13 @@ DEFINE_EVENT(ext4__fallocate_mode, ext4_zero_range,
> > >  	TP_ARGS(inode, offset, len, mode)
> > >  );
> > >
> > > +DEFINE_EVENT(ext4__fallocate_mode, ext4_zeroinit_range,
> > > +
> > > +	TP_PROTO(struct inode *inode, loff_t offset, loff_t len, int mode),
> > > +
> > > +	TP_ARGS(inode, offset, len, mode)
> > > +);
> > > +
> > >  TRACE_EVENT(ext4_fallocate_exit,
> > >  	TP_PROTO(struct inode *inode, loff_t offset,
> > >  		 unsigned int max_blocks, int ret),
> > >
