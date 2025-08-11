Return-Path: <linux-fsdevel+bounces-57381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DF8B20D55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF7D425C19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462CB2E03E1;
	Mon, 11 Aug 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtSeYYum"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D717C220;
	Mon, 11 Aug 2025 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925461; cv=none; b=HOksPTVtFAp5OT7qS2nnAXhWElrHFJZ+jrfZr/cL98qWiAByrM7gYweL6Jmk/0R7BDQHAy9vYFV1Q+GIll0TY7kgrlnDHqVfqvVRCtsnoL0Mi5B6u0o6L2h3wxUpvjhgONv0gwSamg4a2lxXndHOC/Z9kOB9+pltahWGJ3WOdTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925461; c=relaxed/simple;
	bh=+u2qdFuWd0th1TkEjzFGU52HyIz2dNDsEpZrt2xA4F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pkavt5NUFXysqyw0FrsbgQz57pPyijyH94aiNk9AGtkMGj8HZT9QqOn2mxy7EYIh1ms3lk15aINkIZ9/QtCJ0z2rgzhhlT/Y2HfxPs78sLya2RG5Vz5+wjxVplmil1lFAUblCZx0KCt7Bo8sYtJuDYGAEUOcVj0pRuAK/VajKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtSeYYum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D79C4CEED;
	Mon, 11 Aug 2025 15:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754925461;
	bh=+u2qdFuWd0th1TkEjzFGU52HyIz2dNDsEpZrt2xA4F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AtSeYYumA10rytDpW/BdvXWk25RCzsckoCPnaU1tk9QKkaVO0TZNsKdUt/S7CPa1j
	 Qq0RcODPCxV31BF9UAwkVcqWhrWGUVL5MyWcofevLSb6TGEG/gbj4kA+1g8j4TxoVW
	 9NWwSyDyk1yT9psIBy6JIFonFAiATWUxq2cD73JeWHRXsjPO+Frx3UJBAmxFD9kmz0
	 jSdsBxTZLDEulQIuu3aL16E0gstECVOgi93loBIa0Cjx3eTdiZMpBM026wL0QFqMcG
	 LKXj0uQ6EAgrJ/RxCASJH5JVc6QmgzRYd+721TNLWosAqjIsZinNH3jJCpn2OpQIIa
	 ov+rNFdeR4yEw==
Date: Mon, 11 Aug 2025 08:17:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 2/3] generic: introduce test to test
 file_getattr/file_setattr syscalls
Message-ID: <20250811151740.GE7965@frogsfrogsfrogs>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
 <20250808-xattrat-syscall-v1-2-6a09c4f37f10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-xattrat-syscall-v1-2-6a09c4f37f10@kernel.org>

