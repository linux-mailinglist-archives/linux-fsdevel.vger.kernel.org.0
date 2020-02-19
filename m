Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0460C1660B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 16:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgBTPOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 10:14:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728264AbgBTPOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:14:39 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KF9gJZ075854
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 10:14:38 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y93kg4h3w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 10:14:38 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Thu, 20 Feb 2020 15:14:36 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Feb 2020 15:14:35 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01KFEYap53805128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 15:14:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C1B711C07B;
        Thu, 20 Feb 2020 15:14:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6242611C058;
        Thu, 20 Feb 2020 15:14:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.61.89])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Feb 2020 15:14:33 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs: ensure that the inode uid/gid match values match the icdinode ones
Date:   Wed, 19 Feb 2020 20:17:59 +0530
Organization: IBM
In-Reply-To: <20200218210020.40846-2-hch@lst.de>
References: <20200218210020.40846-1-hch@lst.de> <20200218210020.40846-2-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 20022015-0020-0000-0000-000003ABF918
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022015-0021-0000-0000-00002203FF53
Message-Id: <17408386.h8XSfVsPT9@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_04:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1011 phishscore=0 mlxlogscore=626 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=1 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200113
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, February 19, 2020 2:30 AM Christoph Hellwig wrote: 
> Instead of only synchronizing the uid/gid values in xfs_setup_inode,
> ensure that they always match to prepare for removing the icdinode
> fields.
>

The changes indeed keep the uid and gid values the same across icdinode and
vfs inode.

Reviewed-by: Chandan Rajendra <chandanrlinux@gmail.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/libxfs/xfs_inode_buf.c | 2 ++
>  fs/xfs/xfs_icache.c           | 4 ++++
>  fs/xfs/xfs_inode.c            | 8 ++++++--
>  fs/xfs/xfs_iops.c             | 3 ---
>  4 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
> index 8afacfe4be0a..cc4efd34843a 100644
> --- a/fs/xfs/libxfs/xfs_inode_buf.c
> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
> @@ -223,7 +223,9 @@ xfs_inode_from_disk(
> 
>  	to->di_format = from->di_format;
>  	to->di_uid = be32_to_cpu(from->di_uid);
> +	inode->i_uid = xfs_uid_to_kuid(to->di_uid);
>  	to->di_gid = be32_to_cpu(from->di_gid);
> +	inode->i_gid = xfs_gid_to_kgid(to->di_gid);
>  	to->di_flushiter = be16_to_cpu(from->di_flushiter);
> 
>  	/*
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 8dc2e5414276..a7be7a9e5c1a 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -289,6 +289,8 @@ xfs_reinit_inode(
>  	uint64_t	version = inode_peek_iversion(inode);
>  	umode_t		mode = inode->i_mode;
>  	dev_t		dev = inode->i_rdev;
> +	kuid_t		uid = inode->i_uid;
> +	kgid_t		gid = inode->i_gid;
> 
>  	error = inode_init_always(mp->m_super, inode);
> 
> @@ -297,6 +299,8 @@ xfs_reinit_inode(
>  	inode_set_iversion_queried(inode, version);
>  	inode->i_mode = mode;
>  	inode->i_rdev = dev;
> +	inode->i_uid = uid;
> +	inode->i_gid = gid;
>  	return error;
>  }
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index c5077e6326c7..938b0943bd95 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -812,15 +812,19 @@ xfs_ialloc(
> 
>  	inode->i_mode = mode;
>  	set_nlink(inode, nlink);
> -	ip->i_d.di_uid = xfs_kuid_to_uid(current_fsuid());
> -	ip->i_d.di_gid = xfs_kgid_to_gid(current_fsgid());
> +	inode->i_uid = current_fsuid();
> +	ip->i_d.di_uid = xfs_kuid_to_uid(inode->i_uid);
>  	inode->i_rdev = rdev;
>  	ip->i_d.di_projid = prid;
> 
>  	if (pip && XFS_INHERIT_GID(pip)) {
> +		inode->i_gid = VFS_I(pip)->i_gid;
>  		ip->i_d.di_gid = pip->i_d.di_gid;
>  		if ((VFS_I(pip)->i_mode & S_ISGID) && S_ISDIR(mode))
>  			inode->i_mode |= S_ISGID;
> +	} else {
> +		inode->i_gid = current_fsgid();
> +		ip->i_d.di_gid = xfs_kgid_to_gid(inode->i_gid);
>  	}
> 
>  	/*
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 81f2f93caec0..b818b261918f 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1304,9 +1304,6 @@ xfs_setup_inode(
>  	/* make the inode look hashed for the writeback code */
>  	inode_fake_hash(inode);
> 
> -	inode->i_uid    = xfs_uid_to_kuid(ip->i_d.di_uid);
> -	inode->i_gid    = xfs_gid_to_kgid(ip->i_d.di_gid);
> -
>  	i_size_write(inode, ip->i_d.di_size);
>  	xfs_diflags_to_iflags(inode, ip);
> 
> 


-- 
chandan



