Return-Path: <linux-fsdevel+bounces-37718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E678B9F6295
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEB6170C32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77A71991B8;
	Wed, 18 Dec 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qXAA8aPd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC135963;
	Wed, 18 Dec 2024 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517122; cv=none; b=fXaF+So6TlbXAbWFDtDFnDnRRtOXe0mJAyn87XpH0ozGStKrvINwzJY3xZCiTwpeCmFRfE8kMWSA/HLP9WfsCfepC8/ycNrmaIa2Hvvjt1XaLv8Rm1Lf6tk7qN6h6JDFqo0TdDXRCW2a5HopceXWuVa1S83VAoZSz6n/I74afqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517122; c=relaxed/simple;
	bh=QmhnLnmzMYjUj+7+RfP/nFfZHrNw57TpTiHISyrVO9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbN2YCWM+pxM4LkX+WP0G9C3alV6yt+LL7vf9/8VzTrginz/eHMvYHmzsrTPLFxjYsxSXPdGPT2P/sRyh2kXZuGA0jURvaBJSh8iMLvKU7OHnvkyRU8GLSb2S2yaosMhqfr+XT/8lwcPsyXykG7UVoSSs2lixWIojV+Cp5pbO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qXAA8aPd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI3rZ1L029992;
	Wed, 18 Dec 2024 10:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CKT5BpsROLksUYqO4gWqOe4qDhyhl5
	Je5rVJsM2+vCg=; b=qXAA8aPdY19T7xzsCJexCNgcnPXTNihCh4TWieY7zdcp0I
	NlPgYpQz8iwK8DPtAmDL6iRHaUEy9fuxaImwxekxkbpKda3Jlzl/SgRb9j5ydQ+5
	bAwP53brUgGmIyDv4q1/k25pr9ankXRJ/nB12Co5YGGYUWcMaV2x97LAMkJJaTa9
	ymzCfcFaEhYC2wSEF/wk/a/L403rRucF9iy8a8mEA2TqE2KIMm7kutntPNvnGpSR
	vXoHC8g1S6ui3t6wcXb7x9kvVwM4J2oZ2R8KZJ8+Ae2r1DonidNtRAF0bMv7eLew
	zTAkE4Gx43axASzl1g4/Q4MwoePI0yJkVVx/OQ2w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kpvgsjbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:18:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI9ClAp024015;
	Wed, 18 Dec 2024 10:18:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnukf8m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:18:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIAIKbw30933662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 10:18:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 954982004F;
	Wed, 18 Dec 2024 10:18:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87F0A2004B;
	Wed, 18 Dec 2024 10:18:18 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Dec 2024 10:18:18 +0000 (GMT)
Date: Wed, 18 Dec 2024 15:48:16 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 06/10] ext4: refactor ext4_collapse_range()
Message-ID: <Z2KhaFhqwQMy2Fk/@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-7-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nkUYj-hhPASKMXWUBgfthStMdPoC1lF1
X-Proofpoint-ORIG-GUID: nkUYj-hhPASKMXWUBgfthStMdPoC1lF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180080

