Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE2AB4014
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 20:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfIPSML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 14:12:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59166 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbfIPSKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:10:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GI8jcH057914;
        Mon, 16 Sep 2019 18:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=VfJpXahqqBtRtFTcRueIu/dkylKYrVnf3h8VOuuaHqo=;
 b=TCs/YQkXasRA3DCO509VfjZVGKYnKqR7LWiAQWwgY7yG7KBm8a/IyMMSHK4L9SNvVJzs
 WAfI9l/Nnumzwr+kJSiE0VKWeDzBniDYK30PMr6KOS6KZ0SQXC/GYf5aK9vCRIsp2tI5
 czmt8bBvMRiokTshEYVDa7Tq/EWMbQ1eNvc3GkPAU716RkHP1oh22tmkANnACZyxQGtU
 kd5k4cADIM6TvnT9q2MVF6vVczXMZiykkk3kUA+il6UsLoTIo7YR8I45swcmwVZiUhM5
 0c9M8/i20ZrVc1jz3iZeRAhdtpzl6ZZ/+UgmdS4CMrT5VXD9pXBCyO0is6P6L18QHwBz sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2v0ruqh6ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:10:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GI98K1008538;
        Mon, 16 Sep 2019 18:10:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2v0qhpx1hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:10:07 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8GIA6hk004224;
        Mon, 16 Sep 2019 18:10:06 GMT
Received: from localhost (/10.159.225.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 11:10:06 -0700
Date:   Mon, 16 Sep 2019 11:10:05 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/19] iomap: remove the unused iomap argument to
 __iomap_write_end
Message-ID: <20190916181005.GG2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-3-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160178
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:05PM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 051b8ec326ba..2a9b41352495 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -678,7 +678,7 @@ EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
>  
>  static int
>  __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
> -		unsigned copied, struct page *page, struct iomap *iomap)
> +		unsigned copied, struct page *page)
>  {
>  	flush_dcache_page(page);
>  
> @@ -731,7 +731,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
>  				page, NULL);
>  	} else {
> -		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
> +		ret = __iomap_write_end(inode, pos, len, copied, page);
>  	}
>  
>  	/*
> -- 
> 2.20.1
> 
