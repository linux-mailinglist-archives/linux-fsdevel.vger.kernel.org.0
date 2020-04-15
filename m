Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054B31AAB88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414590AbgDOPM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 11:12:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49962 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393131AbgDOPMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:12:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FF3ZLU073190;
        Wed, 15 Apr 2020 15:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bzoZo+HKoo6uH2xvfSZWTuYXjrlhv0Ys9g4w0SsHvfo=;
 b=N2C3mdw6mSJwafPY53rlrzVsmllU/2P1ZsA+JMDy7YOBt4Up1rXV4ITmVwOtQRDu3BAU
 /FVBQaflG1XjbpGTaICOWShSk5G8hde2yD6AfVTd6ada0Arvr9dZCViAM2o9rGYsx6Yn
 vKYxOGWvx6PLW3wSiD8p61yEStlioVBkLRnhNF4d3dqkwyofknQX86kWRj/GXquS9q5l
 //LmaYbd9WiYUkmr+dGFFX8y2NvAiDdHIWlcppzOay/sbdFK7idOirfGRIszKS2ZVGXG
 mRYmNxTX3lD8arSw54wr7Mc5dS61YTRhbwejWodQEwakJA86uRpbn1K82UJy9vUWxZNs TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30e0aa1hdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:12:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FF7MQG186295;
        Wed, 15 Apr 2020 15:12:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30dn8wdeee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:12:11 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03FFC9Ni030716;
        Wed, 15 Apr 2020 15:12:09 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Apr 2020 08:12:09 -0700
Date:   Wed, 15 Apr 2020 08:12:07 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 01/11] fs/xfs: Remove unnecessary initialization of
 i_rwsem
Message-ID: <20200415151207.GN6742@magnolia>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415064523.2244712-2-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=1 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150112
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:45:13PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> An earlier call of xfs_reinit_inode() from xfs_iget_cache_hit() already
> handles initialization of i_rwsem.
> 
> Doing so again is unneeded.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Still looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> ---
> Changes from V4:
> 	Update commit message to make it clear the xfs_iget_cache_hit()
> 	is actually doing the initialization via xfs_reinit_inode()
> 
> New for V4:
> 
> NOTE: This was found while ensuring the new i_aops_sem was properly
> handled.  It seems like this is a layering violation so I think it is
> worth cleaning up so as to not confuse others.
> ---
>  fs/xfs/xfs_icache.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 8dc2e5414276..836a1f09be03 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -419,6 +419,7 @@ xfs_iget_cache_hit(
>  		spin_unlock(&ip->i_flags_lock);
>  		rcu_read_unlock();
>  
> +		ASSERT(!rwsem_is_locked(&inode->i_rwsem));
>  		error = xfs_reinit_inode(mp, inode);
>  		if (error) {
>  			bool wake;
> @@ -452,9 +453,6 @@ xfs_iget_cache_hit(
>  		ip->i_sick = 0;
>  		ip->i_checked = 0;
>  
> -		ASSERT(!rwsem_is_locked(&inode->i_rwsem));
> -		init_rwsem(&inode->i_rwsem);
> -
>  		spin_unlock(&ip->i_flags_lock);
>  		spin_unlock(&pag->pag_ici_lock);
>  	} else {
> -- 
> 2.25.1
> 
