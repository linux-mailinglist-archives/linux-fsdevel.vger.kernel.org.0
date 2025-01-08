Return-Path: <linux-fsdevel+bounces-38625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56BA04FE5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 02:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95DEB7A1A79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97181537C8;
	Wed,  8 Jan 2025 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2knh6A/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFB86AE3;
	Wed,  8 Jan 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736301043; cv=none; b=CEGqOAOb59RiA9pZkPQnJ4hjXFIR9K07se4VJE8IwRYtHvSPDwdABzHevKwAwIZnmIqAa2KD7t1CKZMV5l4CHCuW2tXaJi28aH5p6AErQuPTSr6o/mB9i9P6PmfKJ2slB6fhQXB5WedL+Mzi6byA4eL9VAzZsBaD7EbPsjvwxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736301043; c=relaxed/simple;
	bh=DSGUzJdSZzfL57rQZO42U2Z9ROW5bEFH+MSYoaH0mHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6CvhKYfp4UHw9vkH8POydVPU88jLOetgjeoiMD25dCwdiC94x83AOy9P43TWXHcPOj0l6foeEiC6D0XyFyZeTZpXIR2Y6+Ih1jRvUOLYPPDJLupoH4jlECvg0TcQL9ttiF+QlFeLKUqy1WvL1rFKScIuxQeIIxUK4bmwtldzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2knh6A/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF804C4CED6;
	Wed,  8 Jan 2025 01:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736301042;
	bh=DSGUzJdSZzfL57rQZO42U2Z9ROW5bEFH+MSYoaH0mHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2knh6A/dJpC1MMELvtaLqg/VDm2xhn79zPNzRNdD/JhGLur+lQzUY6vaYN3ZqEse
	 7OW8uN09HpM67aQdb3h3GGS6g58iyhb4C1zBtB7dxgyGA93Rd6kk8ulwGS7dhhQEzl
	 kOTcV/xcM9C6wQ2QyNkZdH3nNaTNjw4D4/f6VDXEyBPUkpgRqbzKpJlxebB+BctRSU
	 ehs3puvEpaxSbctx+MDwF6XA0kfHYpDvfoOeb61+MnsNwM8jX1ZJSkY5fKp0Jy+hJ+
	 2KWSNHPKVUH0xFvEsV7NJebv131UR+gUQOzhQau5y3qYvokElk9XUDB734OUm3O6Gf
	 6GTBvx3kuDumg==
Date: Tue, 7 Jan 2025 17:50:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, willy@infradead.org,
	ojaswin@linux.ibm.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [xfstests PATCH v2] generic: add a partial pages zeroing out test
Message-ID: <20250108015042.GC1251194@frogsfrogsfrogs>
References: <20241225125120.1952219-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241225125120.1952219-1-yi.zhang@huaweicloud.com>

On Wed, Dec 25, 2024 at 08:51:20PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> This addresses a data corruption issue encountered during partial page
> zeroing in ext4 which the block size is smaller than the page size [1].
> Add a new test which is expanded upon generic/567, this test performs a
> zeroing range test that spans two partial pages to cover this case, and
> also generalize it to work for non-4k page sizes.
> 
> Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v1->v2:
>  - Add a new test instead of modifying generic/567.
>  - Generalize the test to work for non-4k page sizes.
> v1: https://lore.kernel.org/fstests/20241223023930.2328634-1-yi.zhang@huaweicloud.com/
> 
>  tests/generic/758     | 76 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/758.out |  3 ++
>  2 files changed, 79 insertions(+)
>  create mode 100755 tests/generic/758
>  create mode 100644 tests/generic/758.out
> 
> diff --git a/tests/generic/758 b/tests/generic/758
> new file mode 100755
> index 00000000..e03b5e80
> --- /dev/null
> +++ b/tests/generic/758
> @@ -0,0 +1,76 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test No. generic/758

"FS QA Test No. 758" is ok here, or whatever ./new spat out.

> +#
> +# Test mapped writes against zero-range to ensure we get the data
> +# correctly written. This can expose data corruption bugs on filesystems
> +# where the block size is smaller than the page size.
> +#
> +# (generic/567 is a similar test but for punch hole.)
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw zero
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $verifyfile $testfile

Don't bother deleting anything on $SCRATCH_MNT, it'll get mkfs'd out of
existence soon enough.

> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_require_test
> +_require_scratch
> +_require_xfs_io_command "fzero"
> +
> +verifyfile=$TEST_DIR/verifyfile

Also is there any harm in putting verifyfile on $SCRATCH_MNT and thereby
not having to override _cleanup?

--D

> +testfile=$SCRATCH_MNT/testfile
> +
> +pagesz=$(getconf PAGE_SIZE)
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +_dump_files()
> +{
> +	echo "---- testfile ----"
> +	_hexdump $testfile
> +	echo "---- verifyfile --"
> +	_hexdump $verifyfile
> +}
> +
> +# Build verify file, the data in this file should be consistent with
> +# that in the test file.
> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((pagesz * 3))" \
> +		-c "pwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> +		$verifyfile | _filter_xfs_io >> /dev/null
> +
> +# Zero out straddling two pages to check that the mapped write after the
> +# range-zeroing are correctly handled.
> +$XFS_IO_PROG -t -f \
> +	-c "pwrite -S 0x58 0 $((pagesz * 3))" \
> +	-c "mmap -rw 0 $((pagesz * 3))" \
> +	-c "mwrite -S 0x5a $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "fzero $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "mwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "close"      \
> +$testfile | _filter_xfs_io > $seqres.full
> +
> +echo "==== Pre-Remount ==="
> +if ! cmp -s $testfile $verifyfile; then
> +	echo "Data does not match pre-remount."
> +	_dump_files
> +fi
> +_scratch_cycle_mount
> +echo "==== Post-Remount =="
> +if ! cmp -s $testfile $verifyfile; then
> +	echo "Data does not match post-remount."
> +	_dump_files
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/758.out b/tests/generic/758.out
> new file mode 100644
> index 00000000..d01c1959
> --- /dev/null
> +++ b/tests/generic/758.out
> @@ -0,0 +1,3 @@
> +QA output created by 758
> +==== Pre-Remount ===
> +==== Post-Remount ==
> -- 
> 2.39.2
> 
> 

