Return-Path: <linux-fsdevel+bounces-19745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017658C9887
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 05:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E671F21800
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 03:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016DD125B9;
	Mon, 20 May 2024 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ia7d6jVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D0B666
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716177165; cv=none; b=msVVJbaeSql3hJ+IB6LT7BpbDsfyDlkUWzeflYWMw0EDMMBldqOFt0h49sBZ0bUu4mgz0XTs+8s1UwZ63zsoOEDhHM7lf7sTdeJF9CA9WgSllnFj/t18jKxXyP9Harh5T2TzzgpInFbT0SgoSmMgB5GyBSlxYzs9t5foNQj23Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716177165; c=relaxed/simple;
	bh=rSyboOe5ADA6s/e4vGwvUomLwIG/5xupU4mSFMwTGg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BB50dEpw4/FGESqGCJmrKCZjDVa8dsx4l6dgtO5B7OnezTYb6Y2YYxSnWDES7FAtoaKmF1vfK52w83qsFcMSQtm/IausSIsLuzlmKQ7B2wVgVS+dG86uXygLVCdcy5VDy63hv83BL4aL5rHWqSUtKpght/lJE/iT45lsAK96kFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ia7d6jVz; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: keescook@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716177161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+hVaXU3OLVtnnff/5Lzdg6bnZTvwPprcV1YnanniD0=;
	b=ia7d6jVzKjdK6FsC6rzouvWzUMOmpf9NbUP98ULlq9BChwXBilKWnTPXP2/4apyoFay3CJ
	FL9B003cDf8xlYbT0kWVwGjZLhFsyHB++EJNeeDnGhenCjhXCoKGSHxI+cTF26RxkGzE4b
	RTRy2CzSog75beIl4SjHg/2wGq8ioSY=
X-Envelope-To: sfr@canb.auug.org.au
X-Envelope-To: torvalds@linux-foundation.org
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Sun, 19 May 2024 23:52:36 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates fro 6.10-rc1
Message-ID: <2uuhtn5rnrfqvwx7krec6lc57gptqearrwwbtbpedvlbor7ziw@zgbzssfacdbe>
References: <zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x>
 <202405191921.C218169@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405191921.C218169@keescook>
X-Migadu-Flow: FLOW_OUT

On Sun, May 19, 2024 at 07:39:38PM -0700, Kees Cook wrote:
> On Sun, May 19, 2024 at 12:14:34PM -0400, Kent Overstreet wrote:
> > [...]
> > bcachefs changes for 6.10-rc1
> > [...]
> >       bcachefs: bch2_btree_path_to_text()
> 
> Hi Kent,
> 
> I've asked after this before[1], but there continues to be a lot of
> bcachefs development going on that is only visible when it appears in
> -next or during the merge window. I cannot find the above commit on
> any mailing list on lore.kernel.org[2]. The rules for -next are clear:
> patches _must_ appear on a list _somewhere_ before they land in -next
> (much less Linus's tree). The point is to get additional reviews, and
> to serve as a focal point for any discussions that pop up over a given
> change. Please adjust the bcachefs development workflow to address this.

Over the course of my career, I've found the kind of workflow and level
of review you seem to asking for to be at best not useful, and at worst
harmful to productive functioning of a team - to my ability to teach
people and get them happy and productive.

The reality has just been that no one has ever been able to keep up with
the rate at which I work and write code [0], and attempting to do code
review of every patch means no one else gets anything done and we get
sidetracked on irrelevant details. When I do post my patches to the
list, the majority of what I get ends up being spelling fixes or at best
the kinds of bugs that shake out quickly in real testing. In short, I've
had to learn to write code without anyone looking over my shoulder, and
I take pride in debugging my own code and not saddling other people with
that.

So instead, I prioritize:
 - real discussion over the work being done, which does tend to happen
   person to person or in meetings (getting more of that on the list
   would not be a bad idea; I do need to be spending more time writing
   documentation and design docs, especially at this point).
 - good effective test infrastructure
 - heavy and thoughtful use of assertions; there's a real art to
   effective use of assertions, where you think about what the
   correctness proof would look like and write assertions for the
   invariants (and assertions should be on _state_, not _logic_)

I also do (try to) post patches to the list that are doing something
interesting and worth discussion; the vast majority this cycle has been
boring syzbot crap...

IOW, I'm not trying to _flout_ process here, even if I do things
somewhat differently; I've got quite a few people I'm actively teaching
and bringing in and that's where most of my energy is going. And we do
spend a lot of time going over code together, the meetings I run
(especially with the younger guys) are very much code-and-workflow
focused.

You'll also find I'm quite responsive, on IRC and the list, should you
have anything you wish to complain or yell about.

(btw, there's also been some discussions in fs land about other people
changing their workflows to something that looks more like mine; get the
important stuff on the list, make the list less spammy, work with each
other on a quicker timeline than that. They're not quite doing what I'm
doing, but I do think there's room for the /way/ we do code review and
the expectations around it to evolve a bit. Personally, I mostly just
want code to be readable).

I personally approach code review as being primarily about mentorship...
I don't want people to have the expectation that I'm going to pore over
their code and find their bugs; I'm not going to do that. I expect
people to be adults, and take as much time as they need to to get it
right; if there's something they're not sure about, I expect _them_ to
bring it up. I personally feel that this mindset teaches more
responsibility and the "right" kind of defensiveness that it takes to
write reliable code.

> Anyway, in reference to the above commit, please scrub bcachefs of its
> %px format string uses. Neither it nor %p should be used[3][4] in new
> code. (Which is, again, something checkpatch.pl will warn about.)

So that particular code is used in debugfs (root only) or in dumps when
we're panicing; the reason it's %px and not hashed is because I not
uncommonly do things like grab addresses from the introspection and then
use kgdb for further inspection.

Does that alleviate your concern, if it's only exposed that way?

If not, perhaps some sort of config option is appropriate.

[0]: except Linus, who quite frequently leaves my jaw hanging with how
quickly he can read code and spot real issues.

