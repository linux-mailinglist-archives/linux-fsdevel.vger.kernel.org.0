Return-Path: <linux-fsdevel+bounces-58205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E38EB2B0B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D664B1706F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 18:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5808A272E45;
	Mon, 18 Aug 2025 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHJ4Xe3m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD413270578;
	Mon, 18 Aug 2025 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542481; cv=none; b=kngCj+7IJnSvvXkxOpVvVREIeVIzaJyYsXxYM9+xFwwnQ4ZmUav8ZJB+2QOVQw1n2t8qDtKRS8kDPhH/i3G3zYSgHSCVtGs2OEuDsiKwsG95DCXJgOz7xa7+zGDtn3tzdTRzE44oa1wlrPSj9qfvfFqb4vWgb84sQoNTF3/y+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542481; c=relaxed/simple;
	bh=CtAYfO2IYLVcLxjp6Yh8VbsIO3Fxt3jRtboig2jxedM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFqaMIUh81LwgmB+4AXC1tuzVznOztAeaeyT7jU0FTAOAaOEzYE6Klfz9p0BGDkdtM8fQnmdX+ASXnaWdiBXGlCJ3nS6WFfNmXgP+alC8jmGeZX3z0POFESQx249DRrpHQjc6v01AL3FSrdhbg9SFPmmKnbLjxJYptq5pr7KECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHJ4Xe3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2BFC4CEEB;
	Mon, 18 Aug 2025 18:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755542481;
	bh=CtAYfO2IYLVcLxjp6Yh8VbsIO3Fxt3jRtboig2jxedM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHJ4Xe3mHyBvDvHkEEzvJW+TKn/uLLAayLKSMg5DU+g5nd9ub4cO3h+bo3oKHd7Lo
	 dDlYiEhrEpIR0WSx68ioefVcrJQEFDIFUEqt5mnuLkuV2YCQhkcsOxwbpcfxcTaa5Q
	 vUmHjAfstKRxm4c4I0IrHu79x59WBellDrjuNdPe0hfOOp6JckeMNXMiirj1/NwVWF
	 tv66KPtGDDzqioK9wWu43hSKXMEFejTbUWovxtAmUDTBdjYodNobkFP5t0/tu0oXFP
	 d1o5VkcN73HHzgGAkrIAK0auGyN6C94waH6/03L4sGxoHTE2JB00GiVMOwrsElrXdb
	 TDuDgzNAaMGOQ==
Date: Mon, 18 Aug 2025 20:40:44 +0200
From: Nicolas Schier <nsc@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: [PATCH v2 5/7] gen_initramfs.sh: use gen_init_cpio -o parameter
Message-ID: <aKNzrJfBXTMaBiVi@levanger>
References: <20250814054818.7266-1-ddiss@suse.de>
 <20250814054818.7266-6-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814054818.7266-6-ddiss@suse.de>

On Thu, Aug 14, 2025 at 03:18:03PM +1000, David Disseldorp wrote:
> gen_init_cpio can now write to a file directly, so use it when
> gen_initramfs.sh is called with -o (e.g. usr/Makefile invocation).
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  usr/gen_initramfs.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
> index 14b5782f961a8..7eba2fddf0ef2 100755
> --- a/usr/gen_initramfs.sh
> +++ b/usr/gen_initramfs.sh
> @@ -193,7 +193,8 @@ root_gid=0
>  dep_list=
>  timestamp=
>  cpio_list=$(mktemp ${TMPDIR:-/tmp}/cpiolist.XXXXXX)
> -output="/dev/stdout"
> +# gen_init_cpio writes to stdout by default
> +output=""
>  
>  trap "rm -f $cpio_list" EXIT
>  
> @@ -207,7 +208,7 @@ while [ $# -gt 0 ]; do
>  			shift
>  			;;
>  		"-o")	# generate cpio image named $1
> -			output="$1"
> +			output="-o $1"
>  			shift
>  			;;
>  		"-u")	# map $1 to uid=0 (root)
> @@ -246,4 +247,4 @@ done
>  
>  # If output_file is set we will generate cpio archive
>  # we are careful to delete tmp files
> -usr/gen_init_cpio $timestamp $cpio_list > $output
> +usr/gen_init_cpio $output $timestamp $cpio_list

I think it would have been sufficient to replace '> $output' by
'-o $output'.

