Return-Path: <linux-fsdevel+bounces-78289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG+GNi/WnWk0SQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:47:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6F518A06B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 041683093A75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799773A9603;
	Tue, 24 Feb 2026 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkDzFJcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047183A8FF7;
	Tue, 24 Feb 2026 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951648; cv=none; b=p+BHp70mnWaGnIIGmke2KlkpQGn0vMFN952xUOdicEiQJpe86yJdb9v4G/jOdGkRuQ8jk8U6pEDq3H3gnfe71p2f7ISfMd1F/i3q2ysbcwUhanhOD6HxDizHippJhovyCWfoP1FRzT3hqU/eSYn6dNeQafu9EdMSFAbVYVxn5qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951648; c=relaxed/simple;
	bh=leBx6olTqSQBJkxFd1UgFNceg95W9Wv4DMitwWK7G6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzSRamJMuqBo46xgoTbQCKujaVFcYDSKzJ0ak/VacN8BU+Pj6SzBBzyh08zhJc0e4P/5yQo2CujEOow7CREBCf/j92dWVob7jc0R6HCy8ZX/hHNcLv9hFqrXXax2nHAi4ttyOB6OOzF0nLBYfYeWmXMP/fmfpXdregrlvj8b438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkDzFJcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B88C116D0;
	Tue, 24 Feb 2026 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771951647;
	bh=leBx6olTqSQBJkxFd1UgFNceg95W9Wv4DMitwWK7G6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkDzFJcw+q2gId92bO6fEHL4Dk3hYgkhbc9P65cEbFHCxSW0YrSsy5A1OJo6vjJOS
	 pLwcxVzQ3AatcLPem7HsSXluFQWS8WD/TFDb0d7syO0ptJOP1Nfs5KM3D5kLfmTnAT
	 ZboT/aX496kw/oYMsF3jm0U4QRxbZb1IP5UrlQ0bggGHIkzlzJLmBcT6rK6sVWZhc2
	 txtSmkzrTeY94kWws8mE4nXwEz2Z3DwI5fszP0tyfxs4A72fdmTe7yUCk22QD0COhr
	 RRjeLfeRjEBSC2ZUtJRneuNjn0wqarVSN0TWgH7LrJYY27f9DcOaU9bBv/h9tVZknW
	 cEfPRjekhlAYg==
Date: Tue, 24 Feb 2026 17:47:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: pidfd && O_RDWR
Message-ID: <20260224-subsumieren-dazulernen-e5339c744d8a@brauner>
References: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
 <20260223-work-pidfs-autoreap-v4-2-e393c08c09d1@kernel.org>
 <aZx2dlV9tJaL5gDG@redhat.com>
 <aZx3ctUf-ZyF-Krc@redhat.com>
 <aZyI6Aht747CTLiC@redhat.com>
 <aZyonv349Qy92yNA@redhat.com>
 <20260223-ziemlich-gemalt-0900475140e5@brauner>
 <aZ16x0OH098LMqen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZ16x0OH098LMqen@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78289-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F6F518A06B
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:17:43AM +0100, Oleg Nesterov wrote:
> On 02/23, Christian Brauner wrote:
> >
> > On Mon, Feb 23, 2026 at 08:21:02PM +0100, Oleg Nesterov wrote:
> > > On 02/23, Oleg Nesterov wrote:
> > > >
> > > > pidfd_prepare() does pidfs_alloc_file(pid, flags | O_RDWR) and "| O_RDWR"
> > > > makes no sense because pidfs_alloc_file() itself does
> > > >
> > > > 	flags |= O_RDWR;
> > > >
> > > > I was going to send the trivial cleanup, but why a pidfs file needs
> > > > O_RDWR/FMODE_WRITE ?
> > > >
> > > > Actually the same question about some anon_inode_getfile_fmode(O_RDWR)
> > > > users, for example signalfd.c.
> > >
> > > perhaps an accidental legacy from 628ff7c1d8d8 ("anonfd: Allow making anon
> > > files read-only") ?
> >
> > It was always a possibility that we would support some form of
> > write-like operation eventually. And we have support for setting trusted
> > extended attributes on pidfds for some time now (trusted xattrs require
> > global cap_sys_admin).
> 
> But why do we need O_RDWR right now? That was my question.
> 
> I can be easily wrong, but I think that pidfs_xattr_handlers logic doesn't
> need it...
> 
> OK, I won't pretend I understand fs, I'll send the trivial cleanup which just
> removes the unnecessary "flags | O_RDWR" in pidfd_prepare().

xattrs don't need FMODE_WRITE. You can use O_RDONLY fds with the
justification that it's metadata (most likely). Although I always found
that rather weird. Sending signals is technically also equivalent to
writing and I think that was the original reason this was done. If you
want to remove it then be my guest.

