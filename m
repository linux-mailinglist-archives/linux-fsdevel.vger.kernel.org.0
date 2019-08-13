Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0EE8BCBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 17:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfHMPN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 11:13:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46094 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfHMPN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:13:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DEvHkt127647;
        Tue, 13 Aug 2019 15:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=8ljovUa1ZWVSdLTaaLgVhhH70qiIcz0sPkBcLPXYzvQ=;
 b=K2vUekboN9OB3wWTJ27oaIVXXiLbAJx9dLq7givn49sPYn7yku2ZeKgM0ZcYaPH1Vqzj
 C4UYADEPLhqBlI9e9BO7IbU+VlA0ZceQeWui4qUJw9ElcOKvmIMPpaS2NnixMFPpxj57
 fEBdIplCEsy0c3ph+oaZrfqgLnJU0Y60jxZwbe8oEdvOACvj8Wi+rgT2YmN2yZtQWhdH
 EeNo9A20s8PWWRHXT7z1JCSOP6ojtQZyzF6RvVOOETAXnEamdlDgTofd2XrL4Ry/pGxc
 xhNbrUNU/Jlg++J+uRmbNaKCvyAggH/sfZFe3XXvR+M69CN04h4FPQxEWdrq9VpjrUMA Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u9nvp728f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 15:13:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DErGKH190147;
        Tue, 13 Aug 2019 15:13:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2ubwcww4hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 15:13:18 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7DFDGdY027570;
        Tue, 13 Aug 2019 15:13:16 GMT
Received: from localhost (/10.159.254.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Aug 2019 08:13:15 -0700
Date:   Tue, 13 Aug 2019 08:13:14 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: iomap: Remove fs/iomap.c record
Message-ID: <20190813151314.GC3440173@magnolia>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190813061325.16904-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813061325.16904-1-efremov@linux.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:13:25AM +0300, Denis Efremov wrote:
> Update MAINTAINERS to reflect that fs/iomap.c file
> was splitted into separate files in fs/iomap/
> 
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: linux-fsdevel@vger.kernel.org
> Fixes: cb7181ff4b1c ("iomap: move the main iteration code into a separate file")
> Signed-off-by: Denis Efremov <efremov@linux.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ec8154e4630..29514fc19b01 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8415,7 +8415,6 @@ L:	linux-xfs@vger.kernel.org
>  L:	linux-fsdevel@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>  S:	Supported
> -F:	fs/iomap.c
>  F:	fs/iomap/
>  F:	include/linux/iomap.h
>  
> -- 
> 2.21.0
> 
