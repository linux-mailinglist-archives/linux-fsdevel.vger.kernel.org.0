Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743C87C681
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfGaP03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 11:26:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37708 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfGaP02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:26:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VF8iI6170025;
        Wed, 31 Jul 2019 15:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=mV7nbjvIRvDgxa2lrrPqvm3heI2DftpFK7gkBxFjpiY=;
 b=lvaweLWZEL5QjzH6jvAovs8MFykTjZ9CzizLMopc22tiSEQxCK0NGtryZmIPkVZ/TaAq
 Y3R7hLMQzJ4DWLU25JgCNC0LinYzdnCxfyqWYS5pH60y6PDt7fw07pn1TGlb6xi8dir5
 7ar9gT/JwUXgt/g+X+Gd312iYC7xdZr73EjQRtsETeB1Cqp11jNRr06OocM+DHFepORh
 6iA2yEFqtY5VEB3nS0dyrt+lOfw6fjUDusyrMfUOt2q19gUJnKFSXcDJuh0oe/S4SkAM
 8vgiAVeVy/rdzPc2Ks2Sti96mHbcMvuKf/Vv/+4E2TwP4NH74DUEK/1cHGNY5T9WtC7P TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u0f8r5xvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 15:26:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VFD1OJ093684;
        Wed, 31 Jul 2019 15:26:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2u38fb5e13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 15:26:17 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6VFQDRE000330;
        Wed, 31 Jul 2019 15:26:13 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 08:26:12 -0700
Date:   Wed, 31 Jul 2019 08:26:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 09/20] ext4: Initialize timestamps limits
Message-ID: <20190731152609.GB7077@magnolia>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-10-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730014924.2193-10-deepa.kernel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907310156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310156
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:49:13PM -0700, Deepa Dinamani wrote:
> ext4 has different overflow limits for max filesystem
> timestamps based on the extra bytes available.
> 
> The timestamp limits are calculated according to the
> encoding table in
> a4dad1ae24f85i(ext4: Fix handling of extended tv_sec):
> 
> * extra  msb of                         adjust for signed
> * epoch  32-bit                         32-bit tv_sec to
> * bits   time    decoded 64-bit tv_sec  64-bit tv_sec      valid time range
> * 0 0    1    -0x80000000..-0x00000001  0x000000000   1901-12-13..1969-12-31
> * 0 0    0    0x000000000..0x07fffffff  0x000000000   1970-01-01..2038-01-19
> * 0 1    1    0x080000000..0x0ffffffff  0x100000000   2038-01-19..2106-02-07
> * 0 1    0    0x100000000..0x17fffffff  0x100000000   2106-02-07..2174-02-25
> * 1 0    1    0x180000000..0x1ffffffff  0x200000000   2174-02-25..2242-03-16
> * 1 0    0    0x200000000..0x27fffffff  0x200000000   2242-03-16..2310-04-04
> * 1 1    1    0x280000000..0x2ffffffff  0x300000000   2310-04-04..2378-04-22
> * 1 1    0    0x300000000..0x37fffffff  0x300000000   2378-04-22..2446-05-10

My recollection of ext4 has gotten rusty, so this could be a bogus
question:

Say you have a filesystem with s_inode_size > 128 where not all of the
ondisk inodes have been upgraded to i_extra_isize > 0 and therefore
don't support nanoseconds or times beyond 2038.  I think this happens on
ext3 filesystems that reserved extra space for inode attrs that are
subsequently converted to ext4?

In any case, that means that you have some inodes that support 34-bit
tv_sec and some inodes that only support 32-bit tv_sec.  For the inodes
with 32-bit tv_sec, I think all that happens is that a large timestamp
will be truncated further, right?

And no mount time warning because at least /some/ of the inodes are
ready to go for the next 30 years?

--D

> Note that the time limits are not correct for deletion times.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Cc: tytso@mit.edu
> Cc: adilger.kernel@dilger.ca
> Cc: linux-ext4@vger.kernel.org
> ---
>  fs/ext4/ext4.h  |  4 ++++
>  fs/ext4/super.c | 17 +++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1cb67859e051..3f13cf12ae7f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1631,6 +1631,10 @@ static inline void ext4_clear_state_flags(struct ext4_inode_info *ei)
>  
>  #define EXT4_GOOD_OLD_INODE_SIZE 128
>  
> +#define EXT4_EXTRA_TIMESTAMP_MAX	(((s64)1 << 34) - 1  + S32_MIN)
> +#define EXT4_NON_EXTRA_TIMESTAMP_MAX	S32_MAX
> +#define EXT4_TIMESTAMP_MIN		S32_MIN
> +
>  /*
>   * Feature set definitions
>   */
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4079605d437a..3ea2d60f33aa 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4035,8 +4035,21 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  			       sbi->s_inode_size);
>  			goto failed_mount;
>  		}
> -		if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE)
> -			sb->s_time_gran = 1 << (EXT4_EPOCH_BITS - 2);
> +		/*
> +		 * i_atime_extra is the last extra field available for [acm]times in
> +		 * struct ext4_inode. Checking for that field should suffice to ensure
> +		 * we have extra space for all three.
> +		 */
> +		if (sbi->s_inode_size >= offsetof(struct ext4_inode, i_atime_extra) +
> +			sizeof(((struct ext4_inode *)0)->i_atime_extra)) {
> +			sb->s_time_gran = 1;
> +			sb->s_time_max = EXT4_EXTRA_TIMESTAMP_MAX;
> +		} else {
> +			sb->s_time_gran = NSEC_PER_SEC;
> +			sb->s_time_max = EXT4_NON_EXTRA_TIMESTAMP_MAX;
> +		}
> +
> +		sb->s_time_min = EXT4_TIMESTAMP_MIN;
>  	}
>  
>  	sbi->s_desc_size = le16_to_cpu(es->s_desc_size);
> -- 
> 2.17.1
> 
