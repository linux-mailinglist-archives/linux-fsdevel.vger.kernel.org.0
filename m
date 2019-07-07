Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B6861777
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2019 22:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfGGUm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 16:42:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46544 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfGGUmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 16:42:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x67KeNVd130079;
        Sun, 7 Jul 2019 20:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vt3SZN0JDPBw66J952W5nQUebjM9H7IKiLkEthot7Sw=;
 b=Yowvw0VF7qQgpfBbpDM2wryc5/KQ4X/YB795dezEQmJVMfI1vdfFefcNIDibdySm5ZNQ
 /W2uanb4Vkar81azWEO+uP6Mb4+ZK2y73apVhxVmEwbRjgNqqS9zFIqbmSAnsO1TitlV
 E8CHRB2ecv2eycf8/AoIuwh07CxOYa2Jzhm5kQe8r6/Xy/sndRClfyWjBQ8rVqHxMKUj
 BmCEIGZCoHRnDwfR2x9fbKDYpYUjDgN7htFgBcv8K9tfGMkWV+aOQnGemIYw4zAIzHEo
 haNK7IF5KPE5ZsHbWQzKHRSduxLLMIz2TszE00fux5PwW/IC9F39Zy4/VyxYYWDKH+zG bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tjkkpb93f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Jul 2019 20:42:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x67KcJjD073681;
        Sun, 7 Jul 2019 20:42:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tjhpc70r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Jul 2019 20:42:14 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x67KgD3n007412;
        Sun, 7 Jul 2019 20:42:13 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jul 2019 13:42:13 -0700
Date:   Sun, 7 Jul 2019 13:42:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] f2fs: remove redundant check from
 f2fs_setflags_common()
Message-ID: <20190707204209.GK1654093@magnolia>
References: <20190701202630.43776-1-ebiggers@kernel.org>
 <20190701202630.43776-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701202630.43776-4-ebiggers@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907070289
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907070289
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 01:26:30PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that f2fs_ioc_setflags() and f2fs_ioc_fssetxattr() call the VFS
> helper functions which check for permission to change the immutable and
> append-only flags, it's no longer needed to do this check in
> f2fs_setflags_common() too.  So remove it.
> 
> This is based on a patch from Darrick Wong, but reworked to apply after
> commit 360985573b55 ("f2fs: separate f2fs i_flags from fs_flags and ext4
> i_flags").
> 
> Originally-from: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/f2fs/file.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ae1a54ecc9fccc..e8b81f6f5c2b15 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1648,19 +1648,12 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
>  static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  {
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
> -	u32 oldflags;
>  
>  	/* Is it quota file? Do not allow user to mess with it */
>  	if (IS_NOQUOTA(inode))
>  		return -EPERM;
>  
> -	oldflags = fi->i_flags;
> -
> -	if ((iflags ^ oldflags) & (F2FS_APPEND_FL | F2FS_IMMUTABLE_FL))
> -		if (!capable(CAP_LINUX_IMMUTABLE))
> -			return -EPERM;
> -
> -	fi->i_flags = iflags | (oldflags & ~mask);
> +	fi->i_flags = iflags | (fi->i_flags & ~mask);
>  
>  	if (fi->i_flags & F2FS_PROJINHERIT_FL)
>  		set_inode_flag(inode, FI_PROJ_INHERIT);
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
