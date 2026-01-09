Return-Path: <linux-fsdevel+bounces-72994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 721EDD0742E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 06:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78480301D0E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 05:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D647284B3B;
	Fri,  9 Jan 2026 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BUDgWacj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678271DDC1D;
	Fri,  9 Jan 2026 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938123; cv=none; b=NtJRwSTIZqy7dijube0NyT0mpiJEcHMck5dxg7jbTpRCp3yj72jy5dDNDFNKuSf6nCWc/+H3H1W14ltUSqBPS4C1pp14+bgw3ewrFX6IbTQQqYjAHzKdNMfIk7NbCICw7SHWo1Rq52uyhpAfDXZqNyfnNd7ezXdrNmsFL8Qhbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938123; c=relaxed/simple;
	bh=fHo3tHDTY2ZFPTkhEY9lr55+JU46hmwUHHeYaTktsVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUy+r16p8es0mPVcKr0f+I17eq2W9bvHHvrX+eE7Xd3ZL6px1kZbtJcu3Uvz63h4Ky1Yihi38R4rt6gIMR5IaIYPaL5aNDY4t/JLEN84H9vYzx0mOSR2cd5xNknGWZVlaFNKPQGX3aD1nFTV7uBC0ULxWOBEGuXJbmdweAWdc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BUDgWacj; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767938119; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kwEry0PBTDpfE4oHiAHCyh7xXcMzLVzss6Nu/zqdczA=;
	b=BUDgWacjdgxM9TXXzR9TI6Qb8/+elDb7+HNvQIw4Q3Q8U0SklPLUo0UulRS1ySorAnJqBn/ifnuLbuHhNDLJvRj1HGR3HqgojtPA8+BcgT68OFhAmvc93KirqDk92UFGHPjZopypHH40LA9gZ0utsrTihUcI81kNjUrwzTYg43c=
Received: from 30.221.131.232(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwf3JGr_1767938118 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 13:55:18 +0800
Message-ID: <c7544d82-416d-4980-ac39-b5f83c540f38@linux.alibaba.com>
Date: Fri, 9 Jan 2026 13:55:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 08/10] erofs: support unencoded inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, chao@kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
 <20260109030140.594936-9-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260109030140.594936-9-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/9 11:01, Hongbo Li wrote:
> This patch adds inode page cache sharing functionality for unencoded
> files.
> 
> I conducted experiments in the container environment. Below is the
> memory usage for reading all files in two different minor versions
> of container images:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     241     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     872     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     2771    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     926     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     390     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     924     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |     474     |      49%      |
> +-------------------+------------------+-------------+---------------+
> 
> Additionally, the table below shows the runtime memory usage of the
> container:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      35     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     149     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     1028    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  2.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     155     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      25     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     186     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |      98     |      48%      |
> +-------------------+------------------+-------------+---------------+
> 
> Co-developed-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/data.c     | 30 +++++++++++++++++++++++-------
>   fs/erofs/inode.c    |  2 ++
>   fs/erofs/internal.h |  6 ++++++
>   fs/erofs/ishare.c   | 32 ++++++++++++++++++++++++++++++++
>   4 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 71e23d91123d..5fc8e3ce0d9e 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -269,6 +269,7 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>   struct erofs_iomap_iter_ctx {
>   	struct page *page;
>   	void *base;
> +	struct inode *realinode;
>   };
>   
>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> @@ -276,14 +277,15 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   {
>   	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
>   	struct erofs_iomap_iter_ctx *ctx = iter->private;
> -	struct super_block *sb = inode->i_sb;
> +	struct inode *realinode = ctx ? ctx->realinode : inode;
> +	struct super_block *sb = realinode->i_sb;
>   	struct erofs_map_blocks map;
>   	struct erofs_map_dev mdev;
>   	int ret;
>   
>   	map.m_la = offset;
>   	map.m_llen = length;
> -	ret = erofs_map_blocks(inode, &map);
> +	ret = erofs_map_blocks(realinode, &map);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -296,7 +298,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		return 0;
>   	}
>   
> -	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(inode)) {
> +	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(realinode)) {
>   		mdev = (struct erofs_map_dev) {
>   			.m_deviceid = map.m_deviceid,
>   			.m_pa = map.m_pa,
> @@ -322,7 +324,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			void *ptr;
>   
>   			ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
> -						 erofs_inode_in_metabox(inode));
> +						 erofs_inode_in_metabox(realinode));
>   			if (IS_ERR(ptr))
>   				return PTR_ERR(ptr);
>   			iomap->inline_data = ptr;
> @@ -379,30 +381,42 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>    */
>   static int erofs_read_folio(struct file *file, struct folio *folio)
>   {
> +	struct inode *inode = folio_inode(folio);
>   	struct iomap_read_folio_ctx read_ctx = {
>   		.ops		= &iomap_bio_read_ops,
>   		.cur_folio	= folio,
>   	};
> -	struct erofs_iomap_iter_ctx iter_ctx = {};
> +	bool need_iput;
> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.realinode	= erofs_real_inode(inode, &need_iput),

I think you could just open-code it for now:

		.realinode = erofs_real_inode(folio_inode(folio), &need_iput),

> +	};
>   
>   	trace_erofs_read_folio(folio, true);
>   
>   	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
> +	if (need_iput)
> +		iput(iter_ctx.realinode);
>   	return 0;
>   }
>   
>   static void erofs_readahead(struct readahead_control *rac)
>   {
> +	struct inode *inode = rac->mapping->host;
>   	struct iomap_read_folio_ctx read_ctx = {
>   		.ops		= &iomap_bio_read_ops,
>   		.rac		= rac,
>   	};
> -	struct erofs_iomap_iter_ctx iter_ctx = {};
> +	bool need_iput;
> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.realinode	= erofs_real_inode(inode, &need_iput),

Same here:
		.realinode = erofs_real_inode(rac->mapping->host,
					      &need_iput),

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

