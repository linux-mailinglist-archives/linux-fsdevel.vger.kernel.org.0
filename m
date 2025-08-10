Return-Path: <linux-fsdevel+bounces-57221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55449B1F951
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC3D163D1B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDED2356C6;
	Sun, 10 Aug 2025 08:03:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DAF6DCE1;
	Sun, 10 Aug 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812983; cv=none; b=mFo00cOkfCFLN0z7VjfoInbiixGq7YsKIQ3PK8yN65v103skkSbk+aPTlzH9G84BKg6MaaeQqQvpqttFRJtdKjy0VtHdikuF88toeb3AlqE9ur3CBapyPQHxbcVjC4wBNIT+SfeVY+4jc/FKBoAbZtQeOvsxOh5/D8wBtn/3FvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812983; c=relaxed/simple;
	bh=ADRozaRnU5m4kHiz5jjiFKrDWtNl3Wz0lFtyPVMGAZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqT0Z4MNCB4RVLU0IF9+NK0qacMA+WrRmsmLkYd4LRGGg92zO6YMMbYYcGKrKHRnFbiJ14PIIQNFYY86Pd8C5+pEOVb4gNZkZQiOCwRkiRMJgd+RcDsg3jCeEA5MejtquR9lXRw/2H6G04WBXNVzqhDZ/bh54ZkHWCi5m8T3EKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 9612312DFD1;
	Sun, 10 Aug 2025 08:02:48 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Theodore Ts'o <tytso@mit.edu>, Kent Overstreet <kent.overstreet@linux.dev>
Cc: Josef Bacik <josef@toxicpanda.com>, Aquinas Admin <admin@aquinas.su>,
 Malte =?UTF-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Carl E. Thompson" <list-bcachefs@carlthompson.net>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Date: Sun, 10 Aug 2025 10:02:46 +0200
Message-ID: <1935642.tdWV9SEqCh@lichtvoll.de>
In-Reply-To: <k6e6f3evjptze7ifjmrz2g5vhm4mdsrgm7dqo7jdatkde5pfvi@3oiymjvy6f3e>
References:
 <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <20250810022436.GA966107@mit.edu>
 <k6e6f3evjptze7ifjmrz2g5vhm4mdsrgm7dqo7jdatkde5pfvi@3oiymjvy6f3e>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Kent, hi,

Kent Overstreet - 10.08.25, 05:17:44 CEST:
> I think you guys have been taking this a bit too far.

I am not sure who is right here. Or right to what extend.

And maybe that is not even the question.

But Kent, if your priority is the users of BCacheFS, look at the result:

The current result is a disservice to users.

Maybe even a huge one.

And likely a disservice to developers as well.

Is this result really what you like to achieve?

Cause if not, I can assure you that by doing the same thing over and over=20
and over again you will yield exactly the same result over and over and=20
over again. Just look at the past: This has been going in *predictable*=20
cycles.

If you go on to do the same thing over and over again that drives off=20
people, then that is exactly the result you will be receiving.

So if you do not adapt your behavior and do something *different* next=20
time=E2=80=A6 *whether you like it or not* (!) you need to wait until someo=
ne else=20
does. And that "until" may never happen. You can only influence what you=20
do. So do you like to continue to give the power to change something in=20
here to someone else by blaming everyone but you? That would be a lot of=20
wasted energy.

You are not going to change the dynamics of power within the kernel=20
development community by what you have been doing all the time.

Of course this goes the other way around as well: As long as people try to=
=20
change each other in here, this is not going anywhere. The only change you=
=20
can affect is a change within yourself.

So maybe take a while off mail, breathe deeply and meditate or do whatever=
=20
helps you to see what within you contributes to the result we see here. I=20
will do the same.

All in all again I point out: This cannot by solved by writing mails. You=20
need to *speak* to each other.

Enough already.

Best,
=2D-=20
Martin



