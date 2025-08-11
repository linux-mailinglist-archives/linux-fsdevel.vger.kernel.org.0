Return-Path: <linux-fsdevel+bounces-57362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A120B20BCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7CA7A1B54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9567248895;
	Mon, 11 Aug 2025 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B1FivQUg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA3246783
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922372; cv=none; b=e6gtZ/29oA5U4UQUpOyTC4CM2ihcidIAapZQfcc9ecMaQ4O7IMyMnL8gKvjBUPD3hYWBnRkciwLNA72/GNBlimxGCZAVvY+23ySAYrdT7y/hUxtDGvFNfpbqTIBDLzYfanso0rec1Dmlff/mf4aDHK/Z3y/F+f0nJOMsGqiDoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922372; c=relaxed/simple;
	bh=Gpgif4jJQvzanWKJOJ2s9ZDQOWPc1/PQaHnckHjCNmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cyifvm2jqHo88eeipRtZb1eav8okIgv/eonAswAOFz8VEabypnhu+jLlE8wg+rMJeqsoAH+EzqEUVHzGzPj2zEy1V6JOr0Z7Ei4nQ1xxqo+TrKWohqS1ERZJYL3OV96b4JMhFRbcr7gdyb+oeUKs59KIIsPkmgRr6aFBIVfy8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B1FivQUg; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 11 Aug 2025 10:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754922367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6rsFHxkQsnak3YFY7+1+x3Sg0pa/9qbnvIjHnk7aBE=;
	b=B1FivQUgvpvJLB61xJM8hVKYlrmhN3IFbY6GpfOTI0aX5GH/dn8Xpqak7qRBv7S6vSHJFD
	P9H6f2rhqAxvzDuw9gmXv0oR/HL8oU6JJcs+GckwpX/DveuBvxSw0XQRkJG+H0EG8tZ5X5
	ZKOJWabEeP+tmcj7qeFeEbO2WZWyb60=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Konstantin Shelekhin <k.shelekhin@ftml.net>
Cc: admin@aquinas.su, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, list-bcachefs@carlthompson.net, 
	malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 11, 2025 at 12:51:11PM +0300, Konstantin Shelekhin wrote:
> >  Yes, this is accurate. I've been getting entirely too many emails from Linus about
> > how pissed off everyone is, completely absent of details - or anything engineering
> > related, for that matter.
> 
> That's because this is not an engineering problem, it's a communication problem. You just piss
> people off for no good reason. Then people get tired of dealing with you and now we're here,
> with Linus thinking about `git rm -rf fs/bcachesfs`. Will your users be happy? Probably not.
> Will your sponsors be happy? Probably not either. Then why are you keep doing this?
> 
> If you really want to change the way things work go see a therapist. A competent enough doctor
> probably can fix all that in a couple of months.

Konstantin, please tell me what you're basing this on.

The claims I've been hearing have simply lacked any kind of specifics;
if there's people I'd pissed off for no reason, I would've been happy to
apologize, but I'm not aware of the incidences you're claiming - not
within a year or more; I have made real efforts to tone things down.

On the other hand, for the only incidences I can remotely refer to in
the past year and a half, there has been:

- the mm developer who started outright swearing at me on IRC in a
  discussion about assertions
- the block layer developer who went on a four email rant where he,
  charitably, misread the spec or the patchset or both; all this over a
  patch to simply bring a warning in line with the actual NVME and SCSI
  specs.
- and reference to an incident at LSF, but the only noteworthy event
  that I can recall at the last LSF (a year and a half ago) was where a
  filesystem developer chased a Rust developer out of the community.

So: what am I supposed to make of all this?

To an outsider, I don't think any of this looks like a reasonable or
measured response, or professional behaviour. The problems with toxic
behaviour have been around long before I was prominent, and they're
still in evidence.

It is not reasonable or professional to jump from professional criticism
of code and work to personal attacks: it is our job to be critical of
our own and each other's code, and while that may bring up strong
feelings when we feel our work is attacked, that does not mean that it
is appropriate to lash out.

We have to separate the professional criticism from the personal.

It's also not reasonable or professional to always escelate tensions,
always look for the upper hand, and never de-escalate.

As a reminder, this all stems from a single patch, purely internal to
fs/bcachefs/, that was a critical, data integrity hotfix.

There has been a real pattern of hyper reactive, dramatic responses to
bugfixes in the bcachefs pull requests, all the way up to full blown
repeated threats of removing it from the kernel, and it's been toxic.

And it's happening again, complete with full blown rants right off the
bat in the private maintainer thread about not trusting my work (and I
have provided data and comparisons with btrfs specifically to rebut
that), all the way to "everyone hates you and you need therapy". That is
not reasonable or constructive.

This specific thread was in response to Linus saying that bcachefs was
imminently going to be git rm -rf'd, "or else", again with zero details
on that or else or anything that would make it actionable.

Look, I'm always happy to sit down, have a beer, talk things out, and
listen.

If there's people I have legitimately pissed off (and I do not include
anyone who starts swearing at me in a technical discussion) - let me
know, I'll listen. I'm not unapproachable, I'm not going to bite your
head off.

I've mended fences with people in the past; there were people I thought
I'd be odds with forever, but all it really takes is just talking. Say
what it is that you feel has affected, be willing to listen and turn,
and it gets better.

