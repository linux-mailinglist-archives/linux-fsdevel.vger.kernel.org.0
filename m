Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 248A69B148
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393401AbfHWNtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 09:49:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390369AbfHWNtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:49:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NDmPRC042938
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2019 09:49:41 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujfdvwa0v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2019 09:49:40 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 23 Aug 2019 14:49:39 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 23 Aug 2019 14:49:36 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7NDnZwT23331270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 13:49:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A12B34204D;
        Fri, 23 Aug 2019 13:49:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 682A142041;
        Fri, 23 Aug 2019 13:49:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Aug 2019 13:49:34 +0000 (GMT)
Subject: Re: [RFC 1/1] ext4: PoC implementation of option-1
To:     mbobrowski@mbobrowski.org
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, aneesh.kumar@linux.ibm.com
References: <20190822120015.GA3330@poseidon.bobrowski.net>
 <20190823134352.31243-1-riteshh@linux.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 23 Aug 2019 19:19:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190823134352.31243-1-riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082313-4275-0000-0000-0000035C9963
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082313-4276-0000-0000-0000386EC320
Message-Id: <20190823134934.682A142041@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=787 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FYI - This patch is built on top of Matthew's patch series just as a 
concept implementation for option-1 stated in previous email.


On 8/23/19 7:13 PM, Ritesh Harjani wrote:
> This is just a PoC implementation of the option-1 which I was
> mentioning in the previous email.
> As mentioned, it is adding some flags & private pointer
> to iomap infrastructure.
> 
> I would let upto you and others to comment on this approach.
> Please note that I have run only few basic tests.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>   fs/ext4/ext4.h        |  1 +
>   fs/ext4/file.c        | 37 ++++++++++++++++++++++++++++++++++---
>   fs/ext4/inode.c       | 31 +++++++++++++++++++++++++++++++
>   fs/iomap/direct-io.c  | 16 +++++++++++++++-
>   fs/xfs/xfs_file.c     |  3 ++-
>   include/linux/iomap.h |  5 ++++-
>   6 files changed, 87 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 2ab91815f52d..93aa716c691e 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1555,6 +1555,7 @@ enum {
>   	EXT4_STATE_NO_EXPAND,		/* No space for expansion */
>   	EXT4_STATE_DA_ALLOC_CLOSE,	/* Alloc DA blks on close */
>   	EXT4_STATE_EXT_MIGRATE,		/* Inode is migrating */
> +	EXT4_STATE_DIO_UNWRITTEN,	/* need convert on dio done*/
>   	EXT4_STATE_NEWENTRY,		/* File just added to dir */
>   	EXT4_STATE_MAY_INLINE_DATA,	/* may have in-inode data */
>   	EXT4_STATE_EXT_PRECACHED,	/* extents have been precached */
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 3736dbf28d0a..adfb56401312 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -314,8 +314,30 @@ static int ext4_handle_inode_extension(struct inode *inode, loff_t size,
>   	return ret;
>   }
>   
> +static int ext4_dio_write_end_io_convert(struct inode *inode, loff_t offset,
> +					 ssize_t size, void *private)
> +{
> +	int ret = 0;
> +	ext4_io_end_t *io_end = private;
> +
> +	if (!io_end) {
> +		WARN_ON(!ext4_test_inode_state(inode,
> +				EXT4_STATE_DIO_UNWRITTEN));
> +		ret = ext4_convert_unwritten_extents(NULL, inode, offset, size);
> +		if (ret)
> +			return ret;
> +		ext4_clear_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN);
> +	} else {
> +		io_end->offset = offset;
> +		io_end->size = size;
> +		ext4_put_io_end(io_end);
> +	}
> +	return ret;
> +}
> +
>   static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> -				 ssize_t error, unsigned int flags)
> +				 ssize_t error, unsigned int flags,
> +				 void *private)
>   {
>   	int ret = 0;
>   	handle_t *handle;
> @@ -345,12 +367,21 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
>   				ext4_orphan_del(handle, inode);
>   			ext4_journal_stop(handle);
>   		}
> +
> +		if (flags & IOMAP_DIO_UNWRITTEN) {
> +			ret = ext4_dio_write_end_io_convert(inode, offset,
> +					size, private);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
>   		return error;
>   	}
>   
>   	if (flags & IOMAP_DIO_UNWRITTEN) {
> -		ret = ext4_convert_unwritten_extents(NULL, inode, offset, size);
> -		if (ret)
> +		ret = ext4_dio_write_end_io_convert(inode, offset,
> +						    size, private);
> +		if (ret < 0)
>   			return ret;
>   	}
>   
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 15715d22808d..9d77ed2aa58c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3322,6 +3322,26 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>   	return inode->i_state & I_DIRTY_DATASYNC;
>   }
>   
> +static int ext4_iomap_init_io_end(struct inode *inode, struct iomap *iomap,
> +				  unsigned flags)
> +{
> +	ext4_io_end_t *io_end;
> +
> +	if (flags & IOMAP_DIRECT_AIO) {
> +		if (flags & IOMAP_PRIVATE)
> +			return 0;
> +		io_end = ext4_init_io_end(inode, GFP_KERNEL);
> +		if (!io_end)
> +			return -ENOMEM;
> +		iomap->private = io_end;
> +		ext4_set_io_unwritten_flag(inode, io_end);
> +	} else {
> +		iomap->private = NULL;
> +		ext4_set_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN);
> +	}
> +	return 0;
> +}
> +
>   static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			    unsigned flags, struct iomap *iomap)
>   {
> @@ -3433,6 +3453,17 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   				ret = ext4_map_blocks(handle, inode, &map,
>   						      EXT4_GET_BLOCKS_IO_CREATE_EXT);
>   			}
> +
> +			if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> +				int err;
> +
> +				err = ext4_iomap_init_io_end(inode, iomap,
> +							     flags);
> +				if (err < 0) {
> +					ext4_journal_stop(handle);
> +					return err;
> +				}
> +			}
>   		}
>   
>   		if (ret < 0) {
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 2ccf1c6460d4..7d88683a0d93 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -17,6 +17,7 @@
>    * Private flags for iomap_dio, must not overlap with the public ones in
>    * iomap.h:
>    */
> +#define IOMAP_DIO_PRIVATE	(1 << 27)
>   #define IOMAP_DIO_WRITE_FUA	(1 << 28)
>   #define IOMAP_DIO_NEED_SYNC	(1 << 29)
>   #define IOMAP_DIO_WRITE		(1 << 30)
> @@ -31,6 +32,7 @@ struct iomap_dio {
>   	unsigned		flags;
>   	int			error;
>   	bool			wait_for_completion;
> +	void			*private;	/* FS specific */
>   
>   	union {
>   		/* used during submission and for synchronous completion: */
> @@ -78,7 +80,8 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
>   	ssize_t ret;
>   
>   	if (dio->end_io)
> -		ret = dio->end_io(iocb, dio->size, dio->error, dio->flags);
> +		ret = dio->end_io(iocb, dio->size, dio->error, dio->flags,
> +				  dio->private);
>   	else
>   		ret = dio->error;
>   
> @@ -363,6 +366,11 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>   {
>   	struct iomap_dio *dio = data;
>   
> +	if (!(dio->flags & IOMAP_DIO_PRIVATE) && iomap->private) {
> +		dio->private = iomap->private;
> +		dio->flags |= IOMAP_DIO_PRIVATE;
> +	}
> +
>   	switch (iomap->type) {
>   	case IOMAP_HOLE:
>   		if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
> @@ -421,6 +429,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>   	dio->end_io = end_io;
>   	dio->error = 0;
>   	dio->flags = 0;
> +	dio->private = NULL;
>   
>   	dio->submit.iter = iter;
>   	dio->submit.waiter = current;
> @@ -458,6 +467,8 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>   		}
>   		flags |= IOMAP_NOWAIT;
>   	}
> +	if (!is_sync_kiocb(iocb) && (flags & IOMAP_WRITE))
> +		flags |= IOMAP_DIRECT_AIO;
>   
>   	ret = filemap_write_and_wait_range(mapping, start, end);
>   	if (ret)
> @@ -486,6 +497,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>   
>   	blk_start_plug(&plug);
>   	do {
> +		if (dio->flags & IOMAP_DIO_PRIVATE)
> +			flags |= IOMAP_PRIVATE;
> +
>   		ret = iomap_apply(inode, pos, count, flags, ops, dio,
>   				iomap_dio_actor);
>   		if (ret <= 0) {
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index f2bc3ac4a60e..205c4219986c 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -370,7 +370,8 @@ xfs_dio_write_end_io(
>   	struct kiocb		*iocb,
>   	ssize_t			size,
>   	ssize_t                 error,
> -	unsigned		flags)
> +	unsigned		flags,
> +	void			*private)
>   {
>   	struct inode		*inode = file_inode(iocb->ki_filp);
>   	struct xfs_inode	*ip = XFS_I(inode);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 900284e5c06c..57d3679442f9 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -102,6 +102,8 @@ struct iomap_page_ops {
>   #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
>   #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
>   #define IOMAP_NOWAIT		(1 << 5) /* do not block */
> +#define IOMAP_DIRECT_AIO	(1 << 6) /* AIO DIO */
> +#define IOMAP_PRIVATE		(1 << 7) /* FS specific */
>   
>   struct iomap_ops {
>   	/*
> @@ -189,7 +191,8 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
>   #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
>   #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
>   typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t size,
> -				 ssize_t error, unsigned int flags);
> +				 ssize_t error, unsigned int flags,
> +				 void *private);
>   ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>   		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
>   int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
> 

