Return-Path: <linux-fsdevel+bounces-7822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AD382B753
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 23:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379A01C24223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 22:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3877858AD7;
	Thu, 11 Jan 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HxmS06Nw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674B055C2E;
	Thu, 11 Jan 2024 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FBdSemuyRjH5lgodevRh9cV2/2y1pbWgdTd3FSRoLsM=; b=HxmS06Nw5lrV+uYkba7CvIkMYS
	0Kj+xPpcFOycFsmUyKHph4vxCvwZK+XesR8Tzl/CIf/PYsAxiyZe7/4J1KFT5dqogVdlL1DUJFbFS
	qaDt5Rs6KLrXNrAVCNEbjXuT2YzNIrTzyqUPHCbNOJUL4wlUvdczNM/Mry8G+IZcNPNr5c5tZ/Tj1
	3rsALIRz1bcvbBTUYsUKnkLfv4k43mEEKdbTKuSsTOI+ecZPxaW4qO7FRBBa+rMKhTzR2RHZyeED0
	kb97HNDN1wzoe54rCiraWvXvEMYE5f7xzOzsYY3314pAKl/Fu1c0saoLVIXf6Vx2wwDCIKVPp0kgt
	tIyHNtuA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rO3zC-00FBqZ-D4; Thu, 11 Jan 2024 22:57:18 +0000
Date: Thu, 11 Jan 2024 22:57:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Kees Cook <keescook@chromium.org>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <ZaByTq3uy0NfYuQs@casper.infradead.org>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook>
 <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook>
 <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <CAHk-=wigjbr7d0ZLo+6wbMk31bBMn8sEwHEJCYBRFuNRhzO+Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wigjbr7d0ZLo+6wbMk31bBMn8sEwHEJCYBRFuNRhzO+Kw@mail.gmail.com>

On Wed, Jan 10, 2024 at 05:47:20PM -0800, Linus Torvalds wrote:
> No, because the whole idea of "let me mark something deprecated and
> then not just remove it" is GARBAGE.
> 
> If somebody wants to deprecate something, it is up to *them* to finish
> the job. Not annoy thousands of other developers with idiotic
> warnings.

What would be nice is something that warned about _new_ uses being
added.  ie checkpatch.  Let's at least not make the problem worse.

