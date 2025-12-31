Return-Path: <linux-fsdevel+bounces-72273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 902C2CEB76D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 08:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72F223032131
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 07:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5788C3126C1;
	Wed, 31 Dec 2025 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="i7dbSKzk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A32DE704;
	Wed, 31 Dec 2025 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767166950; cv=none; b=g59y74KT9u0tmEdFCRMbeM1bUZ2SmXRBrfsWEYCdRVNKhIj0a7l14KbRrUhOn2Ur9XzWqzrVq4qBwYGNVGMShsUxRPVoV+NQLe3oubPPwwvqzIj3gNoHmCyA4DY+wyNp50igVz7U/IbI2DzEiK8J2RXzKqegXNlkSD8Z0RXs3qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767166950; c=relaxed/simple;
	bh=YbmmiTBs//BncidLu8d7jXrNixQNIkrogrbbovvHDRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GasnnmwAhovYYPL9FJURa6/Rs36NKUGJdEjnFCGIQfmZayvbo5InzJUUpJLrMmn4t/AHSlzjqR7gRuHAmPxUFPp/s10d5x8DycVetLD9a+WdWnvV8vrHOMkXmLzJTInESMsbDMRMamiNGbE7LJyOhkD9li2GmnZrB9VLtc0SR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=i7dbSKzk; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=noIFPf2SWZUK3DXeKqlbo2t9k0SKQKuQTmBSs2T5Kjk=;
	b=i7dbSKzkoVxYa9LF23x88XJfjVatDPhc2q32H5HnXoIc9G4i0jQg04EE5D9E18Jvf+RP8nd3z
	hb0TxxJwrd3yser1DRtZni/ruo8CG5EVN1Geg4R2B6lmrYAGPr8T1qui7Dr14z/jesoIEPLOJWI
	HY5IlU2LHv/KIxbksdLHdW4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dh2044HR7z12LDq;
	Wed, 31 Dec 2025 15:39:16 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 0298820104;
	Wed, 31 Dec 2025 15:42:25 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 15:42:23 +0800
Message-ID: <c48419d0-e76b-4637-b532-906b10dec26b@huawei.com>
Date: Wed, 31 Dec 2025 15:42:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 5/7] ext4: remove unused unwritten parameter in
 ext4_dio_write_iter()
Content-Language: en-GB
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ojaswin@linux.ibm.com>, <ritesh.list@gmail.com>, <yi.zhang@huawei.com>,
	<yizhang089@gmail.com>, <yangerkun@huawei.com>, <yukuai@fnnas.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-6-yi.zhang@huaweicloud.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251223011802.31238-6-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-23 09:18, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> The parameter unwritten in ext4_dio_write_iter() is no longer needed,
> simply remove it.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/file.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 6b4b68f830d5..fa22fc0e45f3 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -424,14 +424,14 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>   */
>  static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  				     bool *ilock_shared, bool *extend,
> -				     bool *unwritten, int *dio_flags)
> +				     int *dio_flags)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
>  	loff_t offset;
>  	size_t count;
>  	ssize_t ret;
> -	bool overwrite, unaligned_io;
> +	bool overwrite, unaligned_io, unwritten;
>  
>  restart:
>  	ret = ext4_generic_write_checks(iocb, from);
> @@ -443,7 +443,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  
>  	unaligned_io = ext4_unaligned_io(inode, from, offset);
>  	*extend = ext4_extending_io(inode, offset, count);
> -	overwrite = ext4_overwrite_io(inode, offset, count, unwritten);
> +	overwrite = ext4_overwrite_io(inode, offset, count, &unwritten);
>  
>  	/*
>  	 * Determine whether we need to upgrade to an exclusive lock. This is
> @@ -458,7 +458,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  	 */
>  	if (*ilock_shared &&
>  	    ((!IS_NOSEC(inode) || *extend || !overwrite ||
> -	     (unaligned_io && *unwritten)))) {
> +	     (unaligned_io && unwritten)))) {
>  		if (iocb->ki_flags & IOCB_NOWAIT) {
>  			ret = -EAGAIN;
>  			goto out;
> @@ -481,7 +481,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  			ret = -EAGAIN;
>  			goto out;
>  		}
> -		if (unaligned_io && (!overwrite || *unwritten))
> +		if (unaligned_io && (!overwrite || unwritten))
>  			inode_dio_wait(inode);
>  		*dio_flags = IOMAP_DIO_FORCE_WAIT;
>  	}
> @@ -506,7 +506,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	loff_t offset = iocb->ki_pos;
>  	size_t count = iov_iter_count(from);
> -	bool extend = false, unwritten = false;
> +	bool extend = false;
>  	bool ilock_shared = true;
>  	int dio_flags = 0;
>  
> @@ -552,7 +552,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>  
>  	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend,
> -				    &unwritten, &dio_flags);
> +				    &dio_flags);
>  	if (ret <= 0)
>  		return ret;
>  



