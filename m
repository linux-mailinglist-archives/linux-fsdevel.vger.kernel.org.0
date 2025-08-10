Return-Path: <linux-fsdevel+bounces-57200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC44B1F876
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 07:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D987D1895BAC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 05:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF5B1E32DB;
	Sun, 10 Aug 2025 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BvQcHguB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C61B3930
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Aug 2025 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754803073; cv=none; b=B8ibk+pUAIhx3IFz6H0o6ZJlJkuo+gh+8HMvAjErg1DbtQKbFrjdYinB42imZ7ezXrpR1kYBM3p30JGYDzbQijt2tWU1320hAgNdHt8+JVDZoH2949QUQJSRkOepBTKijgNQvrd2vDmUXt9md97bShVkOPvb1Lk77eZt1cz5z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754803073; c=relaxed/simple;
	bh=eJWlyaAVngrMc4OKpGPn6zQsUMafkn+QfJrG0y6May4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC/ojeYkkTeuZJxyt8km7P4LV7CJwJ/quCIUBfDSXjxelInKJu1C81IFXZyawNJFBHifmPKvihuG/QKke+MSNWKILaNitUdxq6OnL/4BPK/E1+ffJ6jdmfvxkvSYZB0w2G/rFEm/b+hx9LFJunAQERK/vxxpwkb7sls4g++fH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BvQcHguB; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 10 Aug 2025 01:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754803059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3zLGRqEQBXs1PMEq9OQg4uzdZaiL0yhhtQXm4ID90w=;
	b=BvQcHguBd2i767dTJJaAdkon6X4rQE75wP5iv3KxKG2rV50nAnWB1hG+MX+7bAAntnY1jz
	R33apOPkD8QdhEU3D8QE+KcXvSNRMgGp6jCV78m6EeojHOBLu0n/5aDf7zZBvsHOPnnatD
	DHbLDyQM9Z1btVnZGM6RCb4Lu6BFkls=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Gerald B. Cox" <gbcox@bzb.us>
Cc: Sasha Levin <sashal@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Josef Bacik <josef@toxicpanda.com>, Aquinas Admin <admin@aquinas.su>, 
	Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Carl E. Thompson" <list-bcachefs@carlthompson.net>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <57voowmvkgwgdagj4olsig25sqjnuge3efqvqdr4xg4qp6co6d@geacqqv4mkno>
References: <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <20250809192156.GA1411279@fedora>
 <2z3wpodivsysxhxmkk452pa4zrwxsu5jk64iqazwdzkh3rmg5y@xxtklrrebip2>
 <20250810022436.GA966107@mit.edu>
 <k6e6f3evjptze7ifjmrz2g5vhm4mdsrgm7dqo7jdatkde5pfvi@3oiymjvy6f3e>
 <aJgaiFS3aAEEd78W@lappy>
 <2e47wkookxa2w6l2hv4qt2776jrjw5lyukul27nqhyqp5fsyq2@5mvbmay7qn2g>
 <CACLvpcxmnXFmgfwGCyUJe1chz5vLkxbg3=NzayYOKWi4efHrqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLvpcxmnXFmgfwGCyUJe1chz5vLkxbg3=NzayYOKWi4efHrqQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 09, 2025 at 09:26:16PM -0700, Gerald B. Cox wrote:
> Please excuse, sending this again because I forgot to put in plain text mode.
> 
> Been watching this thread unfold. There are valid concerns, sure—but
> I’d caution folks against mistaking frustration for hostility.
> 
> Kent’s been carrying a heavy load with bcachefs, and it shows. Solo
> stewardship at this scale isn’t just technical—it’s psychological.
> When someone’s under pressure and feels attacked, responses get sharp.
> That’s not ideal, but it’s not malicious either.
> 
> If we’re serious about maintaining a healthy kernel community, we need
> to be better at recognizing when someone’s burning out—and not make it
> worse. The CoC isn’t just there to call out bad behavior; it’s
> supposed to guide us toward empathy and restraint.
> 
> Kent, if you’re reading this: it’s clear you’re reacting to what feels
> like a pile-on. That’s understandable. But at this point, stepping
> back might serve you better than continuing to reply. Let the code
> speak. Let others weigh in. You’ve done the hard part—now give it
> room.

Thanks; I really appreciate this response.

The thing is, the burnout isn't coming from bcachefs. It has been an
absolutely monumental effort - but looking back and where we're at now,
I can't describe how lucky I and the bcachefs community have been at how
smoothly it's gone. I've been doing storage for a long time, and I know
what can happen when things go badly; when I look at the bug tracker now
I count my lucky stars.

And the bcachefs community has been amazing, I have a ton of people I
work with on a daily basis, and people see and appreciate the work I do;
when people show up with bugs to report - people are often shocked at
how quickly we're able to get it sorted, it's almost always downright
pleasant experiences where we all get to learn something and someone new
joins the community. I'm honestly proud of the community I've built and
proud of the people I work with.

We've got more engineers coming in and getting up to speed on the code
(THANK YOU ALAN for all the work you've done on the syzbot bugs!);
funding is now stable (Thank you, Valve! They do a ton of amazing stuff
for Linux).

But dealing with upstream has left me at my wit's end, and well past
that. I'm not going to describe the effects it's caused... I'll just
leave off there.

