Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814D9A4C0D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 22:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfIAUwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 16:52:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57076 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbfIAUwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 16:52:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81KoZ36145046;
        Sun, 1 Sep 2019 20:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=T13dADbf1q95VgbF95ANzVgEzppqg/4k5uqljZkMYl4=;
 b=ozfJwS3GxhIayAi6CPLokpTO7YpPik02SnV4YOJlxZ9cXIfPRlxwYnabwLn+/TvUP7Zq
 VpbzzRJUUwCZCVIewV7BEYFHOnDIKC+xzCRmdVyRKp/F3pQFQF16R+STTsGxwWMdjPFB
 yck0BraUEXaFaP4V9/lJfbsew1Xs2EmKxEke3tGnRTDZPbj0FYRk6ntskn1+Rt2DPfdo
 GxdXIK1vGdzuYMYAM77S9Qi42FNKTPxzoqoTCeYB1eVg3TOBag+OGmsvISSHeH/6je8m
 liCsclyRvcDK9DbUcOcYOSsKh53Y2RQWRKCQ99dEuPLNl2H54TJU5luyeU+IzYBpFho+ zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2urnar8081-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 20:52:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81Km69v070340;
        Sun, 1 Sep 2019 20:50:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2uqg827muq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 20:50:01 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x81Knxij004583;
        Sun, 1 Sep 2019 20:49:59 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Sep 2019 13:49:59 -0700
Date:   Sun, 1 Sep 2019 13:50:01 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, david@fromorbit.com, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/15] iomap: Introduce CONFIG_FS_IOMAP_DEBUG
Message-ID: <20190901205001.GB568270@magnolia>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
 <20190901200836.14959-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901200836.14959-2-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909010239
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909010240
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 03:08:22PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> To improve debugging abilities, especially invalid option
> asserts.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/Kconfig            |  3 +++
>  include/linux/iomap.h | 11 +++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index bfb1c6095c7a..4bed5df9b55f 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -19,6 +19,9 @@ if BLOCK
>  
>  config FS_IOMAP
>  	bool
> +config FS_IOMAP_DEBUG
> +	bool "Debugging for the iomap code"
> +	depends on FS_IOMAP
>  
>  source "fs/ext2/Kconfig"
>  source "fs/ext4/Kconfig"
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index bc499ceae392..209b6c93674e 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -18,6 +18,17 @@ struct page;
>  struct vm_area_struct;
>  struct vm_fault;
>  
> +#ifdef CONFIG_FS_IOMAP_DEBUG
> +#define iomap_assert(expr) \
> +	if(!(expr)) { \
> +		printk( "Assertion failed! %s,%s,%s,line=%d\n",\
> +#expr,__FILE__,__func__,__LINE__); \
> +		BUG(); \

Hmm, this log message ought to have a priority level, right?

#define IOMAP_ASSERT(expr) do { WARN_ON(!(expr)); } while(0)

(or crib ASSERT/ass{fail,warn} from XFS? :D)

> +	}
> +#else
> +#define iomap_assert(expr)

((void)0)

So we don't just have stray semicolons in the code stream?

--D

> +#endif
> +
>  /*
>   * Types of block ranges for iomap mappings:
>   */
> -- 
> 2.16.4
> 
