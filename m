Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC3EC8D05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 17:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfJBPjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 11:39:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50252 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfJBPjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:39:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92FNpcl152678;
        Wed, 2 Oct 2019 15:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=VfRxfeWs1nJoNP3kT5ZXTpLac0Gq+oyCCllmNnro7IA=;
 b=XLgkpgrp66zXs8MNybhkD0sanL46h2WsbqHpz64XXAmEaCi3pvJi04j7EV5ZWNl2qapC
 AhoP6UKmR3OcC/8YIpuObL9XQZH1ig3acJjidJ0DTPEnjzC1qqsg8yrhMTKrPhzWLhkx
 MiPNkhQORVMkhi/rBnlH5uceWbZAcpgZSQ9y58N2jP61Zx2DzAfx8X4tcQfDWSoHc3BZ
 2zt+JHlaZlw5dBBEtNTn2qUpIxTh2HmPy9uRoXppWiXi8/+p+1+ATsmWDS/EO+L2/AUE
 vrf8n/OhyG7THPcwdsOol9FuYpbIoojUBqiyqQNpRAAhEm8GhUgZzLGHQ/WE9lecqLyB 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v9xxuwuxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 15:38:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92FNjnN073831;
        Wed, 2 Oct 2019 15:38:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vc9dkref5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 15:38:52 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x92Fcpw4000547;
        Wed, 2 Oct 2019 15:38:51 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Oct 2019 08:38:51 -0700
Date:   Wed, 2 Oct 2019 08:38:50 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] xfs: remove the readpage / readpages tracing code
Message-ID: <20191002153850.GH13108@magnolia>
References: <20191001071152.24403-1-hch@lst.de>
 <20191001071152.24403-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001071152.24403-7-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020140
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 01, 2019 at 09:11:47AM +0200, Christoph Hellwig wrote:
> The actual iomap implementations now have equivalent trace points.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c  |  2 --
>  fs/xfs/xfs_trace.h | 26 --------------------------
>  2 files changed, 28 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index f16d5f196c6b..b6101673c8fb 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -1160,7 +1160,6 @@ xfs_vm_readpage(
>  	struct file		*unused,
>  	struct page		*page)
>  {
> -	trace_xfs_vm_readpage(page->mapping->host, 1);
>  	return iomap_readpage(page, &xfs_iomap_ops);
>  }
>  
> @@ -1171,7 +1170,6 @@ xfs_vm_readpages(
>  	struct list_head	*pages,
>  	unsigned		nr_pages)
>  {
> -	trace_xfs_vm_readpages(mapping->host, nr_pages);
>  	return iomap_readpages(mapping, pages, nr_pages, &xfs_iomap_ops);
>  }
>  
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index eaae275ed430..eae4b29c174e 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -1197,32 +1197,6 @@ DEFINE_PAGE_EVENT(xfs_writepage);
>  DEFINE_PAGE_EVENT(xfs_releasepage);
>  DEFINE_PAGE_EVENT(xfs_invalidatepage);
>  
> -DECLARE_EVENT_CLASS(xfs_readpage_class,
> -	TP_PROTO(struct inode *inode, int nr_pages),
> -	TP_ARGS(inode, nr_pages),
> -	TP_STRUCT__entry(
> -		__field(dev_t, dev)
> -		__field(xfs_ino_t, ino)
> -		__field(int, nr_pages)
> -	),
> -	TP_fast_assign(
> -		__entry->dev = inode->i_sb->s_dev;
> -		__entry->ino = inode->i_ino;
> -		__entry->nr_pages = nr_pages;
> -	),
> -	TP_printk("dev %d:%d ino 0x%llx nr_pages %d",
> -		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  __entry->ino,
> -		  __entry->nr_pages)
> -)
> -
> -#define DEFINE_READPAGE_EVENT(name)		\
> -DEFINE_EVENT(xfs_readpage_class, name,	\
> -	TP_PROTO(struct inode *inode, int nr_pages), \
> -	TP_ARGS(inode, nr_pages))
> -DEFINE_READPAGE_EVENT(xfs_vm_readpage);
> -DEFINE_READPAGE_EVENT(xfs_vm_readpages);
> -
>  DECLARE_EVENT_CLASS(xfs_imap_class,
>  	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
>  		 int whichfork, struct xfs_bmbt_irec *irec),
> -- 
> 2.20.1
> 
