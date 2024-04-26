Return-Path: <linux-fsdevel+bounces-17913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593668B3B43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9051F211BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09DC14D43E;
	Fri, 26 Apr 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGO0TqSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D314884A;
	Fri, 26 Apr 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144896; cv=none; b=XSKQ4uP3elYuy7hYlVv/cd5uvmyLVg177LY+VdkfoGIS6MCVm8p5Jd7xHrX30rRMNLfGKT3gycyMkKQpQLhUA2e683bOuqbkEm3nHbSlyU0hL5mOyEubfgZfdMy5oSFUFqfGAA4nhz4qmVM6jf4f6uG+TvB8PcjOVDltEjUxc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144896; c=relaxed/simple;
	bh=/z0aZyPQcH00AB84k44KpIYCxiNTI8ZTpwHZHCzS2rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poPFgm8Fn4C1ttDe+slBr0o9Cs8jUISVIFsbS7ZzEuPAk1avHpekmdFz8m2JXd7getd+y+05mBA667/qdq5zHs0+lO/lXqR3Fn4j/emlBVa24S/VTajpntAt/Zw9lxQiCAmQQyxAe4DeYfWIOtF6pRL/F9qombJvjscbCQv46f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGO0TqSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835EBC113CD;
	Fri, 26 Apr 2024 15:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144895;
	bh=/z0aZyPQcH00AB84k44KpIYCxiNTI8ZTpwHZHCzS2rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGO0TqStxbiOfnLuztfimqD1+BYQmMw22iYkNbS993fxppyp46Wy0P2dQmdaEf+as
	 P+aV4lV5NuPp5pGofi6qjJVfQoxab2eAJ635o+SGQe1MgpX1iptj6/Y8TSizrfbU7f
	 GC7PhYL3hQuySrwLou0i/BBACto73RbaTyCA/ygfqe48oERyifI9KTh5C92ZX8SK/r
	 v3GtGrfbr26WEhbHWydwBtS7gwpMbAQuyctRIRjf34AitVgSyhKTt4zM8X4hSmS9Nk
	 525kZ0aT3u3vUOmbp8335DSP4HBy/bq9/Gq7JerTVv2kS9LRrJM4RgT/nu5Zm38/9m
	 r+gxyWoqy7gfg==
Date: Fri, 26 Apr 2024 08:21:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 1/7] ext2: Remove comment related to journal handle
Message-ID: <20240426152134.GI360919@frogsfrogsfrogs>
References: <cover.1714046808.git.ritesh.list@gmail.com>
 <08f3371e0c0932b5e1367ebbdd77cf61b7e4850b.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08f3371e0c0932b5e1367ebbdd77cf61b7e4850b.1714046808.git.ritesh.list@gmail.com>

On Thu, Apr 25, 2024 at 06:58:45PM +0530, Ritesh Harjani (IBM) wrote:
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

What handle? ;)
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/ext2/inode.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index f3d570a9302b..c4de3a94c4b2 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -615,8 +615,6 @@ static void ext2_splice_branch(struct inode *inode,
>   * allocations is needed - we simply release blocks and do not touch anything
>   * reachable from inode.
>   *
> - * `handle' can be NULL if create == 0.
> - *
>   * return > 0, # of blocks mapped or allocated.
>   * return = 0, if plain lookup failed.
>   * return < 0, error case.
> -- 
> 2.44.0
> 
> 

