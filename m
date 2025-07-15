Return-Path: <linux-fsdevel+bounces-54907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C33EB04F29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 05:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED3F7A3441
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 03:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BB62D0C97;
	Tue, 15 Jul 2025 03:36:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E44C25B2E3;
	Tue, 15 Jul 2025 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550580; cv=none; b=Wf+7dlKZH5EOZsesZW2T2agKc5GZvNAatbh2AzTwNsZhTPwdcQN7W9EdSS0MZdYCh6Nvb9dO8fVVSKDKi1jCxCD/LCzlDYi+Cfw8ImVqqsY8e4pzl8t8ZHMvp70CtTGa7BB+FjGPmzL8EVoXsSJqXy+uj5OczcIfdGA5KkjUPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550580; c=relaxed/simple;
	bh=sLIRu97tFWD/YcQkd+C2KZRU2bD3i08QgIyXnojHNvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ox3Bb04T5POxCHyYMOdKWLi+58ANla4Q1pDhto1z/wpHKlnf5xCVw0AdBWIhjpiSa1RUlm47JpwH42UDJDSof2xZlCMnhoVSzKbbIihsnC3cxya43S1MW09kBH0AqNt1F8QCKnwvEcOPF0z0mVoCfbMTrLBY7WvnM9TYDY3SN/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bh4ZN052tztSr8;
	Tue, 15 Jul 2025 11:35:08 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 814901401F4;
	Tue, 15 Jul 2025 11:36:13 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Jul
 2025 11:36:12 +0800
Message-ID: <1f12e3ed-ad0e-4ca7-b26e-de7a7ac3a737@huawei.com>
Date: Tue, 15 Jul 2025 11:36:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ext4: fix the compile error of
 EXT4_MAX_PAGECACHE_ORDER macro
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ojaswin@linux.ibm.com>, <sfr@canb.auug.org.au>, <yi.zhang@huawei.com>,
	<yukuai3@huawei.com>, <yangerkun@huawei.com>, <linux-ext4@vger.kernel.org>
References: <20250715031203.2966086-1-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250715031203.2966086-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/7/15 11:12, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> Since both the input and output parameters of the
> EXT4_MAX_PAGECACHE_ORDER should be unsigned int type, switch to using
> umin() instead of min(). This will silence the compile error reported by
> _compiletime_assert() on powerpc.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20250715082230.7f5bcb1e@canb.auug.org.au/
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>   fs/ext4/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1bce9ebaedb7..6fd3692c4faf 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5204,7 +5204,7 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
>    * where the PAGE_SIZE exceeds 4KB.
>    */
>   #define EXT4_MAX_PAGECACHE_ORDER(i)		\
> -		min(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
> +		umin(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
>   void ext4_set_inode_mapping_order(struct inode *inode)
>   {
>   	if (!ext4_should_enable_large_folio(inode))



