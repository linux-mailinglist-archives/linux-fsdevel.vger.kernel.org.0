Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C2880744
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 18:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbfHCQe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 12:34:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53818 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387950AbfHCQe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 12:34:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x73GY6YL044276;
        Sat, 3 Aug 2019 16:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=/sogLQjCmkNupmjnOE6aMR75fUaK1Z3VgipDsdXq3Gs=;
 b=dFOSXGexgfYLYdFn8Ib9HNcllcfb27s4o/4LHntbIC63JU4y4wxYFmPEA1MvvLtgMZB8
 NHfrdC6MxC4nq2EjA5ja5TjxBrbv/79nXSWxyNjWlesR4jbPv6eoEaF3rsgfZpMDnOIA
 6/Y8EwLdPIVrSFh9DdM0rlc+HoP7ufEhxiKnKDq0Ufe59rKj93h4sRRwpIxPgn5pFJCW
 Vqfqu6nfNImMwmmcV9vcXnsW6J6dFgN6SM7Jr5wCF7e50EDM65dRV8vhjI11BFneZ7dG
 kTkJp4dgwXG2MZtUYj/WSCQz9VH6Lfj0YqY8AP4+p35Aks8xPDQIhjMce+du34vSvRoE Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u52wqsjj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Aug 2019 16:34:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x73GWdRb103865;
        Sat, 3 Aug 2019 16:34:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2u50aapc5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Aug 2019 16:34:43 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x73GYeDH024380;
        Sat, 3 Aug 2019 16:34:41 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 03 Aug 2019 09:34:39 -0700
Date:   Sat, 3 Aug 2019 09:34:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Fix trivial typo
Message-ID: <20190803163439.GL7138@magnolia>
References: <20190803135502.19572-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803135502.19572-1-agruenba@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9338 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908030197
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9338 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908030197
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 03, 2019 at 03:55:02PM +0200, Andreas Gruenbacher wrote:
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ba0511131868..4ab1ec0a282f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1258,7 +1258,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
>   * all bios have been submitted and the ioend is really done.
>   *
>   * If @error is non-zero, it means that we have a situation where some part of
> - * the submission process has failed after we have marked paged for writeback
> + * the submission process has failed after we have marked pages for writeback
>   * and unlocked them. In this situation, we need to fail the bio and ioend
>   * rather than submit it to IO. This typically only happens on a filesystem
>   * shutdown.
> -- 
> 2.20.1
> 
