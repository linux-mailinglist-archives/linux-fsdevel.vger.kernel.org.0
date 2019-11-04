Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8631FEDC15
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfKDKEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:04:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56622 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDKEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:04:30 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA49x22J160715;
        Mon, 4 Nov 2019 10:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=HQhP7w0962d2EwU0YsVAYVNgV4Qa8mIpU5WMSsu7f5o=;
 b=nCHWhTEnRB2yHGzxU56GxQKrJAYencv3dDWOVRAxA3TpZwqqxE5PGEHrSWlbN68VCnFF
 jR1mY5L8AxXfj+WwrcU2wxsJlznPK1X516a9aN73J4i3v6ssmNmXBsZHxr+W9U0gC0vQ
 TA0V61RMP6B1UqoQv6gDhcCNTcdxf42SfdRWlyMa+AHiYMfz5wVl6eMkpRQIDKrw3d4J
 0D1GqtL5fquwxDODgsjdMjERa98XDSIJcGMoPbG6+veIJnRlvpFKzrdYTzdjx2X1E4Kg
 DlKLHBnibRmCdR49MUAqevnYezuEArZjqIQajlRMROUzJZ3QwzbjZxJujIAJ9TxBPKAu VA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2w11rpp77u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 10:04:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA49x5dt155183;
        Mon, 4 Nov 2019 10:04:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w1k8ufw9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 10:04:25 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA4A4K6X003678;
        Mon, 4 Nov 2019 10:04:22 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 02:04:20 -0800
Date:   Mon, 4 Nov 2019 13:04:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] staging: exfat: Clean up return codes -
 FFS_SUCCESS
Message-ID: <20191104100413.GC10409@kadam>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
 <20191104014510.102356-8-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104014510.102356-8-Valdis.Kletnieks@vt.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 03, 2019 at 08:45:03PM -0500, Valdis Kletnieks wrote:
> diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
> index 467b93630d86..28a67f8139ea 100644
> --- a/drivers/staging/exfat/exfat_cache.c
> +++ b/drivers/staging/exfat/exfat_cache.c
> @@ -462,7 +462,7 @@ u8 *FAT_getblk(struct super_block *sb, sector_t sec)
>  
>  	FAT_cache_insert_hash(sb, bp);
>  
> -	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
> +	if (sector_read(sb, sec, &bp->buf_bh, 1) != 0) {

It's better to just remove the "!= 0" double negative.  != 0 should be
used when we are talking about the number zero as in "cnt != 0" and for
"strcmp(foo, bar) != 0" where it means that "foo != bar".

regards,
dan carpenter

