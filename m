Return-Path: <linux-fsdevel+bounces-31254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B082993817
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 22:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080181F223DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9675E1DE4E7;
	Mon,  7 Oct 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d7RUNUBh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9A1865FC
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332482; cv=none; b=TzPXu/FA9zKijb51MJ3ywCQfgJ4vofrzfzxXzPeioM5geZAwZmKb09cplLi1S/R2AAPx0RAnnNmlJM7hP69EbpMw8MemSnjw7jvxWNYHR/0B6/z+lDFG1qTQYzKJhHWLTrtCqBdUDMyzDz1EAq89Qe4guOUSWdlOvBcWX0usZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332482; c=relaxed/simple;
	bh=c4a30u6REFUzrAsoAQwDjsVAZw5JYJBEWWtd09jMs5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnZR3fprOnR/ZgFLW0+1Otkd9iypOmsygvqvtsoZFHbAPnEtz/vBUZTcAvW+u6mDWyuP9DeACYqOrcov55CliWgFYFOONM+6qCQD8/yB1AMCff4t/0RsjgVYl2CQp2WrSP6LHbAYb0P3r2UfxEk4brzBWPeTmdrf5Lu8SMZi51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d7RUNUBh; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 7 Oct 2024 16:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728332477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq8JvnD9tzMMx6q54o7Cvi4gHmHlyDT4zjfEUm1ieqo=;
	b=d7RUNUBhxcjAVCJTzWcmfZ/fB9XCDnpJxlrgRmQvtrXRB4BM7BWUz8xIz4UV3rTIjTiHWN
	883bnt5baC77psLPAMIMRzRQcWkLM6eGlgQ6X4j9+fNu5kXJwQ8ZXLUw80ffsg/OEni79E
	7CbM+gl62PlVQlx+DjLCPh0NL8Bt7Bk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@fb.com
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <u266iwml67vr2zrkhebfr3zwak5k7mebk4grhavnujf2wodwkz@eyksfejhgve2>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <20241007145847.GA1898642@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007145847.GA1898642@perftesting>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 07, 2024 at 10:58:47AM GMT, Josef Bacik wrote:
> I tend to ignore these kind of emails, it's been a decade and weirdly the file
> system development community likes to use btrfs as a punching bag.  I honestly
> don't care what anybody else thinks, but I've gotten feedback from others in the
> community that they wish I'd say something when somebody says things so patently
> false.  So I'm going to respond exactly once to this, and it'll be me satisfying
> my quota for this kind of thing for the rest of the year.
> 
> Btrfs is used by default in the desktop spin of Fedora, openSuse, and maybe some
> others.  Our development community is actively plugged into those places, we
> drop everything to help when issues arise there.  Btrfs is the foundation of the
> Meta fleet.  We rely on its capabilities and, most importantly of all, its
> stability for our infrastructure.
> 
> Is it perfect?  Absolutely not.  You will never hear me say that.  I have often,
> and publicly, said that Meta also uses XFS in our database workloads, because it
> simply is just better than Btrfs at that.
> 
> Yes, XFS is better at Btrfs at some things.  I'm not afraid to admit that,
> because my personal worth is not tied to the software projects I'm involved in.
> Dave Chinner, Darrick Wong, Christoph Hellwig, Eric Sandeen, and many others have
> done a fantastic job with XFS.  I have a lot of respect for them and the work
> they've done.  I've learned a lot from them.
> 
> Ext4 is better at Btrfs in a lot of those same things.  Ted T'so, Andreas
> Dilger, Jan Kara, and many others have done a fantastic job with ext4.
> 
> I have learned a lot from all of these developers, all of these file systems,
> and many others in this community.
> 
> Bcachefs is doing new and interesting things.  There are many things that I see
> you do that I wish we had the foresight to know were going to be a problem with
> Btrfs and done it differently.  You, along with the wider file system community,
> have a lot of the same ideals, same practices, and same desire to do your
> absolute best work.  That is an admirable trait, one that we all share.
> 
> But dragging other people and their projects down is not the sort of behavior
> that I think should have a place in this community.  This is not the kind of
> community I want to exist in.  You are not the only person who does this, but
> you are the most vocal and constant example of it.  Just like I tell my kids,
> just because somebody else is doing something wrong doesn't mean you get to do
> it too.

Josef, I've got to be honest with you, if 10 years in one filesystem
still has a lot of user reports that clearly aren't being addressed
where the filesystem is wedging itself, that's a pretty epic fail and
that really is the main reason why I'm here.

#1 priority in filesystem land has to be robustness. Not features, not
performance; it has to simply work.

The bar for "acceptably good" is really, really high when you're
responsible for user's data. In the rest of the kernel, if you screw up,
generally the worst that happens is you crash the machine - users are
annoyed, whatever they were doing gets interrupted, but nothing
drastically bad happens.

In filesystem land, fairly minor screwups can lead to the entire machine
being down for extended periods of time if the filesystem has wedged
itself and really involved repair procedures that users _should not_
have to do, or worst real data loss. And you need to be thinking about
the trust that users are placing in you; that's people's _lives_ they're
storing on their machines.

So no, based on the feedback I still _regularly_ get I don't think btrfs
hit an acceptable level of reliability, and if it's taking this long I
doubt it will.

"Mostly works" is just not good enough.

To be fair, bcachefs isn't "good enough" yet either, I'm still getting
bug reports where bcachefs wedges itself too.

But I've also been pretty explicit about that, and I'm not taking the
experimental label off until those reports have stopped and we've
addressed _every_ known way it can wedge itself and we've torture tested
the absolute crap out of repair.

And I think you've set the bar too low, by just accepting that btrfs
isn't going to be as good as xfs in some situations.

I don't think there's any reason a modern COW filesystem has to be
crappier in _any_ respect than ext4/xfs. It's just a matter of
prioritizing the essentials and working at it until it's done.

