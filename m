Return-Path: <linux-fsdevel+bounces-58317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CDFB2C84B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CF71BC31C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C214A28468E;
	Tue, 19 Aug 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD6Nm8hx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2021FF48;
	Tue, 19 Aug 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616666; cv=none; b=GOikiTw25HMIaWcxIhl9HgAJen0wEpHEMq0GAz4xzKwJgD0UPyrNYLb5xS7lsv6S9PTf4Bo3ZFPQmyMVa0ql6aYmlsgtauObkqDHg8YXFTx4optN8j7ZWfD+bmr0A0jAOgh13S1rezzx4mXg8c2UCqmCWVugWwqDjnaIwZd0mRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616666; c=relaxed/simple;
	bh=YC3YqkY+ubMJ+BckfgV8x/v8nTzqCv3hnNV1WNYIJqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9OticoUjFR81/LZ1mxWK71qyoI2JzSVXhtV1xC9CqUaSw6R2JeWygbtwADJb9lrJAijWXNrhMHNa3lqxWltRp4r9ANxiYY697EV4e5tNBmxB9qgD4vjh1k7Bg/RpRyNFs9hJW/1V4jJLvlKZZLkD+IW2mP+PxPrWrIyFjGW/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD6Nm8hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A38DC4CEF1;
	Tue, 19 Aug 2025 15:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755616665;
	bh=YC3YqkY+ubMJ+BckfgV8x/v8nTzqCv3hnNV1WNYIJqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bD6Nm8hxsVqxV6iX0p8kZ95x/tUAVmv+VI7eQPr5Jd0OewxBu+WwuPok1kZiL9MfK
	 zXcheZ5nVB3l7NQCxUqXAvrveLMeeXaFRE6VwBqtNbdmzldBlAJgPSGuCszNZwYd4A
	 jDDH/hPB2yyjRFvoggiNU2TAv4GygI/iwznAIaQR/V10I+sqrwmZshlvnzMvH+vQDk
	 4x0O/cN3oq4keY0xgornwcUx/U1F2hjRgoTA4hvqyhk1hRsDwPpoCUF/qB0bvv4NRp
	 hiu+rL5hRGT91qdCmifo37zUFRDQNFPKhAz5dftSbKacOVTm/Oc7r5yDeJJ2oLdk1N
	 mZ/xLrIak4efA==
Date: Mon, 18 Aug 2025 21:23:36 +0200
From: Nicolas Schier <nsc@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: [PATCH v2 7/7] gen_init_cpio: add -a <data_align> as reflink
 optimization
Message-ID: <aKN9uMf0HeD1Fgqk@levanger>
References: <20250814054818.7266-1-ddiss@suse.de>
 <20250814054818.7266-8-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814054818.7266-8-ddiss@suse.de>