On Fri, Aug 08, 2025 at 09:31:57PM +0200, Andrey Albershteyn wrote:
> Add a test to test basic functionality of file_getattr() and
> file_setattr() syscalls. Most of the work is done in file_attr
> utility.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  tests/generic/2000     | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/2000.out |  37 ++++++++++++++++
>  2 files changed, 150 insertions(+)
> 
> diff --git a/tests/generic/2000 b/tests/generic/2000
> new file mode 100755
> index 000000000000..b4410628c241
> --- /dev/null
> +++ b/tests/generic/2000
> @@ -0,0 +1,113 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 2000
> +#
> +# Test file_getattr/file_setattr syscalls
> +#
> +. ./common/preamble
> +_begin_fstest auto
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +_wants_kernel_commit xxxxxxxxxxx \
> +	"fs: introduce file_getattr and file_setattr syscalls"
> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_test_program "af_unix"
> +_require_test_program "file_attr"
> +_require_symlinks
> +_require_mknod
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +file_attr () {
> +	$here/src/file_attr $*
> +}
> +
> +create_af_unix () {
> +	$here/src/af_unix $* || echo af_unix failed
> +}
> +
> +projectdir=$SCRATCH_MNT/prj
> +
> +# Create normal files and special files
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
> +echo "Error codes"
> +# wrong AT_ flags
> +file_attr --get --invalid-at $projectdir ./foo
> +file_attr --set --invalid-at $projectdir ./foo
> +# wrong fsxattr size (too big, too small)
> +file_attr --get --too-big-arg $projectdir ./foo
> +file_attr --get --too-small-arg $projectdir ./foo
> +file_attr --set --too-big-arg $projectdir ./foo
> +file_attr --set --too-small-arg $projectdir ./foo
> +# out of fsx_xflags mask
> +file_attr --set --new-fsx-flag $projectdir ./foo
> +
> +echo "Initial attributes state"
> +file_attr --get $projectdir
> +file_attr --get $projectdir ./fifo
> +file_attr --get $projectdir ./chardev
> +file_attr --get $projectdir ./blockdev
> +file_attr --get $projectdir ./socket
> +file_attr --get $projectdir ./foo
> +file_attr --get $projectdir ./symlink
> +
> +echo "Set FS_XFLAG_NODUMP (d)"
> +file_attr --set --set-nodump $projectdir
> +file_attr --set --set-nodump $projectdir ./fifo
> +file_attr --set --set-nodump $projectdir ./chardev
> +file_attr --set --set-nodump $projectdir ./blockdev
> +file_attr --set --set-nodump $projectdir ./socket
> +file_attr --set --set-nodump $projectdir ./foo
> +file_attr --set --set-nodump $projectdir ./symlink
> +
> +echo "Read attributes"
> +file_attr --get $projectdir
> +file_attr --get $projectdir ./fifo
> +file_attr --get $projectdir ./chardev
> +file_attr --get $projectdir ./blockdev
> +file_attr --get $projectdir ./socket
> +file_attr --get $projectdir ./foo
> +file_attr --get $projectdir ./symlink
> +
> +echo "Set attribute on broken link with AT_SYMLINK_NOFOLLOW"
> +file_attr --set --set-nodump $projectdir ./broken-symlink
> +file_attr --get $projectdir ./broken-symlink
> +
> +file_attr --set --no-follow --set-nodump $projectdir ./broken-symlink
> +file_attr --get --no-follow $projectdir ./broken-symlink
> +
> +cd $SCRATCH_MNT
> +touch ./foo2
> +echo "Initial state of foo2"
> +file_attr --get --at-cwd ./foo2
> +echo "Set attribute relative to AT_FDCWD"
> +file_attr --set --at-cwd --set-nodump ./foo2
> +file_attr --get --at-cwd ./foo2
> +
> +echo "Set attribute on AT_FDCWD"
> +mkdir ./bar
> +file_attr --get --at-cwd ./bar
> +cd ./bar
> +file_attr --set --at-cwd --set-nodump ""
> +file_attr --get --at-cwd .
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/2000.out b/tests/generic/2000.out
> new file mode 100644
> index 000000000000..51b4d84e2bae
> --- /dev/null
> +++ b/tests/generic/2000.out
> @@ -0,0 +1,37 @@
> +QA output created by 2000
> +Error codes
> +Can not get fsxattr on ./foo: Invalid argument
> +Can not get fsxattr on ./foo: Invalid argument
> +Can not get fsxattr on ./foo: Argument list too long
> +Can not get fsxattr on ./foo: Invalid argument
> +Can not get fsxattr on ./foo: Argument list too long
> +Can not get fsxattr on ./foo: Invalid argument
> +Can not set fsxattr on ./foo: Invalid argument
> +Initial attributes state
> +----------------- /mnt/scratch/prj 

Assuming SCRATCH_DIR=/mnt/scratch on your system, please _filter_scratch
the output.

(The rest looks reasonable to me.)

--D

> +----------------- ./fifo 
> +----------------- ./chardev 
> +----------------- ./blockdev 
> +----------------- ./socket 
> +----------------- ./foo 
> +----------------- ./symlink 
> +Set FS_XFLAG_NODUMP (d)
> +Read attributes
> +------d---------- /mnt/scratch/prj 
> +------d---------- ./fifo 
> +------d---------- ./chardev 
> +------d---------- ./blockdev 
> +------d---------- ./socket 
> +------d---------- ./foo 
> +------d---------- ./symlink 
> +Set attribute on broken link with AT_SYMLINK_NOFOLLOW
> +Can not get fsxattr on ./broken-symlink: No such file or directory
> +Can not get fsxattr on ./broken-symlink: No such file or directory
> +------d---------- ./broken-symlink 
> +Initial state of foo2
> +----------------- ./foo2 
> +Set attribute relative to AT_FDCWD
> +------d---------- ./foo2 
> +Set attribute on AT_FDCWD
> +----------------- ./bar 
> +------d---------- . 
> 
> -- 
> 2.49.0
> 
> 

