Return-Path: <linux-fsdevel+bounces-50374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B426ACB942
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 18:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03AD47A7D65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0990222599;
	Mon,  2 Jun 2025 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi/J6bL1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE14221F3E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880337; cv=none; b=KGkdM1Sd7F4CoThzJhaBKQNYB/r0bnRYI68knxX4QmEpDyEV5itI/ub9QB7fIJ+RRsVIa6J+Qn5ECEuM8nDdXPYJU15TGoTNtiK4yW0N0vGSziTg5CzhUhgZ2rCQYfnMJGmO1uYZEvMVLJbmGHo9GNyyrHG20Vi1cKdf1eP0GDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880337; c=relaxed/simple;
	bh=A3pRvyB9HIx3Zf3r/C3GJr+0BFFqJwPn2oxiWVZ6UJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIGy+rSxqosoNpd7bwxu+dKVm/LCavomrZ6qbcMY/uRsEDtI/fWnIBHgQt54Tw0ZLgLYuRwxi+HUfoaMNBIfNGEBGTyF9KbcoCXHdQXw/m3zbjxJjXsA1OvZZZXbaYc2GM2FRcfg3pEKpvBmsIMBGwJgt0MrlZv5aKqCgvovNtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi/J6bL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF35C4CEEB;
	Mon,  2 Jun 2025 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748880336;
	bh=A3pRvyB9HIx3Zf3r/C3GJr+0BFFqJwPn2oxiWVZ6UJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bi/J6bL1HXjnT8nhjqkrb0BqipL5lEsfj9ZI9qP4FFyR0D5E+POyOXKP4SjvZJYGN
	 8XRYEGfybih0xmsomVFL5/Bb4iW+fINUV77q9Z6fxvOqc2oFZdzsuwdDjIQFuM6rn6
	 AOhxRcYkfqWlOevVw420/1J43WoqK7sySa7TtlpG06r7i6adcUbDVD0fm6JC8JbPfm
	 xDI1hYc8q18wCyH6stmisn6LUIWCTQdNvbbr7FreJ7FOgeAjgJy/wyJ+zqr2n32uEk
	 eOl7xbbfhv4fUrlVG7Fu8gaKXlFfsFxdGRwGAkuZribyF4ha+FoeizY0vhZ3SRPEd/
	 YkKSgHCvdOC8w==
Date: Mon, 2 Jun 2025 16:05:34 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	sandeen@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] f2fs: new mount API conversion
Message-ID: <aD3Lzsp-u6KuyGRt@google.com>
References: <20250602090224.485077-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602090224.485077-1-lihongbo22@huawei.com>

Thanks you, Hongbo.

I just applied this series to the dev-test branch as below, and will
keep testing with incoming patches together. Let's see. :)

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test

On 06/02, Hongbo Li wrote:
> In this version, we have finished the issues pointed in v3.
> First, I'd like to express my sincere thanks to Jaegeuk and Chao
> for reviewing this patch series and providing corrections. I also
> appreciate Eric for rebasing the patches onto the latest branch to
> ensure forward compatibility.
> 
> The latest patch series has addressed all the issues mentioned in
> the previous set. For modified patches, I've re-added Signed-off-by
> tags (SOB) and uniformly removed all Reviewed-by tags.
> 
> v4:
>   - Change is_remount as bool type in patch 2.
>   - Remove the warning reported by Dan for patch 5.
>   - Enhance sanity check and fix some coding style suggested by
>     Jaegeuk in patch 5.
>   - Change the log info when compression option conflicts in patch 5.
>   - Fix the issues reported by code-reviewing in patch 5.
>   - Context modified in patch 7.
> 
> V3: https://lore.kernel.org/all/20250423170926.76007-1-sandeen@redhat.com/
> - Rebase onto git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
>   dev branch
> - Fix up some 0day robot warnings
> 
> (Here is the origianl cover letter:)
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
> 
> Hongbo Li (7):
>   f2fs: Add fs parameter specifications for mount options
>   f2fs: move the option parser into handle_mount_opt
>   f2fs: Allow sbi to be NULL in f2fs_printk
>   f2fs: Add f2fs_fs_context to record the mount options
>   f2fs: separate the options parsing and options checking
>   f2fs: introduce fs_context_operation structure
>   f2fs: switch to the new mount api
> 
>  fs/f2fs/super.c | 2108 +++++++++++++++++++++++++++--------------------
>  1 file changed, 1197 insertions(+), 911 deletions(-)
> 
> -- 
> 2.33.0

