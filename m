Return-Path: <linux-fsdevel+bounces-77578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDO8AAzGlWmTUgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 15:00:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4D2156EFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 15:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A8A73014C5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 14:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3B830DED7;
	Wed, 18 Feb 2026 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dvaDgiLX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D622D7B5
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423238; cv=none; b=G8MbU5C/KiWTzCp5aMY+bW7867PclIdu8CCLCCf1XdMZjwiJiwX9MzoD3aoj3AKetjAYEqn9IImDNMmogLwt8gNrJnh/siAovzxMLed1lHH7qwlCJVs3aqRiRaYxRc8QI6l/V1ZuYWM0r1PcLd+lkMfOarwkCO1QVF9FSf1iSmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423238; c=relaxed/simple;
	bh=aQyfPNbZ5tma/GlMTYcdjpJ/BoxTrnZRSIykid7Y3Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGbCQQ8hWsXdOSItKE664UjdEcu8cz1U4suR56jnMwNXj14NGTSc2XaTV6U1WW98avGgnwHLz931Hugpv6AhLPQFZ4J5teJupQJRRCSYO6FIxvybGaDFxX5hKXUl8TQbNH1tb2kqTIibRUzBollnM4+YqUmHl1tMC/6rTrkfFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dvaDgiLX; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-113-47.bstnma.fios.verizon.net [173.48.113.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61IE0AQJ004385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 09:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1771423213; bh=MeJaimv0Gz22rggELY3R0BKZxO902yuWAVOXVJoTUVc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dvaDgiLXHKJaiyWFBQG7C+n/hIJA5z06Tec8wkQnUQUdVccXjGzUa+o9jKvk3wDiL
	 sye1Do7TagKlhAPfQhQ95TfkKibBl9/OJu0QVHnat9y7ZJWmkfFOdyA0V+07tTVEav
	 G33TGxBTdcasFPXye1wi7ed74a//E0SPGSWsNh1ns4PXw6+hDKCbeoiUoJoDFPNwSv
	 /YA0KIoql94POrEYdv3MlYyki/RP5VUy08fGRgjb7ZW04ArzJ4cWn97ujC/peAESnU
	 8TXAkLT4ty0pXRj8zTWAqVP4D8kReZp5vFoR5KRHQaUye3CTBKt9Z0mVsQPr9TANRH
	 IKcE9quCkfbmQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 609C45901A5C; Wed, 18 Feb 2026 09:00:10 -0500 (EST)
Date: Wed, 18 Feb 2026 09:00:10 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
Message-ID: <20260218140010.GC45984@macsyma-wired.lan>
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
 <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
 <CAHk-=wj80zwxy=5jp5SAi64cqCZgRjY1cRokVuDPd9_t3XMvUw@mail.gmail.com>
 <CAG48ez2YiL7RZ1fm9vwOCDGr9OsDrCHrCmkyRRoGRMWUZjyyBg@mail.gmail.com>
 <CAHk-=wiPJfnTVq6vUF8K8kF0FfrY2svAqSwsL8xLEV76pVyEkg@mail.gmail.com>
 <20260218-wonach-kampieren-adfca0940b45@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218-wonach-kampieren-adfca0940b45@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,macsyma-wired.lan:mid];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77578-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+]
X-Rspamd-Queue-Id: 6E4D2156EFD
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 09:18:49AM +0100, Christian Brauner wrote:
> The kill-on-close contract cannot be flaunted no matter what gets
> executed very much in contrast to pdeath_signal which is annoying
> because it magically gets unset and then userspace needs to know when it
> got unset and then needs to reset it again.

I think you mean "violated", not "flaunted", above.

If a process can do the double-fork dance to avoid getting killed, is
that a problem with your use case?

What if we give the process time to exit before we bring down the
hammer, as I suggested in another message on this thread?

> My ideal model for kill-on-close is to just ruthlessly enforce that the
> kernel murders anything once the file is released. I would value input
> under what circumstances we could make this work without having the
> kernel magically unset it under magical circumstances that are
> completely opaque to userspace.

I don't think this proposal would fly, but what if an exec of a setuid
binary fails with an error if the AUTOKILL flag is set?   :-)

       	     	     	      	  	   	- Ted

