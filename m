Return-Path: <linux-fsdevel+bounces-59506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6504B3A2B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290BE18830B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35504312828;
	Thu, 28 Aug 2025 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9lCxvns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F53101C6;
	Thu, 28 Aug 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392692; cv=none; b=Wh7aH8LmAlWQMV41GEBUTjihhc/1vADrvDOTjq34pmCUeDBrtrQrxDZru9jeDvigfC6n2UcbNhxQqTXuA6MXFA7NyWyXJkXGcIkv1S7rKtfsHorXXHfC1PfvTpIKwRkYU8KBM2qEuk2eOGsFnR4OBG7zfzahGK+4n8YHF6Z36iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392692; c=relaxed/simple;
	bh=OvVqtfth6j/jTCd/BPJWhhcrg/xi0V4w72KJLJRWXBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs8xQcjsNRDfET6Ii1Nbb1Uk/N2Z2sQLqGuHY9wln+GsAMvCKw/Jx5gx1VhAbaVuIaDjKYtDr7hQmiMrLGE2AoPU8ff9Zg1/gbTH4qlDu/MdteIWF74Z8tTMWnj9IvYjhm8656rNt8bd9zGZ9algx2OqLEQTLgzwL4MHzfQd838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9lCxvns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B4BC4CEED;
	Thu, 28 Aug 2025 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756392692;
	bh=OvVqtfth6j/jTCd/BPJWhhcrg/xi0V4w72KJLJRWXBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9lCxvns0J6wsynNxwfMG34Xgf5M4z9TBDcNdICD7H5BzNqAClhdjIYH8VplNUrHM
	 RyFftL3sGh62/fGsifzLAHjMv/X7uTZyJ+KCOppyPu+zqtIKE8LOvP8Tzja+tE9vpB
	 ZOvYeXb68WNwfBw7I9lMcMLYd+5OI+T4Sd39HB6GfLUzG9BoBwsm0gTq3u6ZphYpib
	 OUvYigLB3Q7tjRu3D+UipBF6OTJtl/zzxMy10GYcw2NtQ5A6thyIbR6L7R+bN/wvDQ
	 h38mm2TPyOJ9z0drPI5y9bNrH6FCO6+pSbOP7OqfobQdxQguVij2d2WjVZcqSnE/Ro
	 Zos0sf61y4Q9Q==
Date: Thu, 28 Aug 2025 07:51:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v2 3/3] xfs: test quota's project ID on special files
Message-ID: <20250828145131.GG8096@frogsfrogsfrogs>
References: <20250827-xattrat-syscall-v2-0-ba489b5bc17a@kernel.org>
 <20250827-xattrat-syscall-v2-3-ba489b5bc17a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-xattrat-syscall-v2-3-ba489b5bc17a@kernel.org>

On Wed, Aug 27, 2025 at 05:16:17PM +0200, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> With addition of file_getattr() and file_setattr(), xfs_quota now can
> set project ID on filesystem inodes behind special files. Previously,
> quota reporting didn't count inodes of special files created before
> project initialization. Only new inodes had project ID set.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

I'm glad we can finally set the project ids on irregular files!
Thanks for the functional test of the new syscalls. :)

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/xfs/2000     | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/2000.out | 15 +++++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/tests/xfs/2000 b/tests/xfs/2000
> new file mode 100755
> index 000000000000..7d45732bdbb7
> --- /dev/null
> +++ b/tests/xfs/2000
> @@ -0,0 +1,73 @@
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
> +# Modify as appropriate.
> +_require_scratch
> +_require_xfs_quota
> +_require_test_program "af_unix"
> +_require_test_program "file_attr"
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
> +	-c "report -inN -p" $SCRATCH_DEV | _filter_project_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
> +
> +# Let's check that we can recreate the project (flags were cleared out)
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "report -inN -p" $SCRATCH_DEV | _filter_project_quota
> +$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/2000.out b/tests/xfs/2000.out
> new file mode 100644
> index 000000000000..e53ceb959775
> --- /dev/null
> +++ b/tests/xfs/2000.out
> @@ -0,0 +1,15 @@
> +QA output created by 2000
> +Setting up project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> +Checking project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> +#42 8 20 20 00 [--------]
> +
> +Clearing project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> +Setting up project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> +#42 8 20 20 00 [--------]
> +
> +Clearing project 42 (path SCRATCH_MNT/prj)...
> +Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
> 
> -- 
> 2.49.0
> 
> 

