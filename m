Return-Path: <linux-fsdevel+bounces-12279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFEB85E37C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20EFCB23C0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02A0839E0;
	Wed, 21 Feb 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1G3A0h7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB97C097;
	Wed, 21 Feb 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533454; cv=none; b=MrpVfleq5YHBjEmTAmD2mxswf0txt2vGjumFjYTHwZCy/aY5oRuD3fnx1uy0sRhLGLc97R1jWHg6p5qtDSlYjyPxOK1tU6YEwTW/oGhe/2W26ipNEi4YUCxgT71rT03nPqMNrs1H97O8eaO6SKZL4Rw+rSte4muTFhhQkUAbHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533454; c=relaxed/simple;
	bh=61rYAmqgDRAe9edWJaqEcS5Zlv4o/Cij2SJEH7qn3h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr3I0XgmukwZcboZ4mChfK0GHBYsvfV8ttJ+6sh9DvbevCMOr+aGLq63euV1iqBxmXoikxw6o8jQ5pOUW4HGBoI28dm8KFs6xxD7CrX5OHOGNIH7/kkHbm0O1uf0F0adIiouQOD2ATl0c15NCMED7NTpnuJcC2BhwT8p0Rt0KxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1G3A0h7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4B2C433F1;
	Wed, 21 Feb 2024 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708533453;
	bh=61rYAmqgDRAe9edWJaqEcS5Zlv4o/Cij2SJEH7qn3h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1G3A0h7SkfBpSUflt+lTKHC87eU1iJ/DaDcXAhlikyExWp0kkFWbafpnQm4TYM2J
	 FKN1DMa2z61n77AAYhJv21jVj32KbL3yqPaS1B+cy4lQ+XtDIFm0nEppwZEXGfNYq0
	 KJWWocHQbdSHRtoGjbx0hDfodaK2dww9Kan5Kb2b/AFC5MspGzohFUVMqAtWvMS7Sj
	 ckrMVl7LQD4cYszoDu0804/Oshp2xFDVn0iSSmxi6I+W3eJbbIGyvAr1yAizhPx+cT
	 jUntoGSmTeYk/vawRktbvXepdiqAye35+TMzQ2QHkecMY5ErqAo/t5/8m1cULdcM1F
	 j/uM9yD+mguQQ==
Date: Wed, 21 Feb 2024 08:37:32 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -next] iomap: add pos and dirty_len into
 trace_iomap_writepage_map
Message-ID: <20240221163732.GH6226@frogsfrogsfrogs>
References: <20240220115759.3445025-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220115759.3445025-1-yi.zhang@huaweicloud.com>

On Tue, Feb 20, 2024 at 07:57:59PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since commit fd07e0aa23c4 ("iomap: map multiple blocks at a time"), we
> could map multi-blocks once a time, and the dirty_len indicates the
> expected map length, map_len won't large than it. The pos and dirty_len
> means the dirty range that should be mapped to write, add them into
> trace_iomap_writepage_map() could be more useful for debug.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

LGTM too
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c |  2 +-
>  fs/iomap/trace.h       | 43 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2ad0e287c704..ae4e2026e59e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1776,7 +1776,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
>  		error = wpc->ops->map_blocks(wpc, inode, pos, dirty_len);
>  		if (error)
>  			break;
> -		trace_iomap_writepage_map(inode, &wpc->iomap);
> +		trace_iomap_writepage_map(inode, pos, dirty_len, &wpc->iomap);
>  
>  		map_len = min_t(u64, dirty_len,
>  			wpc->iomap.offset + wpc->iomap.length - pos);
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index c16fd55f5595..3ef694f9489f 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -154,7 +154,48 @@ DEFINE_EVENT(iomap_class, name,	\
>  	TP_ARGS(inode, iomap))
>  DEFINE_IOMAP_EVENT(iomap_iter_dstmap);
>  DEFINE_IOMAP_EVENT(iomap_iter_srcmap);
> -DEFINE_IOMAP_EVENT(iomap_writepage_map);
> +
> +TRACE_EVENT(iomap_writepage_map,
> +	TP_PROTO(struct inode *inode, u64 pos, unsigned int dirty_len,
> +		 struct iomap *iomap),
> +	TP_ARGS(inode, pos, dirty_len, iomap),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(u64, ino)
> +		__field(u64, pos)
> +		__field(u64, dirty_len)
> +		__field(u64, addr)
> +		__field(loff_t, offset)
> +		__field(u64, length)
> +		__field(u16, type)
> +		__field(u16, flags)
> +		__field(dev_t, bdev)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = inode->i_sb->s_dev;
> +		__entry->ino = inode->i_ino;
> +		__entry->pos = pos;
> +		__entry->dirty_len = dirty_len;
> +		__entry->addr = iomap->addr;
> +		__entry->offset = iomap->offset;
> +		__entry->length = iomap->length;
> +		__entry->type = iomap->type;
> +		__entry->flags = iomap->flags;
> +		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
> +	),
> +	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d pos 0x%llx dirty len 0x%llx "
> +		  "addr 0x%llx offset 0x%llx length 0x%llx type %s flags %s",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ino,
> +		  MAJOR(__entry->bdev), MINOR(__entry->bdev),
> +		  __entry->pos,
> +		  __entry->dirty_len,
> +		  __entry->addr,
> +		  __entry->offset,
> +		  __entry->length,
> +		  __print_symbolic(__entry->type, IOMAP_TYPE_STRINGS),
> +		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS))
> +);
>  
>  TRACE_EVENT(iomap_iter,
>  	TP_PROTO(struct iomap_iter *iter, const void *ops,
> -- 
> 2.39.2
> 

