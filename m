Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848CD166C48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 02:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgBUB0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 20:26:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49932 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgBUB0W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:26:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01L196c9176616;
        Fri, 21 Feb 2020 01:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=NXiIUJANzDUYBIecp4w2FUtQauNgIQkqo7760wOohGQ=;
 b=pFvlMA+l70YUZLCRABvkAdGcAJrFxh3YYybikt5grOvcdDZvjYwdye+8Aps1rvKkxlo5
 Njru4BMEauPjpxiiMNR5UjZ+xV0uAg1BFBdjbZVq/uHDQxypdhd3qoARfTYYJBjiLZGY
 +CnunkgM4dBLj7AaU76s5GeNX06NIeed0at9ZN6CruopQ4mJJyWs/yzz5cDAwjkUhPsY
 IayokqlHeVtLTcdhZBcD6CvdqlL+xHSbSvPA3CviJssdOHL6XXZeAR10ssaaxv6ZogPH
 t6oCQGO7XX/njrCclDWdCXnGICFA6yyYnMOOk5mBDii0TigSt379aOjolwZXhIIH+nBF AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y8udddn2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 01:26:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01L18Gdt018478;
        Fri, 21 Feb 2020 01:26:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y8udgxqef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 01:26:17 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01L1QGs7003715;
        Fri, 21 Feb 2020 01:26:16 GMT
Received: from localhost (/10.145.178.17)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 17:26:16 -0800
Date:   Thu, 20 Feb 2020 17:26:16 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs: remove the kuid/kgid conversion wrappers
Message-ID: <20200221012616.GF9506@magnolia>
References: <20200218210020.40846-1-hch@lst.de>
 <20200218210020.40846-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218210020.40846-4-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210006
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 01:00:20PM -0800, Christoph Hellwig wrote:
> Remove the XFS wrappers for converting from and to the kuid/kgid types.
> Mostly this means switching to VFS i_{u,g}id_{read,write} helpers, but
> in a few spots the calls to the conversion functions is open coded.
> To match the use of sb->s_user_ns in the helpers and other file systems,
> sb->s_user_ns is also used in the quota code.  The ACL code already does
> the conversion in a grotty layering violation in the VFS xattr code,
> so it keeps using init_user_ns for the identity mapping.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/libxfs/xfs_inode_buf.c |  8 ++++----
>  fs/xfs/xfs_acl.c              | 12 ++++++++----
>  fs/xfs/xfs_dquot.c            |  4 ++--
>  fs/xfs/xfs_inode_item.c       |  4 ++--
>  fs/xfs/xfs_itable.c           |  4 ++--
>  fs/xfs/xfs_linux.h            | 26 --------------------------
>  fs/xfs/xfs_qm.c               | 23 +++++++++--------------
>  7 files changed, 27 insertions(+), 54 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
> index bc72b575ceed..17e88a8c8353 100644
> --- a/fs/xfs/libxfs/xfs_inode_buf.c
> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
> @@ -222,8 +222,8 @@ xfs_inode_from_disk(
>  	}
>  
>  	to->di_format = from->di_format;
> -	inode->i_uid = xfs_uid_to_kuid(be32_to_cpu(from->di_uid));

Hmm.  I'm not up on my userns-fu, but right now this is effectively:

inode->i_uid = make_kuid(&init_user_ns, be32_to_cpu(from->di_uid));

> -	inode->i_gid = xfs_gid_to_kgid(be32_to_cpu(from->di_gid));
> +	i_uid_write(inode, be32_to_cpu(from->di_uid));

Whereas this is:

inode->i_uid = make_kuid(inode->i_sb->s_user_ns, be32_to_cpu(...));

What happens if s_user_ns != init_user_ns?  Isn't this a behavior
change?  Granted, it looks like many of the other filesystems use
i_uid_write so maybe we're the ones who are doing it wrong...?