On Thu, Aug 14, 2025 at 03:18:05PM +1000, David Disseldorp wrote:
> As described in buffer-format.rst, the existing initramfs.c extraction
> logic works fine if the cpio filename field is padded out with trailing
> zeros, with a caveat that the padded namesize can't exceed PATH_MAX.
> 
> Add filename zero-padding logic to gen_init_cpio, which can be triggered
> via the new -a <data_align> parameter. Performance and storage
> utilization is improved for Btrfs and XFS workloads, as copy_file_range
> can reflink the entire source file into a filesystem block-size aligned
> destination offset within the cpio archive.
> 
> Btrfs benchmarks run on 6.15.8-1-default (Tumbleweed) x86_64 host:
>   > truncate --size=2G /tmp/backing.img
>   > /sbin/mkfs.btrfs /tmp/backing.img
>   ...
>   Sector size:        4096        (CPU page size: 4096)
>   ...
>   > sudo mount /tmp/backing.img mnt
>   > sudo chown $USER mnt
>   > cd mnt
>   mnt> dd if=/dev/urandom of=foo bs=1M count=20 && cat foo >/dev/null
>   ...
>   mnt> echo "file /foo foo 0755 0 0" > list
>   mnt> perf stat -r 10 gen_init_cpio -o unaligned_btrfs list
>   ...
>             0.023496 +- 0.000472 seconds time elapsed  ( +-  2.01% )
> 
>   mnt> perf stat -r 10 gen_init_cpio -o aligned_btrfs -a 4096 list
>   ...
>            0.0010010 +- 0.0000565 seconds time elapsed  ( +-  5.65% )
> 
>   mnt> /sbin/xfs_io -c "fiemap -v" unaligned_btrfs
>   unaligned_btrfs:
>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>      0: [0..40967]:      695040..736007   40968   0x1
>   mnt> /sbin/xfs_io -c "fiemap -v" aligned_btrfs
>   aligned_btrfs:
>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>      0: [0..7]:          26768..26775         8   0x0
>      1: [8..40967]:      269056..310015   40960 0x2000
>      2: [40968..40975]:  26776..26783         8   0x1
>   mnt> /sbin/btrfs fi du unaligned_btrfs aligned_btrfs
>        Total   Exclusive  Set shared  Filename
>     20.00MiB    20.00MiB       0.00B  unaligned_btrfs
>     20.01MiB     8.00KiB    20.00MiB  aligned_btrfs
> 
> XFS benchmarks run on same host:
>   > sudo umount mnt && rm /tmp/backing.img
>   > truncate --size=2G /tmp/backing.img
>   > /sbin/mkfs.xfs /tmp/backing.img
>   ...
>            =                       reflink=1    ...
>   data     =                       bsize=4096   blocks=524288, imaxpct=25
>   ...
>   > sudo mount /tmp/backing.img mnt
>   > sudo chown $USER mnt
>   > cd mnt
>   mnt> dd if=/dev/urandom of=foo bs=1M count=20 && cat foo >/dev/null
>   ...
>   mnt> echo "file /foo foo 0755 0 0" > list
>   mnt> perf stat -r 10 gen_init_cpio -o unaligned_xfs list
>   ...
>             0.011069 +- 0.000469 seconds time elapsed  ( +-  4.24% )
> 
>   mnt> perf stat -r 10 gen_init_cpio -o aligned_xfs -a 4096 list
>   ...
>             0.001273 +- 0.000288 seconds time elapsed  ( +- 22.60% )
> 
>   mnt> /sbin/xfs_io -c "fiemap -v" unaligned_xfs
>    unaligned_xfs:
>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>      0: [0..40967]:      106176..147143   40968   0x0
>      1: [40968..65023]:  147144..171199   24056 0x801
>   mnt> /sbin/xfs_io -c "fiemap -v" aligned_xfs
>    aligned_xfs:
>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>      0: [0..7]:          120..127             8   0x0
>      1: [8..40967]:      192..41151       40960 0x2000
>      2: [40968..40975]:  236728..236735       8   0x0
>      3: [40976..106495]: 236736..302255   65520 0x801
> 
> The alignment is best-effort; a stderr message is printed if alignment
> can't be achieved due to PATH_MAX overrun, with fallback to non-padded
> filename. This allows it to still be useful for opportunistic alignment,
> e.g. on aarch64 Btrfs with 64K block-size. Alignment failure messages
> provide an indicator that reordering of the cpio-manifest may be
> beneficial.
> 
> Archive read performance for reflinked initramfs images may suffer due
> to the effects of fragmentation, particularly on spinning disks. To
> mitigate excessive fragmentation, files with lengths less than
> data_align aren't padded.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  usr/gen_init_cpio.c | 50 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 12 deletions(-)

Thanks!  Testing with a massively oversized initramfs (600MB) was fun:
from 2:44 down to 38s.


Questions that pop up in my mind:
Now, how can we make other benefit from this?  Might it make sense to
introduce a kconfig variable for initramfs alignment -- even though this
is just a build-time optimisation of few seconds?


Kind regards,
Nicolas

