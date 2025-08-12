Return-Path: <linux-fsdevel+bounces-57502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7EBB22447
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 12:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572107B6A55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174852EB5D8;
	Tue, 12 Aug 2025 10:09:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B62EAB90;
	Tue, 12 Aug 2025 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993353; cv=none; b=SMgAhCv21/25AOHTMILMJZevl9mIjz+WyzClJujZoVreu5+VDZR0G/EJx3F2rTpqgW6t4w053s6u/IUTF7AInynmfcsOEI4iQzOyLL7sq3p4XpkUZg7j1y5WqHmtA7h5BtZDC1R2+1sOfx4v3tn+fV1Olvj721dv5sX7GSokQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993353; c=relaxed/simple;
	bh=rXldXyQYQNsTINwFWo1vCWq2u09zsOBrOqUDFtbCO9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AeLryMh/7pozISQleItKkc0z9nXzwrit64dTsBMRzrJr8P2LAGCQ/6+62TOuWCAS2jyXR2DSYkIwUOWORJi5hcCFmswe9LdrYpFLYQ89bv+nvfGrhvCH9Ct4/ECwAtFIpqh8rQi49EeQrwktNCwG/h3m+2rPo2tifjpDIQI6+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id D0AE712F5B5;
	Tue, 12 Aug 2025 10:09:05 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Matthew Wilcox <willy@infradead.org>, Jani Partanen <jiipee@sotapeli.fi>
Cc: Aquinas Admin <admin@aquinas.su>,
 Malte =?UTF-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Carl E. Thompson" <list-bcachefs@carlthompson.net>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Date: Tue, 12 Aug 2025 12:09:03 +0200
Message-ID: <3374793.44csPzL39Z@lichtvoll.de>
In-Reply-To: <c55affa6-4b8e-4110-bf44-c595d4cda81f@sotapeli.fi>
References:
 <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <5ip2wzfo32zs7uznaunpqj2bjmz3log4yrrdezo5audputkbq5@uoqutt37wmvp>
 <c55affa6-4b8e-4110-bf44-c595d4cda81f@sotapeli.fi>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Jani, hi.

Jani Partanen - 12.08.25, 09:49:03 CEST:
> On 10/08/2025 2.13, Kent Overstreet wrote:
> > And now, I just got an email from Linus saying "we're now talking
> > about
> > git rm -rf in 6.18", after previously saying we just needed a
> > go-between.
> > 
> > So if that's the plan, I need to be arguing forcefully here, because a
> > lot is on the line for a lot of people.
> 
> No that is not what you need to do. Arguing is the guarantee way that rm
> -rf will happen.
> 
> You need to *SHUT* *THE* *FUCK* *UP* *RIGHT* *NOW!* That is what you
> need to do and find very very fast some spokesman/woman/person who deal
> all the communication.

I might have worded this differently, but in essence I agree.

The likely hood of BCacheFS pull requests being accepted again would have 
been far better without that initial comment and subsequent comments from 
you, Kent, (and some others) on this thread. Actually I felt that the 
thread was even going in a quite good direction, before your first comment 
to it. Some users spoke in favor of accepting the pull request. And I feel 
after your comment that momentum was completely destroyed. As I read your 
first comment, Kent, I thought: Oh no, now this is going to go downhill 
just like the other threads about the topic. And unfortunately that 
happened. It was predictable. Completely predictable.

And avoidable.

See, Kent, you argued all the time. Look at the results.

Again: Look at your behavior and look at the results. Really do it. Take 
time to do it.

It is not even about to what extent your arguments have been accurate or 
not. But more about the *way* you argued.

If you continue to do the same thing all over again, you will receive the 
same result. (Unless someone in charge changes their behavior in a 
significant way, but do you really like to make BCacheFS acceptance in 
kernel community dependent on that? You may wait a very long time then.)

See, it is not about right or wrong, but it is about where the lever to 
change the outcome actually is. And that lever is not in asking others to 
change. And it is also not within insisting that you are right, even in 
case you are right at least to some extent.

It may very well be that others overreacted. But it is outside of your 
power to change that. Especially not by blaming or asking them to change. 
Blaming is a certain way to give away power over what you experience to 
someone else.

Step back. Take some time to contemplate about what happened. Actually 
that is a good approach for everyone involved, I think.

Seek another approach to communicate *differently* from what you have 
already been doing all the time. Then you *might* achieve a different 
result.

Doing the same thing over and over again and expecting a different result 
is insane.

Best,
-- 
Martin



