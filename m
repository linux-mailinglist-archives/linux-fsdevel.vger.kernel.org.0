Return-Path: <linux-fsdevel+bounces-23883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7B93441E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 23:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD561C21230
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9239E18C330;
	Wed, 17 Jul 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjeofoUR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A718A954;
	Wed, 17 Jul 2024 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252686; cv=none; b=rPT6SQCpb+Uvv7SWB3+NXT6RisB1YTx/Xb0ETRnZbstqeYDVozq9DjeWRTXoMZlR2pqkWPqlMzaRP8BD/U860lSgeqLHEz04P79Gf+H1zdiNneXFDMUE6guS7pIpix1g6OCZE4T2Z8pN5yRckmw6XFaKUGPYnk6ViCKRnGIlvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252686; c=relaxed/simple;
	bh=FEBudQVNl95vpCGTkugDg4r7nGZAj+Q+cg7cpwrx8yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMl9G33BDzDuRVYunnGHWjxZFakKpY4y94AQmcvqauj7pueMCzdktIffhBFyNDvIncQH9pUmtTqM36zAcxzOSXsLsv+Aj7DLcd3ytj04dXsHykhpgmsdNInoj5fhZHyO4dVV8YlbpdbsfUOnOLQ103FxcWe9nroio5r8pU38XQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjeofoUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7938FC2BD10;
	Wed, 17 Jul 2024 21:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721252685;
	bh=FEBudQVNl95vpCGTkugDg4r7nGZAj+Q+cg7cpwrx8yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjeofoURralzxPLYBf0NZAgT3liJ7CWyiMMHtTcnA1vE9Kb8FuYtT54EoiUswG6PA
	 knH2tr9mVujWL0Ctch9lpfl2tLYhx3UQBBuH9s9AMOJAzdIX5gECjHKTnF3uCxl4EU
	 lGIooPCdPMvKV37BnI7Nrw0pRF0hDNpv/QdOEVH0gDDNY7MowFg48nmNdGtisYlYSR
	 962vMr1K+z/aSGdxK014dMvB0a79eUTgcVnj38YO8sqjdypdxgBs23Cylr1kM1CWr2
	 s9TM3FUrApfUoLJYK7RfWRCgkY+U0AVqOKxcJOKu6W8SIRBDeW/prlRbtk4EVUnWds
	 WDJDKQ7tsDtag==
Date: Wed, 17 Jul 2024 14:44:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: alx@kernel.org, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	dchinner@redhat.com, martin.petersen@oracle.com
Subject: Re: [PATCH v4 3/3] io_submit.2: Document RWF_ATOMIC
Message-ID: <20240717214444.GJ1998502@frogsfrogsfrogs>
References: <20240717093619.3148729-1-john.g.garry@oracle.com>
 <20240717093619.3148729-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717093619.3148729-4-john.g.garry@oracle.com>

On Wed, Jul 17, 2024 at 09:36:19AM +0000, John Garry wrote:
> Document RWF_ATOMIC for asynchronous I/O.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  man/man2/io_submit.2 | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/man/man2/io_submit.2 b/man/man2/io_submit.2
> index c53ae9aaf..12b4a72d7 100644
> --- a/man/man2/io_submit.2
> +++ b/man/man2/io_submit.2
> @@ -140,6 +140,25 @@ as well the description of
>  .B O_SYNC
>  in
>  .BR open (2).
> +.TP
> +.BR RWF_ATOMIC " (since Linux 6.11)"
> +Write a block of data such that a write will never be torn from power fail or
> +similar.
> +See the description of
> +.B RWF_ATOMIC
> +in
> +.BR pwritev2 (2).
> +For usage with
> +.BR IOCB_CMD_PWRITEV,
> +the upper vector limit is in
> +.I stx_atomic_write_segments_max.
> +See
> +.B STATX_WRITE_ATOMIC
> +and
> +.I stx_atomic_write_segments_max
> +description
> +in
> +.BR statx (2).

Sounds good to me!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  .RE
>  .TP
>  .I aio_lio_opcode
> -- 
> 2.31.1
> 

