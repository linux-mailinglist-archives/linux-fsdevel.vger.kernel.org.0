Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A444E1BFFED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgD3PQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 11:16:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54520 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgD3PQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:16:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03UFD55d169844;
        Thu, 30 Apr 2020 15:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Tm0TEordpY3zCjdu1wJVpqKvrP0I5ede7+XgdfzJldU=;
 b=WwINN9yG3SwxNx++5RYPsoCaqb5qwBwZzH66lR+Idu0SaSjT/mqPwTECgB+l1w/ItS5d
 2Esj0qCQYN/rc6z85unrWZ0JZCYDOsyjI9ttl7RqZZXsp70mMOHOk5nc4HjPgrJysER8
 vesYG/LoGDIVjSIOLuTOBTuSSvo6CjCrAnAN+Rlq4hsec63l4WIQQhxuE7nmOHJ0wWxq
 CVS1al0HYXXogITplQFDOBfDhtdUKhDxrpiwG7HmbUFEaFwNOzAPqMXx7/afH55k6wuy
 ssmBBoC0PQwDMbmC1Hg+y4brZMtNy/mDNk4DNTP3kiL5A4eWFBEdczpZ7VC01iVgqJdH HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30nucgc2eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 15:16:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03UFCRUw041962;
        Thu, 30 Apr 2020 15:16:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30qtg167rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 15:16:36 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03UFGXBM015036;
        Thu, 30 Apr 2020 15:16:33 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Apr 2020 08:16:33 -0700
Date:   Thu, 30 Apr 2020 08:16:31 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCHv3 1/1] fibmap: Warn and return an error in case of block
 > INT_MAX
Message-ID: <20200430151631.GK6733@magnolia>
References: <b95aca069607600ffd1efc95803cf39c13768b4d.1588222212.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b95aca069607600ffd1efc95803cf39c13768b4d.1588222212.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300123
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:25:18AM +0530, Ritesh Harjani wrote:
> We better warn the fibmap user and not return a truncated and therefore
> an incorrect block map address if the bmap() returned block address
> is greater than INT_MAX (since user supplied integer pointer).
> 
> It's better to pr_warn() all user of ioctl_fibmap() and return a proper
> error code rather than silently letting a FS corruption happen if the
> user tries to fiddle around with the returned block map address.
> 
> We fix this by returning an error code of -ERANGE and returning 0 as the
> block mapping address in case if it is > INT_MAX.
> 
> Now iomap_bmap() could be called from either of these two paths.
> Either when a user is calling an ioctl_fibmap() interface to get
> the block mapping address or by some filesystem via use of bmap()
> internal kernel API.
> bmap() kernel API is well equipped with handling of u64 addresses.
> 
> WARN condition in iomap_bmap_actor() was mainly added to warn all
> the fibmap users. But now that we have directly added this warning
> for all fibmap users and also made sure to return 0 as block map address
> in case if addr > INT_MAX.
> So we can now remove this logic from iomap_bmap_actor().
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> v2 -> v3:
> 1. Added file path info using (%pD4)
> 2. Dropped Reviewed-by tags for reviewing this final version.
> 
>  fs/ioctl.c        | 8 ++++++++
>  fs/iomap/fiemap.c | 5 +----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index f1d93263186c..6b8629fbe0fd 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -55,6 +55,7 @@ EXPORT_SYMBOL(vfs_ioctl);
>  static int ioctl_fibmap(struct file *filp, int __user *p)
>  {
>  	struct inode *inode = file_inode(filp);
> +	struct super_block *sb = inode->i_sb;
>  	int error, ur_block;
>  	sector_t block;
>  
> @@ -71,6 +72,13 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
>  	block = ur_block;
>  	error = bmap(inode, &block);
>  
> +	if (block > INT_MAX) {
> +		error = -ERANGE;
> +		pr_warn_ratelimited("[%s/%d] FS: %s File: %pD4 would truncate fibmap result\n",
> +				    current->comm, task_pid_nr(current),
> +				    sb->s_id, filp);
> +	}
> +
>  	if (error)
>  		ur_block = 0;
>  	else
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index bccf305ea9ce..d55e8f491a5e 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -117,10 +117,7 @@ iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  	if (iomap->type == IOMAP_MAPPED) {
>  		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
> -		if (addr > INT_MAX)
> -			WARN(1, "would truncate bmap result\n");
> -		else
> -			*bno = addr;
> +		*bno = addr;
>  	}
>  	return 0;
>  }
> -- 
> 2.21.0
> 
