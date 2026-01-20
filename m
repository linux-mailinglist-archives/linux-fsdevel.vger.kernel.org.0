Return-Path: <linux-fsdevel+bounces-74706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGxrJYDbb2n8RwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:46:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0C44AAEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E0D662D207
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC443CED1;
	Tue, 20 Jan 2026 17:47:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B513043636A
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931224; cv=none; b=e7aXxVstZpZSKKEsFDN+iVtiy18gwuPlB+xNHgYIrbqswNa0GWSpbltRhO1XmH/zUzwHUg9wzbLVaGYGNuuW/gRa4MVo8eBs31Cmst+etA2yJShNTW5FfT5CbBzK+oSAHdWfvpqV3jGT+ISCt4TwueTkdUO87sexo/bo5VRAHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931224; c=relaxed/simple;
	bh=j7r7bBh+TNMwmcYRtzec30Sn1pdEm08wClZ+gl3HPDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heTKDyDxpjFaCW1U+OSd4hUZUrWNZ7eYnDc3+hvY8Nbm2cOIfk9YbunrCTgguh0XpET8L4ZS3LCy3YEd9gTqzELlCKnCMthw5RqZ36ltU6mGlxTFGwcNZgktDvDH3AIKWMDZryvj49/CQUbRR0j7Bs6BVCCUSsLlGqM75jIRerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Tue, 20 Jan 2026 12:46:59 -0500
From: Rich Felker <dalias@libc.org>
To: Zack Weinberg <zack@owlfolio.org>
Cc: Alejandro Colomar <alx@kernel.org>,
	Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20260120174659.GE6263@brightrain.aerifal.cx>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[libc.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dalias@libc.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-74706-lists,linux-fsdevel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,brightrain.aerifal.cx:mid]
X-Rspamd-Queue-Id: 5A0C44AAEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 12:05:52PM -0500, Zack Weinberg wrote:
> > On Fri, May 23, 2025 at 02:10:57PM -0400, Zack Weinberg wrote:
> >>     close() always succeeds.  That is, after it returns, _fd_ has
> >>     always been disconnected from the open file it formerly referred
> >>     to, and its number can be recycled to refer to some other file.
> >>     Furthermore, if _fd_ was the last reference to the underlying
> >>     open file description, the resources associated with the open file
> >>     description will always have been scheduled to be released.
> ...
> >>     EINPROGRESS
> >>     EINTR
> >>            There are no delayed errors to report, but the kernel is
> >>            still doing some clean-up work in the background.  This
> >>            situation should be treated the same as if close() had
> >>            returned zero.  Do not retry the close(), and do not report
> >>            an error to the user.
> >
> > Since this behavior for EINTR is non-conforming (and even prior to the
> > POSIX 2024 update, it was contrary to the general semantics for EINTR,
> > that no non-ignoreable side-effects have taken place), it should be
> > noted that it's Linux/glibc-specific.
> 
> I am prepared to take your word for it that POSIX says this is
> non-conforming, but in that case, POSIX is wrong, and I will not be
> convinced otherwise by any argument.  Operations that release a
> resource must always succeed.

There are two conflicting requirements here:

1. Operations that release a resource must always succeed.
2. Failure with EINTR must not not have side effects.

The right conclusion is that operations that release resources must
not be able to fail with EINTR. And that's how POSIX should have
resolved the situation -- by getting rid of support for the silly
legacy synchronous-tape-drive-rewinding behavior of close on some
systems, and requiring close to succeed immediately with no waiting
for anything. But abandoning requirement 2 is not an option,
especially in light of the relationship between EINTR and thread
cancellation in regards to contract about side effects.

It's perfectly reasonable for implementations (as musl does, and as I
think glibc either does or intends to do) to just go all the way and
satisfy both 1 and 2 by having close translate the kernel EINTR into
0.

> Now, the abstract correct behavior is secondary to the fact that we
> know there are both systems where close should not be retried after
> EINTR (Linux) and systems where the fd is still open after EINTR
> (HP-UX).  But it is my position that *portable code* should assume the
> Linux behavior, because that is the safest option.  If you assume the
> HP-UX behavior on a machine that implements the Linux behavior, you
> might close some unrelated file out from under yourself (probably but
> not necessarily a different thread).  If you assume the Linux behavior
> on a machine that implements the HP-UX behavior, you have leaked a
> file descriptor; the worst things that can do are much less severe.

Unfortunately, regardless of what happens, code portable to old
systems needs to avoid getting in the situation to begin with. By
either not installing interrupting signal handlers or blocking EINTR
around close.

> The only way to get it right all the time is to have a big long list
> of #ifdefs for every Unix under the sun, and we don't even have the
> data we would need to write that list.
> 
> > While I agree with all of this, I think the tone is way too
> > proscriptive. The man pages are to document the behaviors, not tell
> > people how to program.
> 
> I could be persuaded to tone it down a little but in this case I think
> the man page's job *is* to tell people how to program.  We know lots of
> existing code has gotten the fine details of close() wrong and we are
> trying to document how to do it right.

No, the job of the man pages absolutely is not "to tell people how to
program". It's to document behaviors. They are not a programming
tutorial. They are not polemic diatribes. They are unbiased statements
of facts. Facts of what the standards say and what implementations do,
that equip programmers with the knowledge they need to make their own
informed decisions, rather than blindly following what someone who
thinks they know better told them to do.

> > Aside: the reason EINTR *has to* be specified this way is that pthread
> > cancellation is aligned with EINTR. If EINTR were defined to have
> > closed the fd, then acting on cancellation during close would also
> > have closed the fd, but the cancellation handler would have no way to
> > distinguish this, leading to a situation where you're forced to either
> > leak fds or introduce a double-close vuln.
> 
> The correct way to address this would be to make close() not be a
> cancellation point.

This would also be a desirable change, one I would support if other
implementors are on-board with pushing for it.

> > An outline of what I'd like to see instead:
> >
> > - Clear explanation of why double-close is a serious bug that must
> >   always be avoided. (I think we all agree on this.)
> >
> > - Statement that the historical Linux/glibc behavior and current POSIX
> >   requirement differ, without language that tries to paint the POSIX
> >   behavior as a HP-UX bug/quirk. Possibly citing real sources/history
> >   of the issue (Austin Group tracker items 529, 614; maybe others).
> >
> > - Consequence of just assuming the Linux behavior (fd leaks on
> >   conforming systems).
> >
> > - Consequences of assuming the POSIX behavior (double-close vulns on
> >   GNU/Linux, maybe others).
> >
> > - Survey of methods for avoiding the problem (ways to preclude EINTR,
> >   possibly ways to infer behavior, etc).
> 
> This outline seems more or less reasonable to me but, if it's me
> writing the text, I _will_ characterize what POSIX currently says
> about EINTR returns from close() as a bug in POSIX.  As far as I'm
> concerned, that is a fact, not polemic.
> 
> I have found that arguing with you in particular, Rich, is generally
> not worth the effort.  Therefore, unless you reply and _accept_ that
> the final version of the close manpage will say that POSIX is buggy,
> I am not going to write another version of this text, nor will I be
> drawn into further debate.

I will not accept that because it's a gross violation of the
responsibility of document writing.

Rich

