Return-Path: <linux-fsdevel+bounces-54792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F10B03473
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 04:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF993B1E38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 02:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C381D54EE;
	Mon, 14 Jul 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McCMGcjq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D875163CB
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460048; cv=none; b=Bqy9O/SpMs3cnWU3CZ9tDC0ME89pAylZc/9uZnn+vln6UVAWax1G3589wBG/xFKzxAreO1VpUlk7bz+JPbXTzRNV9QAOgeX5Pa5RHGPw2SQKVQjWm8+siQaNx8PgGcQzoEGCFQbnmNTi7i9EnOZdOzS/0WyhBMPc53DNAk3nweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460048; c=relaxed/simple;
	bh=7Axe8joyugX6kQZ14NmROgtOmkdcODhNEvwCi5eQuUw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eHaMWLe0ovM9Z300XcXF0g1lG1/twgZjWFHRMx0all+/WB/y/EmIpvTuM2dV8Wz2TDXel37eWShp2HXkNbgBfYiac67FWi3b/FjL0XA7SwLAMrMGQkgQxoBKH9ZlBcAe+5Og2K1z5x5CaAltiaLRtk4mivBELKlmC5gaKQdOJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McCMGcjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8016C4CEE3;
	Mon, 14 Jul 2025 02:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752460048;
	bh=7Axe8joyugX6kQZ14NmROgtOmkdcODhNEvwCi5eQuUw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=McCMGcjqjDqC9Qoqo15VRZ3U+4XZPPudj4x6AKoVdcPIfyJFrDRKDESZ0GnGv7Cec
	 J6PeYfxTmPJK/l9RxQM3XUZPq21SPKrQKHktOpYjEl/bHM44hbU99mh5E1K/YddZNP
	 dK/ULCyuwhv00tBB9LVp15c+4ztq/foLQBrFTbP3DsH5uZvwGr11m4Vu0aed1Px6lx
	 KJoeys1Mo8Wv6y+SWrOlZW1t/fFU3yYa3591bNKdV2pgPzR+qRHYxMtOJdTkp0/DML
	 jHb3RyjPFN+IkbkjcrxcY/VXZaQY2eJvTeBLP7BfjudZELyA+zYXxrfsVAOnZEau6S
	 PYBQGO0so2GLA==
Message-ID: <b12d791e-a9f6-4b9d-a299-858821ebc1b5@kernel.org>
Date: Mon, 14 Jul 2025 10:27:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, sandeen@redhat.com
Subject: Re: [PATCH v5 0/7] f2fs: new mount API conversion
To: Hongbo Li <lihongbo22@huawei.com>, jaegeuk@kernel.org
References: <20250710121415.628398-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250710121415.628398-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 20:14, Hongbo Li wrote:
> In this version, we have finished the issues pointed in v4.
> First, I'd like to express my sincere thanks to Jaegeuk and Chao
> for reviewing this patch series and providing corrections. I also
> appreciate Eric for rebasing the patches onto the latest branch to
> ensure forward compatibility.
> 
> The latest patch series has addressed all the issues mentioned in
> the previous set. For modified patches, I've re-added Signed-off-by
> tags (SOB) and uniformly removed all Reviewed-by tags.
> 
> v5:
>   - Add check for bggc_mode(off) with sb blkzone case.
>   - Fix the 0day-ci robot reports.

Looks good to me, feel free to add to all patches:

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> v4: https://lore.kernel.org/all/20250602090224.485077-1-lihongbo22@huawei.com/
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
>  fs/f2fs/super.c | 2101 +++++++++++++++++++++++++++--------------------
>  1 file changed, 1190 insertions(+), 911 deletions(-)
> 


