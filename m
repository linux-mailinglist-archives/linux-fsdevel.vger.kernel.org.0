Return-Path: <linux-fsdevel+bounces-3949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBCB7FA485
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 16:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA85B21160
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824B328C7;
	Mon, 27 Nov 2023 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cHcVaYGm";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="fy0XjToO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24121183;
	Mon, 27 Nov 2023 07:29:00 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 631811BE6B3;
	Mon, 27 Nov 2023 10:28:59 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=rNBAVfaX9ctZ4ii/4kyKzGuefYpJB4VqiJgPY8
	WPzqk=; b=cHcVaYGmjCo8DBEc0yXUKmQZF15X0FNCKHgV35JbEAO0r7qYdvC0cp
	vrWnWJp19UMAnlDLeASJ/Rd1sN2VizWhI8nJOnfqTuFiuDeFKdO1RUbkZc2roVKh
	+8IOs8jfCz2f47l0L+UpRnWISiuddhkymWYMVQCNhXsJo078UUvpM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 597FC1BE6B1;
	Mon, 27 Nov 2023 10:28:59 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=rNBAVfaX9ctZ4ii/4kyKzGuefYpJB4VqiJgPY8WPzqk=; b=fy0XjToO+L9LJ+IBXt/kVcmQoLiVPpN+G0Xc4nOLER3sgFdSfSouMaXB3nJNnvvr8fH0w93C7TLBPM7WZ88aGrxAa2UflPkEfXTQCugXnRHMt2vSU5wksCxSRcWB4tm3DOlRzxFjOnpCbA6hS9h3KsL75RJKVbPYaREQvkDQQKE=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC2741BE6AE;
	Mon, 27 Nov 2023 10:28:58 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id A9833A27F2B;
	Mon, 27 Nov 2023 10:28:57 -0500 (EST)
Date: Mon, 27 Nov 2023 10:28:57 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Yu Kuai <yukuai1@huaweicloud.com>
cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH block/for-next v2 09/16] cramfs: use new helper to get
 inode from block_device
In-Reply-To: <20231127062116.2355129-10-yukuai1@huaweicloud.com>
Message-ID: <srnpr4p2-qns9-rorp-7886-175105485062@syhkavp.arg>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com> <20231127062116.2355129-10-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 AF4021C4-8D39-11EE-A368-25B3960A682E-78420484!pb-smtp2.pobox.com

On Mon, 27 Nov 2023, Yu Kuai wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> Which is more efficiency, and also prepare to remove the field
> 'bd_inode' from block_device.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  fs/cramfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 60dbfa0f8805..e9ed1e24c9e4 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -183,7 +183,7 @@ static int next_buffer;
>  static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>  				unsigned int len)
>  {
> -	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
> +	struct address_space *mapping = bdev_inode(sb->s_bdev)->i_mapping;
>  	struct file_ra_state ra = {};
>  	struct page *pages[BLKS_PER_BUF];
>  	unsigned i, blocknr, buffer;
> -- 
> 2.39.2
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 

