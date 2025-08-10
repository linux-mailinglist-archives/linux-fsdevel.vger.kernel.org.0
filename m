Return-Path: <linux-fsdevel+bounces-57189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D0B1F84A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 06:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08698176E47
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 04:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2F01D2F42;
	Sun, 10 Aug 2025 04:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbl0DmKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024A2E3704;
	Sun, 10 Aug 2025 04:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754798731; cv=none; b=CcxnNcfn9wR0FWGlPzO5LIykSWUoN2hHV2Lk6dITZqoDlO4JbkQAd1Q3Ol7zWMjarXciXSoZcoStlOyc23t1/SzNoah5FBMjKULMqR1UBQ5GMOLuihiY+BllNs7HHZ1MQDBzGvOuYNxzdyfL8nP12wSLUC5aU5XPAQ2P3oRg8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754798731; c=relaxed/simple;
	bh=G24pxG20wqagoacBXN4bO4ncr47htssyKoOTe2+i4MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGB2bCPMgNfrd0VzCKspY1IwQJfcEtJlMSiJMftWN8/WwCnJ6YGMRpXgg2v1lnLz+C/DVlvaHmvw1p7kqsNosDQ86q09ukFIkjbWamt85e0I/1MxpBan9PlyqEhruHZG6+xoGeFMhM58OfZ1HhLWk9hB9Q6NdNH3m+rUDBAs5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbl0DmKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA773C4CEEB;
	Sun, 10 Aug 2025 04:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754798730;
	bh=G24pxG20wqagoacBXN4bO4ncr47htssyKoOTe2+i4MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbl0DmKj1uxOrNmCspyyBqJNBVR5yUZIuhYNZvsgu1GxkNDIni1fTLIxIbOeVJfpM
	 3JRji2ng/LQskGPKOk5gxQfEE9YKR2gdIv3b65FpJZl5jYQ4aiHMFu95sih+L2hzUK
	 zHWXgOnqppnxtg1yzJ4mO8z7NZiwuol/KgJTC7Edk++gAQo7JRtkKBti0o21GDb1zM
	 RPfG6z8lvW4TJH0d9Yj82NkropftZwNGoLJ1Bgs2ZrlZNY/xcIayux7LB4h4Fxlz13
	 vYqe5Ebjk6RHyNgpFPbzBemFGPDvTXqvJtnMhpptJ3YeIH/bvcFG7t71ktgCiCxOVF
	 iA8xpDVq3mL6A==
Date: Sun, 10 Aug 2025 00:05:28 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>,
	Aquinas Admin <admin@aquinas.su>,
	Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Carl E. Thompson" <list-bcachefs@carlthompson.net>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <aJgaiFS3aAEEd78W@lappy>
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <20250809192156.GA1411279@fedora>
 <2z3wpodivsysxhxmkk452pa4zrwxsu5jk64iqazwdzkh3rmg5y@xxtklrrebip2>
 <20250810022436.GA966107@mit.edu>
 <k6e6f3evjptze7ifjmrz2g5vhm4mdsrgm7dqo7jdatkde5pfvi@3oiymjvy6f3e>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <k6e6f3evjptze7ifjmrz2g5vhm4mdsrgm7dqo7jdatkde5pfvi@3oiymjvy6f3e>

On Sat, Aug 09, 2025 at 11:17:44PM -0400, Kent Overstreet wrote:
>On Sat, Aug 09, 2025 at 10:24:36PM -0400, Theodore Ts'o wrote:
>> And how did you respond?  By criticizing another file system, and
>> talking about how wonderful you believe bcachefs to be, all of which
>> is beside the point.  In fact, you once again demonstrated exactly why
>> a very large number of kernel deevlopers have decided you are
>> extremely toxic, and have been clamoring that your code be ejected
>> from the kernel.  Not because of the code, but because your behavior.
>
>I would dearly love to have not opened that up, but "let's now delete
>bcachefs from the kernel" opened up that discussion, because our first
>priority has to be doing right by users - and a decision like that
>should absolutely be discussed publicly, well in advance, with all
>technical arguments put forth.

Kent,

You say our first priority has to be doing right by users, and I agree -
but doing right by users means maintaining a healthy, functioning
development community. A toxic community that drives away contributors
fails its users far more severely than the absence of any single
filesystem ever could.

Look at this thread again. Really look at it. Neither Ted nor Josef
raised a single technical argument against bcachefs. They didn't
criticize your code, your design decisions, or your engineering. Josef
explicitly praised your technical work. Ted has repeatedly shown respect
for your code.  The discussions about potentially dropping bcachefs
aren't happening because it's technically inferior to ext4, xfs, or
btrfs. They're happening because your personal interactions are
undermining the health of the community that maintains all of these
filesystems.

>"Work as service to others" is something I think worth thinking about.
>We're not supposed to be in this for ourselves; I don't write code to
>stroke my own ego, I do it to be useful.

Service to others includes maintaining professional relationships with
your colleagues. It includes building rather than tearing down. It
includes recognizing that a healthy community serves users better in the
long run than any individual contribution, no matter how technically
excellent.

The kernel has thrived for over 30 years not just because of technical
excellence, but because it has (mostly) maintained a collaborative
environment where developers can work together despite disagreements.
That collaborative environment IS doing right by users.

No filesystem is worth destroying that.

-- 
Thanks,
Sasha

