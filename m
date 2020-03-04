Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7825179406
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 16:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgCDPtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 10:49:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47368 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgCDPtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:49:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024Fm4Ia130486;
        Wed, 4 Mar 2020 15:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/ZcHpQN1+1pZpVy4wwwRZns65+S1+9FUcze507wKngg=;
 b=aiY01TbOsAyWVS3jZhXiIDqj4pCs8+0CtQouA9U1bG0y9jc7RzExEgCPTyOWaSabhp4z
 jxCTncWWVe+Mh/OjcND55AbzhAjoqlPmuwkKiA3YgrLo3gXnoy900Lp4uSLhwjXPgoio
 6SSkNo0T9ikj05gyMbWuNojqKrwII3XkOld/btWIjWMscyGTLi6wPY2k3eGe/5nBozkW
 1pfv4WbtcFjPd7UHKA7TcHCMex+cPvdHqKULYs4VtRGWBlSiTm0tnA5BZPHiShu6d5XK
 x32BRiRZnjFeoIrzglu0o6Ra/XZ7Id+NUi+ES+UGD5IsX4hP7Sql9mqnVUxzSuSZ6MLh kQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yffwqy469-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 15:49:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024FmXrN097592;
        Wed, 4 Mar 2020 15:49:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2yg1p7s8vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 15:49:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 024FmwRW006862;
        Wed, 4 Mar 2020 15:48:58 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 07:48:58 -0800
Date:   Wed, 4 Mar 2020 07:48:57 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] iomap: Remove pgoff from tracepoints
Message-ID: <20200304154857.GF8037@magnolia>
References: <20200304154706.GH29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304154706.GH29971@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 07:47:06AM -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> The 'pgoff' displayed by the tracepoints wasn't a pgoff at all; it
> was a byte offset from the start of the file.  We already emit that in
> the form of the 'offset', so we can just remove pgoff.  That means we
> can remove 'page' as an argument to the tracepoint, and rename this
> type of tracepoint from being a page class to being a range class.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks fine to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7057ef155a29..cab29ffb2b40 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -487,7 +487,7 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>  int
>  iomap_releasepage(struct page *page, gfp_t gfp_mask)
>  {
> -	trace_iomap_releasepage(page->mapping->host, page, 0, 0);
> +	trace_iomap_releasepage(page->mapping->host, 0, 0);
>  
>  	/*
>  	 * mm accommodates an old ext3 case where clean pages might not have had
> @@ -504,7 +504,7 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
>  void
>  iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
>  {
> -	trace_iomap_invalidatepage(page->mapping->host, page, offset, len);
> +	trace_iomap_invalidatepage(page->mapping->host, offset, len);
>  
>  	/*
>  	 * If we are invalidating the entire page, clear the dirty state from it
> @@ -1503,7 +1503,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  	u64 end_offset;
>  	loff_t offset;
>  
> -	trace_iomap_writepage(inode, page, 0, 0);
> +	trace_iomap_writepage(inode, 0, 0);
>  
>  	/*
>  	 * Refuse to write the page out if we are called from reclaim context.
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index d6ba705f938a..5693a39d52fb 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -41,14 +41,12 @@ DEFINE_EVENT(iomap_readpage_class, name,	\
>  DEFINE_READPAGE_EVENT(iomap_readpage);
>  DEFINE_READPAGE_EVENT(iomap_readahead);
>  
> -DECLARE_EVENT_CLASS(iomap_page_class,
> -	TP_PROTO(struct inode *inode, struct page *page, unsigned long off,
> -		 unsigned int len),
> -	TP_ARGS(inode, page, off, len),
> +DECLARE_EVENT_CLASS(iomap_range_class,
> +	TP_PROTO(struct inode *inode, unsigned long off, unsigned int len),
> +	TP_ARGS(inode, off, len),
>  	TP_STRUCT__entry(
>  		__field(dev_t, dev)
>  		__field(u64, ino)
> -		__field(pgoff_t, pgoff)
>  		__field(loff_t, size)
>  		__field(unsigned long, offset)
>  		__field(unsigned int, length)
> @@ -56,29 +54,26 @@ DECLARE_EVENT_CLASS(iomap_page_class,
>  	TP_fast_assign(
>  		__entry->dev = inode->i_sb->s_dev;
>  		__entry->ino = inode->i_ino;
> -		__entry->pgoff = page_offset(page);
>  		__entry->size = i_size_read(inode);
>  		__entry->offset = off;
>  		__entry->length = len;
>  	),
> -	TP_printk("dev %d:%d ino 0x%llx pgoff 0x%lx size 0x%llx offset %lx "
> +	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset %lx "
>  		  "length %x",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->ino,
> -		  __entry->pgoff,
>  		  __entry->size,
>  		  __entry->offset,
>  		  __entry->length)
>  )
>  
> -#define DEFINE_PAGE_EVENT(name)		\
> -DEFINE_EVENT(iomap_page_class, name,	\
> -	TP_PROTO(struct inode *inode, struct page *page, unsigned long off, \
> -		 unsigned int len),	\
> -	TP_ARGS(inode, page, off, len))
> -DEFINE_PAGE_EVENT(iomap_writepage);
> -DEFINE_PAGE_EVENT(iomap_releasepage);
> -DEFINE_PAGE_EVENT(iomap_invalidatepage);
> +#define DEFINE_RANGE_EVENT(name)		\
> +DEFINE_EVENT(iomap_range_class, name,	\
> +	TP_PROTO(struct inode *inode, unsigned long off, unsigned int len),\
> +	TP_ARGS(inode, off, len))
> +DEFINE_RANGE_EVENT(iomap_writepage);
> +DEFINE_RANGE_EVENT(iomap_releasepage);
> +DEFINE_RANGE_EVENT(iomap_invalidatepage);
>  
>  #define IOMAP_TYPE_STRINGS \
>  	{ IOMAP_HOLE,		"HOLE" }, \
