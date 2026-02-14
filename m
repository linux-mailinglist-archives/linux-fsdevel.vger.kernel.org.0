Return-Path: <linux-fsdevel+bounces-77219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7zmTDRCzkGmYcQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 18:38:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9065613C9F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 18:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36E383013A76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6B72494D8;
	Sat, 14 Feb 2026 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XuuwY2aL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B21624C0
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771090700; cv=none; b=fcnnEsy4pjabBWZHQpBdQmk+KiIKadSH2amuZna1cJ/c9EKNGZZFP/gvtrr3WRjKJwedBGA4TBqsWZ9wiO56vVsB8ZyE087Yxjm1jO9V/QLfCGBCyQtkCvEr+TOi77LRi/VVYg7nIyYOqOVYjsEcSdLqzhFzXpzqUJZmlLTfNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771090700; c=relaxed/simple;
	bh=eRiMdy+kvqgWky7sxMSe0eX8qWo3ZrCs/cj9xPt+Q+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf+PQt1dJKMtcm/4hi3u6jghCMqv29d8dNrdo0kF+WwlwtfAX7aX8/ISKc9SqGPKtuU/SqqLIfQ2Z/+QL1MVuT0NXaFu/yO6laEx1XcJT6Tq8I4DWsAikPTDFW2TgTDRwUu8vezLThrRFQpUDKQG9w2Q6IzPiqhpVT5oQ4+Ie8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XuuwY2aL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r5YCzEMx5jIDvrvaWRd9+EzGuH1Z5UCLnQFZpwOOH48=; b=XuuwY2aLTeLxraz3dLX35+mpYx
	3SeIQYOKwt8IjtbobsVD//j/SBTtmNZlDqLVNwzJyljaRJvRqOjklxBhkMzYePWAaMGk1cjnK3NDj
	L58Ji0tSPmZ/5qC0IVCf1AF1frY+DjQWkaImXV/nu7uPS4d+iGhEVZl888bl2Es8AkaomdwfRENta
	NRGDIpLR3KHejVyIkk4BKJRPU0fqqW8SvZ+PQwAvHGP5s3ijV07qPeyulYDSk/FkasV6YLPiEIxUE
	i+uV22lMgLRIMkaiI2BeN6r7wtGqbeYzM53pCHFpqrvRbiMeoHoQ1/80Tj5kTgYrWOrifJGVEeP3V
	Kd8PRvKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vrJd8-0000000ERVR-1Jhh;
	Sat, 14 Feb 2026 17:40:30 +0000
Date: Sat, 14 Feb 2026 17:40:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Askar Safin <safinaskar@gmail.com>, christian@brauner.io,
	cyphar@cyphar.com, hpa@zytor.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260214174030.GT3183987@ZenIV>
References: <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com>
 <20260213182732.196792-1-safinaskar@gmail.com>
 <CAHk-=wiB7BN2BnBjk5y2Zim_vveYg7GAZA_N+XjrptY59Qnzzw@mail.gmail.com>
 <20260214-duzen-inschrift-9382ae6a5c2b@brauner>
 <CAHk-=wiG5uhN1F7fxyEiEQdMtK_j8TCd7FoStbCFpNbn8qx7iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiG5uhN1F7fxyEiEQdMtK_j8TCd7FoStbCFpNbn8qx7iQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77219-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,brauner.io,cyphar.com,zytor.com,suse.cz,vger.kernel.org,almesberger.net];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9065613C9F7
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 08:18:55AM -0800, Linus Torvalds wrote:
> On Sat, 14 Feb 2026 at 04:15, Christian Brauner <brauner@kernel.org> wrote:
> >
> > But my point has been: we don't need it anymore.
> 
> I don't think that makes much of a difference. We'd still need to have
> pivot_root() around for the legacy case, and I do think we want to
> make sure it can't be used as an attack vector (perhaps not directly,
> but by possibly confusing other people).
> 
> Not that you should use containers as security boundaries anyway, but
> I do think the current behavior needs to be limited. Because it's
> dangerous.
> 
> Maybe just limiting it by namespace is ok.
> 
> Because even if the "white hat" users stop using pivot_root, we'd keep
> it around for legacy - and we want to limit the damage.

Indeed.  Let's backtrack a bit:
1) pivot_root() screwing around with root/pwd is unfortunate, but it's not
going away and neither is pivot_root() itself - not for several years,
at the very least.
2) having the set of affected threads limited shouldn't be a problem, as
long as we don't get too enthisiastic about that (relying upon the
assumptions about kernel threads getting picked along with init is
a bad idea, IMO).
3) walking into a container and expecting that mount tree won't get fucked
under you is a Bloody Bad Idea(tm) even without pivot_root() in the mix.
Sure, having pwd changed under you is still nice to avoid, but that's far
from the only thing to be cautious about.  That doesn't affect the
desirability of (2).
4) as long as we change pwd and root of _any_ threads that are not aware of
pivot_root() being done, we ought to have that change atomic wrt fork();
if child gets spawned by any such thread, the resulting state should not
depend upon the timinig of fork() vs. pivot_root().  The same goes for
unshare(2) (and while we are at it, in absense of pivot_root(2) and other
mount-related activity a caller of unshare(2) that gets ENOMEM can reasonably
expect their mount tree to remain unchanged).

Does anybody have objections to the above?

