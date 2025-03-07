Return-Path: <linux-fsdevel+bounces-43481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BB2A572FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 21:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08220170B73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 20:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3D42571D8;
	Fri,  7 Mar 2025 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJDvr1PE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1520C183CB0
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741379999; cv=none; b=WTMnK0zn8jIyKZNyS2CyiJlMRGptN/pBBUYaSA6toxx1r5ApJzjxTwxNZjho/ux8JZtC5ZYEN3/zWJ3tm40Z7A+KV1GCj7eEq7ec7M3ikyIocU9SEn8m9GZShT7ABPQXk0Q4z16UaDLRSbQyW2uJENXXNfZeF7u4SNlMfKGRDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741379999; c=relaxed/simple;
	bh=H8ql6R14QTVScWQoYRQBgXkNTHCFl/dZikkrBPMpnIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyOqjXhUxUC/PrDJ2BldCPMWXXCZkKDXuHjVvctLZd3rJjWKONm5HtudxCRYM8Vhwv2FBCk+35vWLJ/yjg1fD93ow+Y66tdktlf9V32Dk/enYAvT5uvPrzBD+HF9I97wrNNDww9sMOPydczMF3LtToSxtH6jgqaFS5tTzn9ltdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJDvr1PE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E02C4CEE2;
	Fri,  7 Mar 2025 20:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741379998;
	bh=H8ql6R14QTVScWQoYRQBgXkNTHCFl/dZikkrBPMpnIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJDvr1PE4Zmn0kjDj/ENOdDtLhy+vxW/FMM/joYTCIXNM1OWokZ69mnFH/4us841M
	 Qb9d/t1XvX15wRYZQ4prZYifMG/ZjFNFtZMyH2l+cdgfJ1ErSApNMJG+/+7SNROcbz
	 jLzSkR8MWlDyehaeSFpUE5AgUOUQl0cdvcgPLblpbskdqQMEwbPZgMnplsqa+KqGaq
	 8WBjlf/i5Ieitb7/oxoze0xllLaSPzeGvX7Wm2Ebh56keyPzAK7OKcjgZUIqrTZnyC
	 Sy1szc0LyeGebebzVRW4kiG5Q6ogMmWNygSLUIeRcMhK4eY7B2i9OJLHJNYCtbBBi4
	 Q1KLRN2J9jFuQ==
Date: Fri, 7 Mar 2025 20:39:56 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] f2fs: Remove uses of writepage
Message-ID: <Z8tZnN-CAS20Dpi7@google.com>
References: <20250307182151.3397003-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307182151.3397003-1-willy@infradead.org>

On 03/07, Matthew Wilcox (Oracle) wrote:
> I was planning on sending this next cycle, but maybe there's time to
> squeeze these patches into the upcoming merge window?
> 
> f2fs already implements writepages and migrate_folio for all three
> address_space_operations, so either ->writepage will never be called (by
> migration) or it will only be harmful (if called from pageout()).

My tree sitting on [1] doesn't have mm-next, which looks difficult to test this
series for test alone. Matthew, can you point which patches I need to apply
in mm along with this for test?

[1] f286757b644c "Merge tag 'timers-urgent-2025-02-03' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip"


> 
> The only remaining filesystem with ->writepage defined in next-20250307
> is vboxsf, so the concept of removing ->writepage is well proven.  I
> have some follow-up patches which simplify f2fs writeback afterwards,
> but I think we can postpone them to next cycle.
> 
> See
> https://lore.kernel.org/linux-fsdevel/20250307135414.2987755-1-willy@infradead.org/
> for where we're going; the first four patches in that series are the
> same as the four patches in this series, and I've split them out here
> for your convenience.
> 
> Matthew Wilcox (Oracle) (4):
>   f2fs: Remove check for ->writepage
>   f2fs: Remove f2fs_write_data_page()
>   f2fs: Remove f2fs_write_meta_page()
>   f2fs: Remove f2fs_write_node_page()
> 
>  fs/f2fs/checkpoint.c |  7 -------
>  fs/f2fs/data.c       | 28 ----------------------------
>  fs/f2fs/node.c       |  8 --------
>  3 files changed, 43 deletions(-)
> 
> -- 
> 2.47.2

