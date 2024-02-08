Return-Path: <linux-fsdevel+bounces-10766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043CE84DDDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 11:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981DF1F288A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995BB6D1D1;
	Thu,  8 Feb 2024 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njlYExiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C486BFAD;
	Thu,  8 Feb 2024 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387077; cv=none; b=S9c5HQJaJgT0BDIFtceitvwYynb74J8ukD+5AUloqcqukUD5VHc9qVDkzikTxQ8LcuZTMh0tG9MIoPupnwjki3AZ5uMbQSBObjP3+29fzlbyqWhzlHrWw4cw5J1QvJOpEpJFIJCf9JWeAtkpDtjB1kBJ8suaEDiGRClOG4yjhpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387077; c=relaxed/simple;
	bh=rfNkriTuMNrxWSnu5QKHxsR1ZExIOifqwJ9EYHRwU8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqFz7+Mx7Qcz2Y5USNwfnSYyq+/uwFcUVtrc4mSywL4p4UWTrIaR7obTTbdBsMRJs5LgDUNPpA/1y8YwWkHuYpcufL8sBav91Nnpoeu6GsFPTGCqLnlkx2SXfg0hzt7JGpyOAEWc8Xiai2pd+8QGlkMVS7zKlsffMvOwEAboxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njlYExiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C88DC433C7;
	Thu,  8 Feb 2024 10:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707387076;
	bh=rfNkriTuMNrxWSnu5QKHxsR1ZExIOifqwJ9EYHRwU8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njlYExiJT9v6c1nmCFm8dS/OiFM9V8Ux8ZCtaKpE2QDsB8lMdx51G35SnenSPAuSJ
	 y+zbxP/fCh6LwD3bbMCQh8NudEW/9xSDZsm/bKxB0B5+hzc18jYeNS582Z6YpyIykH
	 p30ogV2w18dHT1AriIrticqUXoT7A0/NOpILcUOIXWAKQakjNkmZUU8liAPQuLXe77
	 jaBNXTyXpcg1EaxkOKLHXqDlTxiUfpOBaSUlK1FDogB2S9/4h2EmeqOoKfiQcaeJ+5
	 R7N+A/U6mQs26fvFxStrFItOXEELhoV8102PuXBpm4anZVMQmYAS80dSdiFMQFKMwN
	 tKs/vViaB/UDg==
Date: Thu, 8 Feb 2024 11:11:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v3 1/7] fs: super_set_uuid()
Message-ID: <20240208-ersonnen-nichtig-19348b8e6afa@brauner>
References: <20240207025624.1019754-1-kent.overstreet@linux.dev>
 <20240207025624.1019754-2-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240207025624.1019754-2-kent.overstreet@linux.dev>

> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d45ab0992ae5..5dd7b7b26db9 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4496,7 +4496,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_time_gran = 1;
>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
>  		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
> -	memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
> +	super_set_uuid(&sb, (void *) raw_super->uuid, sizeof(raw_super->uuid));

This won't compile because of &sb. This wants to be sb...
I fixed that up.

