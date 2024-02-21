Return-Path: <linux-fsdevel+bounces-12277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D68B85E365
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A61B25E12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232A981AA5;
	Wed, 21 Feb 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aauweU1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4F33E495
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533066; cv=none; b=sboCgrC2fxDX6beMqyeleGEZ0sjc2Luv8wunR+V/CK3BtWDHVc7ByKMmSOBjcJX4rQ5siif3feoh4bqjk/n/crt9NcvjlLrlMym5SFsRj5MsGJ2AAf7oXY2/kuKhhbIsAtNvVDVGVXV8GEHeqxgIF8034UipDKfKc01UEl0QR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533066; c=relaxed/simple;
	bh=eKP07L/I9Hnm7yoCUygnCc3+Pf0BBxzUgJyW0226EI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ri7Zl8W3mmwphuWszYubhBLeWp3Rr8Fh2/o904IN5uR7Z9qHomxD6cA721r0V3Kjiw0CPtZvdC41PegccfoJrNh7TI8nw8QANPlL1n2+nW84ttweSvMefuuObJvNGqyeuyw9pLqaDH6dYoqr4yHcmuR/KzMA8ufwRngRZXkmKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aauweU1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F2FC433C7;
	Wed, 21 Feb 2024 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708533066;
	bh=eKP07L/I9Hnm7yoCUygnCc3+Pf0BBxzUgJyW0226EI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aauweU1TQTFIUnMmuPb2VzufbZtNabY6SQeaX0x0sKakLjmbrO/zJvooJwwHzFmPw
	 6EmWJNL9fE6RkhJxFV5K5B877gSct/w4pDqpPUBv5lN3b68ZkkCqU3OgD326l4wDfF
	 NwkNhNtrbCAF/3O54zoY+SUFHRY62JxM1t6PUpoE+41ldlMx9TW9Edkkm1AD55Wi78
	 mpi5yu8Rg7iE4AvJ81kN+Hwi3Mso626xkcT4pkRmlzUQYjwHYNlA/Rua9H4lBArNTB
	 qOwc9PKNXr7UMJiGtuYg+EPTllXJ0PT/M7QIFo6IwjsYoBLYmoPxhljloN3dN3CaYx
	 n0Fs8TVZu9hIA==
Date: Wed, 21 Feb 2024 08:31:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kassey Li <quic_yingangl@quicinc.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Add processed for iomap_iter
Message-ID: <20240221163105.GG6184@frogsfrogsfrogs>
References: <20240219021138.3481763-1-quic_yingangl@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219021138.3481763-1-quic_yingangl@quicinc.com>

On Mon, Feb 19, 2024 at 10:11:38AM +0800, Kassey Li wrote:
> processed: The number of bytes processed by the body in the
> most recent  iteration, or a negative errno. 0 causes the iteration to
> stop.
> 
> The processed is useful to check when the loop breaks.
> 
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>

Heh, sorry I didn't even see this one before it got merged, but:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/trace.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index c16fd55f5595..ff87ac58b6b7 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -165,6 +165,7 @@ TRACE_EVENT(iomap_iter,
>  		__field(u64, ino)
>  		__field(loff_t, pos)
>  		__field(u64, length)
> +		__field(s64, processed)
>  		__field(unsigned int, flags)
>  		__field(const void *, ops)
>  		__field(unsigned long, caller)
> @@ -174,15 +175,17 @@ TRACE_EVENT(iomap_iter,
>  		__entry->ino = iter->inode->i_ino;
>  		__entry->pos = iter->pos;
>  		__entry->length = iomap_length(iter);
> +		__entry->processed = iter->processed;
>  		__entry->flags = iter->flags;
>  		__entry->ops = ops;
>  		__entry->caller = caller;
>  	),
> -	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx length 0x%llx flags %s (0x%x) ops %ps caller %pS",
> +	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx length 0x%llx processed %lld flags %s (0x%x) ops %ps caller %pS",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		   __entry->ino,
>  		   __entry->pos,
>  		   __entry->length,
> +		   __entry->processed,
>  		   __print_flags(__entry->flags, "|", IOMAP_FLAGS_STRINGS),
>  		   __entry->flags,
>  		   __entry->ops,
> -- 
> 2.25.1
> 
> 

