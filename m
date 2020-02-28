Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E4C173B5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgB1P03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:26:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47652 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgB1P03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:26:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SFMkA2164511;
        Fri, 28 Feb 2020 15:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=R1+8/rDEhrQ02CuBBSRZR7/oyjwRNIrTokda7GqTRL0=;
 b=p4/XoVRS/AYWH2cOB9La5DuZGjShnHNfaE2l8YWfhyIkhoCPLjG8o9xYm6eW8FaXWpEu
 I+6CyC50Hv9ks2K+HeOdp9H82rgywh3SS4sqTomupK3ylqLOZmGnqNjSYtaCZKJJSz4a
 5941mXfCkSPAaxRkT109ewq7HSklWIVlWcoZHkGTOcmkuIr7Z9uhcjB6poK4qQckwww7
 r/h5A45obm/V/NjJ1dUTmZReib/7t00GpvxJDvirTok2Uv6dJ075QRMqWrcYykq9iMt6
 oQWpZnDHBu38JjSSlWM1p1DchrqVUj3AOcsWk4M44H3LQcm0RbS45ft5QdtWYVweQQ9H Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2ydct3kfx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 15:26:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SFMQEh084407;
        Fri, 28 Feb 2020 15:26:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ydcsepg2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 15:26:16 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01SFQEO4014157;
        Fri, 28 Feb 2020 15:26:14 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 07:26:14 -0800
Date:   Fri, 28 Feb 2020 07:26:14 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com
Subject: Re: [PATCHv5 1/6] ext4: Add IOMAP_F_MERGED for non-extent based
 mapping
Message-ID: <20200228152614.GF8036@magnolia>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <a4764c91c08c16d4d4a4b36defb2a08625b0e9b3.1582880246.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4764c91c08c16d4d4a4b36defb2a08625b0e9b3.1582880246.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280122
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:56:54PM +0530, Ritesh Harjani wrote:
> IOMAP_F_MERGED needs to be set in case of non-extent based mapping.
> This is needed in later patches for conversion of ext4_fiemap to use iomap.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Seems reasonable,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/ext4/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d035acab5b2a..6cf3b969dc86 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3335,6 +3335,10 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>  	iomap->offset = (u64) map->m_lblk << blkbits;
>  	iomap->length = (u64) map->m_len << blkbits;
>  
> +	if ((map->m_flags & EXT4_MAP_MAPPED) &&
> +	    !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		iomap->flags |= IOMAP_F_MERGED;
> +
>  	/*
>  	 * Flags passed to ext4_map_blocks() for direct I/O writes can result
>  	 * in m_flags having both EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits
> -- 
> 2.21.0
> 
