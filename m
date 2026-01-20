Return-Path: <linux-fsdevel+bounces-74711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBxvFMrmb2lhUQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:34:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 171884B5E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92ED17EC956
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988BC466B63;
	Tue, 20 Jan 2026 19:00:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3601E466B50
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935614; cv=none; b=bLdotbH859euaUdF3kn5AKa3tpXSq9e6szMTBnnr6VRm6EP850piq+3UFYJM4wJ/2MhFDcYoC7dCot6XlW+ckYrh44273G0z7cR0ms2J0auh4/6sULMvYGE9iG1v0rnQaVQeqkal7bJQ2mvK0JOdYIN7/A3GGnf8HwqBayqHZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935614; c=relaxed/simple;
	bh=mtMJsCsaL8BH0KEkcMmk82BnDFTAYGH/g1xlTfzG9QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQpzocWOzzXGOxMH9SmQTDep0rPSj24c5eB+7V2YfTg9J6zo/7FkWvRY8gJLWCgwClqaPXst7QaaqLRM45HUyZZXoeMW3nGBWpSXnOgOsugUZ3R1tbFco1FNXC+5rdrRdqbHyY/BpvFS0ajn829sWAs0DigXLYS8tdDY8TTvBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Tue, 20 Jan 2026 14:00:10 -0500
From: Rich Felker <dalias@libc.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Zack Weinberg <zack@owlfolio.org>, Alejandro Colomar <alx@kernel.org>,
	Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20260120190010.GF6263@brightrain.aerifal.cx>
References: <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
 <lhubjio5dsb.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhubjio5dsb.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[libc.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dalias@libc.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-74711-lists,linux-fsdevel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,brightrain.aerifal.cx:mid]
X-Rspamd-Queue-Id: 171884B5E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 07:39:48PM +0100, Florian Weimer wrote:
> * Rich Felker:
> 
> > On Tue, Jan 20, 2026 at 12:05:52PM -0500, Zack Weinberg wrote:
> >> > On Fri, May 23, 2025 at 02:10:57PM -0400, Zack Weinberg wrote:
> >> >>     close() always succeeds.  That is, after it returns, _fd_ has
> >> >>     always been disconnected from the open file it formerly referred
> >> >>     to, and its number can be recycled to refer to some other file.
> >> >>     Furthermore, if _fd_ was the last reference to the underlying
> >> >>     open file description, the resources associated with the open file
> >> >>     description will always have been scheduled to be released.
> >> ...
> >> >>     EINPROGRESS
> >> >>     EINTR
> >> >>            There are no delayed errors to report, but the kernel is
> >> >>            still doing some clean-up work in the background.  This
> >> >>            situation should be treated the same as if close() had
> >> >>            returned zero.  Do not retry the close(), and do not report
> >> >>            an error to the user.
> >> >
> >> > Since this behavior for EINTR is non-conforming (and even prior to the
> >> > POSIX 2024 update, it was contrary to the general semantics for EINTR,
> >> > that no non-ignoreable side-effects have taken place), it should be
> >> > noted that it's Linux/glibc-specific.
> >> 
> >> I am prepared to take your word for it that POSIX says this is
> >> non-conforming, but in that case, POSIX is wrong, and I will not be
> >> convinced otherwise by any argument.  Operations that release a
> >> resource must always succeed.
> >
> > There are two conflicting requirements here:
> >
> > 1. Operations that release a resource must always succeed.
> > 2. Failure with EINTR must not not have side effects.
> >
> > The right conclusion is that operations that release resources must
> > not be able to fail with EINTR. And that's how POSIX should have
> > resolved the situation -- by getting rid of support for the silly
> > legacy synchronous-tape-drive-rewinding behavior of close on some
> > systems, and requiring close to succeed immediately with no waiting
> > for anything.
> 
> What about SO_LINGER?  Isn't this relevant in context?

shutdown should be used for this, not close. So that the acts of
waiting for the operation to finish, and releasing the resource handle
needed to observe if it's finished, are separate.

> As far as I know, there is no other way besides SO_LINGER to get
> notification if the packet buffers are actually gone.  If you don't use
> it, memory can pile up in the kernel without the application's
> knowledge.

The way Linux's EINTR behaves, using close can't ensure this memory
doesn't pile up, because on EINTR you lose the ability to wait for it.

Rich

