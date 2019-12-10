Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DA211920F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 21:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLJUc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 15:32:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37216 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJUc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:32:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBAKTqDD041259;
        Tue, 10 Dec 2019 20:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=tWaSFFSXk9dNo1Pm9UBajo3GrWy26jKUkAis4BPkOPc=;
 b=R8igmffM3zxS7dDueZN0nItEYtBPGAsdjG12VSZSczovEjmmaDGzF8rSUzD5uLz5vMt/
 ex6d+RSBFgSKEse8AfE5B4e94y8m2I1NvyR9PTbqcIlDo4kAOGV6C+v/hLMS/R6eB478
 RrG1qB6pH4TVuQu/VBCed5alwv58/gxnoDR+ophdVGtoyo4TWY8B1c21mE4Q7/krC8Rg
 M1jsSTx3VLPzc2z2H/g8vOfisFFn3lTVBUP+2gai8e/tBvOgLLHIAqKz6qSb9LmOsAxa
 lbtRZuIqCzpkwTw/MMQzNg4utID8Zg3mJl64FZnSCMLk9EA9bmNIKWnPBnjSKpwPlGez uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wr41q8nan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 20:32:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBAKSeLs169161;
        Tue, 10 Dec 2019 20:32:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wsv8ccqkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 20:32:55 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBAKWsXY002222;
        Tue, 10 Dec 2019 20:32:54 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Dec 2019 12:32:53 -0800
Date:   Tue, 10 Dec 2019 12:32:52 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH] iomap: Export iomap_page_create and
 iomap_set_range_uptodate
Message-ID: <20191210203252.GA99875@magnolia>
References: <20191210102916.842-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210102916.842-1-agruenba@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912100169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912100169
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:29:16AM +0100, Andreas Gruenbacher wrote:
> These two functions are needed by filesystems for converting inline
> ("stuffed") inodes into non-inline inodes.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks fine to me... this is a 5.6 change, correct?

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 6 ++++--
>  include/linux/iomap.h  | 5 +++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 828444e14d09..e8f6d7ba4e3c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -41,7 +41,7 @@ static inline struct iomap_page *to_iomap_page(struct page *page)
>  
>  static struct bio_set iomap_ioend_bioset;
>  
> -static struct iomap_page *
> +struct iomap_page *
>  iomap_page_create(struct inode *inode, struct page *page)
>  {
>  	struct iomap_page *iop = to_iomap_page(page);
> @@ -64,6 +64,7 @@ iomap_page_create(struct inode *inode, struct page *page)
>  	SetPagePrivate(page);
>  	return iop;
>  }
> +EXPORT_SYMBOL(iomap_page_create);
>  
>  static void
>  iomap_page_release(struct page *page)
> @@ -164,7 +165,7 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
>  }
>  
> -static void
> +void
>  iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  {
>  	if (PageError(page))
> @@ -175,6 +176,7 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	else
>  		SetPageUptodate(page);
>  }
> +EXPORT_SYMBOL(iomap_set_range_uptodate);
>  
>  static void
>  iomap_read_finish(struct iomap_page *iop, struct page *page)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8b09463dae0d..b00f9bc396b1 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -13,6 +13,7 @@
>  struct address_space;
>  struct fiemap_extent_info;
>  struct inode;
> +struct iomap_page;
>  struct iomap_writepage_ctx;
>  struct iov_iter;
>  struct kiocb;
> @@ -152,6 +153,10 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
>  		unsigned flags, const struct iomap_ops *ops, void *data,
>  		iomap_actor_t actor);
>  
> +struct iomap_page *iomap_page_create(struct inode *inode, struct page *page);
> +void iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len);
> +
> +
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops);
>  int iomap_readpage(struct page *page, const struct iomap_ops *ops);
> -- 
> 2.20.1
> 
