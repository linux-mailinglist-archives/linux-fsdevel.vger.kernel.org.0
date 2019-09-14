Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63522B2924
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2019 02:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbfINAm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 20:42:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58566 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388296AbfINAm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 20:42:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8E0cdP1053691;
        Sat, 14 Sep 2019 00:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=6d2cvRfdJN50GU1V/daRJGyYVSGwGk6V686nfsANX4c=;
 b=ixEjTpwi/cnsLqTFKYAqCgWo3WKIEb/AEronGfkSXPUcAW2Xh7cPTXg3TNpV5AtFbMYN
 IfepcDwF7HU/AlD0f2yqX4sTBT69EBqeHGKbqSEKjCeOa+6amnqqewvi7pG9P3D/3fok
 lcIX0uDvWRfgV9QjTJ2eKNa3HNFASdkqpoLtGWOQv19NSRuv2T0lvEMAjy9koLF338WF
 fubT4SD83HK3JkmXpe6O8GwCxerl6FrTBo6Je7tqCXyZDx5v2e9PZlaE47ldoGTz6x8G
 W/RBuSE02vw4aiFxMCpl7VVVDczPKOfdDsuABuxqNOlB0qS6kxNE07LbdVaRGXvJA+r3 bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2uytd37kdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 00:42:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8E0cOTR174500;
        Sat, 14 Sep 2019 00:42:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2v0nb11196-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 00:42:21 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8E0gKBS026322;
        Sat, 14 Sep 2019 00:42:20 GMT
Received: from [192.168.1.9] (/67.1.21.243)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 17:42:20 -0700
From:   Allison Collins <allison.henderson@oracle.com>
Subject: Re: [PATCH 02/19] iomap: remove the unused iomap argument to
 __iomap_write_end
To:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-3-hch@lst.de>
Message-ID: <62b2c42f-f4ac-aa7f-25e8-9c7e4e1ccacf@oracle.com>
Date:   Fri, 13 Sep 2019 17:42:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909182722.16783-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909140004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909140004
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks fine:
Reviewed-by: Allison Collins <allison.henderson@oracle.com>

On 9/9/19 11:27 AM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/iomap/buffered-io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 051b8ec326ba..2a9b41352495 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -678,7 +678,7 @@ EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
>   
>   static int
>   __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
> -		unsigned copied, struct page *page, struct iomap *iomap)
> +		unsigned copied, struct page *page)
>   {
>   	flush_dcache_page(page);
>   
> @@ -731,7 +731,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>   		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
>   				page, NULL);
>   	} else {
> -		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
> +		ret = __iomap_write_end(inode, pos, len, copied, page);
>   	}
>   
>   	/*
> 
