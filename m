Return-Path: <linux-fsdevel+bounces-78614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOBbNwKMoGkCkwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:08:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0832A1AD431
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99F583001F8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DCD3290AC;
	Thu, 26 Feb 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GJCwtwvL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DnVUwia3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GJCwtwvL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DnVUwia3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDCA3290A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126363; cv=none; b=e2tnK16d95h5WNRPmBhKazECZaZU+oIgfpTmv9ws3cTH0hwOy8gLudjafTz2WOABv5rKqiV7t54k50EMw+uPGjEY1zTUSph0CN4AanTCSap0yVQr1iN+ZuHmEs84Dvf0JK9Bkj7YLPNl1pHiYMeAfrC3bl2kvBj+8Ume+OiLtG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126363; c=relaxed/simple;
	bh=Yz06xS8n351h926ibHfwTY0r1HRP3tglieWQP0/1TLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUXk+zZ6sBsZxH4UHOLcnuXkuiMeCCcCGdWNMwCxpeJmO4ozTpvVf1WLWMtJbjmL+UyZrWSr+0+iPn8BbaQWUNvgxiRNtUx5ohW7JKWrQxiAs931daNKdiGbwAR3k57OYSWXsWPrB4LUaf+3aYfFK+qsgvAZVPm8aolwBsqvTPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GJCwtwvL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DnVUwia3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GJCwtwvL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DnVUwia3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9296840009;
	Thu, 26 Feb 2026 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772126360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hiS/ZOO9Sm59YO0jlPwiYn9deba1DB2WuwVTuxItfYs=;
	b=GJCwtwvLSr8Jz12f/7ZvZChatvFT22x4DehmEunFhM5R8qNkOBWxBkNehe7NBTw3ah22c1
	Gjo4hBvLnOtUCkesIY7DXmL9yLP2ZkSyBBgLXI2wMg8PBa3DPzG7CVn2JtdocFberaBrnL
	Y2pru1TWQKM32/9WK3ZrWSQK5Wsd5Uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772126360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hiS/ZOO9Sm59YO0jlPwiYn9deba1DB2WuwVTuxItfYs=;
	b=DnVUwia3icr2IsbXKEUF6MWLQHLTI4NDSKZ3Q9HKv5lg7YvqwVgkTdsdJLHIVoRwDe9WY4
	gJ+FpuO6YJrOQJDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GJCwtwvL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DnVUwia3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772126360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hiS/ZOO9Sm59YO0jlPwiYn9deba1DB2WuwVTuxItfYs=;
	b=GJCwtwvLSr8Jz12f/7ZvZChatvFT22x4DehmEunFhM5R8qNkOBWxBkNehe7NBTw3ah22c1
	Gjo4hBvLnOtUCkesIY7DXmL9yLP2ZkSyBBgLXI2wMg8PBa3DPzG7CVn2JtdocFberaBrnL
	Y2pru1TWQKM32/9WK3ZrWSQK5Wsd5Uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772126360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hiS/ZOO9Sm59YO0jlPwiYn9deba1DB2WuwVTuxItfYs=;
	b=DnVUwia3icr2IsbXKEUF6MWLQHLTI4NDSKZ3Q9HKv5lg7YvqwVgkTdsdJLHIVoRwDe9WY4
	gJ+FpuO6YJrOQJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 839303EA62;
	Thu, 26 Feb 2026 17:19:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9lwbIJiAoGnsTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 17:19:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C877A0A27; Thu, 26 Feb 2026 18:19:20 +0100 (CET)
Date: Thu, 26 Feb 2026 18:19:20 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/61] vfs: change i_ino from unsigned long to u64
Message-ID: <v2gibkxuingitgmoxevqhh7fxsnceioos2xrhycwnilep3fcni@jkgct7onqolx>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <20260226-iino-u64-v1-2-ccceff366db9@kernel.org>
 <06c94e29-32d8-4753-a78c-8f5497680cf4@efficios.com>
 <df0b9e26fca0dc56a10e2f6792892c7b5f23c84b.camel@kernel.org>
 <540a4fa6-40fc-4302-aaef-3df5fb3a8cef@efficios.com>
 <e0759209c02d81b877b136f1e2b9500ba69b4f35.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0759209c02d81b877b136f1e2b9500ba69b4f35.camel@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-78614-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0832A1AD431
X-Rspamd-Action: no action

On Thu 26-02-26 11:45:16, Jeff Layton wrote:
> On Thu, 2026-02-26 at 11:40 -0500, Mathieu Desnoyers wrote:
> > On 2026-02-26 11:35, Jeff Layton wrote:
> > > 
> > > I'll let others chime in first, but I'm open to going back and doing it
> > > that way if we don't want to live with the compiler warnings during a
> > > bisect.
> > 
> > On 32-bit archs, I suspect it will do more than emit compiler warnings.
> > Trying to boot a kernel in the middle of the series is likely to lead to
> > interesting inode value printout results.
> > 
> 
> Definitely. None of that would be trustworthy in the middle of the
> series.

Yeah, I think defining kino_t in the beginning as unsigned long, convert
everything (including special format string specifier) to it, then switch
it to u64 and finally just 'sed-out' the format string specifier in the
final patch shouldn't be harder than what you do here and should keep
bisectability?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

