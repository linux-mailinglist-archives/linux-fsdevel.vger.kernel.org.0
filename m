Return-Path: <linux-fsdevel+bounces-46485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0682CA8A18F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C8B189D074
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343D82973CA;
	Tue, 15 Apr 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJh+D3Vd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E620ADD6;
	Tue, 15 Apr 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728549; cv=none; b=Y6fHnmvNujpOx8S3qw7p8ImT9dWpJxax2dwhVQB5e2wxg2zSVakOV3vZvRA2Q7zt9OXM8c/J8ecHj6MXG8vGTgVsKbgSZThg822UPH0ItNGpXTxyHerxmXi3yXg5OisrP3yM7VCGFlziVlb9WIrLoRom3myMw9Hk0I6cEBToXDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728549; c=relaxed/simple;
	bh=yzqoj+qnZ4835r5vJvU1UpocaGW4Cjv0A48IJJzwAlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvhdJTHT8SM2jMoUi+CTi1bwdgCnLlZnrGbD2TA0p6p4Bq18Bql3vY3T/XjT5iVYItUXfV3JXLOEzz45hk4+91JRjtArgBAjVnBxZ0x8VapeKHmL948tm26xOT19EQKrk/pyEHAN06ssrv+FhieUur4z4Kcbt0QzsLjU3zj+WCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJh+D3Vd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C291C4CEED;
	Tue, 15 Apr 2025 14:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728549;
	bh=yzqoj+qnZ4835r5vJvU1UpocaGW4Cjv0A48IJJzwAlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJh+D3VdR/SORHhLDTZ13GGlrHvIp/loiJdp+OZPxvZ/EFc3ZEC4Hy/c/VE9j4D0A
	 68wZ27akOied5l88bGw9CrLeEqVyY7W4YTOLXaE0F1lKkQPjiy8xBoDEfS6+k0CsAk
	 hBvCmOYFCUrwj5Iigh7WWWxjLrrwc5HSMn784qjNRrz5QOzAgqjkbuTSZ1H6srN+vs
	 kSrV8iMNRnOba7KfCUKYG2OzzoyZxosMjSrSjghkZjEIVvBU7Y9DstRfAaYptP98TZ
	 CxHx+mQYq+ZcHIhgErD8dAA2lHBC+tyEl9MZgTQqbqWmmmdrOe6n+PxYyudBCFfAhe
	 6zDXP4TCvhe1g==
Date: Tue, 15 Apr 2025 07:49:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	David Sterba <dsterba@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Josef Bacik <josef@toxicpanda.com>, Sandeen <sandeen@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfs{plus}: add deprecation warning
Message-ID: <20250415144907.GB25659@frogsfrogsfrogs>
References: <20250415-orchester-robben-2be52e119ee4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415-orchester-robben-2be52e119ee4@brauner>

On Tue, Apr 15, 2025 at 09:51:37AM +0200, Christian Brauner wrote:
> Both the hfs and hfsplus filesystem have been orphaned since at least
> 2014, i.e., over 10 years. It's time to remove them from the kernel as
> they're exhibiting more and more issues and no one is stepping up to
> fixing them.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/hfs/super.c     | 2 ++
>  fs/hfsplus/super.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index fe09c2093a93..4413cd8feb9e 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -404,6 +404,8 @@ static int hfs_init_fs_context(struct fs_context *fc)
>  {
>  	struct hfs_sb_info *hsb;
>  
> +	pr_warn("The hfs filesystem is deprecated and scheduled to be removed from the kernel in 2025\n");

Does this mean before or after the 2025 LTS kernel is released?  I would
say that we ought to let this circulate more widely among users, but
OTOH I guess no maintainer for a decade is really bad.

--D

> +
>  	hsb = kzalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
>  	if (!hsb)
>  		return -ENOMEM;
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 948b8aaee33e..58cff4b2a3b4 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -656,6 +656,8 @@ static int hfsplus_init_fs_context(struct fs_context *fc)
>  {
>  	struct hfsplus_sb_info *sbi;
>  
> +	pr_warn("The hfsplus filesystem is deprecated and scheduled to be removed from the kernel in 2025\n");
> +
>  	sbi = kzalloc(sizeof(struct hfsplus_sb_info), GFP_KERNEL);
>  	if (!sbi)
>  		return -ENOMEM;
> -- 
> 2.47.2
> 
> 

