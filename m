Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCE614A351
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 12:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgA0Lzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 06:55:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35430 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgA0Lzv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:55:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RBth74032921;
        Mon, 27 Jan 2020 11:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ALjefakC3CGXO1zV8vhhyOxpEu7eY/3098B4TpY59K8=;
 b=rmxQ6k+GEUBba46cb3Wm7G+DcSvIqRxOI6ee5Wr8T8PtCyRlF1r0KGMgAECufQlaSXjI
 cJzBZlUCWvx4oq7Vwzepa/LHWXyLC0wsk0WE7cm5O7+QX3QUbVQzlMUFohrVnEK/iOCU
 OqDUrJ8c78EVLCkVIvWN6zu4HSpMKKK5GOwriP5Fi/WxS9yD7ZDB/J1D1v5/gmar0C+a
 DHmQO14AQE7O/1OaKEaZQfrvUzpo6FHJFUktALYPj6oqsQeFvwGJdtKjfOqjM1Z1dcU0
 gVteot5WZggVUpfYNtotONsbEK64HFQOrsogNpVf7uzHrFAF3WiD/GhQ61CWN2el7LLQ OA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xrd3txv9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 11:55:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RBsErs111818;
        Mon, 27 Jan 2020 11:55:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xryu988dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 11:55:43 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00RBtfUm026923;
        Mon, 27 Jan 2020 11:55:41 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 03:55:40 -0800
Date:   Mon, 27 Jan 2020 14:55:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 07/22] staging: exfat: Rename variable "MilliSecond" to
 "milli_second"
Message-ID: <20200127115530.GZ1847@kadam>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
 <20200127101343.20415-8-pragat.pandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127101343.20415-8-pragat.pandya@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270102
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 03:43:28PM +0530, Pragat Pandya wrote:
> Change all the occurrences of "MilliSecond" to "milli_second" in exfat.
> 
> Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
> ---
>  drivers/staging/exfat/exfat.h       |  2 +-
>  drivers/staging/exfat/exfat_super.c | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
> index 85fbea44219a..5c207d715f44 100644
> --- a/drivers/staging/exfat/exfat.h
> +++ b/drivers/staging/exfat/exfat.h
> @@ -228,7 +228,7 @@ struct date_time_t {
>  	u16      hour;
>  	u16      minute;
>  	u16      second;
> -	u16      MilliSecond;
> +	u16      milli_second;

Normally we would just call it "ms".

regards,
dan carpenter

