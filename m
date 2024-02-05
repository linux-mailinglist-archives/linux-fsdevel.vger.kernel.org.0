Return-Path: <linux-fsdevel+bounces-10328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015DA849DDC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 16:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA45C1F24BAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 15:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ACA35EF1;
	Mon,  5 Feb 2024 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="cXOX1Ha2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD082E63B;
	Mon,  5 Feb 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146443; cv=none; b=cOlmXKceEivJtYnUDzmlRLT3rad4nTpKVry/cCPZS4cwJifCsWFGQZIHZbTY6jlt2GD92UROnqYAGKZ5qJBjE2DlL/MomPyO8G0r7XY7KALNqpMJBDlQ0tXKsytzS4U3kjZaYm9AW/XM3Hh7B4EITeoTKaVkQxrRX4Ll6EXeyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146443; c=relaxed/simple;
	bh=RcWOjD26WJ8My7Q+eCiNGU84jj3EPhEAksItK/992bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtZ1x+nZzQaSnv9w1ntR5GzP86CWn+PsrytinqF/LogzIvNIsQ3H6NIkFDFNG0O9kH02kFZ9CWC39cGcqz57pR1BkmykHjEdkphPAPBjRgy3qVI2HavAfh1vmjqvVa7O6ObtyrvIBGqbNN+z9cMGueDwLfdcHk4TSTL4IqL6/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=cXOX1Ha2; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TT9793Lcrz9snM;
	Mon,  5 Feb 2024 16:20:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707146437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O5QpBm9OVYV8g3cMHMrIijGXJuiMqqynbOTCB/oJ0aY=;
	b=cXOX1Ha29Ld4nfj9cuuSNhqtFhZEWJsriIMfUx2094ad47RC6zJWZZmfA/Kc27sAgINjfq
	DgHIsV7uu0KxFEgQgh5sr31Oe3RiP+vETLygLg4mQGjgMkfuIoZdmwkbtfVOq9inRz0hIh
	ZwNYYwE/ai4QYoI8bWSK8PTMfh2W24kBuBkl7U5w6bSMR9LhpivpBaTm+EEpb+hEn/qpSg
	L4H5+kodVLRutrE19pLE+Qx0Srp6to2AlnphJtg/Kq4dhY2CXQU82mYnv5eCt8HndzHMRM
	oWZCtVhtiyi+EohyJmzR66CAemW9Bab6rxKh2WWxi3Xan0v+2IOoE7UcakfiOA==
Date: Mon, 5 Feb 2024 16:20:32 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com, 
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com, 
	p.raghav@samsung.com
Subject: Re: [PATCH 1/6] fs: iomap: Atomic write support
Message-ID: <7ttdwk46hkj6ohdyq3ruwb2zkskzrpicz7dpf4g53v32nh7mgy@5g63yuoyotyi>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124142645.9334-2-john.g.garry@oracle.com>

On Wed, Jan 24, 2024 at 02:26:40PM +0000, John Garry wrote:
> Add flag IOMAP_ATOMIC_WRITE to indicate to the FS that an atomic write
> bio is being created and all the rules there need to be followed.
> 
> It is the task of the FS iomap iter callbacks to ensure that the mapping
> created adheres to those rules, like size is power-of-2, is at a
> naturally-aligned offset, etc. However, checking for a single iovec, i.e.
> iter type is ubuf, is done in __iomap_dio_rw().
> 
> A write should only produce a single bio, so error when it doesn't.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/iomap/direct-io.c  | 21 ++++++++++++++++++++-
>  fs/iomap/trace.h      |  3 ++-
>  include/linux/iomap.h |  1 +
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index bcd3f8cf5ea4..25736d01b857 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -275,10 +275,12 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		struct iomap_dio *dio)
>  {
> +	bool atomic_write = iter->flags & IOMAP_ATOMIC;

Minor nit: the commit says IOMAP_ATOMIC_WRITE and you set the enum as
IOMAP_ATOMIC in the code.

As the atomic semantics only apply to write, the commit could be just
reworded to reflect the code?

<snip>
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index c16fd55f5595..c95576420bca 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>  	{ IOMAP_REPORT,		"REPORT" }, \
>  	{ IOMAP_FAULT,		"FAULT" }, \
>  	{ IOMAP_DIRECT,		"DIRECT" }, \
> -	{ IOMAP_NOWAIT,		"NOWAIT" }
> +	{ IOMAP_NOWAIT,		"NOWAIT" }, \
> +	{ IOMAP_ATOMIC,		"ATOMIC" }
>  

