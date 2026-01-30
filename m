Return-Path: <linux-fsdevel+bounces-75950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ib/JNrTfGlbOwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 16:52:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7AEBC407
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 16:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ACFA305F3D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2263446A5;
	Fri, 30 Jan 2026 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vcbvqM8z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QdMWcBGT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485234251F;
	Fri, 30 Jan 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788249; cv=none; b=TFpwVJoIKpwkSh/YrV6QMank0TvcW7BmqxL/kpM8ryqRHSmgIv/Y7Dkdj4MZra+XM/I9S4+jZb0pBMKRirUXSptfjOCUGVQryxkaLxu+fsqyuKCvnIFKIowWKgyphURmhsxYJpYCK+RLEczimgIb2LIatKoekGAEaEk9czgTJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788249; c=relaxed/simple;
	bh=W4KBxLLfE9ElWibilqx7jUzbdgU3N1lyFdNxSsKozK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mj3qGkjfxXRSo/2U0/x6D6CAwDbnajQn8mkkuJoRrHXQCPU0tZm8R+gFh00quxahY9R3VZ4HYGWavdaLIbkN0DIr7HRy5OMNuWAxQD6cDR3MOw7FyloUm6HdZHcdInxF/9EPr2fNx8bYXklN6KiQCNbJpOVAlphppFb5WQDgJ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vcbvqM8z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QdMWcBGT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769788246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VKYYYdqumsniIC39YChzbfba4q3RKQuXPKPNETM4jMs=;
	b=vcbvqM8zYMWsd/tMS8cM3Z8mI0EFVLj960Sgnq06Gp+EE//WNnLbcLZhAA/pMTKCGlvDfP
	yqke2jH0ufmQ2nSCXnCEz+Jn+XrQJzGXcBaQD7aRlFZRq53PQc5/Ez6pS9vF8H4vaE7v3p
	5Os9pnShRRfDny9vUFVCUgpDJtra3pkpEpGkGFqBbqhRd67I4u4yEw2yRumLCICvxBk8BF
	lYslZ9n7CIZiicXU68jj736XQbVbZj259QlZ9D5cpD/hhtYKt/yvG/sW6XwJQlB9xGg1Yt
	1dTW+LYZ7TXgk5cXhk98yy4erq5rCNAMT0/GW3UcnHSmpCbIxRncuJF5VzCABA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769788246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VKYYYdqumsniIC39YChzbfba4q3RKQuXPKPNETM4jMs=;
	b=QdMWcBGTcUpDPEMRRsRb8Xqv5ndFVC6eiO9zg4AEYukrcFUq2iwMVZ0Wp1FzCEeMeF0WzL
	p1LnaogxsATMNsAA==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Jiri
 Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jacky Huang <ychuang3@nuvoton.com>,
 Shan-Chun Hung <schung@nuvoton.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 02/19] printk: Introduce console_is_nbcon
In-Reply-To: <20251227-printk-cleanup-part3-v1-2-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-2-21a291bcf197@suse.com>
Date: Fri, 30 Jan 2026 16:56:45 +0106
Message-ID: <875x8j3xre.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75950-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[46];
	FREEMAIL_TO(0.00)[suse.com,nod.at,cambridgegreys.com,sipsolutions.net,linuxfoundation.org,windriver.com,kernel.org,chromium.org,goodmis.org,debian.org,lunn.ch,davemloft.net,google.com,redhat.com,linux-m68k.org,intel.com,igalia.com,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,gaisler.com,linux.intel.com,foss.st.com,nuvoton.com,nxp.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.ogness@linutronix.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jogness.linutronix.de:mid,suse.com:email]
X-Rspamd-Queue-Id: EB7AEBC407
X-Rspamd-Action: no action

On 2025-12-27, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> Besides checking if the current console is NBCON or not, console->flags
> is also being read in order to serve as argument of the console_is_usable
> function.
>
> But CON_NBCON flag is unique: it's set just once in the console
> registration and never cleared. In this case it can be possible to read
> the flag when console_srcu_lock is held (which is the case when using
> for_each_console).
>
> This change makes possible to remove the flags argument from
> console_is_usable in the next patches.

Note that console_is_usable() now also checks for the flag
CON_NBCON_ATOMIC_UNSAFE as well.

> diff --git a/include/linux/console.h b/include/linux/console.h
> index 35c03fc4ed51..dd4ec7a5bff9 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -561,6 +561,33 @@ static inline void console_srcu_write_flags(struct console *con, short flags)
>  	WRITE_ONCE(con->flags, flags);
>  }
>  
> +/**
> + * console_srcu_is_nbcon - Locklessly check whether the console is nbcon
> + * @con:	struct console pointer of console to check
> + *
> + * Requires console_srcu_read_lock to be held, which implies that @con might
> + * be a registered console. The purpose of holding console_srcu_read_lock is
> + * to guarantee that no exit/cleanup routines will run if the console
> + * is currently undergoing unregistration.
> + *
> + * If the caller is holding the console_list_lock or it is _certain_ that
> + * @con is not and will not become registered, the caller may read
> + * @con->flags directly instead.
> + *
> + * Context: Any context.
> + * Return: True when CON_NBCON flag is set.
> + */
> +static inline bool console_is_nbcon(const struct console *con)
> +{
> +	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
> +
> +	/*
> +	 * The CON_NBCON flag is statically initialized and is never
> +	 * set or cleared at runtime.
> +	 */
> +	return data_race(con->flags & CON_NBCON);

If this flag is statically initialized and is never set or cleared at
runtime, why is the console_srcu_read_lock required? Why not just:

static inline bool console_is_nbcon(const struct console *con)
{
        /*
	 * The CON_NBCON flag is statically initialized and is never
	 * set or cleared at runtime.
	 */
	return data_race(con->flags & CON_NBCON);
}

And even if you do need the console_srcu_read_lock, why copy/paste the
implementation and comments of console_srcu_read_flags()? Just do:

static inline bool console_is_nbcon(const struct console *con)
{
	return console_srcu_read_flags(con) & CON_NBCON;
}

John Ogness

