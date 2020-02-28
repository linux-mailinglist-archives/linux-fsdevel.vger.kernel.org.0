Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA64173B34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgB1PUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:20:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39602 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgB1PUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:20:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SFInxd161013;
        Fri, 28 Feb 2020 15:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=P+FGiNW4DdarK451Sm5GUQAEbQCtUTRtdQn7l8g186E=;
 b=P3efOf8QKNLB/anqlYztIKceupjCn5xRmIAMXqBZYfE0vx/8x/vTptSeYNZ5WDK36eeV
 9+aSxkriOpFXvTlHkDHx2Y1tEOI7LR3s7uQs83gG0PBcM+v7qBx+d3BFz7/wZQZohLfP
 WlythMh4/XBsw01zjwKzqGBJQoq0Bdr7rgro29gvd86kMe/5NTvBO3pYCbkYszt6W6TU
 xpYA1BvkM5gsGKCZGQXxL4jY6wCVlbwpsKgJ9iExnIBpX/XLTySNqTCmQWw5HS4zKc3B
 OwgPaC0HnzhHIUpQFyTXK1O2XOiNFwFMYwV8azIv+AYkCwRYNr8UrCV7wZ8uo/01k2uL ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2ydct3ker1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 15:20:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SFILlK124979;
        Fri, 28 Feb 2020 15:20:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ydcs8r4jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 15:20:19 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01SFKGt9018141;
        Fri, 28 Feb 2020 15:20:16 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 07:20:16 -0800
Date:   Fri, 28 Feb 2020 07:20:15 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com
Subject: Re: [PATCHv5 6/6] Documentation: Correct the description of
 FIEMAP_EXTENT_LAST
Message-ID: <20200228152015.GC8036@magnolia>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <5a00e8d4283d6849e0b8f408c8365b31fbc1d153.1582880246.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a00e8d4283d6849e0b8f408c8365b31fbc1d153.1582880246.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280121
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:56:59PM +0530, Ritesh Harjani wrote:
> Currently FIEMAP_EXTENT_LAST is not working consistently across
> different filesystem's fiemap implementations. So add more information
> about how else this flag could set in other implementation.
> 
> Also in general, user should not completely rely on this flag as
> such since it could return false value for e.g.
> when there is a delalloc extent which might get converted during
> writeback, immediately after the fiemap calls return.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks reasonable,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  Documentation/filesystems/fiemap.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/fiemap.txt b/Documentation/filesystems/fiemap.txt
> index f6d9c99103a4..fedfa9b9dde5 100644
> --- a/Documentation/filesystems/fiemap.txt
> +++ b/Documentation/filesystems/fiemap.txt
> @@ -71,8 +71,7 @@ allocated is less than would be required to map the requested range,
>  the maximum number of extents that can be mapped in the fm_extent[]
>  array will be returned and fm_mapped_extents will be equal to
>  fm_extent_count. In that case, the last extent in the array will not
> -complete the requested range and will not have the FIEMAP_EXTENT_LAST
> -flag set (see the next section on extent flags).
> +complete the requested range.
>  
>  Each extent is described by a single fiemap_extent structure as
>  returned in fm_extents.
> @@ -96,7 +95,7 @@ block size of the file system.  With the exception of extents flagged as
>  FIEMAP_EXTENT_MERGED, adjacent extents will not be merged.
>  
>  The fe_flags field contains flags which describe the extent returned.
> -A special flag, FIEMAP_EXTENT_LAST is always set on the last extent in
> +A special flag, FIEMAP_EXTENT_LAST *may be* set on the last extent in
>  the file so that the process making fiemap calls can determine when no
>  more extents are available, without having to call the ioctl again.
>  
> @@ -115,8 +114,9 @@ data. Note that the opposite is not true - it would be valid for
>  FIEMAP_EXTENT_NOT_ALIGNED to appear alone.
>  
>  * FIEMAP_EXTENT_LAST
> -This is the last extent in the file. A mapping attempt past this
> -extent will return nothing.
> +This is generally the last extent in the file. A mapping attempt past this
> +extent may return nothing. In some implementations this flag is also set on
> +the last dataset queried by the user (via fiemap->fm_length).
>  
>  * FIEMAP_EXTENT_UNKNOWN
>  The location of this extent is currently unknown. This may indicate
> -- 
> 2.21.0
> 
