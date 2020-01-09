Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8F71363BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 00:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgAIXX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 18:23:28 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:49059 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgAIXX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:23:28 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200109232325epoutp04500a0d60796ef4d3894a86efca83098b~oW2-6qpVA2265222652epoutp04R
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2020 23:23:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200109232325epoutp04500a0d60796ef4d3894a86efca83098b~oW2-6qpVA2265222652epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578612205;
        bh=XS6WVKmPd78SLOqbRxJQGmEqQFFIzyRpnGXetgRINKM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=oseDwGskdZ6l8Ff7viKJIaVbVoU28tu4b6YScSEFuKMRabEBPdc7vKADmKi4XRKQN
         4kTKmvtgh1CK3AhtdAD+w0sWalkn7cBC/g2kqqiDL5qsiCzO7RnFaVwA+sKa1sSRpj
         A+RwEFHb08gqNh4bO3OyztEqgfXRKBoABbtOGa3A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200109232325epcas1p1302e6b3038cdb5d9817cdb722765e6c7~oW2-e8XVX2942629426epcas1p1v;
        Thu,  9 Jan 2020 23:23:25 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47v2H03knvzMqYkb; Thu,  9 Jan
        2020 23:23:24 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.AA.52419.CE5B71E5; Fri, 10 Jan 2020 08:23:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200109232324epcas1p1033a8f381a7eaee98076d2aa82f321ba~oW2_LqUAA2941829418epcas1p1C;
        Thu,  9 Jan 2020 23:23:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200109232324epsmtrp20c8458fbaee2f5a114d10aecfae0a592~oW2_K-Rzn0042400424epsmtrp2a;
        Thu,  9 Jan 2020 23:23:24 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-99-5e17b5eca51a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.56.10238.BE5B71E5; Fri, 10 Jan 2020 08:23:23 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200109232323epsmtip113ee34fb91d7f913006d27f32d680367~oW2_Ay-BA1335813358epsmtip1k;
        Thu,  9 Jan 2020 23:23:23 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Christoph Hellwig'" <hch@lst.de>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>,
        <pali.rohar@gmail.com>
In-Reply-To: <20200108175044.GA14009@lst.de>
Subject: RE: [PATCH v9 03/13] exfat: add inode operations
Date:   Fri, 10 Jan 2020 08:23:23 +0900
Message-ID: <001801d5c743$c9c058e0$5d410aa0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJSGi/S1M7UFBjz5N3SW71o+eawLwJF6SzsAfeZsmAAg5yyM6bESf1A
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRDN1223i1hdCsIEr7oGFSPQUgurAeIVbBRNiYkoKrihmxbslW5r
        RPkBGA7REPEfFfBAMYJaUrmPEFEgeIsmCIr6A8+gKHgRjLVlIfLvzZs382a+bwhM6sSDiXST
        jbWaGAOFzxE23A6Vh43UB6XICycX0ccrnTh9taZLQPcPDWJ0W3uvkH7aUobTJfcmBXTd3zsi
        um/0q3ADoW52DInVHeXXxOrWgWxcXVxXjdTjriXqzsYRXIMnG2L0LKNlrTLWlGbWppt0sdT2
        XambU1VRckWYYh0dTclMjJGNpbYkaMLi0w2egSjZYcZg91AahuOoiLgYq9luY2V6M2eLpViL
        1mBRyC3hHGPk7CZdeJrZuF4hl0eqPMqDBn1F7zNkKVccGe1+Jc5GeSuKkA8B5FpoPP0HFaE5
        hJRsQjA2WIPzwRiC645aAR/8RJDX1C2eKTlf6hbyiXYEt6pGp+s/eupzXiKvCifD4O+fDtyL
        A8gVcH8iX+wVYeRdBO76kqmED7kGil39U239yXXQnJvj8SMIIRkCJ0t3eGmJh35wdUTEYz/o
        LR0WejFGLoXGz2UYP5EMJt5WiXiveHh/85yA1wTA2RP5mNcXSDcObZXPp1fYApfcwziP/eFT
        T900HwzjX9px7wxAHoNvHdP9CxF8+BXLYyUMOGtFXglGhoKzJYKnl0HzZDnibefBlx+nRHwX
        CRTmS3lJCBT33RbweCEUFXwVn0aUY9ZijlmLOWYt4Phvdh4Jq1Ega+GMOpZTWJSzP9uFpo51
        dXQTqn2Y0IlIAlFzJXr/oBSpiDnMZRo7ERAYFSDpeh6YIpVomcyjrNWcarUbWK4TqTzPXoIF
        L0gze07fZEtVqCKVSiW9Nio6SqWkgiTE7ycHpKSOsbGHWNbCWmfqBIRPcDbKfFe5f5sqqcFv
        +cqMbY8ubhyOc0ZW+e6rdRjt3/Pe2DTz9+canwh8RQWji3dWdEWH+rYmXV7WG9dX8S7w3H2J
        auy17kVN0qOEZNX7fWU10u49n1N2D626sDVwxw1jf3hGaYEg8cxjS9b4RPbuvWN6edadK4mu
        ntZNzomeLFPGyZb4CErI6RnFaszKMf8Aoo3jN8IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnO7rreJxBjdeWFo0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBYTT/9mstjy7wirxaX3H1gcODx2zrrL7rF/7hp2j903G9g8+ras
        YvT4vEnO49D2N2wBbFFcNimpOZllqUX6dglcGfNOXmEsmGtY8f7YPfYGxla1LkZODgkBE4kF
        M/+zdDFycQgJ7GaUuPqwlxkiIS1x7MQZIJsDyBaWOHy4GKLmOaPE8h3tLCA1bAK6Ev/+7GcD
        sUUE1CTO/GxjByliFrjEKDGht4kZouM+o8SJ82fBqjgFdCT6Nl1nB7GFBSwldjY1MoFsYBFQ
        leie6QsS5gUKn135hhXCFpQ4OfMJC0gJs4CeRNtGRpAws4C8xPa3c6DuVJD4+XQZK8QNbhLP
        N89ngqgRkZjd2cY8gVF4FpJJsxAmzUIyaRaSjgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz
        0vWS83M3MYLjS0tzB+PlJfGHGAU4GJV4eDOExeOEWBPLiitzDzFKcDArifAevSEWJ8SbklhZ
        lVqUH19UmpNafIhRmoNFSZz3ad6xSCGB9MSS1OzU1ILUIpgsEwenVAPjgpaUHcV6L903/K/6
        P+fcnetsm5ivHqv5U7tJWMjgU9HCovjgbsNTz3bON9pR/lb0mFfO+wn7LKdpXW6dPZepK9Jr
        15n7mxS3cSpMj+7V2OnlF3Ojsbv+wc37s15tsjk6Z8GW7bP3zlSabloa7CP9kautpcLHStHt
        uYzgwv96fAd3z7oZXsLvosRSnJFoqMVcVJwIAHccHCWrAgAA
