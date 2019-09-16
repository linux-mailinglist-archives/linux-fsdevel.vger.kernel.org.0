Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70578B400A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 20:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390235AbfIPSJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 14:09:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58246 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfIPSJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:09:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GI8jR7057912;
        Mon, 16 Sep 2019 18:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=8rOaCF+qRFQoUNrMDXPUFDAuyu85Ml82oWyZFWWQmLM=;
 b=U68DlDtSwWNwFx9MPNVM8yrjmMKaM9iiu+ReqtmgKM3NLqkRRHdGRbekqp8GhIp+UNir
 xmMLjKpmO1KZO0IJq7zorMtSQzsXZilEedlvaLjIv23xIKVtzUAshOAsy1T95qB+EGYV
 HFGUq+A1sSBqZAaWr49huK+Vu+x7a22Z8Z4TDaHKSaWpRAvzHvDmH2R6Fd3SoOCmXHQP
 oZQqCHMrZ4x9FKcyjuFc4RzPZUiAxukn+AVvMm2FE6c3gy5h//lHRcM456BLEq69P/pT
 4gZvEdU0wgorwuITU59eTfAtDejZYVT1O6cESbCQbV/e49kWL39QV0i1DY6UfpnjZU6L YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2v0ruqh6cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:08:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GI8eIe075963;
        Mon, 16 Sep 2019 18:08:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2v0nb54j1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:08:57 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8GI8uSG003476;
        Mon, 16 Sep 2019 18:08:57 GMT
Received: from localhost (/10.159.225.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 11:08:56 -0700
Date:   Mon, 16 Sep 2019 11:08:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/19] iomap: better document the IOMAP_F_* flags
Message-ID: <20190916180854.GF2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-2-hch@lst.de>
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

On Mon, Sep 09, 2019 at 08:27:04PM +0200, Christoph Hellwig wrote:
> The documentation for IOMAP_F_* is a bit disorganized, and doesn't
> mention the fact that most flags are set by the file system and consumed
> by the iomap core, while IOMAP_F_SIZE_CHANGED is set by the core and
> consumed by the file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Wooooooo,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  include/linux/iomap.h | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e79af6b28410..8adcc8dd4498 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -30,21 +30,36 @@ struct vm_fault;
>  #define IOMAP_INLINE	0x05	/* data inline in the inode */
>  
>  /*
> - * Flags for all iomap mappings:
> + * Flags reported by the file system from iomap_begin:
> + *
> + * IOMAP_F_NEW indicates that the blocks have been newly allocated and need
> + * zeroing for areas that no data is copied to.
>   *
>   * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed to access
>   * written data and requires fdatasync to commit them to persistent storage.
> + *
> + * IOMAP_F_SHARED indicates that the blocks are shared, and will need to be
> + * unshared as part a write.
> + *
> + * IOMAP_F_MERGED indicates that the iomap contains the merge of multiple block
> + * mappings.
> + *
> + * IOMAP_F_BUFFER_HEAD indicates that the file system requires the use of
> + * buffer heads for this mapping.
>   */
> -#define IOMAP_F_NEW		0x01	/* blocks have been newly allocated */
> -#define IOMAP_F_DIRTY		0x02	/* uncommitted metadata */
> -#define IOMAP_F_BUFFER_HEAD	0x04	/* file system requires buffer heads */
> -#define IOMAP_F_SIZE_CHANGED	0x08	/* file size has changed */
> +#define IOMAP_F_NEW		0x01
> +#define IOMAP_F_DIRTY		0x02
> +#define IOMAP_F_SHARED		0x04
> +#define IOMAP_F_MERGED		0x08
> +#define IOMAP_F_BUFFER_HEAD	0x10
>  
>  /*
> - * Flags that only need to be reported for IOMAP_REPORT requests:
> + * Flags set by the core iomap code during operations:
> + *
> + * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
> + * has changed as the result of this write operation.
>   */
> -#define IOMAP_F_MERGED		0x10	/* contains multiple blocks/extents */
> -#define IOMAP_F_SHARED		0x20	/* block shared with another file */
> +#define IOMAP_F_SIZE_CHANGED	0x100
>  
>  /*
>   * Flags from 0x1000 up are for file system specific usage:
> -- 
> 2.20.1
> 
