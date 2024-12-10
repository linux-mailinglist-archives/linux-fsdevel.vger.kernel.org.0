Return-Path: <linux-fsdevel+bounces-36977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498519EB926
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 19:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118E31889D11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AB61850AF;
	Tue, 10 Dec 2024 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NEEspu2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C124523ED59;
	Tue, 10 Dec 2024 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854544; cv=none; b=Pq0rblZCRSK5vFO+qyZK6CEW3HzPQrqMDrQaPnl77FcxZsNDKC1i+see/cT1eLQGcjBAK5u9qpd/k+OI3ltUS2f3h8JIPv/uZa8o1YCb/ctSZ7LI1wrBYA932roAm7v7iPDdKUCX9sL9p90AQ/KQljiOxu4zmWwh92fxJJOHhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854544; c=relaxed/simple;
	bh=MUgvN2LO4z97shSFG7P9yC0L4LFur7hd+6BDicaGC38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLa1Vw2XDIDLmpPAfAL7CZX52LgRFisxNxnmiGadKiedSPS4yl0uIIIrxB8BdvmxFZFo0NwFaNk+r5KvsOqkK+E2DJGESmTrFI5egybsJ7p9eLteCF1mcBQVotSGYayUt8OnZOl38O55C4FqVO518fWsXmG1pqbiAO690HrwXGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NEEspu2b; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jDhXgbgyx5KWrAQCTRL0SbVqDBJt06mti96q7/ZFnv4=; b=NEEspu2bx/5nmcoqsPkkyPwZ1c
	JrsjY0LBikcu/Yd8MwbeKeK/2vg82OEgZmNs/nc8fwiVIypqiuLkSAyQtET3BqpxSfA858WWJXQYa
	TrfsJlNPM1/zPYEwZQXmNsAILn7BE20jGUz5p6um1i/e7hzbP/MwpDaOfA1TAY+Clc9lUhmqAiDKt
	DKGA3J/TR/4qHKnUpW5xhXiDkpQ9863R8i1tgUXLFSI+xvkLP4roOkbtrjVg2OsdglHmAYp7ZiCv4
	z968P/rx++nybaL02dv9gkg3S3Z7uQ/TCocioXuHPJWLEspnWQ5SeWCKCvbMKGfzByPQKY/VmF0/Y
	I22AHreg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tL4ln-00000006yDB-2VGv;
	Tue, 10 Dec 2024 18:15:39 +0000
Date: Tue, 10 Dec 2024 18:15:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [MEH PATCH] fs: sort out a stale comment about races between fd
 alloc and dup2
Message-ID: <20241210181539.GE3387508@ZenIV>
References: <20241205154743.1586584-1-mjguzik@gmail.com>
 <20241206-inszenieren-anpflanzen-317317fd0e6d@brauner>
 <20241209195637.GY3387508@ZenIV>
 <CAGudoHH76NYH2O-TQw6ZPjZF5ht76HgiKtsG=owYdLZarGRwcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHH76NYH2O-TQw6ZPjZF5ht76HgiKtsG=owYdLZarGRwcA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 10, 2024 at 05:48:40AM +0100, Mateusz Guzik wrote:
 
> Oh huh. I had seen that code before, did not mentally register there
> may be repeat file alloc/free calls due to repeat path_openat.
> 
> Indeed it would be nice if someone(tm) sorted it out, but I don't see
> how this has any relation to installing the file early and thus having
> fget worry about it.

Other than the former being an obvious prereq for the latter?  Not much...

> Suppose the "embryo"/"larval" file pointer is to be installed early
> and populated later. I don't see a benefit but do see a downside: this
> requires protection against close() on the fd (on top of dup2 needed
> now).
> The options that I see are:
> - install the file with a refcount of 2, let dup2/close whack it, do a
> fput in open to bring back to 1 or get rid of it if it raced (yuck)
> (freebsd is doing this)
> - dup2 is already special casing to not mess with it, add that to
> close as well (also yuck imo)

As a possibility (again, I'm not sold on the benefits of that scheme,
just looking into feasibility):
	dup2() when evicting an embryo:
		mark it evicted
		remove from descriptor table
		do nothing to refcount (in effect, transfer it to open())
		then proceed as if it hadn't been there
		[== pretend that dup2() always loses the race]
	close() when running into an embryo
		return -EBADF
		[== pretend that close() always loses the race]
	open() when it's done setting file up:
		if opening failed
			if not marked evicted
				remove from descriptor table
			fput()
			return whatever error we've got
		else
			if marked evicted
				fput()
			return the descriptor
		[== pretend that open() always wins the race]
"open" in the above stands for everything that opens a descriptor - socket(2),
pipe(2), eventfd(2), whatever.

> >From userspace side the only programs which can ever see EBUSY are
> buggy or trying to screw the kernel, so not a concern on that front.

Agreed.  I'm not saying we should go that way.