X-CMS-MailID: 20200109232324epcas1p1033a8f381a7eaee98076d2aa82f321ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082402epcas1p47cdc0873473f99c5d81f56865bb94abc
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082402epcas1p47cdc0873473f99c5d81f56865bb94abc@epcas1p4.samsung.com>
        <20200102082036.29643-4-namjae.jeon@samsung.com>
        <20200108175044.GA14009@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +#include "exfat_fs.h"
> > +
> > +/* 2-level option flag */
> > +enum {
> > +	BMAP_NOT_CREATE,
> > +	BMAP_ADD_CLUSTER,
> > +};
> 
> I looked at how this flag is used and found the get_block code a little
> confusing.  Let me know what you think of the following untested patch to
> streamline that area:
I will check and test this patch.

Thanks!

> 
> 
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c index
> c2b04537cb24..ccf9700c6a55 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -17,12 +17,6 @@
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> 
> -/* 2-level option flag */
> -enum {
> -	BMAP_NOT_CREATE,
> -	BMAP_ADD_CLUSTER,
> -};
> -
>  static int __exfat_write_inode(struct inode *inode, int sync)  {
>  	int ret = -EIO;
> @@ -298,109 +292,91 @@ static int exfat_map_cluster(struct inode *inode,
> unsigned int clu_offset,
>  	return 0;
>  }
> 
> -static int exfat_bmap(struct inode *inode, sector_t sector, sector_t
> *phys,
> -		unsigned long *mapped_blocks, int *create)
> +static int exfat_map_new_buffer(struct exfat_inode_info *ei,
> +		struct buffer_head *bh, loff_t pos)
>  {
> -	struct super_block *sb = inode->i_sb;
> -	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> -	sector_t last_block;
> -	unsigned int cluster, clu_offset, sec_offset;
> -	int err = 0;
> -
> -	*phys = 0;
> -	*mapped_blocks = 0;
> -
> -	last_block = EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode), sb);
> -	if (sector >= last_block && *create == BMAP_NOT_CREATE)
> -		return 0;
> -
> -	/* Is this block already allocated? */
> -	clu_offset = sector >> sbi->sect_per_clus_bits;  /* cluster offset
> */
> -
> -	err = exfat_map_cluster(inode, clu_offset, &cluster,
> -		*create & BMAP_ADD_CLUSTER);
> -	if (err) {
> -		if (err != -ENOSPC)
> -			return -EIO;
> -		return err;
> -	}
> -
> -	if (cluster != EXFAT_EOF_CLUSTER) {
> -		/* sector offset in cluster */
> -		sec_offset = sector & (sbi->sect_per_clus - 1);
> -
> -		*phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
> -		*mapped_blocks = sbi->sect_per_clus - sec_offset;
> -	}
> +	if (buffer_delay(bh) && pos > ei->i_size_aligned)
> +		return -EIO;
> +	set_buffer_new(bh);
> 
> -	if (sector < last_block)
> -		*create = BMAP_NOT_CREATE;
> +	/*
> +	 * Adjust i_size_aligned if i_size_ondisk is bigger than it.
> +	 * (i.e. non-DA)
> +	 */
> +	if (ei->i_size_ondisk > ei->i_size_aligned)
> +		ei->i_size_aligned = ei->i_size_ondisk;
>  	return 0;
>  }
> 
>  static int exfat_get_block(struct inode *inode, sector_t iblock,
>  		struct buffer_head *bh_result, int create)  {
> +	struct exfat_inode_info *ei = EXFAT_I(inode);
>  	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
>  	int err = 0;
> -	unsigned long mapped_blocks;
> -	sector_t phys;
> +	unsigned long mapped_blocks = 0;
> +	unsigned int cluster, sec_offset;
> +	sector_t last_block;
> +	sector_t phys = 0;
>  	loff_t pos;
> -	int bmap_create = create ? BMAP_ADD_CLUSTER : BMAP_NOT_CREATE;
> +
> +	mutex_lock(&sbi->s_lock);
> +	last_block = EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode), sb);
> +	if (iblock >= last_block && !create)
> +		goto done;
> 
> -	mutex_lock(&EXFAT_SB(sb)->s_lock);
> -	err = exfat_bmap(inode, iblock, &phys, &mapped_blocks,
> &bmap_create);
> +	/* Is this block already allocated? */
> +	err = exfat_map_cluster(inode, iblock >> sbi->sect_per_clus_bits,
> +				&cluster, create);
>  	if (err) {
> -		if (err != -ENOSPC)
> -			exfat_fs_error_ratelimit(sb,
> -				"failed to bmap (inode : %p iblock : %llu,
> err : %d)",
> -				inode, (unsigned long long)iblock, err);
> +		if (err == -ENOSPC)
> +			goto unlock_ret;
> +
> +		exfat_fs_error_ratelimit(sb,
> +			"failed to bmap (inode : %p iblock : %llu, err :
%d)",
> +			inode, (unsigned long long)iblock, err);
>  		goto unlock_ret;
>  	}
> 
> -	if (phys) {
> -		max_blocks = min(mapped_blocks, max_blocks);
> -
> -		/* Treat newly added block / cluster */
> -		if (bmap_create || buffer_delay(bh_result)) {
> -			/* Update i_size_ondisk */
> -			pos = EXFAT_BLK_TO_B((iblock + 1), sb);
> -			if (EXFAT_I(inode)->i_size_ondisk < pos)
> -				EXFAT_I(inode)->i_size_ondisk = pos;
> -
> -			if (bmap_create) {
> -				if (buffer_delay(bh_result) &&
> -				    pos > EXFAT_I(inode)->i_size_aligned) {
> -					exfat_fs_error(sb,
> -						"requested for bmap out of
> range(pos : (%llu) > i_size_aligned(%llu)\n",
> -						pos,
> -
EXFAT_I(inode)->i_size_aligned);
> -					err = -EIO;
> -					goto unlock_ret;
> -				}
> -				set_buffer_new(bh_result);
> -
> -				/*
> -				 * adjust i_size_aligned if i_size_ondisk is
> -				 * bigger than it. (i.e. non-DA)
> -				 */
> -				if (EXFAT_I(inode)->i_size_ondisk >
> -				    EXFAT_I(inode)->i_size_aligned) {
> -					EXFAT_I(inode)->i_size_aligned =
> -
EXFAT_I(inode)->i_size_ondisk;
> -				}
> -			}
> +	if (cluster == EXFAT_EOF_CLUSTER)
> +		goto done;
> +
> +	/* sector offset in cluster */
> +	sec_offset = iblock & (sbi->sect_per_clus - 1);
> +
> +	phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
> +	mapped_blocks = sbi->sect_per_clus - sec_offset;
> +	max_blocks = min(mapped_blocks, max_blocks);
> 
> -			if (buffer_delay(bh_result))
> -				clear_buffer_delay(bh_result);
> +	/* Treat newly added block / cluster */
> +	if (iblock < last_block)
> +		create = 0;
> +
> +	if (create || buffer_delay(bh_result)) {
> +		pos = EXFAT_BLK_TO_B((iblock + 1), sb);
> +		if (ei->i_size_ondisk < pos)
> +			ei->i_size_ondisk = pos;
> +	}
> +
> +	if (create) {
> +		err = exfat_map_new_buffer(ei, bh_result, pos);
> +		if (err) {
> +			exfat_fs_error(sb,
> +				"requested for bmap out of range(pos :
(%llu) >
> i_size_aligned(%llu)\n",
> +				pos, ei->i_size_aligned);
> +			goto unlock_ret;
>  		}
> -		map_bh(bh_result, sb, phys);
>  	}
> 
> +	if (buffer_delay(bh_result))
> +		clear_buffer_delay(bh_result);
> +	map_bh(bh_result, sb, phys);
> +done:
>  	bh_result->b_size = EXFAT_BLK_TO_B(max_blocks, sb);
>  unlock_ret:
> -	mutex_unlock(&EXFAT_SB(sb)->s_lock);
> +	mutex_unlock(&sbi->s_lock);
>  	return err;
>  }
> 

