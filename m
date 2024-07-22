Return-Path: <linux-fsdevel+bounces-24090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0859393D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 20:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC52D1F22024
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 18:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A8116EBF0;
	Mon, 22 Jul 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVsQcElm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17FB17BCD;
	Mon, 22 Jul 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721674041; cv=none; b=U6tKIO6lK5wyVYQy+P2r+szmk4ajHPoPlWeljfIxPQAk2P8rhLHfmcdavIORNAmwugZrhRuvZS+bw6FMRIGacOtFtHkau15h+J5IgdEUBBkiQnD3p+BYOYcBHb74JjrWKmIvun+zI8ZMC1cAY8ghbCzPLVOKWeag/Fb0tb+Cs/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721674041; c=relaxed/simple;
	bh=S5GrtjtULSXbV/i+L84ILs3JF/xVcMZrP+WqTjpfT4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyQnfUe5QRbJzNxpHhJPXAQxuPP7qeCEF1MCOfz4Uy/Ld+Fsmr3M8FlZkzPZ5OgMBnGQNA4l6+WVKbg4FPnNeQboyLAo09Z0zMSb2XrJXBq1mHaQ9RfLZ9NnRnYsk4q7RCMjt32w2Wc/y8neDjQSTM4rBIWphpQfxZulCfQDTB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVsQcElm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2848CC116B1;
	Mon, 22 Jul 2024 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721674041;
	bh=S5GrtjtULSXbV/i+L84ILs3JF/xVcMZrP+WqTjpfT4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVsQcElmV6Uk9t857GfLrLLA2sWQftrlFMlMuYedPSrAE6Bt4IutcKpPuE5H48uS5
	 n2xNEW1+LCuQ+hFTpPI21S7a1dQIPBjFhxlRAeSgeVLxeYdf4ywKCc2c0Zh7KaCVJN
	 iGseaeuUOYVp0G0FfblbVqDAaytgzQcDZewB6cvxVJ+HNDnn8fIB0BxM8G44MTW8MM
	 pxYmUaAyzbHlM30yX9V5EfKLX+u+PQd2HvlBryptw6JJCi8/auUIFxUwvjHyx2EmwQ
	 QPCPlBvc3PFjP7LCtGNhHSC6ouiJBTaAzkUjbpTNJPh9DlNiSvzILBanyQ2scKFbxy
	 hRGsSx6M9LWJg==
Date: Mon, 22 Jul 2024 11:47:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: alx@kernel.org, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	dchinner@redhat.com, martin.petersen@oracle.com,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v5 2/3] readv.2: Document RWF_ATOMIC flag
Message-ID: <20240722184720.GI103014@frogsfrogsfrogs>
References: <20240722095723.597846-1-john.g.garry@oracle.com>
 <20240722095723.597846-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722095723.597846-3-john.g.garry@oracle.com>

On Mon, Jul 22, 2024 at 09:57:22AM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add RWF_ATOMIC flag description for pwritev2().
> 
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> [jpg: complete rewrite]
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Sounds good to me now!  Thanks for taking care of the documentation!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  man/man2/readv.2 | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/man/man2/readv.2 b/man/man2/readv.2
> index eecde06dc..7737eb65c 100644
> --- a/man/man2/readv.2
> +++ b/man/man2/readv.2
> @@ -237,6 +237,50 @@ the data is always appended to the end of the file.
>  However, if the
>  .I offset
>  argument is \-1, the current file offset is updated.
> +.TP
> +.BR RWF_ATOMIC " (since Linux 6.11)"
> +Requires that writes to regular files in block-based filesystems be issued with
> +torn-write protection.
> +Torn-write protection means that for a power or any other hardware failure,
> +all or none of the data from the write will be stored,
> +but never a mix of old and new data.
> +This flag is meaningful only for
> +.BR pwritev2 (),
> +and its effect applies only to the data range written by the system call.
> +The total write length must be power-of-2 and must be sized in the range
> +.RI [ stx_atomic_write_unit_min ,
> +.IR stx_atomic_write_unit_max ].
> +The write must be at a naturally-aligned offset within the file with respect to
> +the total write length.
> +For example,
> +a write of length 32KiB at a file offset of 32KiB is permitted,
> +however a write of length 32KiB at a file offset of 48KiB is not permitted.
> +The upper limit of
> +.I iovcnt
> +for
> +.BR pwritev2 ()
> +is given by the value in
> +.I stx_atomic_write_segments_max.
> +Torn-write protection only works with
> +.B O_DIRECT
> +flag,
> +i.e. buffered writes are not supported.
> +To guarantee consistency from the write between a file's in-core state with the
> +storage device,
> +.B O_SYNC
> +or
> +.B O_DSYNC
> +must be specified for
> +.BR open (2).
> +The same synchronized I/O guarantees as described in
> +.BR open (2)
> +are provided when these flags or their equivalent flags and system calls are
> +used (e.g.
> +if
> +.BR RWF_SYNC
> +is specified for
> +.BR pwritev2 ()
> +).
>  .SH RETURN VALUE
>  On success,
>  .BR readv (),
> @@ -280,9 +324,26 @@ values overflows an
>  value.
>  .TP
>  .B EINVAL
> +If
> +.BR RWF_ATOMIC
> +is specified,
> +the combination of the sum of the
> +.I iov_len
> +values and the
> +.I offset
> +value does not comply with the length and offset torn-write protection rules.
> +.TP
> +.B EINVAL
>  The vector count,
>  .IR iovcnt ,
>  is less than zero or greater than the permitted maximum.
> +If
> +.BR RWF_ATOMIC
> +is specified,
> +this maximum is given by the
> +.I stx_atomic_write_segments_max
> +value from
> +.I statx.
>  .TP
>  .B EOPNOTSUPP
>  An unknown flag is specified in \fIflags\fP.
> -- 
> 2.31.1
> 
> 

