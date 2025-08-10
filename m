Return-Path: <linux-fsdevel+bounces-57190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 478BCB1F84C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 06:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFC3179DE4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 04:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B91D54E9;
	Sun, 10 Aug 2025 04:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZO3f0eFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FAE18FC92;
	Sun, 10 Aug 2025 04:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754799222; cv=none; b=CBRKr31fzdGNw/BkgEmy4i/9dvpucVHzEvDnP+jE8xsYqkFVgm4rHsIiEbNFktYEdoh7Sd2WpT4BRuG/1CCtZ2c1TjB/+YsH9U6cB3T8vgWWhdShsRUA4L7ks9vaJ9JIhrpMj5QpsPKoQfX8VjAzDLlM0iVJBEHipEkoMOuAXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754799222; c=relaxed/simple;
	bh=T8MgHSHg4V0gPP8P/sig4DHzyEXUy2xFEYPIDGAcH5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox8Zfid5oV65JoYT5iCXvFyzLN0xLKCZUnsSe/8//Xji/VnoPoSbFK+f0pRX3k8VdOcIN8sN3gmJXltqHexNP67SXneKX4iwhU2ZUFK0Qzo4xq3w/C2PLtHO+8VthoLzYMYoQvZgDl8E+lKDqmD5DpzdIIHVY6ApdhxD8gNFjO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZO3f0eFX; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 10 Aug 2025 00:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754799205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1mfOgujeLBQ45ACBW6yhiyCuz7+oNssPbIUGDzfhqy8=;
	b=ZO3f0eFXi062oiqS5kFeWbM2VyOrLXewyJL3+ngaQJx4LzJvAkc1ZdMAGmW74NYAokRSwr
	21T0uJwAaCel/zHHg46FwfgvJRk5Fn/f4JK5DEs1V9r0676PT2paGgjHudWZ6kSAReOtoF
	fbwFRUn55ZzqO0AY/FW37qfqWCZsD70=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sasha Levin <sashal@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>, 
	Aquinas Admin <admin@aquinas.su>, Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, "Carl E. Thompson" <list-bcachefs@carlthompson.net>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <2e47wkookxa2w6l2hv4qt2776jrjw5lyukul27nqhyqp5fsyq2@5mvbmay7qn2g>
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <20250809192156.GA1411279@fedora>
 <2z3wpodivsysxhxmkk452pa4zrwxsu5jk64iqazwdzkh3rmg5y@xxtklrrebip2>
 <20250810022436.GA966107@mit.edu>
 <k6e6f3evjptze7ifjmrz2g5vhm4mdsrgm7dqo7jdatkde5pfvi@3oiymjvy6f3e>
 <aJgaiFS3aAEEd78W@lappy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJgaiFS3aAEEd78W@lappy>
X-Migadu-Flow: FLOW_OUT

On Sun, Aug 10, 2025 at 12:05:28AM -0400, Sasha Levin wrote:
> On Sat, Aug 09, 2025 at 11:17:44PM -0400, Kent Overstreet wrote:
> > On Sat, Aug 09, 2025 at 10:24:36PM -0400, Theodore Ts'o wrote:
> > > And how did you respond?  By criticizing another file system, and
> > > talking about how wonderful you believe bcachefs to be, all of which
> > > is beside the point.  In fact, you once again demonstrated exactly why
> > > a very large number of kernel deevlopers have decided you are
> > > extremely toxic, and have been clamoring that your code be ejected
> > > from the kernel.  Not because of the code, but because your behavior.
> > 
> > I would dearly love to have not opened that up, but "let's now delete
> > bcachefs from the kernel" opened up that discussion, because our first
> > priority has to be doing right by users - and a decision like that
> > should absolutely be discussed publicly, well in advance, with all
> > technical arguments put forth.
> 
> Kent,
> 
> You say our first priority has to be doing right by users, and I agree -
> but doing right by users means maintaining a healthy, functioning
> development community. A toxic community that drives away contributors
> fails its users far more severely than the absence of any single
> filesystem ever could.
> 
> Look at this thread again. Really look at it. Neither Ted nor Josef
> raised a single technical argument against bcachefs. They didn't
> criticize your code, your design decisions, or your engineering. Josef
> explicitly praised your technical work. Ted has repeatedly shown respect
> for your code.  The discussions about potentially dropping bcachefs
> aren't happening because it's technically inferior to ext4, xfs, or
> btrfs. They're happening because your personal interactions are
> undermining the health of the community that maintains all of these
> filesystems.
> 
> > "Work as service to others" is something I think worth thinking about.
> > We're not supposed to be in this for ourselves; I don't write code to
> > stroke my own ego, I do it to be useful.
> 
> Service to others includes maintaining professional relationships with
> your colleagues. It includes building rather than tearing down. It
> includes recognizing that a healthy community serves users better in the
> long run than any individual contribution, no matter how technically
> excellent.
> 
> The kernel has thrived for over 30 years not just because of technical
> excellence, but because it has (mostly) maintained a collaborative
> environment where developers can work together despite disagreements.
> That collaborative environment IS doing right by users.
> 
> No filesystem is worth destroying that.

Then can we please drop all this madness?

I do hereby solomnly swear that I will refrain from critizing btrfs ever
again, or any other code anywhere in the kernel (if that is the wish) -
as long as Linus stops trying to dictate on patches internal to
fs/bcachefs/.

If it affects the rest of the kernel, that's fair game; I just want to
be able to get work done.

