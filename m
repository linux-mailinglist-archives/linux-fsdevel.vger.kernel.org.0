Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08835189EFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 16:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCRPHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 11:07:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42254 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgCRPHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:07:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02IEvhGa033520;
        Wed, 18 Mar 2020 15:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=h+8RsoFa4HBvYCxPKp95KMpydcQrQOAmTjFLD+d8CUo=;
 b=KfiB9LS7TQgzyPvTzKfLJ+Ak2xDROyDnPYbx8CNRry/72ASZivBsLe6qZhifVJoP9kVv
 97MHAUDKHpBUuZgkgwGMgLqqKc7zYLdX84TbrMKzVp2tCFJfPIeXlfgiQ6KuWhwWg1kO
 OewbYowVA32ehf6LUW70GsnkL7MJgAFZCEWneowOxA/c1SR4my+2u32D9eKVB2xhjDj8
 oTsUKvO5xCN93orpimNw2w1yy58PpB78TPfR29E14tf010k7mK0cbAqZyRg0BFvQWE6T
 Xo0UPYx9Kgp5OwnjI2ix3YP0YJCleL+7MtlKQIPwOvyjBokT+GSmwwUc/JTmdbcuTiPV zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yub2731dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 15:06:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02IEuWbs169958;
        Wed, 18 Mar 2020 15:06:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ys901p07r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 15:06:34 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02IF6XeA019836;
        Wed, 18 Mar 2020 15:06:33 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Mar 2020 08:06:32 -0700
Date:   Wed, 18 Mar 2020 08:06:32 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     yangerkun <yangerkun@huawei.com>
Cc:     hch@infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: fix comments in iomap_dio_rw
Message-ID: <20200318150632.GC256713@magnolia>
References: <20200318095022.5613-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318095022.5613-1-yangerkun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9563 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003180072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9563 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=2
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180072
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 18, 2020 at 05:50:22PM +0800, yangerkun wrote:
> Double 'three' exists in the comments of iomap_dio_rw.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Looks good, will stage for 5.7...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/direct-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 23837926c0c5..20dde5aadcdd 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -534,8 +534,8 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  
>  	/*
>  	 * We are about to drop our additional submission reference, which
> -	 * might be the last reference to the dio.  There are three three
> -	 * different ways we can progress here:
> +	 * might be the last reference to the dio.  There are three different
> +	 * ways we can progress here:
>  	 *
>  	 *  (a) If this is the last reference we will always complete and free
>  	 *	the dio ourselves.
> -- 
> 2.17.2
> 
