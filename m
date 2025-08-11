Return-Path: <linux-fsdevel+bounces-57395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9533CB211AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5188D6254C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4832429BDA8;
	Mon, 11 Aug 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D226lHnA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40AF296BDD
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928609; cv=none; b=MJi8ylgQpCaON5Ylllxxb9l2SjsPOEGlVr6TQUnOwUnltOH20dARYk99WCMVz3NIu4nXdMLJFqomFUPBNqfqPomR4fRk5MfNAA67zhUr/fXersdGQP5fZwtoqzoS7E0OvG4ThHtsaH6Xv8nlWCoHaQze2yoYKaPTLYYqmiwRol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928609; c=relaxed/simple;
	bh=ZDyW6dGl3TULOg2U+r8tBlgs2lCFiNKeLALb7CoitC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBxcqQ1Vz7tFgig50J4LCHXfVTPHIWi2TZpG0ekeqse/oLL3H0MBE3U9W9u4mtXNqvuKf1n7wTRWJcQW4rchCtXAPBPgGAdBMaqnhNdGJomeDs6LfOE2w6QR9qYg761Yhjn16gUxYZ0IO5uhSseKLCh9149j8TZ78iPK3Xs0YLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D226lHnA; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 11 Aug 2025 12:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754928595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIKvWA431gp23Shuwsp8vJ1z4SvvLDAXoswipYUi0bY=;
	b=D226lHnAA5f0olDYynfGNLeLQaNrGZ02dyegR21shc3Kx3ElNbQMe5B8UR4Q+sSTscNfys
	lwRsfrU3lZhlwOenIrfs4/MIfo2YdBSGOCLisXmOdyoDJ8KsG9bxrVMBvECcrhmCxlKj9G
	nYmakBDgVfN04bk6XTvO0IBHXj8hjjk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Aquinas Admin <admin@aquinas.su>
Cc: Josef Bacik <josef@toxicpanda.com>, 
	Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Carl E. Thompson" <list-bcachefs@carlthompson.net>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <6xvioxpjw4cavxqznocsgcqwmuc6yhws72mqp6jixm4ebmg3ev@asr4qaaita5z>
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <20250809192156.GA1411279@fedora>
 <5030625.31r3eYUQgx@woolf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5030625.31r3eYUQgx@woolf>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 11, 2025 at 11:02:24PM +0700, Aquinas Admin wrote:
> > Exactly. Which is why the Meta infrastructure is built completely on btrfs
> > and its features. We have saved billions of dollars in infrastructure costs
> > with the features and robustness of btrfs.
> > 
> > Btrfs doesn't need me or anybody else wandering around screaming about how
> > everybody else sucks to gain users. The proof is in the pudding. If you read
> > anything that I've wrote in my commentary about other file systems you will
> > find nothing but praise and respect, because this is hard and we all make
> > our tradeoffs.
> > 
> Sure, of course. The problem is that Meta doesn't need a general-purpose file 
> system. And yes, and in general, Meta is not the kind of company that makes 
> technically sound decisions.

This is entirely unnecessary.

> Has the problem with RAID5/6 (write hole) been solved in more than 20
> years of development?

My understanding is that RAID5/6 v2, with the stripes tree, is intended
to fix this (the same as how it works in bcachefs).

