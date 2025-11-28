Return-Path: <linux-fsdevel+bounces-70100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F6C908AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B71F534EFA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 01:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB832264617;
	Fri, 28 Nov 2025 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IgmiPlHq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E13AC39;
	Fri, 28 Nov 2025 01:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294880; cv=none; b=XCbNdzfDHjpAuu9xfsgbTvxoyhKtw2PAJ2KaoTdN8E20RJ7HWPPrfW5NUkbFo68Jve5iRWKtLa/JN13aLLReVonNGabdlW5MPqAfD+IGxdc2K+jz9wHAuhRkWGyHDVUrEgt3NE84fObNrYttCpE5KkcFa8P7Wef6LkQERW/0qhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294880; c=relaxed/simple;
	bh=h9Ay1BqTQhZ6jcW36Sxiews1peM94L8LmALWvrDzwME=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L6k17l/w0HDWUazYyGVzdvzP3TYFhTl7Mq/D27t6dUEhMRTBJXXvvjAX1IjFUJnL/7wWflA2UXOxyP7kFgD60syIUf3lpwtSp9oQVdoxJE9GslP+K+/rfGKZyiZDgjDa2BmqpoJ15eHCXRnYno8hUmycp01nJXvDyw85lQ13uNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IgmiPlHq; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OjaaxQcI4mzK5sUm6E3VGl9rvkiNl04hzo8cQCptuL0=;
	b=IgmiPlHqJPxx7qFzuXLP3+im6QIoYzJD8s4a0tPREMz1+2LGHGoQEYm+Qq+a35Us/WFjlOHsp
	ML/3/EKf5BYdivUhS1h1WSz/RQ8s6nOWbISybKSSTZh7viTUZMPSAYnKqt9TB7vG67eZLVrD2xg
	nmFlFnERSKMoTq0C82ZY1LQ=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dHbrm4kkZznTXP;
	Fri, 28 Nov 2025 09:52:08 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DE2A1401F4;
	Fri, 28 Nov 2025 09:54:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 28 Nov
 2025 09:54:32 +0800
Message-ID: <b0ea740f-5e69-4217-9f67-a61e30fcd7e5@huawei.com>
Date: Fri, 28 Nov 2025 09:54:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] ext4: cleanup zeroout in ext4_split_extent_at()
Content-Language: en-GB
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <yi.zhang@huawei.com>, <yizhang089@gmail.com>,
	<yangerkun@huawei.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-2-yi.zhang@huaweicloud.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251121060811.1685783-2-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-21 14:07, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> zero_ex is a temporary variable used only for writing zeros and
> inserting extent status entry, it will not be directly inserted into the
> tree. Therefore, it can be assigned values from the target extent in
> various scenarios, eliminating the need to explicitly assign values to
> each variable individually.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Nice cleanup! Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/extents.c | 63 ++++++++++++++++++-----------------------------
>  1 file changed, 24 insertions(+), 39 deletions(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c7d219e6c6d8..91682966597d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3278,46 +3278,31 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  	ex = path[depth].p_ext;
>  
>  	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
> -		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
> -			if (split_flag & EXT4_EXT_DATA_VALID1) {
> -				err = ext4_ext_zeroout(inode, ex2);
> -				zero_ex.ee_block = ex2->ee_block;
> -				zero_ex.ee_len = cpu_to_le16(
> -						ext4_ext_get_actual_len(ex2));
> -				ext4_ext_store_pblock(&zero_ex,
> -						      ext4_ext_pblock(ex2));
> -			} else {
> -				err = ext4_ext_zeroout(inode, ex);
> -				zero_ex.ee_block = ex->ee_block;
> -				zero_ex.ee_len = cpu_to_le16(
> -						ext4_ext_get_actual_len(ex));
> -				ext4_ext_store_pblock(&zero_ex,
> -						      ext4_ext_pblock(ex));
> -			}
> -		} else {
> -			err = ext4_ext_zeroout(inode, &orig_ex);
> -			zero_ex.ee_block = orig_ex.ee_block;
> -			zero_ex.ee_len = cpu_to_le16(
> -						ext4_ext_get_actual_len(&orig_ex));
> -			ext4_ext_store_pblock(&zero_ex,
> -					      ext4_ext_pblock(&orig_ex));
> -		}
> +		if (split_flag & EXT4_EXT_DATA_VALID1)
> +			memcpy(&zero_ex, ex2, sizeof(zero_ex));
> +		else if (split_flag & EXT4_EXT_DATA_VALID2)
> +			memcpy(&zero_ex, ex, sizeof(zero_ex));
> +		else
> +			memcpy(&zero_ex, &orig_ex, sizeof(zero_ex));
>  
> -		if (!err) {
> -			/* update the extent length and mark as initialized */
> -			ex->ee_len = cpu_to_le16(ee_len);
> -			ext4_ext_try_to_merge(handle, inode, path, ex);
> -			err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> -			if (!err)
> -				/* update extent status tree */
> -				ext4_zeroout_es(inode, &zero_ex);
> -			/* If we failed at this point, we don't know in which
> -			 * state the extent tree exactly is so don't try to fix
> -			 * length of the original extent as it may do even more
> -			 * damage.
> -			 */
> -			goto out;
> -		}
> +		err = ext4_ext_zeroout(inode, &zero_ex);
> +		if (err)
> +			goto fix_extent_len;
> +
> +		/* update the extent length and mark as initialized */
> +		ex->ee_len = cpu_to_le16(ee_len);
> +		ext4_ext_try_to_merge(handle, inode, path, ex);
> +		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> +		if (!err)
> +			/* update extent status tree */
> +			ext4_zeroout_es(inode, &zero_ex);
> +		/*
> +		 * If we failed at this point, we don't know in which
> +		 * state the extent tree exactly is so don't try to fix
> +		 * length of the original extent as it may do even more
> +		 * damage.
> +		 */
> +		goto out;
>  	}
>  
>  fix_extent_len:



