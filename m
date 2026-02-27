Return-Path: <linux-fsdevel+bounces-78769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDraL/74oWknyAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:05:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6654F1BD2FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFBEC3049702
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84D3436353;
	Fri, 27 Feb 2026 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qHqY9fc8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2282345736
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772222716; cv=none; b=PuhrG6SRKp/oOnGwqUPUhYJ6rGZeBFGL5yQBM08F1aKGxVMovhuv4diCLqnbqJMxGONuXazEYuB8aXaGHvkDcKKqxHs1qYpJ590cWrfzbK1xo4dC1P1jgGZCQmP8cgWC9Rect/afkWbjqfbWveFfq0aaO6SthhtT+OuujxQlOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772222716; c=relaxed/simple;
	bh=in9DCZ0YITnk+p2NZ6VhdtJF8bwVt/UvE2F4AX4biDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJTjG4giyA6A+lAWM+oyUfOk/6FNDM8hxGTQDgGjJX9M/rasJOePjQ3+CJ0gn2RsOgjvnT/ZI+D/9DkKc5pnIDnxB8C8douE/IHlQbCmiuGz2F4x21L0uCPNDMyXA9Da/ibKxwAg4Rg44ETSM/ssL/uJDoQR2/iFr62a31pPy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qHqY9fc8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=73YDpLo4A1iR6jgwBSXyrqqg1gdt00zNc/iUcEgP7mI=; b=qHqY9fc8RNFJUqXZAcMov2kmXh
	vpk2Gys2aq8W0OGEqNrOXRTraOrPAdXuPGBvo41rLeKv293IPG9sD2s0rAGgRaJthcFGySaCAQCrV
	JqPmI6hpTxo6FvIWevpSv9q/t31DwL5MJTczl6D1osOLUan2d5PfmxcVONa1Dj+SbMYNjBImKcME/
	ejP4ldUKyhO20CDdMBwWSWflagbmrrO1mhAXe8clYPgL/SQwS7afGoTUm2eDDolAA9v34nO5bMOQg
	J3sAtd00hsSyWh3u6xVnd64vgktjSoaRhGLAUeMNS87OMxizqH+u/hB+upU6wK/aify+I3tqLb2X4
	ucjofAwA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vw47r-00000009KHc-3PwW;
	Fri, 27 Feb 2026 20:07:51 +0000
Date: Fri, 27 Feb 2026 20:07:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: hooanon05g@gmail.com
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: v7.0-rc1, name_to_handle_at(..., AT_EMPTY_PATH)
Message-ID: <20260227200751.GD3836593@ZenIV>
References: <14544.1772189098@jrotkm2>
 <20260227152211.GB3836593@ZenIV>
 <26309.1772206864@jrotkm2>
 <20260227184804.GC3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227184804.GC3836593@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-78769-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6654F1BD2FE
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 06:48:04PM +0000, Al Viro wrote:
> On Sat, Feb 28, 2026 at 12:41:04AM +0900, hooanon05g@gmail.com wrote:
> > Al Viro:
> > > This
> > > struct filename *getname_uflags(const char __user *filename, int uflags)
> > > {
> > >         int flags = (uflags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
> > >
> > > 	return getname_flags(filename, flags);
> > > }
> > > is where AT_EMPTY_PATH is handled; could you check the arguuments it's getting
> > > in your reproducer and argument passed to getname_flags()?
> > 
> > getname_flags() is not a problem.
> > For me, the problem looks that LOOKUP_EMPTY is NOT passed to
> > path_lookupat().
> 
> Could you please show me a single place in path_lookupat() where we would
> check for for LOOKUP_EMPTY?
> 
> The last point where LOOKUP_EMPTY (or AT_EMPTY_PATH) matters is (and had
> always been) getname_flags(); pathname resolution proper doesn't care.
> 
> In theory some out-of-tree filesystem might have been playing silly
> buggers with LOOKUP_EMPTY in its ->d_revalidate(); there's no good
> reason for doing so, though, and none of the in-tree filesystems had
> ever tried to pull that off.

To elaborate a bit: LOOKUP_EMPTY has ever had only one purpose - to tell
getname...() that empty pathname is not to be rejected.  This is _all_
- e.g. a combination of LOOKUP_EMPTY with non-empty pathname has always
been possible.  It simply does not carry any useful information past
that check on pathname import.

Nothing in pathname resolution checks it; of the few filesystem methods
that might see something of nd->flags, only ->d{_weak}_revalidate() would
have a chance to see that one for an empty pathname (no components to
look up, obviously).  And considering how uninformative LOOKUP_EMPTY would
be for that method... not a single in-tree instance had bothered to check.

Note that combination of AT_EMPTY_PATH with a non-empty pathname
has always been legitimate, and it would better behave exactly
like the call the same non-empty pathname and AT_EMPTY_PATH
removed from the flags.  So if LOOKUP_EMPTY changes behaviour of
->d_weak_revalidate()/->d_revalidate(), it's almost certainly a bug.

Is your testcase on the mainline kernel?  If not, is there an out-of-tree
filesystem involved?  Are there any kprobes/bpf programs/etc. stuck
into the guts of fs/namei.c?  struct nameidata shouldn't be even visible
to any of those, but...

