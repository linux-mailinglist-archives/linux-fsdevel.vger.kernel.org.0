Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768C050F48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfFXOyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:54:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42432 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFXOyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:54:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OEmwp4147762;
        Mon, 24 Jun 2019 14:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jsA94D5m4Ze62YKxeT7Wgc5dt4qC2g+k5ejRr2p+ZzM=;
 b=bi3Exnwv/Jz/tyJXws1fLHCOk1vpMpP155SRKzjzYlEuSnO2jKhtfUpq1Ty5oB//iWcR
 VZitbgG7zsm5PDaW/TK6EzEq/Dfl27mxnIXNXrOpLysPm2i16xXbPfAHoejGWA9lYBoF
 kH7pn8nR4XDLqn+G9B0PKChMKri69bIUJnlUcV66lwPbMmHfLX5h3b08Hf+sDW5Gnkz8
 h/++1oQV46Q6a5qN/V+0B+A0Imn5jU/stApXKMl4bx27O6Q+0HeVqENuEvEzIjvvufPV
 b6Ngd2DZf17Wzupfpde9AXddmlJG0OTNvdFJOO3AkLFEXb0xKFHdfv+UwPND5YqDWBBV Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t9c9pevmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 14:53:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OErRp1153186;
        Mon, 24 Jun 2019 14:53:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9acbj2pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 14:53:43 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OErgFd021945;
        Mon, 24 Jun 2019 14:53:42 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 07:53:42 -0700
Date:   Mon, 24 Jun 2019 07:53:41 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] xfs: fix a comment typo in xfs_submit_ioend
Message-ID: <20190624145341.GG5387@magnolia>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-4-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240121
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:52:44AM +0200, Christoph Hellwig wrote:
> The fail argument is long gone, update the comment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 9cceb90e77c5..dc60aec0c5a7 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -626,7 +626,7 @@ xfs_map_blocks(
>   * reference to the ioend to ensure that the ioend completion is only done once
>   * all bios have been submitted and the ioend is really done.
>   *
> - * If @fail is non-zero, it means that we have a situation where some part of
> + * If @status is non-zero, it means that we have a situation where some part of
>   * the submission process has failed after we have marked paged for writeback
>   * and unlocked them. In this situation, we need to fail the bio and ioend
>   * rather than submit it to IO. This typically only happens on a filesystem
> -- 
> 2.20.1
> 
