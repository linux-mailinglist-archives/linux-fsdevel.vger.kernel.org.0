Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35E3FB71D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 19:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfKMSTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 13:19:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46030 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKMSTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:19:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADI97jv110780;
        Wed, 13 Nov 2019 18:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=QqPLR23WbtLLmBLv1Y/qMpibvkpOaVLJ71YqnsOGErk=;
 b=Bs4Ay0SbJRQz44r+iYu8kbiAT0IpoBiCDnukqLvyTDw784iMccDyO/YGpH1zYxz9r4T2
 AvkMQDevx/10faleSSYf/eenNzt6qfkS0IkpKXTR5RRluFTDDZt5SORDZsed+M0JtoFA
 f1N2Dpz4rvd2L70vpso4VLdPRXP2Ozt5S3a5rsjzvhB/8CmrQ0awcsWiNYZ28XduWeyC
 F279alDiCS/WyWkG/dzO0j318w7eIz6+G9iGUHdoUDigTLDGZ8ZBiw8OtdqaXAICdnN8
 344t3/foyIUJ92MkZBauI0YAAxPMG8Kw0k7vKyGcIiyI5wItzJN70lnRfaAT/5J5LkhM uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2w5mvtxckr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 18:19:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADIDebh006778;
        Wed, 13 Nov 2019 18:19:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2w7vbdatdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 18:19:14 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xADIJEFd002374;
        Wed, 13 Nov 2019 18:19:14 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Nov 2019 10:19:13 -0800
Date:   Wed, 13 Nov 2019 21:19:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] staging: exfat: Collapse redundant return code
 translations
Message-ID: <20191113181904.GD3284@kadam>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
 <20191112021000.42091-9-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112021000.42091-9-Valdis.Kletnieks@vt.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 09:09:56PM -0500, Valdis Kletnieks wrote:
> Now that we no longer use odd internal return codes, we can
> heave the translation code over the side, and just pass the
> error code back up the call chain.
> 
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> ---
>  drivers/staging/exfat/exfat_super.c | 92 +++++------------------------
>  1 file changed, 14 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
> index 5d538593b5f6..a97a61a60517 100644
> --- a/drivers/staging/exfat/exfat_super.c
> +++ b/drivers/staging/exfat/exfat_super.c
> @@ -650,7 +650,7 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
>  	struct uni_name_t uni_name;
>  	struct super_block *sb = inode->i_sb;
>  	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
> -	int ret;
> +	int ret = 0;

Why are you adding this initializer?  It just disables static analysis
warnings about uninitialized variables and it creates a static analysis
warning about unused assignments.

>  
>  	/* check the validity of pointer parameters */
>  	if (!fid || !path || (*path == '\0'))

[ snip ]

> @@ -3161,12 +3102,7 @@ static int exfat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
>  
>  	err = ffsMapCluster(inode, clu_offset, &cluster);
>  
> -	if (err) {
> -		if (err == -ENOSPC)
> -			return -ENOSPC;
> -		else
> -			return -EIO;
> -	} else if (cluster != CLUSTER_32(~0)) {
> +	if (!err && (cluster != CLUSTER_32(~0))) {
>  		*phys = START_SECTOR(cluster) + sec_offset;
>  		*mapped_blocks = p_fs->sectors_per_clu - sec_offset;
>  	}


If ffsMapCluster() fails then we return success now.  Is that
intentional?

regards,
dan carpener

