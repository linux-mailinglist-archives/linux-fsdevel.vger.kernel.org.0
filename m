Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E932C36E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 03:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgKYCqz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 21:46:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36398 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgKYCqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:46:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AP2eSpI086920;
        Wed, 25 Nov 2020 02:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=dYqnJEw4NB/4m7HOupDUjABFTmx0/tYok8bw9SgMPak=;
 b=XP0HfvJA9WyuHOB5YpV/Cy0wva2iljOKn8ea+nZq4jWUegKZonT33gwGX7fM4oMd9QgQ
 6xxMnhrB9XbFsRrWIOl9H/bBA+b02OGJgKhLTw/xO/cEYcLq0L4+eeQTKdasMDpaRmQi
 DYWxkbzx/tjXCyOHVMQYDkAWzgchdEytD8VITEUCMypu3DOhKjH8p/us7w7CVTrXa8PV
 O2BAVsvLABktsNOEzbZN3/eFJdVvtnH1dbccz9Z3CYYlj81+ofQrejDrezoqAFnQEgWw
 5axp9WDEY5xClx1mdavKWRerEGsjIRVAliPpyQ8tuH+1qJcdQSsJBX3jwsZTu2SXxYJl vQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3514q8jfg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Nov 2020 02:46:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AP2dgSr112106;
        Wed, 25 Nov 2020 02:46:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34yx8km8a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 02:46:48 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AP2kkk4030294;
        Wed, 25 Nov 2020 02:46:46 GMT
Received: from localhost (/10.159.139.224)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Nov 2020 18:46:45 -0800
Date:   Tue, 24 Nov 2020 18:46:44 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     XiaoLi Feng <xifeng@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        Xiaoli Feng <fengxiaoli0714@gmail.com>
Subject: Re: [PATCH v2] fs/stat: set attributes_mask for STATX_ATTR_DAX
Message-ID: <20201125024644.GA14534@magnolia>
References: <20201125020840.1275-1-xifeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125020840.1275-1-xifeng@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=1
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 mlxscore=0 suspectscore=1 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250016
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 10:08:40AM +0800, XiaoLi Feng wrote:
> From: Xiaoli Feng <fengxiaoli0714@gmail.com>
> 
> keep attributes and attributes_mask are consistent for
> STATX_ATTR_DAX.
> ---
> Hi,
> Please help to review this patch. I send this patch because xfstests generic/532
> is failed for dax test.
> 
>  fs/stat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index dacecdda2e79..4619b3fc9694 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -80,8 +80,10 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  	if (IS_AUTOMOUNT(inode))
>  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
>  
> -	if (IS_DAX(inode))
> +	if (IS_DAX(inode)) {
>  		stat->attributes |= STATX_ATTR_DAX;
> +		stat->attributes_mask |= STATX_ATTR_DAX;

From the discussion of the V1 patch:

Doesn't it make more sense for /filesystems/ driver to set the attr_mask
bit when the filesystem is capable of DAX?  Surely we should be able to
tell applications that DAX is a possibility for the fs even if it's not
enabled on this specific file.

IOWs the place to make this change is in the ext2/ext4/fuse/xfs code,
not in the generic vfs.

--D

> +	}
>  
>  	if (inode->i_op->getattr)
>  		return inode->i_op->getattr(path, stat, request_mask,
> -- 
> 2.18.1
> 
