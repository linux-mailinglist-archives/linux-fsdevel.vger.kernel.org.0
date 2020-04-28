Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF7D1BC23C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgD1PHT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 11:07:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34480 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgD1PHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:07:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SF2oQg186150;
        Tue, 28 Apr 2020 15:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=iipreQ5GV+rvEB10J9TRs1WYlt4LV7NmGOo51IIe1z8=;
 b=IGQLThE2J+8uo+T8p65/hBXvV8tQDVe3kizQSdpP5eOHhh2MPK44njSSJP3nCRqrgmgN
 JP1fu+1aMW3xJhqu7o5lbsFmpvPbb9eFgyYwAzTe5eqJCwyaenpV6jeXl1T6dppEuQe9
 Rr3pIaEDZPAaaaBT6SLiQxMUwsmugd6PylYdSyfgcr+dJQy5HmRtl1/I2yMC/jRO4bV1
 fXbeJIzo26je9oLe62J8mUJtxMAeslkgIMujyIcjnSvbJW+HJHRT1BxWooU7xqyFHNuC
 MObcpCE3eGZJQd3eySoOxW9kJUqcHeu06v4Q3/8leq1iOcvzBzbQkWbLKs8Yaa0usaeK bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30nucg0htr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:07:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SF3tfn153636;
        Tue, 28 Apr 2020 15:07:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30mxx006f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:07:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SF6vM3028406;
        Tue, 28 Apr 2020 15:06:57 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:06:57 -0700
Date:   Tue, 28 Apr 2020 08:06:55 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        tytso@mit.edu, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 05/11] fs: mark __generic_block_fiemap static
Message-ID: <20200428150655.GG6741@magnolia>
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427181957.1606257-6-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280118
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 08:19:51PM +0200, Christoph Hellwig wrote:
> There is no caller left outside of ioctl.c.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/ioctl.c         | 4 +---
>  include/linux/fs.h | 4 ----
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 282d45be6f453..f55f53c7824bb 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -299,8 +299,7 @@ static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
>   * If you use this function directly, you need to do your own locking. Use
>   * generic_block_fiemap if you want the locking done for you.
>   */
> -
> -int __generic_block_fiemap(struct inode *inode,
> +static int __generic_block_fiemap(struct inode *inode,
>  			   struct fiemap_extent_info *fieinfo, loff_t start,
>  			   loff_t len, get_block_t *get_block)
>  {
> @@ -445,7 +444,6 @@ int __generic_block_fiemap(struct inode *inode,
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(__generic_block_fiemap);
>  
>  /**
>   * generic_block_fiemap - FIEMAP for block based inodes
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4f6f59b4f22a8..3104c6f7527b5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3299,10 +3299,6 @@ static inline int vfs_fstat(int fd, struct kstat *stat)
>  extern const char *vfs_get_link(struct dentry *, struct delayed_call *);
>  extern int vfs_readlink(struct dentry *, char __user *, int);
>  
> -extern int __generic_block_fiemap(struct inode *inode,
> -				  struct fiemap_extent_info *fieinfo,
> -				  loff_t start, loff_t len,
> -				  get_block_t *get_block);
>  extern int generic_block_fiemap(struct inode *inode,
>  				struct fiemap_extent_info *fieinfo, u64 start,
>  				u64 len, get_block_t *get_block);
> -- 
> 2.26.1
> 
