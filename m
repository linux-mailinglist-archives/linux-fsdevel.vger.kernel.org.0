Return-Path: <linux-fsdevel+bounces-77575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGsvOTG/lWkfUgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 14:31:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD2D156AE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 14:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F21AB3014A2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19070327209;
	Wed, 18 Feb 2026 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="NXAsZZ6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D03271E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421432; cv=none; b=WXLjw+4YD0XHenyW8qTtRkwv3L9jKZc/cuPmyE6N+6jhSbUHPpK4231feb/4SbjBdXfvUyJP25Vxd8Fc+P0UW80SVuLXeLoayKDiTgPeflmCddQA9e84pLLi6vOrtm1d3bTB//kNL84gAteyl5dTAII/jQp1kgXVxqMzwtHsKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421432; c=relaxed/simple;
	bh=BUcbqGXHuR1KNA7AOVUKexsQGN8FVHG6OgIdvHbwxhA=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5uNenomDnua72JKh+FtFKjphiC+xbvJ/O0kZAf7DflHs4CgaVmGaFYy/xNDcicFKQ+lmi8EPzf4OK7SxNEsLvtv72JP/94EDJy8Re+R5VYhIyeR1z0Ybcc0ZqGVBBtamzLTkgXnCwhFIxMSkZRon/tTPuNyICE5Jh4pFsd+aqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=NXAsZZ6d; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-113-47.bstnma.fios.verizon.net [173.48.113.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61IDTtYH018341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 08:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1771421397; bh=ttRrWrhPrzLzmBLq8cse1fRC/Cd5ZBOuRs3LOAaPw2g=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=NXAsZZ6dfomZQDhQDoXUYVVnsdoELU1CMDZkwfnRjcDsXbYipDX9bUREA/wiAhhMw
	 UO8G3+ipWoUbqG9v7pz9RwNVOXmUYTIKGlzLxcNnJfjLHKEsnlCIjMxjroY5W+0Ual
	 jzrDv7Gkqc83fMCglCLkDerIiLxaAir0a+1AQo2cRVMkebTR48nTuUniaqGj6vgXIG
	 YP88DgunCIw/z3B4nXCwyjOVmsq4byEd/tAEiorBiSQl7AdModYKnnNmN6UcppC8X6
	 xrVVCqf1y7R/wCs08VKsz6lNE4xhgnJBeoteMrm5t86MDluBjZ9CovO/eDZkPxbN3/
	 LP+0K9CBPef1g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 1A8CA58FE818; Wed, 18 Feb 2026 08:29:55 -0500 (EST)
Date: Wed, 18 Feb 2026 08:29:54 -0500
From: "Theodore Tso" <tytso@mit.edu>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
Message-ID: <20260218132954.GA45984@macsyma-wired.lan>
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
 <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
 <CAHk-=wj80zwxy=5jp5SAi64cqCZgRjY1cRokVuDPd9_t3XMvUw@mail.gmail.com>
 <CAG48ez2YiL7RZ1fm9vwOCDGr9OsDrCHrCmkyRRoGRMWUZjyyBg@mail.gmail.com>
 <CAHk-=wiPJfnTVq6vUF8K8kF0FfrY2svAqSwsL8xLEV76pVyEkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPJfnTVq6vUF8K8kF0FfrY2svAqSwsL8xLEV76pVyEkg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77575-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FD2D156AE3
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 03:44:52PM -0800, Linus Torvalds wrote:
> On Tue, 17 Feb 2026 at 15:38, Jann Horn <jannh@google.com> wrote:
> >
> > You can already send SIGHUP to such binaries through things like job
> > control, right?
> 
> But at least those can be blocked, and people can disassociate
> themselves from a tty if they care etc.

Does CLONE_PIDFD_AUTOKILL need to send a SIGKILL?  Could it be
something that could be trapped/blocked, like SIGHUP or SIGTERM?  Or
maybe we could do the SIGHUP, wait 30 seconds (+/- a random delay), if
it hasn't exited, send SIGTERM, wait another 30 seconds (+/- a random
delay) if it hasn't exited send a SIGKILL.  That's still a change in
the security model, but it's less likely to cause problems if the goal
is to try to catch a setuid program while it is in the middle of
editing some critical file such as /etc/sudo.conf or /etc/passwd or
some such.

I bet we'll still see some zero days coming out of this, but we can at
least mitigate likelihood of security breach.

							- Ted
							

