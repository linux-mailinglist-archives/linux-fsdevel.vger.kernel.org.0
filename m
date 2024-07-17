Return-Path: <linux-fsdevel+bounces-23882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B47A934417
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 23:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CAB6282DED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 21:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C75187877;
	Wed, 17 Jul 2024 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHoDtraM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4B187325;
	Wed, 17 Jul 2024 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252664; cv=none; b=YNKLTwp+x4TRLI/dqI8VO+9ZSQGgLvbscTNErbxrHUflvQD8W/LT+CNzjZYX3oiTY6D27p2l/NWl0zPy9egQ55LoNsTtQQgUO5cE4OscHgRT2+YQvmBKA7qk0a238r9Qe2nyD4bEyRTFKI3W0loK5C0z5Fttvdv3UbrC8EhFdj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252664; c=relaxed/simple;
	bh=Du+HWZ56Bco444d6kt0zYds/0gqGYf/+QFxGUCa/2IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oO3gBhw1CqmrIBBiueHf3fGqWNANkAWpQPjfQ5jmp7p+UttgCqwelemLxTFqjLlYZXgD4N7YJmsYkj9DG9zgq6Uf146klTLprQzQXNGVcD15ZlZwYJ+iGOPsKIW351N01oFsKAbUJmKSbYAPeiymlVlICqXGLQNulBWU5zZf5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHoDtraM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF64C2BD10;
	Wed, 17 Jul 2024 21:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721252664;
	bh=Du+HWZ56Bco444d6kt0zYds/0gqGYf/+QFxGUCa/2IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHoDtraMIEtVP1so5xeUBh4Yh8I1IPH7qsjZpVWthUso0KE5MY4eYvi0/j0DXX2lQ
	 sqE9VZUVcFU4WYq0rBUVvIkq80X2sZlMfxSPYMWM6K5NVtmligd5C9xEh7Pu18xQvq
	 92yJCfxaz/oSx681chBmd/ZabNU5xWxRNnL0cZoAuPJQshlgEKUZmD7zg0sZV6RQTQ
	 kLEUUBsJCDN/RRUVmCbrPASBReAg4QyW3MXXmD1ccTmVCHZKlqxW04Uln3oNfvPDqB
	 fx+9SQS7x5DFsxbW9X83Cp2ELkzijltqu2FGsEoU7s4hXYY5tge1QlNdaJRe50ZLk1
	 mOl3pjY1mduQw==
Date: Wed, 17 Jul 2024 14:44:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: alx@kernel.org, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	dchinner@redhat.com, martin.petersen@oracle.com,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v4 2/3] readv.2: Document RWF_ATOMIC flag
Message-ID: <20240717214423.GI1998502@frogsfrogsfrogs>
References: <20240717093619.3148729-1-john.g.garry@oracle.com>
 <20240717093619.3148729-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717093619.3148729-3-john.g.garry@oracle.com>

On Wed, Jul 17, 2024 at 09:36:18AM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add RWF_ATOMIC flag description for pwritev2().
> 
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> [jpg: complete rewrite]
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  man/man2/readv.2 | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/man/man2/readv.2 b/man/man2/readv.2
> index eecde06dc..9c8a11324 100644
> --- a/man/man2/readv.2
> +++ b/man/man2/readv.2
> @@ -193,6 +193,66 @@ which provides lower latency, but may use additional resources.
>  .B O_DIRECT
>  flag.)
>  .TP
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
> +the total write length -
> +for example,

Nit: these could be two sentences

"The write must be at a naturally-aligned offset within the file with
respect to the total write length.  For example, ..."

> +a write of length 32KB at a file offset of 32KB is permitted,
> +however a write of length 32KB at a file offset of 48KB is not permitted.

Pickier nit: KiB, not KB.

> +The upper limit of
> +.I iovcnt
> +for
> +.BR pwritev2 ()
> +is in

"is given by" ?

> +.I stx_atomic_write_segments_max.
> +Torn-write protection only works with
> +.B O_DIRECT
> +flag, i.e. buffered writes are not supported.
> +To guarantee consistency from the write between a file's in-core state with the
> +storage device,
> +.BR fdatasync (2),
> +or
> +.BR fsync (2),
> +or
> +.BR open (2)
> +and either
> +.B O_SYNC
> +or
> +.B O_DSYNC,
> +or
> +.B pwritev2 ()
> +and either
> +.B RWF_SYNC
> +or
> +.B RWF_DSYNC
> +is required. Flags

This sentence   ^^ should start on a new line.

> +.B O_SYNC
> +or
> +.B RWF_SYNC
> +provide the strongest guarantees for
> +.BR RWF_ATOMIC,
> +in that all data and also file metadata updates will be persisted for a
> +successfully completed write.
> +Just using either flags
> +.B O_DSYNC
> +or
> +.B RWF_DSYNC
> +means that all data and any file updates will be persisted for a successfully
> +completed write.

"any file updates" ?  I /think/ the difference between O_SYNC and
O_DSYNC is that O_DSYNC persists all data and file metadata updates for
the file range that was written, whereas O_SYNC persists all data and
file metadata updates for the entire file.

Perhaps everything between "Flags O_SYNC or RWF_SYNC..." and "...for a
successfully completed write." should instead refer readers to the notes
about synchronized I/O flags in the openat manpage?

> +Not using any sync flags means that there is no guarantee that data or
> +filesystem updates are persisted.
> +.TP
>  .BR RWF_SYNC " (since Linux 4.7)"
>  .\" commit e864f39569f4092c2b2bc72c773b6e486c7e3bd9
>  Provide a per-write equivalent of the
> @@ -279,10 +339,26 @@ values overflows an
>  .I ssize_t
>  value.
>  .TP
> +.B EINVAL
> + For
> +.BR RWF_ATOMIC
> +set,

"If RWF_ATOMIC is specified..." ?

(to be a bit more consistent with the language around the AT_* flags in
openat)

> +the combination of the sum of the
> +.I iov_len
> +values and the
> +.I offset
> +value does not comply with the length and offset torn-write protection rules.
> +.TP
>  .B EINVAL
>  The vector count,
>  .IR iovcnt ,
>  is less than zero or greater than the permitted maximum.
> +For
> +.BR RWF_ATOMIC
> +set, this maximum is in

(same)

--D

> +.I stx_atomic_write_segments_max
> +from
> +.I statx.
>  .TP
>  .B EOPNOTSUPP
>  An unknown flag is specified in \fIflags\fP.
> -- 
> 2.31.1
> 

