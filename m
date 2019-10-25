Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1922E42E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 07:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390383AbfJYFcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 01:32:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35130 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbfJYFcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 01:32:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P5Sujr135656;
        Fri, 25 Oct 2019 05:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=UY8hKCAlJHAj1H53DanVyzEear6JptLSOn8vuByiQZ0=;
 b=X7fO3xgJ/qVWj1PtohmFs01Rr5bVoL1rlT2btYk2pbPnGfUXHmYb5uT3X+zd2fROXS9I
 7rSdN5dwnGBpVgg6aNfvS4oImOLruxLlHdG1vIH2So8hc2IEDdOb+FNBN22syomFR1Wz
 uZpRfFzw9UisaOg341wspOtAqmaq4KhxEtyMlKERGlJlhcl/OJB/lzCLX5PYldb3Z3oy
 oJyT0T5Zzin4yKvsmTgnRJEbnRdznWdRHC2/Ltp7ptHLIgPSFaNT7/BOlT6kqHT/XB8l
 TFOpaZHHKQDdwu0c1p1oChoTh+QKDFNBQJAe3sKc/M4Bh7dzB8yN0bVLFBg/EKrY00r4 Ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vqswu0be0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 05:32:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P5Sf0b157352;
        Fri, 25 Oct 2019 05:32:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vunbkhsen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 05:32:47 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9P5WiZF014564;
        Fri, 25 Oct 2019 05:32:45 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 22:32:43 -0700
Date:   Thu, 24 Oct 2019 22:32:42 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] xfs: don't implement XFS_IOC_RESVSP /
 XFS_IOC_RESVSP64 directly
Message-ID: <20191025053242.GE913374@magnolia>
References: <20191025023609.22295-1-hch@lst.de>
 <20191025023609.22295-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025023609.22295-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=736
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=816 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250053
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:36:06AM +0900, Christoph Hellwig wrote:
> These ioctls are implemented by the VFS and mapped to ->fallocate now,
> so this code won't ever be reached.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_ioctl.c   | 10 ----------
>  fs/xfs/xfs_ioctl32.c |  2 --
>  2 files changed, 12 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 0fed56d3175c..da4aaa75cfd3 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -643,8 +643,6 @@ xfs_ioc_space(
>  	 */
>  	switch (cmd) {
>  	case XFS_IOC_ZERO_RANGE:
> -	case XFS_IOC_RESVSP:
> -	case XFS_IOC_RESVSP64:
>  	case XFS_IOC_UNRESVSP:
>  	case XFS_IOC_UNRESVSP64:
>  		if (bf->l_len <= 0) {
> @@ -670,12 +668,6 @@ xfs_ioc_space(
>  		flags |= XFS_PREALLOC_SET;
>  		error = xfs_zero_file_space(ip, bf->l_start, bf->l_len);
>  		break;
> -	case XFS_IOC_RESVSP:
> -	case XFS_IOC_RESVSP64:
> -		flags |= XFS_PREALLOC_SET;
> -		error = xfs_alloc_file_space(ip, bf->l_start, bf->l_len,
> -						XFS_BMAPI_PREALLOC);
> -		break;
>  	case XFS_IOC_UNRESVSP:
>  	case XFS_IOC_UNRESVSP64:
>  		error = xfs_free_file_space(ip, bf->l_start, bf->l_len);
> @@ -2121,11 +2113,9 @@ xfs_file_ioctl(
>  		return xfs_ioc_setlabel(filp, mp, arg);
>  	case XFS_IOC_ALLOCSP:
>  	case XFS_IOC_FREESP:
> -	case XFS_IOC_RESVSP:
>  	case XFS_IOC_UNRESVSP:
>  	case XFS_IOC_ALLOCSP64:
>  	case XFS_IOC_FREESP64:
> -	case XFS_IOC_RESVSP64:
>  	case XFS_IOC_UNRESVSP64:
>  	case XFS_IOC_ZERO_RANGE: {
>  		xfs_flock64_t		bf;
> diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
> index 1e08bf79b478..257b7caf7fed 100644
> --- a/fs/xfs/xfs_ioctl32.c
> +++ b/fs/xfs/xfs_ioctl32.c
> @@ -558,8 +558,6 @@ xfs_file_compat_ioctl(
>  	case XFS_IOC_FREESP_32:
>  	case XFS_IOC_ALLOCSP64_32:
>  	case XFS_IOC_FREESP64_32:
> -	case XFS_IOC_RESVSP_32:
> -	case XFS_IOC_UNRESVSP_32:
>  	case XFS_IOC_RESVSP64_32:
>  	case XFS_IOC_UNRESVSP64_32:
>  	case XFS_IOC_ZERO_RANGE_32: {
> -- 
> 2.20.1
> 
