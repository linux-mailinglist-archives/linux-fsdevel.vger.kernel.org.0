Return-Path: <linux-fsdevel+bounces-57382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B23B21051
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A423E6587
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB98E2E266D;
	Mon, 11 Aug 2025 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCzhd0w5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F582E11AA;
	Mon, 11 Aug 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925670; cv=none; b=UYK9mVrHFRG0GeyfjeEfv57sTrWaLe0ZDZqPex7aFVVlR5GFUmO1zPaSvOWQRczsVwqZdihKE4Gmr0EPBFCRKuk0h/+z3OatKlu63FJW7TYv5Tgj43iH2xxey7qNuZpnEldMiOu7BmjyBfkHBvDN1DlAAHlK75eq2l2UN9/7L2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925670; c=relaxed/simple;
	bh=FOapJCkcHHb2SlWwRYoetr0nJMVUP61KZwf6I7eXpDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDPuBPn2vFUJRg6UAw5h1gT21MPVRKY0yA5HeX0/bjoudvWe+vU5UJy9wyk9qCnTxVEQ7gDJr9FeH2mvDZCZiHEUerdJ+11V004vYBLxB7T7t133jXCNAhUcoie1IVd0MW8Pr/xsNZe71ZLO2PqaCTErjiC4eVeD0kV5FdKO01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCzhd0w5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8A7C4CEED;
	Mon, 11 Aug 2025 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754925669;
	bh=FOapJCkcHHb2SlWwRYoetr0nJMVUP61KZwf6I7eXpDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCzhd0w5kq2HlxRUxrbVr+gu/htgK7dbS6jYuuDM19LanpGFhcfCRQLQKe2Y4NONZ
	 DkPUZcgL9WB8tW4110ldXKqlx4rZEbiYW0qctIPr2pW8iCNRMwt21nnSnGusPdVCx6
	 Ers/uMCLklQ/OXADnJAMMQS3Ns1YxdVySe8VCVKNwbS4EuUS91Spy3UfZE/BBeSf62
	 q2xwAPndPvPAnwZe1fEeU332oSuYqGwLhMx4PVKdn5AYnyTMRTjADjIAKpjIVOqa3d
	 iz6IgEiaJNOT8pZF7EJXX5rjMTkXwKhpqGd4QA7BHRaE/1Wantm+Bodx95qSEmIcav
	 EBHhHmckj72eQ==
Date: Mon, 11 Aug 2025 08:21:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 3/3] xfs: test quota's project ID on special files
Message-ID: <20250811152109.GF7965@frogsfrogsfrogs>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
 <20250808-xattrat-syscall-v1-3-6a09c4f37f10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-xattrat-syscall-v1-3-6a09c4f37f10@kernel.org>

On Fri, Aug 08, 2025 at 09:31:58PM +0200, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> With addition of file_getattr() and file_setattr(), xfs_quota now can
> set project ID on filesystem inodes behind special files. Previously,
> quota reporting didn't count inodes of special files created before
> project initialization. Only new inodes had project ID set.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  tests/xfs/2000     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/2000.out | 17 ++++++++++++
>  2 files changed, 94 insertions(+)
> 
> diff --git a/tests/xfs/2000 b/tests/xfs/2000
> new file mode 100755
> index 000000000000..26a0093c1da1
> --- /dev/null
> +++ b/tests/xfs/2000
> @@ -0,0 +1,77 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Red Hat.  All Rights Reserved.
> +#
> +# FS QA Test No. 2000
> +#
> +# Test that XFS can set quota project ID on special files
> +#
> +. ./common/preamble
> +_begin_fstest auto quota
> +
> +# Import common functions.
> +. ./common/quota
> +. ./common/filter
> +
> +_wants_kernel_commit xxxxxxxxxxx \
> +	"xfs: allow setting file attributes on special files"
> +_wants_git_commit xfsprogs xxxxxxxxxxx \
> +	"xfs_quota: utilize file_setattr to set prjid on special files"

These syscalls aren't going to be backported to old kernels, so I think
these two tests are going to need a _require_file_getattr to skip them.

--D

> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_xfs_quota
> +_require_test_program "af_unix"
> +_require_symlinks
> +_require_mknod
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_qmount_option "pquota"
> +_scratch_mount
> +
> +create_af_unix () {
> +	$here/src/af_unix $* || echo af_unix failed
> +}
> +
> +filter_quota() {
> +	_filter_quota | sed "s~$tmp.projects~PROJECTS_FILE~"
> +}
> +
> +projectdir=$SCRATCH_MNT/prj
> +id=42
> +
> +mkdir $projectdir
> +mkfifo $projectdir/fifo
> +mknod $projectdir/chardev c 1 1
> +mknod $projectdir/blockdev b 1 1
> +create_af_unix $projectdir/socket
> +touch $projectdir/foo
> +ln -s $projectdir/foo $projectdir/symlink
> +touch $projectdir/bar
> +ln -s $projectdir/bar $projectdir/broken-symlink
> +rm -f $projectdir/bar
> +
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -cp $projectdir $id" $SCRATCH_DEV | filter_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "report -inN -p" $SCRATCH_DEV
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
> +
> +# Let's check that we can recreate the project (flags were cleared out)
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "report -inN -p" $SCRATCH_DEV
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/2000.out b/tests/xfs/2000.out
> new file mode 100644
> index 000000000000..dd3918f1376d
> --- /dev/null
> +++ b/tests/xfs/2000.out
> @@ -0,0 +1,17 @@
> +QA output created by 2000
> +Setting up project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> +Checking project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> +#0                   3          0          0     00 [--------]
> +#42                  8         20         20     00 [--------]
> +
> +Clearing project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> +Setting up project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> +#0                   3          0          0     00 [--------]
> +#42                  8         20         20     00 [--------]
> +
> +Clearing project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> 
> -- 
> 2.49.0
> 
> 