> +	i_gid_write(inode, be32_to_cpu(from->di_gid));
>  	to->di_flushiter = be16_to_cpu(from->di_flushiter);
>  
>  	/*
> @@ -276,8 +276,8 @@ xfs_inode_to_disk(
>  
>  	to->di_version = from->di_version;
>  	to->di_format = from->di_format;
> -	to->di_uid = cpu_to_be32(xfs_kuid_to_uid(inode->i_uid));
> -	to->di_gid = cpu_to_be32(xfs_kgid_to_gid(inode->i_gid));
> +	to->di_uid = cpu_to_be32(i_uid_read(inode));
> +	to->di_gid = cpu_to_be32(i_gid_read(inode));
>  	to->di_projid_lo = cpu_to_be16(from->di_projid & 0xffff);
>  	to->di_projid_hi = cpu_to_be16(from->di_projid >> 16);
>  
> diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
> index cd743fad8478..e7314b525b19 100644
> --- a/fs/xfs/xfs_acl.c
> +++ b/fs/xfs/xfs_acl.c
> @@ -67,10 +67,12 @@ xfs_acl_from_disk(
>  
>  		switch (acl_e->e_tag) {
>  		case ACL_USER:
> -			acl_e->e_uid = xfs_uid_to_kuid(be32_to_cpu(ace->ae_id));
> +			acl_e->e_uid = make_kuid(&init_user_ns,
> +						 be32_to_cpu(ace->ae_id));

And I'm assuming that the "gross layering violation in the vfs xattr
code" is why it's init_user_ns here?

--D

>  			break;
>  		case ACL_GROUP:
> -			acl_e->e_gid = xfs_gid_to_kgid(be32_to_cpu(ace->ae_id));
> +			acl_e->e_gid = make_kgid(&init_user_ns,
> +						 be32_to_cpu(ace->ae_id));
>  			break;
>  		case ACL_USER_OBJ:
>  		case ACL_GROUP_OBJ:
> @@ -103,10 +105,12 @@ xfs_acl_to_disk(struct xfs_acl *aclp, const struct posix_acl *acl)
>  		ace->ae_tag = cpu_to_be32(acl_e->e_tag);
>  		switch (acl_e->e_tag) {
>  		case ACL_USER:
> -			ace->ae_id = cpu_to_be32(xfs_kuid_to_uid(acl_e->e_uid));
> +			ace->ae_id = cpu_to_be32(
> +					from_kuid(&init_user_ns, acl_e->e_uid));
>  			break;
>  		case ACL_GROUP:
> -			ace->ae_id = cpu_to_be32(xfs_kgid_to_gid(acl_e->e_gid));
> +			ace->ae_id = cpu_to_be32(
> +					from_kgid(&init_user_ns, acl_e->e_gid));
>  			break;
>  		default:
>  			ace->ae_id = cpu_to_be32(ACL_UNDEFINED_ID);
> diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
> index 3579de9306c1..711376ca269f 100644
> --- a/fs/xfs/xfs_dquot.c
> +++ b/fs/xfs/xfs_dquot.c
> @@ -829,9 +829,9 @@ xfs_qm_id_for_quotatype(
>  {
>  	switch (type) {
>  	case XFS_DQ_USER:
> -		return xfs_kuid_to_uid(VFS_I(ip)->i_uid);
> +		return i_uid_read(VFS_I(ip));
>  	case XFS_DQ_GROUP:
> -		return xfs_kgid_to_gid(VFS_I(ip)->i_gid);
> +		return i_gid_read(VFS_I(ip));
>  	case XFS_DQ_PROJ:
>  		return ip->i_d.di_projid;
>  	}
> diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
> index 83d7914556ef..f021b55a0301 100644
> --- a/fs/xfs/xfs_inode_item.c
> +++ b/fs/xfs/xfs_inode_item.c
> @@ -308,8 +308,8 @@ xfs_inode_to_log_dinode(
>  
>  	to->di_version = from->di_version;
>  	to->di_format = from->di_format;
> -	to->di_uid = xfs_kuid_to_uid(inode->i_uid);
> -	to->di_gid = xfs_kgid_to_gid(inode->i_gid);
> +	to->di_uid = i_uid_read(inode);
> +	to->di_gid = i_gid_read(inode);
>  	to->di_projid_lo = from->di_projid & 0xffff;
>  	to->di_projid_hi = from->di_projid >> 16;
>  
> diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
> index 497db4160283..d10660469884 100644
> --- a/fs/xfs/xfs_itable.c
> +++ b/fs/xfs/xfs_itable.c
> @@ -86,8 +86,8 @@ xfs_bulkstat_one_int(
>  	 */
>  	buf->bs_projectid = ip->i_d.di_projid;
>  	buf->bs_ino = ino;
> -	buf->bs_uid = xfs_kuid_to_uid(inode->i_uid);
> -	buf->bs_gid = xfs_kgid_to_gid(inode->i_gid);
> +	buf->bs_uid = i_uid_read(inode);
> +	buf->bs_gid = i_gid_read(inode);
>  	buf->bs_size = dic->di_size;
>  
>  	buf->bs_nlink = inode->i_nlink;
> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> index 8738bb03f253..bc43cd98697b 100644
> --- a/fs/xfs/xfs_linux.h
> +++ b/fs/xfs/xfs_linux.h
> @@ -163,32 +163,6 @@ struct xstats {
>  
>  extern struct xstats xfsstats;
>  
> -/* Kernel uid/gid conversion. These are used to convert to/from the on disk
> - * uid_t/gid_t types to the kuid_t/kgid_t types that the kernel uses internally.
> - * The conversion here is type only, the value will remain the same since we
> - * are converting to the init_user_ns. The uid is later mapped to a particular
> - * user namespace value when crossing the kernel/user boundary.
> - */
> -static inline uint32_t xfs_kuid_to_uid(kuid_t uid)
> -{
> -	return from_kuid(&init_user_ns, uid);
> -}
> -
> -static inline kuid_t xfs_uid_to_kuid(uint32_t uid)
> -{
> -	return make_kuid(&init_user_ns, uid);
> -}
> -
> -static inline uint32_t xfs_kgid_to_gid(kgid_t gid)
> -{
> -	return from_kgid(&init_user_ns, gid);
> -}
> -
> -static inline kgid_t xfs_gid_to_kgid(uint32_t gid)
> -{
> -	return make_kgid(&init_user_ns, gid);
> -}
> -
>  static inline dev_t xfs_to_linux_dev_t(xfs_dev_t dev)
>  {
>  	return MKDEV(sysv_major(dev) & 0x1ff, sysv_minor(dev));
> diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
> index 54dda7d982c9..de1d2c606c14 100644
> --- a/fs/xfs/xfs_qm.c
> +++ b/fs/xfs/xfs_qm.c
> @@ -326,8 +326,7 @@ xfs_qm_dqattach_locked(
>  	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
>  
>  	if (XFS_IS_UQUOTA_ON(mp) && !ip->i_udquot) {
> -		error = xfs_qm_dqattach_one(ip,
> -				xfs_kuid_to_uid(VFS_I(ip)->i_uid),
> +		error = xfs_qm_dqattach_one(ip, i_uid_read(VFS_I(ip)),
>  				XFS_DQ_USER, doalloc, &ip->i_udquot);
>  		if (error)
>  			goto done;
> @@ -335,8 +334,7 @@ xfs_qm_dqattach_locked(
>  	}
>  
>  	if (XFS_IS_GQUOTA_ON(mp) && !ip->i_gdquot) {
> -		error = xfs_qm_dqattach_one(ip,
> -				xfs_kgid_to_gid(VFS_I(ip)->i_gid),
> +		error = xfs_qm_dqattach_one(ip, i_gid_read(VFS_I(ip)),
>  				XFS_DQ_GROUP, doalloc, &ip->i_gdquot);
>  		if (error)
>  			goto done;
> @@ -1625,6 +1623,7 @@ xfs_qm_vop_dqalloc(
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  	struct inode		*inode = VFS_I(ip);
> +	struct user_namespace	*user_ns = inode->i_sb->s_user_ns;
>  	struct xfs_dquot	*uq = NULL;
>  	struct xfs_dquot	*gq = NULL;
>  	struct xfs_dquot	*pq = NULL;
> @@ -1664,7 +1663,7 @@ xfs_qm_vop_dqalloc(
>  			 * holding ilock.
>  			 */
>  			xfs_iunlock(ip, lockflags);
> -			error = xfs_qm_dqget(mp, xfs_kuid_to_uid(uid),
> +			error = xfs_qm_dqget(mp, from_kuid(user_ns, uid),
>  					XFS_DQ_USER, true, &uq);
>  			if (error) {
>  				ASSERT(error != -ENOENT);
> @@ -1688,7 +1687,7 @@ xfs_qm_vop_dqalloc(
>  	if ((flags & XFS_QMOPT_GQUOTA) && XFS_IS_GQUOTA_ON(mp)) {
>  		if (!gid_eq(inode->i_gid, gid)) {
>  			xfs_iunlock(ip, lockflags);
> -			error = xfs_qm_dqget(mp, xfs_kgid_to_gid(gid),
> +			error = xfs_qm_dqget(mp, from_kgid(user_ns, gid),
>  					XFS_DQ_GROUP, true, &gq);
>  			if (error) {
>  				ASSERT(error != -ENOENT);
> @@ -1815,8 +1814,7 @@ xfs_qm_vop_chown_reserve(
>  			XFS_QMOPT_RES_RTBLKS : XFS_QMOPT_RES_REGBLKS;
>  
>  	if (XFS_IS_UQUOTA_ON(mp) && udqp &&
> -	    xfs_kuid_to_uid(VFS_I(ip)->i_uid) !=
> -			be32_to_cpu(udqp->q_core.d_id)) {
> +	    i_uid_read(VFS_I(ip)) != be32_to_cpu(udqp->q_core.d_id)) {
>  		udq_delblks = udqp;
>  		/*
>  		 * If there are delayed allocation blocks, then we have to
> @@ -1829,8 +1827,7 @@ xfs_qm_vop_chown_reserve(
>  		}
>  	}
>  	if (XFS_IS_GQUOTA_ON(ip->i_mount) && gdqp &&
> -	    xfs_kgid_to_gid(VFS_I(ip)->i_gid) !=
> -			be32_to_cpu(gdqp->q_core.d_id)) {
> +	    i_gid_read(VFS_I(ip)) != be32_to_cpu(gdqp->q_core.d_id)) {
>  		gdq_delblks = gdqp;
>  		if (delblks) {
>  			ASSERT(ip->i_gdquot);
> @@ -1927,16 +1924,14 @@ xfs_qm_vop_create_dqattach(
>  
>  	if (udqp && XFS_IS_UQUOTA_ON(mp)) {
>  		ASSERT(ip->i_udquot == NULL);
> -		ASSERT(xfs_kuid_to_uid(VFS_I(ip)->i_uid) ==
> -			be32_to_cpu(udqp->q_core.d_id));
> +		ASSERT(i_uid_read(VFS_I(ip)) == be32_to_cpu(udqp->q_core.d_id));
>  
>  		ip->i_udquot = xfs_qm_dqhold(udqp);
>  		xfs_trans_mod_dquot(tp, udqp, XFS_TRANS_DQ_ICOUNT, 1);
>  	}
>  	if (gdqp && XFS_IS_GQUOTA_ON(mp)) {
>  		ASSERT(ip->i_gdquot == NULL);
> -		ASSERT(xfs_kgid_to_gid(VFS_I(ip)->i_gid) ==
> -			be32_to_cpu(gdqp->q_core.d_id));
> +		ASSERT(i_gid_read(VFS_I(ip)) == be32_to_cpu(gdqp->q_core.d_id));
>  
>  		ip->i_gdquot = xfs_qm_dqhold(gdqp);
>  		xfs_trans_mod_dquot(tp, gdqp, XFS_TRANS_DQ_ICOUNT, 1);
> -- 
> 2.24.1
> 
