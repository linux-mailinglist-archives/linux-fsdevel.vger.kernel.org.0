Return-Path: <linux-fsdevel+bounces-74768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHamKGg8cGmgXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:39:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 146174FE80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 402A2BC3FA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D42730EF8F;
	Wed, 21 Jan 2026 02:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TSqQjrEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E90C2749ED
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963107; cv=none; b=UG+2ZxamsH432vlXGUYmfz+8Jqq3jTNCUw/c8gmq4pgICnBwF0pscqjvMtIxhFtusw/moGbavPCpA51MSasdFMHreWr6jROCffGAQNJBzpuKbEtxtoT1GHxuwMsbiISwLahWECS9vDdE4PNOsqm7/6wUAtNqdtGkXo6fOz14gnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963107; c=relaxed/simple;
	bh=35IJCgB2W5E/cj4TwvSDaMRFFuQD7RFdgW5G95EYRDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2HE5hxWQZXy40huTlTuChIDS+NRZ6nw7kvxaXcw+N39PofuWAWdVUZw2pY80qr1f/Dz8n62vt7Nb/3XASbB1kSy1pcbOHwqvCQZyVPH8iPT+i/di7FCmAHzXUX0+m0Fz/tIZ+k7zEq9/HYgU53A0UAgRdfYXp9awxSY1KDroVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TSqQjrEB; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768963096; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mRD9TOtA3cZJt0onYW1I5pqmD8Gy9ogDKeItrowtu48=;
	b=TSqQjrEBmi8xrDtZaD9onvtcNasKR+rz7ZPQp8si6r1WgJd4hjGZUP8GhVvp/4vGlV95aCUOnRGbN9my9fne1xhQxL1rE2rPQfqBqyEg7o0W5EPz66YG5j8V+RbhSj4U8zQTWlJEqbxfE+FIzQNqun50JHdVF4lTK2GtGZnz9s4=
Received: from 30.221.146.111(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WxWNzYl_1768962779 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 Jan 2026 10:33:00 +0800
Message-ID: <f8c1b240-21d3-4daa-bc7c-2549085092f3@linux.alibaba.com>
Date: Wed, 21 Jan 2026 10:32:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] fuse: simplify logic in fuse_notify_store() and
 fuse_retrieve()
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: luochunsheng@ustc.edu, djwong@kernel.org, horst@birthelmer.de,
 linux-fsdevel@vger.kernel.org
References: <20260120224449.1847176-1-joannelkoong@gmail.com>
 <20260120224449.1847176-3-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260120224449.1847176-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-8.96 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,szeredi.hu];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74768-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,alibaba.com:email]
X-Rspamd-Queue-Id: 146174FE80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/21/26 6:44 AM, Joanne Koong wrote:
> Simplify the folio parsing logic in fuse_notify_store() and
> fuse_retrieve().
> 
> In particular, calculate the index by tracking pos, which allows us to
> remove calculating nr_pages, and use "pos" in place of outarg's offset
> field.
> 
> Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c | 42 +++++++++++++++++-------------------------
>  1 file changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 7558ff337413..9cbd5b64d9c9 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1765,10 +1765,9 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  	struct address_space *mapping;
>  	u64 nodeid;
>  	int err;
> -	pgoff_t index;
> -	unsigned int offset;
>  	unsigned int num;
>  	loff_t file_size;
> +	loff_t pos;
>  	loff_t end;
>  
>  	if (size < sizeof(outarg))
> @@ -1785,7 +1784,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  		return -EINVAL;
>  
>  	nodeid = outarg.nodeid;
> -	num = min(outarg.size, MAX_LFS_FILESIZE - outarg.offset);
> +	pos = outarg.offset;
> +	num = min(outarg.size, MAX_LFS_FILESIZE - pos);
>  
>  	down_read(&fc->killsb);
>  
> @@ -1795,10 +1795,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  		goto out_up_killsb;
>  
>  	mapping = inode->i_mapping;
> -	index = outarg.offset >> PAGE_SHIFT;
> -	offset = outarg.offset & ~PAGE_MASK;
>  	file_size = i_size_read(inode);
> -	end = outarg.offset + num;
> +	end = pos + num;
>  	if (end > file_size) {
>  		file_size = end;
>  		fuse_write_update_attr(inode, file_size, num);
> @@ -1808,19 +1806,18 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  		struct folio *folio;
>  		unsigned int folio_offset;
>  		unsigned int nr_bytes;
> -		unsigned int nr_pages;
> +		pgoff_t index = pos >> PAGE_SHIFT;
>  
>  		folio = filemap_grab_folio(mapping, index);
>  		err = PTR_ERR(folio);
>  		if (IS_ERR(folio))
>  			goto out_iput;
>  
> -		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> -		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
> -		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +		folio_offset = offset_in_folio(folio, pos);
> +		nr_bytes = min(num, folio_size(folio) - folio_offset);
>  
>  		err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
> -		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
> +		if (!folio_test_uptodate(folio) && !err && folio_offset == 0 &&
>  		    (nr_bytes == folio_size(folio) || file_size == end)) {
>  			folio_zero_segment(folio, nr_bytes, folio_size(folio));
>  			folio_mark_uptodate(folio);
> @@ -1831,9 +1828,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  		if (err)
>  			goto out_iput;
>  
> +		pos += nr_bytes;
>  		num -= nr_bytes;
> -		offset = 0;
> -		index += nr_pages;
>  	}
>  
>  	err = 0;
> @@ -1865,7 +1861,6 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>  {
>  	int err;
>  	struct address_space *mapping = inode->i_mapping;
> -	pgoff_t index;
>  	loff_t file_size;
>  	unsigned int num;
>  	unsigned int offset;
> @@ -1876,15 +1871,16 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>  	size_t args_size = sizeof(*ra);
>  	struct fuse_args_pages *ap;
>  	struct fuse_args *args;
> +	loff_t pos = outarg->offset;
>  
> -	offset = outarg->offset & ~PAGE_MASK;
> +	offset = offset_in_page(pos);
>  	file_size = i_size_read(inode);
>  
>  	num = min(outarg->size, fc->max_write);
> -	if (outarg->offset > file_size)
> +	if (pos > file_size)
>  		num = 0;
> -	else if (num > file_size - outarg->offset)
> -		num = file_size - outarg->offset;
> +	else if (num > file_size - pos)
> +		num = file_size - pos;
>  
>  	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	num_pages = min(num_pages, fc->max_pages);

Now offset is used only here.  It seems that the logic can be replaced
with fuse_wr_pages() [1] here.

I'm also fine with the current patch.
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

[1]
https://yhbt.net/lore/all/20260113192243.73983-1-david.laight.linux@gmail.com/

-- 
Thanks,
Jingbo


