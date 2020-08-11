Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD524218A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 23:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHKVBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 17:01:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35318 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHKVBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:01:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BKwpWp104446;
        Tue, 11 Aug 2020 21:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0aWr1JbTz9MANuTgghjLE8DdEGOn5azfbueXcuHgc1A=;
 b=uvCf001p4nYsW/asvNYGT36AT6kCbFkMvVcEfB/SAN8/k0/X/ExZNdjZLkdEYcuxoZ30
 WoYsM3qbSp07zAILWGiDtUiF7Lw5f/IgxA3A5Nl1Jevpo3KvreXLUytnIiSl0e1nQCPr
 PXHO8kCSAX4+hjWtfiE8p/lq8+qyNEQz2QjAVrsKCO/CSbl5+eDwVQd+ttuutxO54ex/
 nth6swzB7Zpl1Fe1T+lkOiSp7VAXi7k3lMKsMnU58PvEk/5JaiTIuhNquunJL7ju6No2
 iG4LSQgf+N8dAO7E42anShrYp2XlcUGqC/lnUk0ylgZuWzoqaC6HjouxnRYb++OiU9qe UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32t2ydnhnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Aug 2020 21:01:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BKxIJU171718;
        Tue, 11 Aug 2020 21:01:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 32t5y4yssv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 21:01:29 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07BL1T6b014208;
        Tue, 11 Aug 2020 21:01:29 GMT
Received: from localhost (/10.159.237.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Aug 2020 21:01:28 +0000
Date:   Tue, 11 Aug 2020 14:01:27 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: Add iomap_iter
Message-ID: <20200811210127.GG6107@magnolia>
References: <20200728173216.7184-1-willy@infradead.org>
 <20200728173216.7184-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728173216.7184-2-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9710 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=1 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008110149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9710 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=1 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110149
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 06:32:14PM +0100, Matthew Wilcox (Oracle) wrote:
> The iomap_iter provides a convenient way to package up and maintain
> all the arguments to the various mapping and operation functions.
> iomi_advance() moves the iterator forward to the next chunk of the file.
> This approach has only one callback to the filesystem -- the iomap_next_t
> instead of the separate iomap_begin / iomap_end calls.  This slightly
> complicates the filesystems, but is more efficient.  The next function

How much more efficient?  I've wondered since the start of
spectre/meltdown if in ten years we're still going to appreciate the
increase in code complexity that comes from trying to avoid indirect
function calls.  That said, we needed an iomap iterator long before
that, so I think I mostly like this.

> will be called even after an error has occurred to allow the filesystem
> the opportunity to clean up.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/apply.c      | 29 ++++++++++++++++++++++
>  include/linux/iomap.h | 57 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index 76925b40b5fd..c83dcd203558 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -92,3 +92,32 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  
>  	return written ? written : ret;
>  }
> +
> +bool iomi_advance(struct iomap_iter *iomi, int err)
> +{
> +	struct iomap *iomap = &iomi->iomap;
> +
> +	if (likely(!err)) {
> +		iomi->pos += iomi->copied;
> +		iomi->len -= iomi->copied;
> +		iomi->ret += iomi->copied;
> +		if (!iomi->len)
> +			return false;
> +		iomi->copied = 0;
> +		if (WARN_ON(iomap->offset > iomi->pos))
> +			err = -EIO;
> +		if (WARN_ON(iomap->offset + iomap->length <= iomi->pos))
> +			err = -EIO;
> +	}
> +
> +	if (unlikely(err < 0)) {
> +		if (iomi->copied < 0)
> +			return false;
> +		/* Give the body a chance to see the error and clean up */
> +		iomi->copied = err;
> +		if (!iomi->ret)
> +			iomi->ret = err;
> +	}
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(iomi_advance);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 4d1d3c3469e9..fe58e68ec0c1 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -142,6 +142,63 @@ struct iomap_ops {
>  			ssize_t written, unsigned flags, struct iomap *iomap);
>  };
>  
> +/**
> + * struct iomap_iter - Iterate through a range of a file.
> + * @inode: Set at the start of the iteration and should not change.
> + * @pos: The current file position we are operating on.  It is updated by
> + *	calls to iomap_iter().  Treat as read-only in the body.
> + * @len: The remaining length of the file segment we're operating on.
> + *	It is updated at the same time as @pos.
> + * @ret: What we want our declaring function to return.  It is initialised
> + *	to zero and is the cumulative number of bytes processed so far.
> + *	It is updated at the same time as @pos.
> + * @copied: The number of bytes operated on by the body in the most
> + *	recent iteration.  If no bytes were operated on, it may be set to
> + *	a negative errno.  0 is treated as -EIO.
> + * @flags: Zero or more of the iomap_begin flags above.
> + * @iomap: ...
> + * @srcma:s ...

...? :)

> + */
> +struct iomap_iter {
> +	struct inode *inode;
> +	loff_t pos;
> +	u64 len;

Thanks for leaving this u64 :)

> +	loff_t ret;
> +	ssize_t copied;

Is this going to be sufficient for SEEK_{HOLE,DATA} when it wants to
jump ahead by more than 2GB?

> +	unsigned flags;
> +	struct iomap iomap;
> +	struct iomap srcmap;
> +};
> +
> +#define IOMAP_ITER(name, _inode, _pos, _len, _flags)			\
> +	struct iomap_iter name = {					\
> +		.inode = _inode,					\
> +		.pos = _pos,						\
> +		.len = _len,						\
> +		.flags = _flags,					\
> +	}
> +
> +typedef int (*iomap_next_t)(const struct iomap_iter *,
> +		struct iomap *iomap, struct iomap *srcmap);

I muttered in my other reply how these probably should be called
iomap_iter_advance_t since they actually do the upper level work of
advancing the iterator to the next mapping.

--D

> +bool iomi_advance(struct iomap_iter *iomi, int err);
> +
> +static inline bool iomap_iter(struct iomap_iter *iomi, iomap_next_t next)
> +{
> +	if (iomi->ret && iomi->copied == 0)
> +		iomi->copied = -EIO;
> +
> +	return iomi_advance(iomi, next(iomi, &iomi->iomap, &iomi->srcmap));
> +}
> +
> +static inline u64 iomap_length(const struct iomap_iter *iomi)
> +{
> +	u64 end = iomi->iomap.offset + iomi->iomap.length;
> +
> +	if (iomi->srcmap.type != IOMAP_HOLE)
> +		end = min(end, iomi->srcmap.offset + iomi->srcmap.length);
> +	return min(iomi->len, end - iomi->pos);
> +}
> +
>  /*
>   * Main iomap iterator function.
>   */
> -- 
> 2.27.0
> 
