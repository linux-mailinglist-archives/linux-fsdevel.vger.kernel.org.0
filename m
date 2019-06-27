Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C28B5894A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfF0Ruc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 13:50:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53956 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0Ruc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:50:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RHhqUX194718;
        Thu, 27 Jun 2019 17:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=9dcRBZ1oH1Yw3KXHkcZZY5r+tJ0AoB4UqlalnGuOKrw=;
 b=tc2of1B4ZZYeugMVvjoTHZ7potobN0S2vYp0H5R9KvpdjImxhtrW+P+NcGc1HYqgX739
 WDIuhOknuj9aY3+VbQrjtdpfUMOAzcET7s267K5UEMHtzpr2FevYjhzc4AbF76NvU5DZ
 iK7ja0P1SQaYadRPMK0/pkeQXn5SSYslmfUQ0f6Whpx9NMSjorwC3f+j7WXlsCP8ZYag
 o/70+3KRKY6gtVwplHOIfn3h8OkrgVyTx3YDhN7wszwJmL1oPq6FPQKbqE7+qY/GKiFu
 1bZ8D3xoyi/a1ibwRRf1YkTfkRBI8slj07ygKb3luG7CbY5HUamJ+quSyK1+vU/d56DA pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t9cyqsn5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 17:50:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RHnZnO164797;
        Thu, 27 Jun 2019 17:50:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9acdd265-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 17:50:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5RHoCA3003961;
        Thu, 27 Jun 2019 17:50:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 10:50:12 -0700
Date:   Thu, 27 Jun 2019 10:50:11 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] xfs: remove the unused xfs_count_page_state
 declaration
Message-ID: <20190627175011.GO5171@magnolia>
References: <20190627104836.25446-1-hch@lst.de>
 <20190627104836.25446-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627104836.25446-3-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270205
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270205
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 27, 2019 at 12:48:25PM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
> index f62b03186c62..45a1ea240cbb 100644
> --- a/fs/xfs/xfs_aops.h
> +++ b/fs/xfs/xfs_aops.h
> @@ -28,7 +28,6 @@ extern const struct address_space_operations xfs_dax_aops;
>  
>  int	xfs_setfilesize(struct xfs_inode *ip, xfs_off_t offset, size_t size);
>  
> -extern void xfs_count_page_state(struct page *, int *, int *);
>  extern struct block_device *xfs_find_bdev_for_inode(struct inode *);
>  extern struct dax_device *xfs_find_daxdev_for_inode(struct inode *);
>  
> -- 
> 2.20.1
> 
