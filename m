Return-Path: <linux-fsdevel+bounces-23965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCBC937096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 00:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87F71F21FA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 22:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5A9146016;
	Thu, 18 Jul 2024 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AOFI4+IF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3BE1386BF
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721341457; cv=none; b=iwfCca2zQ5W0V1LfpLn6wZHV0s7Epxy/1MyLWhWS0gNSaOT7axznNc0JYAOi6s8+4vci0L1pPXkdTA54lBOAbfPsTWkYafUtXoM2sMChz2UJDFm0Z8wpUbBSAyZG8yXS+UdKxwer8IV9rKuiabBxsKRmxW7Tn2GLb2Dhu0ps83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721341457; c=relaxed/simple;
	bh=l1ERU79x0rWVEeuuXc1iu4AW4Co90oq3mVLqBjFPi50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tK6jkVTI0S7iefbAEu8zRu7S6j5ZOSSyveV6a6Ys2XA5YBTIfJoHPBqPDylqh5ZpmDR9FU8BW8TEd3Or8vwaAN8qlJ5BBdze7QUfqr+3NJQVsTHyhBapuj5wIUoZwf773A9TtnP3/cU+BOiBDgrmDPi5oOkukVAELJVF8UIsJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AOFI4+IF; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721341451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/ZOzuuAVfYpoVsRCrl5has0gH/pZv30+PUlL5NnO4E=;
	b=AOFI4+IF0cvcPpE82lRFtWdD9xKrlKETu1AJFNmSa7quxc40uxeITUz4G3u76vTAaCX2wH
	SuKWFcuK91QDLsdh0hOGeEhFUJNGBtZizYGqKHbT6V8qpm8/NsSoN+s6jN8hjwsT+N5LG+
	BeEJW03Q9bbAjAcmkwwhmGOlIQJNdQY=
X-Envelope-To: longman@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Thu, 18 Jul 2024 18:24:08 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.11
Message-ID: <4l32ehljkxjavy3d2lwegx3adec25apko3v355tnlnxhrs43r4@efhplbikcoqs>
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
 <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com>
 <5ypgzehnp2b3z2e5qfu2ezdtyk4dc4gnlvme54hm77aypl3flj@xlpjs7dbmkwu>
 <CAHk-=wgzMxdCRi9Fqhq2Si+HzyKgWEvMupq=Q-QRQ1xgD_7n=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgzMxdCRi9Fqhq2Si+HzyKgWEvMupq=Q-QRQ1xgD_7n=Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 18, 2024 at 03:06:07PM GMT, Linus Torvalds wrote:
> On Thu, 18 Jul 2024 at 14:21, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > But my master branch (previously the same as for-next) will now be
> > for-next merged with the latest tag from your tree, and I may do
> > similarly for bcachefs-for-upstream if it's needed.
> 
> No. No back-merges. We actually have documentation about this, so I
> won't repeat the hundreds of emails I've sent out:

Sorry, I must not have been clear. My master branch is a) not where I do
development, and b) not not a branch that I will be sending to you -
that's simply the primary branch I publish for people testing the latest
bcachefs code.

So: master will now be just updated by a hook on the server whenever I
update for-next.

> There are valid reasons to rebase, but they are balanced against some
> VERY valid reasons not to do it, so if you have to rebase, make sure
> those reasons really outweigh the reasons not to.
> 
> And don't do it just before a pull request - and if there is some
> catastrophic event that caused a recent rebase, let me know in the
> pull request.

Yes, this will help with that; last cycle I had to rebase at rc4 because
of something my testers were hitting, but it wasn't affecting my
development so with the new setup my development branches will be able
to stay based on rc1.

> > As a bonus, this means the testing automation will now be automatically
> > testing my branch + your latest
> 
> No. That's what linux-next is about - it does integration testing.

Oh?

Does it now?

I've gotten essentially zero in the way of test feedback from for-next
(except from Stephen Rothwell directly, the odd build warning or merge
issue, but 0day mostly catches the build stuff before it hits next).

And I don't think the rest of the filesystem community is any different,
because a major subject at LSF this year was in fact the need for
someone to start a fs-next branch for integration testing.

> Your development branch IS NOT FOR TESTING OTHER RANDOM THINGS.
> 
> You are actively making things worse if you do: you should worry about
> YOUR code, not about all the random other things going on.
> 
> Now, if you want to do _additional_ testing along the lines of "what
> happens with my branch and Linus' latest" then that is ok - but that
> should be something you see as completely separate from testing your
> own work.

Yes, that's exactly what I was describing.
> 
> IOW, you can certainly wear "multiple hats" - your bcachefs developer
> hat that worries about your bcachefs branch, and if you want to *also*
> do some integration testing, go right ahead and have another
> "integration testing branch" that you then test separately.
> 
> But I don't want your integration path. When I get a bcachefs pull, I
> want the *bcachefs* side to be solid and tested. Not something else.

Ditto

> So by all means keep multiple branches for different reasons. If you
> think you have users that need to test some integration branch (which
> honestly sounds like a horrible idea, but you do you),

No, the integration branch isn't for testing other code, it's because
they don't want to be running rc1 if rc4 or rc7 is out.

That's literally all it is.

