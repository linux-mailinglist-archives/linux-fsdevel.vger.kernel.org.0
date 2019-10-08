Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F3CFD15
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfJHPDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 11:03:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49650 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfJHPDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:03:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98F2q99115924;
        Tue, 8 Oct 2019 15:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=BQFz62FVuFWjOuz2xoHuT2OKRp//IwuftnJosYSLbjo=;
 b=iuYVCR8YG1+jRR/qY34m6Dwo0yZKIOnM4DYphO6WB8W19Vt5du5+HXsN3KtNH+bhhO4c
 a2gd2JVZahwPZmcY6qmKqfzsRIchZMrFLya0NrY7JDupTxWAowiXs+eMaUS9sXRWOF8q
 4iyyA/nNQn9FM0G5zbXJEvzqAasHg0SCNpo3aYXCiSkpUa1DDKa/Og+deQf3Hc59TTn5
 d/fJcdyPTbxiRIWDDojNabQ61Gq68EOfi+YuUYMHfWkXYUwEXHzZbyw01qsqU8cEzpvT
 V+S+GLbyVSA8tiCzRU04kQ08Mh1KEiNfd2VsJ2dIFpXmTtgPEbWwyrZe713OOFr5aAol bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vejkudxus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:03:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98EnUMN122302;
        Tue, 8 Oct 2019 15:01:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vg1yw3ntd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:01:32 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x98F1VUx007119;
        Tue, 8 Oct 2019 15:01:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 08:01:30 -0700
Date:   Tue, 8 Oct 2019 08:01:30 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/20] iomap: renumber IOMAP_HOLE to 0
Message-ID: <20191008150130.GW13108@magnolia>
References: <20191008071527.29304-1-hch@lst.de>
 <20191008071527.29304-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008071527.29304-8-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080134
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:15:14AM +0200, Christoph Hellwig wrote:
> Instead of keeping a separate unnamed state for uninitialized iomaps,
> renumber IOMAP_HOLE to zero so that an uninitialized iomap is treated
> as a hole.
> 
> Suggested-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  include/linux/iomap.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 220f6b17a1a7..24c784e44274 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -23,11 +23,11 @@ struct vm_fault;
>  /*
>   * Types of block ranges for iomap mappings:
>   */
> -#define IOMAP_HOLE	0x01	/* no blocks allocated, need allocation */
> -#define IOMAP_DELALLOC	0x02	/* delayed allocation blocks */
> -#define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
> -#define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
> -#define IOMAP_INLINE	0x05	/* data inline in the inode */
> +#define IOMAP_HOLE	0	/* no blocks allocated, need allocation */
> +#define IOMAP_DELALLOC	1	/* delayed allocation blocks */
> +#define IOMAP_MAPPED	2	/* blocks allocated at @addr */
> +#define IOMAP_UNWRITTEN	3	/* blocks allocated at @addr in unwritten state */
> +#define IOMAP_INLINE	4	/* data inline in the inode */
>  
>  /*
>   * Flags reported by the file system from iomap_begin:
> -- 
> 2.20.1
> 
