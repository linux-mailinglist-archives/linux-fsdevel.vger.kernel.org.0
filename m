Return-Path: <linux-fsdevel+bounces-58203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6D8B2B0AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275E91961861
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0D0270577;
	Mon, 18 Aug 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/ce/qwP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2A49620;
	Mon, 18 Aug 2025 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542477; cv=none; b=oMdwm+UW/UU9OmRja9Je290YBNNsDOR/hElhow06ikDTaE15PmPb0kEpx+Bj5FuyaotLuNPZzjdEaoq7XZIWkmLMxWQFaYzQM3PzNicosNDPusrS25ulcbqeCNgENLGT6fz0dzEDvvvrKWWDNnX7p3Xs0N/brN1GEpw2Hd5Y8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542477; c=relaxed/simple;
	bh=HTE2nZfj7BPRAeoKiMTW2zoYQT6KnVd1IbuKX8Egkg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgK4kAyP6V3p7AyL9/+LkJs+Jz9B/FZZEOBKsbT7FpcdLfn4/0hK4L0AEmPeSsfy4cnjFHGRJNgEuhqozxhgtXSRIKvJmS4RsnU0Jo/70+ccyjd2FlK0ei9HuBUq7Y/P4wUAP7GBfvExGrs9ZSGRx9fEEzQmE+q7SquOrHWdS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/ce/qwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C856C4CEEB;
	Mon, 18 Aug 2025 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755542476;
	bh=HTE2nZfj7BPRAeoKiMTW2zoYQT6KnVd1IbuKX8Egkg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/ce/qwP/XOodpfMPdRgl7K2+76R3u/AJFP4irh9aTGocmH4FE+rWyyxJ3BtlrQgI
	 S/oLa9OZc1uO1zZBBTc2/t1eVYCco62wTfLFCyCP/TBQ+BuU36J40y4/xxQbfDLkk5
	 IimZ2dGiqqlDvxmoHr6SzhWSL5hhofEn03BNaiaI8BJylvTSsesbVwyjewJXsNB+bz
	 q+paiLQ3KJhzPZ6KshIslXYrEL1EUOy028/Fb5X0KUVlEOoywTHcoUUrHvpNEAie5f
	 hFOBrH49uHF3nwcQ05u2gkZ6Hzol5lzz8vgT/lvn64pub2wD6u0Lgdohhsb6h+rzdB
	 r4vo5XdnzDQXg==
Date: Mon, 18 Aug 2025 20:40:34 +0200
From: Nicolas Schier <nsc@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: [PATCH v2 2/7] gen_init_cpio: support -o <output_path> parameter
Message-ID: <aKNzon8sMXtpNItJ@levanger>
References: <20250814054818.7266-1-ddiss@suse.de>
 <20250814054818.7266-3-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814054818.7266-3-ddiss@suse.de>

On Thu, Aug 14, 2025 at 03:18:00PM +1000, David Disseldorp wrote:
> This is another preparatory change to allow for reflink-optimized
> cpio archives with file data written / cloned via copy_file_range().
> The output file is truncated prior to write, so that it maps to
> usr/gen_initramfs.sh usage. It may make sense to offer an append option
> in future, for easier archive concatenation.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  usr/gen_init_cpio.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> index d8779fe4b8f1f..563594a0662a6 100644
> --- a/usr/gen_init_cpio.c
> +++ b/usr/gen_init_cpio.c
> @@ -110,7 +110,7 @@ static int cpio_trailer(void)
>  	 || push_pad(padlen(offset, 512)) < 0)
>  		return -1;
>  
> -	return 0;
> +	return fsync(outfd);
>  }
>  
>  static int cpio_mkslink(const char *name, const char *target,
> @@ -532,7 +532,7 @@ static int cpio_mkfile_line(const char *line)
>  static void usage(const char *prog)
>  {
>  	fprintf(stderr, "Usage:\n"
> -		"\t%s [-t <timestamp>] [-c] <cpio_list>\n"
> +		"\t%s [-t <timestamp>] [-c] [-o <output_path>] <cpio_list>\n"
>  		"\n"
>  		"<cpio_list> is a file containing newline separated entries that\n"
>  		"describe the files to be included in the initramfs archive:\n"
> @@ -569,7 +569,8 @@ static void usage(const char *prog)
>  		"as mtime for symlinks, directories, regular and special files.\n"
>  		"The default is to use the current time for all files, but\n"
>  		"preserve modification time for regular files.\n"
> -		"-c: calculate and store 32-bit checksums for file data.\n",
> +		"-c: calculate and store 32-bit checksums for file data.\n"
> +		"<output_path>: write cpio to this file instead of stdout\n",

gen_init_cpio writes only a single output file (instead of multiple
files to an output directory), I'd suggest to name the parameter just
'file' or 'output_file'.


I'd like to see the the '... -o ...' patch right after this one.



For compilability, I had to add

#define _LARGEFILE64_SOURCE

or

#define _GNU_SOURCE

as you do in the next patch, in order to get O_LARGEFILE defined.


Kind regards,
Nicolas

