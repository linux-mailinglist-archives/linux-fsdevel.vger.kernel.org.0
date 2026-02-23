Return-Path: <linux-fsdevel+bounces-77898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHmjHk6rm2mu4QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:20:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB66171472
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B42B3018C27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F3199E89;
	Mon, 23 Feb 2026 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gOySpbf/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V+0JcQ5l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uj6QMf/a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ejivpoGX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59EF1B142D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809605; cv=none; b=SXxNsm39axc5sGnoup77Em8ooeZo5qojt7XgiHdZpNVaV1ANZSqCo/ewth6tuw2R8Sjk1ApKanihwVZYnS/oI0+UEIEyTPWsr9wiM1POX8Jv3R1bFBUtHNotYOQus+BHfgp/dkS4kEBGxqx3KyyMwhuOgNr/sFo2hiod3v0AMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809605; c=relaxed/simple;
	bh=tgq2YoYvWHrG9qbHcPkL26Ke7julp5xe4c/8XsuNBV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOvxesYwFpYnUPrXUW0PoV+S1m6d9p8YNVCXYEblejfjVZsS+caosOnsHA6feJkdOMKITqO0YJRxDdTdEyNgkt/1rwGySzhGKTjIWzNzsPM/mliZQPVazKzXqXousDs4YSH2C6RR4tx4WgN/p9c5H3bQn0jUai0tnmkAdOm+RVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gOySpbf/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V+0JcQ5l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uj6QMf/a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ejivpoGX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17A275BCC5;
	Mon, 23 Feb 2026 01:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771809602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKdPuJO/+UnRu5M/kPc7RuH5b+M9Cy/o7ZlODqdL2yQ=;
	b=gOySpbf/1ZWgQ+DFTgYTwzSUYSMlcbMNJc+seo8mRW3uVSJ/RcKvJwxHS7Ig5Z9Ddz3lR3
	if0bI33wiApMsGa16X3ocVObTS8/E1KrRugX0UZvsRYPqlBdO3RZHfh4gWGU4QOYnw7Gdl
	UnxLHDwmT4BYHsOqRyHBNw5/+FpRCmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771809602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKdPuJO/+UnRu5M/kPc7RuH5b+M9Cy/o7ZlODqdL2yQ=;
	b=V+0JcQ5lNyApGKGVPPpxiSQYXOinVvvwCJIc+bZwBa9TN1mzCHw0nru9IYVltEHgOidm0r
	1Cm2iYWyK/sH30Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Uj6QMf/a";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ejivpoGX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771809601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKdPuJO/+UnRu5M/kPc7RuH5b+M9Cy/o7ZlODqdL2yQ=;
	b=Uj6QMf/aCdFNnjdJWalZTsUMnADqJcYMCVo7vJu/W5/qbKxQ7TAvLF7Xo2k4gtdrGjpWl6
	HmbzjfY/7XHc2jpQHAt8J9J1HCrGYqy/17ZFelz2qjxxRjnFYSP50fAyiszlJDkLeb64nr
	xsq0XlQTaj9uQ7nK4j2rTY/W5ecwqjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771809601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKdPuJO/+UnRu5M/kPc7RuH5b+M9Cy/o7ZlODqdL2yQ=;
	b=ejivpoGXPvp8LiNWmWyj/dZgjTCE2ne7+5B8qM00GDna+/EOAYupxuhdHhT/9mZppHfFap
	HukOc6w5asIBWJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F0583EA68;
	Mon, 23 Feb 2026 01:19:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0c5sOzurm2mENQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 23 Feb 2026 01:19:55 +0000
Date: Mon, 23 Feb 2026 12:19:46 +1100
From: David Disseldorp <ddiss@suse.de>
To: Askar Safin <safinaskar@gmail.com>
Cc: brauner@kernel.org, initramfs@vger.kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, nathan@kernel.org, nsc@kernel.org,
 patches@lists.linux.dev, rdunlap@infradead.org, rob@landley.net,
 viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always
 available in initramfs
Message-ID: <20260223121946.45b3c5b1.ddiss@suse.de>
In-Reply-To: <20260220191150.244006-1-safinaskar@gmail.com>
References: <20260220105913.4b62e124.ddiss@suse.de>
	<20260220191150.244006-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77898-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.com:url]
X-Rspamd-Queue-Id: EBB66171472
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 22:11:50 +0300, Askar Safin wrote:

> David Disseldorp <ddiss@suse.de>:
> > I'd prefer not to go down this path:
> > - I think it's reasonable to expect that users who override the default
> >   internal initramfs know what they're doing WRT /dev/console creation.
> > - initramfs can be made up of concatenated cpio archives, so tools which
> >   insist on using GNU cpio and run into mknod EPERM issues could append
> >   the nodes via gen_init_cpio, while continuing to use GNU cpio for
> >   everything else.  
> 
> This cannot be done in proper way.
> 
> Let's assume we want to build *builtin* initramfs using GNU cpio and
> then concatenate to it an archive made by gen_init_cpio.
> 
> Then we want CONFIG_INITRAMFS_SOURCE to accept already existing cpio
> archive AND file in gen_init_cpio format. But, according to
> CONFIG_INITRAMFS_SOURCE docs in usr/Kconfig, this is not possible
> (I didn't check whether this is true, I just have read the docs.)

...

> This means that the only remaining way is this:
> 
> 1. Create *fake* kernel config
> 2. Build whole kernel (!!!)
> 3. Create an archive by invoking gen_init_cpio and concatenate it to
> our preexisting archive
> 4. Create config, this time for real. Specify archive created in previous
> step as CONFIG_INITRAMFS_SOURCE
> 5. Build the kernel, this time for real
> 
> I hope you agree that this is totally insane.

A two-phase build isn't insane alongside a custom internal initrams -
consider the case where the user wants to bundle kernel modules.
Buildroot has logic for this kind of two-phase build:
https://gitlab.com/buildroot.org/buildroot/-/blob/master/linux/linux.mk?ref_type=heads#L408
IIUC buildroot doesn't change the kernel config but uses an initial
dummy cpio which is updated for the final (incremental) build stage.

> So, there is no proper way to create builtin initramfs by concatenating
> archives created by GNU cpio and gen_init_cpio.

There are still other options:
- use a different initramfs archiving tool
- point GNU cpio at an existing /dev/console, or call mknod as root

> I think this is a bug in kbuild, and it probably needs to be fixed.
> 
> But I think that my patchset is a better approach. My patchset simply
> ensures that /dev/console and /dev/null are always available, no matter
> what. And thus my patchset side steps the whole issue.

I remain unconvinced. To me it still feels like a workaround for GNU
cpio's poor archive-contents-must-exist-locally interface.

Thanks, David

