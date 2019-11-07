Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF88F2472
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 02:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbfKGBop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 20:44:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38518 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732064AbfKGBop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:44:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA71iQwD165492;
        Thu, 7 Nov 2019 01:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=cn3zXXUmFy7Cq1yV6SlWOhU6ypKw5aRvkQdQRCJrNA8=;
 b=cVgenG4vrO3Qek66gbPNIxj/jnAJPSV4YSh0gepnHx9pBtFJQhfleqMjXysxLngDxX8u
 bRCOmYIJ9GS02/Gp2U8wlZHcHlBFAwKNjvyVLV7IjgkWJYAH0OlivRcWaGaNGufxMd9k
 Dxz+v1RI/JfK7/c0hWZ8faDvGMizLdR0LPcJwVzml+fO95MlpKkawi+7V+IwiqrFvTMQ
 bUKRaSzOJJn65qyxQEoZvwj7CAJyfaLkZ6pxO+VG/g2DNP6r6EKMDNVPADqQDu3oJdPJ
 Z2SRSCg2/4a8+3KGqOJLUdRgSsCPgoSVe6ftbbkzaxhQP/vLVxGjQwEKYhtLgbMRSzUP kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2w41w0trny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 01:44:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA71ctDO146722;
        Thu, 7 Nov 2019 01:44:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2w41wfw4hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 01:44:26 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA71iMee018191;
        Thu, 7 Nov 2019 01:44:23 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 17:44:22 -0800
Date:   Wed, 6 Nov 2019 17:44:20 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH 1/4] statx: define STATX_ATTR_VERITY
Message-ID: <20191107014420.GD15212@magnolia>
References: <20191029204141.145309-1-ebiggers@kernel.org>
 <20191029204141.145309-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029204141.145309-2-ebiggers@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070017
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 29, 2019 at 01:41:38PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a statx attribute bit STATX_ATTR_VERITY which will be set if the
> file has fs-verity enabled.  This is the statx() equivalent of
> FS_VERITY_FL which is returned by FS_IOC_GETFLAGS.
> 
> This is useful because it allows applications to check whether a file is
> a verity file without opening it.  Opening a verity file can be
> expensive because the fsverity_info is set up on open, which involves
> parsing metadata and optionally verifying a cryptographic signature.
> 
> This is analogous to how various other bits are exposed through both
> FS_IOC_GETFLAGS and statx(), e.g. the encrypt bit.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  include/linux/stat.h      | 3 ++-
>  include/uapi/linux/stat.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 765573dc17d659..528c4baad09146 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -33,7 +33,8 @@ struct kstat {
>  	 STATX_ATTR_IMMUTABLE |				\
>  	 STATX_ATTR_APPEND |				\
>  	 STATX_ATTR_NODUMP |				\
> -	 STATX_ATTR_ENCRYPTED				\
> +	 STATX_ATTR_ENCRYPTED |				\
> +	 STATX_ATTR_VERITY				\
>  	 )/* Attrs corresponding to FS_*_FL flags */
>  	u64		ino;
>  	dev_t		dev;
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 7b35e98d3c58b1..ad80a5c885d598 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -167,8 +167,8 @@ struct statx {
>  #define STATX_ATTR_APPEND		0x00000020 /* [I] File is append-only */
>  #define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
>  #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
> -
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
> +#define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */

Any reason why this wasn't 0x2000?

If there's a manpage update that goes with this, then...
Acked-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  
>  
>  #endif /* _UAPI_LINUX_STAT_H */
> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 