On Mon, Dec 16, 2024 at 09:39:11AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Simplify ext4_collapse_range() and align its code style with that of
> ext4_zero_range() and ext4_punch_hole(). Refactor it by: a) renaming
> variables, b) removing redundant input parameter checks and moving
> the remaining checks under i_rwsem in preparation for future
> refactoring, and c) renaming the three stale error tags.

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/extents.c | 103 +++++++++++++++++++++-------------------------
>  1 file changed, 48 insertions(+), 55 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 97ad6fea58d3..8a0a720803a8 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5292,43 +5292,36 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	struct inode *inode = file_inode(file);
>  	struct super_block *sb = inode->i_sb;
>  	struct address_space *mapping = inode->i_mapping;
> -	ext4_lblk_t punch_start, punch_stop;
> +	loff_t end = offset + len;
> +	ext4_lblk_t start_lblk, end_lblk;
>  	handle_t *handle;
>  	unsigned int credits;
> -	loff_t new_size, ioffset;
> +	loff_t start, new_size;
>  	int ret;
>  
> -	/*
> -	 * We need to test this early because xfstests assumes that a
> -	 * collapse range of (0, 1) will return EOPNOTSUPP if the file
> -	 * system does not support collapse range.
> -	 */
> -	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		return -EOPNOTSUPP;
> +	trace_ext4_collapse_range(inode, offset, len);
>  
> -	/* Collapse range works only on fs cluster size aligned regions. */
> -	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
> -		return -EINVAL;
> +	inode_lock(inode);
>  
> -	trace_ext4_collapse_range(inode, offset, len);
> +	/* Currently just for extent based files */
> +	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
>  
> -	punch_start = offset >> EXT4_BLOCK_SIZE_BITS(sb);
> -	punch_stop = (offset + len) >> EXT4_BLOCK_SIZE_BITS(sb);
> +	/* Collapse range works only on fs cluster size aligned regions. */
> +	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
> -	inode_lock(inode);
>  	/*
>  	 * There is no need to overlap collapse range with EOF, in which case
>  	 * it is effectively a truncate operation
>  	 */
> -	if (offset + len >= inode->i_size) {
> +	if (end >= inode->i_size) {
>  		ret = -EINVAL;
> -		goto out_mutex;
> -	}
> -
> -	/* Currently just for extent based files */
> -	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> -		ret = -EOPNOTSUPP;
> -		goto out_mutex;
> +		goto out;
>  	}
>  
>  	/* Wait for existing dio to complete */
> @@ -5336,7 +5329,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out_mutex;
> +		goto out;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -5346,55 +5339,52 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  
>  	ret = ext4_break_layouts(inode);
>  	if (ret)
> -		goto out_mmap;
> +		goto out_invalidate_lock;
>  
>  	/*
> +	 * Write tail of the last page before removed range and data that
> +	 * will be shifted since they will get removed from the page cache
> +	 * below. We are also protected from pages becoming dirty by
> +	 * i_rwsem and invalidate_lock.
>  	 * Need to round down offset to be aligned with page size boundary
>  	 * for page size > block size.
>  	 */
> -	ioffset = round_down(offset, PAGE_SIZE);
> -	/*
> -	 * Write tail of the last page before removed range since it will get
> -	 * removed from the page cache below.
> -	 */
> -	ret = filemap_write_and_wait_range(mapping, ioffset, offset);
> -	if (ret)
> -		goto out_mmap;
> -	/*
> -	 * Write data that will be shifted to preserve them when discarding
> -	 * page cache below. We are also protected from pages becoming dirty
> -	 * by i_rwsem and invalidate_lock.
> -	 */
> -	ret = filemap_write_and_wait_range(mapping, offset + len,
> -					   LLONG_MAX);
> +	start = round_down(offset, PAGE_SIZE);
> +	ret = filemap_write_and_wait_range(mapping, start, offset);
> +	if (!ret)
> +		ret = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
>  	if (ret)
> -		goto out_mmap;
> -	truncate_pagecache(inode, ioffset);
> +		goto out_invalidate_lock;
> +
> +	truncate_pagecache(inode, start);
>  
>  	credits = ext4_writepage_trans_blocks(inode);
>  	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
> -		goto out_mmap;
> +		goto out_invalidate_lock;
>  	}
>  	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
>  
> +	start_lblk = offset >> inode->i_blkbits;
> +	end_lblk = (offset + len) >> inode->i_blkbits;
> +
>  	down_write(&EXT4_I(inode)->i_data_sem);
>  	ext4_discard_preallocations(inode);
> -	ext4_es_remove_extent(inode, punch_start, EXT_MAX_BLOCKS - punch_start);
> +	ext4_es_remove_extent(inode, start_lblk, EXT_MAX_BLOCKS - start_lblk);
>  
> -	ret = ext4_ext_remove_space(inode, punch_start, punch_stop - 1);
> +	ret = ext4_ext_remove_space(inode, start_lblk, end_lblk - 1);
>  	if (ret) {
>  		up_write(&EXT4_I(inode)->i_data_sem);
> -		goto out_stop;
> +		goto out_handle;
>  	}
>  	ext4_discard_preallocations(inode);
>  
> -	ret = ext4_ext_shift_extents(inode, handle, punch_stop,
> -				     punch_stop - punch_start, SHIFT_LEFT);
> +	ret = ext4_ext_shift_extents(inode, handle, end_lblk,
> +				     end_lblk - start_lblk, SHIFT_LEFT);
>  	if (ret) {
>  		up_write(&EXT4_I(inode)->i_data_sem);
> -		goto out_stop;
> +		goto out_handle;
>  	}
>  
>  	new_size = inode->i_size - len;
> @@ -5402,16 +5392,19 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	EXT4_I(inode)->i_disksize = new_size;
>  
>  	up_write(&EXT4_I(inode)->i_data_sem);
> -	if (IS_SYNC(inode))
> -		ext4_handle_sync(handle);
>  	ret = ext4_mark_inode_dirty(handle, inode);
> +	if (ret)
> +		goto out_handle;
> +
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
> +	if (IS_SYNC(inode))
> +		ext4_handle_sync(handle);
>  
> -out_stop:
> +out_handle:
>  	ext4_journal_stop(handle);
> -out_mmap:
> +out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out_mutex:
> +out:
>  	inode_unlock(inode);
>  	return ret;
>  }
> -- 
> 2.46.1
> 

