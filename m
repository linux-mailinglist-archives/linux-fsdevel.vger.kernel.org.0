Return-Path: <linux-fsdevel+bounces-57202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC8B1F893
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A152716BEAA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 06:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91E31F3BAE;
	Sun, 10 Aug 2025 06:06:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.carlthompson.net (charon.carlthompson.net [45.77.7.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD51E520B;
	Sun, 10 Aug 2025 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.7.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805970; cv=none; b=BwexFPKAMQ3pmSfU1XbgqTLE8vvlvEVCHGtoHdQcIE4IqttaKtHP83B5kOtjAZmrK9AU64dBNdCkix0t6NxGAXt2NuWrj3XN3RGN07pmi85CK90/QzX101MAojPnQIc2b3bfBiKRaNfXa4sDhVZxdyAngxOYwUzDeK9+hq54k7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805970; c=relaxed/simple;
	bh=a+BZgYmi7k3vnE2eh4pZZC/qkKUR0kd5fvjKOuGsfYc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HrWXVhRd/vMQBpfZAXkKqL1DxyzhWz6sFi4xMt7RThpOgJMiorqbbhdrO63w1FUbdNVf2WBDc7QTzPmuZTjFaimBaz9pViTASv8iUmdoq7G8C6Qd/qM7CeZxFkjKTmsLxzFsnBIw2KrBBYwoi7MVzpclcNuFw5JIOckg+bXd3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net; spf=pass smtp.mailfrom=carlthompson.net; arc=none smtp.client-ip=45.77.7.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carlthompson.net
Received: from mail.carlthompson.net (mail.home [10.35.20.252])
	(Authenticated sender: cet@carlthompson.net)
	by smtp.carlthompson.net (Postfix) with ESMTPSA id 5162A1E3AE570;
	Sat,  9 Aug 2025 23:05:58 -0700 (PDT)
Date: Sat, 9 Aug 2025 23:05:58 -0700 (PDT)
From: "Carl E. Thompson" <list-bcachefs@carlthompson.net>
To: Theodore Ts'o <tytso@mit.edu>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: Josef Bacik <josef@toxicpanda.com>, Aquinas Admin <admin@aquinas.su>,
	=?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <745617536.363.1754805958174@mail.carlthompson.net>
In-Reply-To: <20250810022436.GA966107@mit.edu>
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <20250809192156.GA1411279@fedora>
 <2z3wpodivsysxhxmkk452pa4zrwxsu5jk64iqazwdzkh3rmg5y@xxtklrrebip2>
 <20250810022436.GA966107@mit.edu>
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev73
X-Originating-Client: open-xchange-appsuite


> On 2025-08-09 7:24 PM PDT Theodore Ts'o <tytso@mit.edu> wrote:

> ... unless you can find someone willing to be your intermediary, and
> hopefully your coach in how to better work with other people ...

Going that route would just prolong Kent's attack on all of you (and the kernel) and make the damage worse. It's not a matter of getting him to understand; He's *always* understood what is needed from him but he does not believe in it and will not do it. Even though he is now (once again) promising to behave he won't. You all know that. Giving him yet another chance right now won't undo the damage that's already been done to Linux and will only allow him to inflict more.

Kent has already said many times, including in this thread, that he can and will continue to work on bcachefs even if it's removed from the kernel. Let him.

This is not the time to try to fix him. This is the time to protect the thing you've spent so much of your collective lives building.

