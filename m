Return-Path: <linux-fsdevel+bounces-48311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC16AAD25A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 02:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE13B1C0567D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 00:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147D20330;
	Wed,  7 May 2025 00:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hki2Y1nj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031E4C9D
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578135; cv=none; b=KbdWmzGnO2kxLqbfd1Y/O6LHWcQWo8wBurY7qXkewQtGRFJEMI91DoOd7qDAkD6P1Ya5BFzea8tFtzCap287B3TLeeHmoCQ0LHzqZK/qNNQLDS2hoGRHFHs3VXiyQ2sXtYBS9FIWWItGxwQmflM+YAYPa2nLw0acmx2p4M8yM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578135; c=relaxed/simple;
	bh=9uDEMjzBMdRLNFtPdLcRRxHMd6lhIfTxWyvWPXxaVvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mR7bFHePQHSL+AMIVMJ3gIqsz5wpyvp54y8dawW7OOgd9zRWWl1ZVMLZVYvxr/CHYVdryia02pr9VPT9UPT/TmCnOg25YHYyr3qKzLs6NghGvD7XerSTS5THYR3NUJ98Vag8ArBAN6DzYlFQ122OA6Eez2hcOKKn5K7nJgfIAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hki2Y1nj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB45C4CEE4;
	Wed,  7 May 2025 00:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746578135;
	bh=9uDEMjzBMdRLNFtPdLcRRxHMd6lhIfTxWyvWPXxaVvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hki2Y1njW4O9HdN+R2d0DfkuueRvY2Og9sudjs/k+uJcKpaOIjQwb8bAX0zLdmjwv
	 B3DBMNf/b56yYRpqw6bDR6d7hZ74vydigct02P31qljRQm6GgXer3OEWnxf/YNh5fh
	 iHttPaS4DMTsbQR9kIYC02mvZLaEgL54htIzwLicBMg4FQBYu6BcScnvqbogljDGbh
	 mUly3C2fxLOmmhDXXFfc8ADNBxfsSlF+xOwPgqUKas7rzdr1WR8GcTKBZ0k2Q6vAfK
	 RJIdjV4Q3Zm0E9jhfD5AF+11ylHsFzeFtFFIVgCDXOFW8QWgMC9Mhqz9/7624eq+Qw
	 3Sca3jNKU8bPA==
Date: Wed, 7 May 2025 00:35:33 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	chao@kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH V3 0/7] f2fs: new mount API conversion
Message-ID: <aBqq1fQd1YcMAJL6@google.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423170926.76007-1-sandeen@redhat.com>

Hmm, I had to drop the series at the moment, since it seems needing more
work to deal with default_options(), which breaks my device setup.
For example, set_opt(sbi, READ_EXTENT_CACHE) in default_options is not propagating
to the below logics. In this case, do we need ctx_set_opt() if user doesn't set?

On 04/23, Eric Sandeen wrote:
> V3:
> - Rebase onto git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
>   dev branch
> - Fix up some 0day robot warnings
> 
> This is a forward-port of Hongbo's original f2fs mount API conversion,
> posted last August at 
> https://lore.kernel.org/linux-f2fs-devel/20240814023912.3959299-1-lihongbo22@huawei.com/
> 
> I had been trying to approach this with a little less complexity,
> but in the end I realized that Hongbo's approach (which follows
> the ext4 approach) was a good one, and I was not making any progrss
> myself. 😉
> 
> In addition to the forward-port, I have also fixed a couple bugs I found
> during testing, and some improvements / style choices as well. Hongbo and
> I have discussed most of this off-list already, so I'm presenting the
> net result here.
> 
> This does pass my typical testing which does a large number of random
> mounts/remounts with valid and invalid option sets, on f2fs filesystem
> images with various features in the on-disk superblock. (I was not able
> to test all of this completely, as some options or features require
> hardware I dn't have.)
> 
> Thanks,
> -Eric
> 
> (A recap of Hongbo's original cover letter is below, edited slightly for
> this series:)
> 
> Since many filesystems have done the new mount API conversion,
> we introduce the new mount API conversion in f2fs.
> 
> The series can be applied on top of the current mainline tree
> and the work is based on the patches from Lukas Czerner (has
> done this in ext4[1]). His patch give me a lot of ideas.
> 
> Here is a high level description of the patchset:
> 
> 1. Prepare the f2fs mount parameters required by the new mount
> API and use it for parsing, while still using the old API to
> get mount options string. Split the parameter parsing and
> validation of the parse_options helper into two separate
> helpers.
> 
>   f2fs: Add fs parameter specifications for mount options
>   f2fs: move the option parser into handle_mount_opt
> 
> 2. Remove the use of sb/sbi structure of f2fs from all the
> parsing code, because with the new mount API the parsing is
> going to be done before we even get the super block. In this
> part, we introduce f2fs_fs_context to hold the temporary
> options when parsing. For the simple options check, it has
> to be done during parsing by using f2fs_fs_context structure.
> For the check which needs sb/sbi, we do this during super
> block filling.
> 
>   f2fs: Allow sbi to be NULL in f2fs_printk
>   f2fs: Add f2fs_fs_context to record the mount options
>   f2fs: separate the options parsing and options checking
> 
> 3. Switch the f2fs to use the new mount API for mount and
> remount.
> 
>   f2fs: introduce fs_context_operation structure
>   f2fs: switch to the new mount api
> 
> [1] https://lore.kernel.org/all/20211021114508.21407-1-lczerner@redhat.com/

