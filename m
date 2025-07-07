Return-Path: <linux-fsdevel+bounces-54176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21EFAFBCAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0838A169C4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D9421FF30;
	Mon,  7 Jul 2025 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t+bucOOz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AAD2264AD
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920764; cv=none; b=qjfUkjftLsRmt81STReL9hEVFcl3ulb6er/L313gQ2/4hUZYlatYv4BEdY8zubdGekNCFUduoAG9CtZx8riq0KCSnYI2yYgx+PCGGWf7UXNN5b9hgub0zr56fqHAZQigCLhN0k0nL2GdhQwOV10EQFZjBY6J3nElulBB9kVTqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920764; c=relaxed/simple;
	bh=rjLa6AXjsim1n4tWgGoYki/voX5t/VWIZIyagSE1kiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr3KgN4DAi++WuvZn8cZMe6LvaJLrBei/2TywaBGr9tR/jcln0VJm0iUVRupUPTo7u9VCiPbvU5/hFOi5KA3xQD0H64bpyR0op08kVbptrF4UAjmD/+p0q00BORf1r7bB7FoR5SM2z+bYzCLX6HAtkXpKcr7ungu5kA3fwEC4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t+bucOOz; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 7 Jul 2025 16:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751920749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSj+RrRVg7elakQo//mzU9XNj7ZAPUtOH5WQTGKN4Mk=;
	b=t+bucOOz7VknLpxUu4hkPRH6/XJdUv9/jJ8EFbA8OvqAzRPn5g2ojdF+U42Qr8FVg5+Ue8
	EiMR2CzYEgYSsIrOIIcj9PidJtWSdXO1qemTZW/mDkd6bsudq6NNIEXEZgrknXBf/t2mXZ
	gFIe5weNSrP4vn17Vfa+2Mq+bhIPCIg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: John Stoffel <john@stoffel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kerenl@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
Message-ID: <r2ibma56tp7mwqepp7ksenmcrildo6n4wnmj3aa7l3vdpyk26r@42azsnav5bm2>
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
 <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
 <xl2fyyjk4kjcszcgypirhoyflxojzeyxkzoevvxsmo26mklq7i@jw2ou76lh2py>
 <26723.62463.967566.748222@quad.stoffel.home>
 <gq2c4qlivewr2j5tp6cubfouvr42jww4ilhx3l55cxmbeotejk@emoy2z2ztmi2>
 <26732.10255.420410.321937@quad.stoffel.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26732.10255.420410.321937@quad.stoffel.home>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 07, 2025 at 04:03:27PM -0400, John Stoffel wrote:
> If those users are not prepared to accept the risk of an experimental
> filesystem, then screw them!  They're idiots and should be treated as
> such.  

No, that's not the attitude of a responsible filesystem developer.

It doesn't matter what stage of development the code is in, if it's got
users and they're hitting bugs, those bugs take priority. "Screw the
user" is no way to develop a filesystem that people will actually want
to run.

If we want to attain rock solid, bulletproof reliability, then
reliability, top to bottom, has to be the priority at every stage of
development. The job is not done until it is working well and verified
for everyone.

> > Shipping a project as large and complex as a filesystem must be done
> > incrementally, in stages where we're deploying to gradually increasing
> > numbers of users, fixing everything they find and assessing where we're
> > at before opening it up to more users.
> 
> Yes!  But that process also has to include rollbacks, which git has
> made so so so easy.  Just accept that _if_ 6.x-rc[12345] is buggy,
> then it needs to be rolled back and subbmitted to 6.x+1-rc1 for the
> next cycle after it's been baked.

I'm very quick to kick out buggy patches; simple regressions where a
revert is the correct solution almost never hit Linus's tree. This isn't
the issue we're talking about.

> > Right now we need to be getting those fixes out to users so
> > they can keep testing and finding the next bug. When someone has
> > invested time and effort learning how the system works and how to
> > report bugs, we don't watn them getting frustrated and leaving - we
> > want to work with them, so they can keep testing and finding new
> > bugs.
> 
> So post patches on your own tree that they can use, nothing stops you! 

That is indeed what it comes down to, isn't it?

I support my code. I triage every bug report, prioritizing the critical
bugs, and I spend most of my day working with users to track bugs down
and make sure the fixes work.

That's my job.

If fixes aren't going into Linus's tree, that means the working,
supported bcachefs tree is no longer his tree, it's mine.

We've been down that road with other subsystems in the past (e.g.
Lustre), and it doesn't work.

Going down that road means the first thing I have to do with every bug
report is ask "which tree are you running? stock mainline or mine?" -
and then we might as well go all the way and go the DKMS route, for the
sake of everyone's sanity.

