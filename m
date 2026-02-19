Return-Path: <linux-fsdevel+bounces-77753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NqZCfyjl2mf3wIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 00:59:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EE8163C05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 00:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 838C3301111F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20982F8BEE;
	Thu, 19 Feb 2026 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DbF8Broz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mNEqWp7W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DbF8Broz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mNEqWp7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B5329E7E
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545576; cv=none; b=sC2y56p0vf2gc/PQHEF2FzC0WA2DhwO0TmKh6LiUqEJfnOev7lLk7G0RiwjjnXV/aJ8CtVWZfM+qJQXKWSMwQh5L5OyuEy8j74orIZy6WYkw5l5i5wQDsqKSdauBtX7Qo/R7H/WoXgYdnHYBcsrTlcotlGqWRkQUWSMGXnN8pgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545576; c=relaxed/simple;
	bh=/sMVd6t/ySVPo+xYFCuqRKNAdXXwIh8XQ0cpYIdZPPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPNKmxptqCqS3LyF/s3jVlgv1JaYN/D+2f2iiDti3BpmuNesZSUBKgksvdefgCASBFNMzKZB3UIQJrmvJM5MztskGyQJfblidcdXu1928zt8ES2WpKpTbnoAVDBsw4BbGW6CMFA6Dc5Fo6ly4ITBrr9qKv2XYpb1JfiFBA+TXb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DbF8Broz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mNEqWp7W; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DbF8Broz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mNEqWp7W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 429AB3E709;
	Thu, 19 Feb 2026 23:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771545573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZD03gpmbjzf0OFyLhz08rHF0+1Tr1YE3QGG0eHm078=;
	b=DbF8Brozji/Gnlo86j5STnf3x3t1w/OuGydFZxJ5nWv7SETPQ/qVhS90RgrIgmrAB0l5yH
	xelF8QLcGsauhT8ubJonaoFetIwO/kdgWqUj32mxazzJ1zODhlmsAf/kcFidtmKF9QSs+C
	C42EyH+LwoGDBujDSG7xspkXB83Aids=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771545573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZD03gpmbjzf0OFyLhz08rHF0+1Tr1YE3QGG0eHm078=;
	b=mNEqWp7Wy2+OGLKVxlN2vVuPD0pVjSs9GATulwuCv78j/9Nhxn3oyzVN8Z05tR6kuXOvLE
	fA/Txza0ZEAl0uDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DbF8Broz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mNEqWp7W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771545573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZD03gpmbjzf0OFyLhz08rHF0+1Tr1YE3QGG0eHm078=;
	b=DbF8Brozji/Gnlo86j5STnf3x3t1w/OuGydFZxJ5nWv7SETPQ/qVhS90RgrIgmrAB0l5yH
	xelF8QLcGsauhT8ubJonaoFetIwO/kdgWqUj32mxazzJ1zODhlmsAf/kcFidtmKF9QSs+C
	C42EyH+LwoGDBujDSG7xspkXB83Aids=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771545573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZD03gpmbjzf0OFyLhz08rHF0+1Tr1YE3QGG0eHm078=;
	b=mNEqWp7Wy2+OGLKVxlN2vVuPD0pVjSs9GATulwuCv78j/9Nhxn3oyzVN8Z05tR6kuXOvLE
	fA/Txza0ZEAl0uDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76C8F3EA65;
	Thu, 19 Feb 2026 23:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IzI+CuCjl2ntMwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 19 Feb 2026 23:59:28 +0000
Date: Fri, 20 Feb 2026 10:59:13 +1100
From: David Disseldorp <ddiss@suse.de>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Randy
 Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org, Rob Landley
 <rob@landley.net>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
 <nsc@kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always
 available in initramfs
Message-ID: <20260220105913.4b62e124.ddiss@suse.de>
In-Reply-To: <20260219210312.3468980-2-safinaskar@gmail.com>
References: <20260219210312.3468980-1-safinaskar@gmail.com>
	<20260219210312.3468980-2-safinaskar@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77753-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69EE8163C05
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 21:03:11 +0000, Askar Safin wrote:

> If we generate external initramfs as normal user using "cpio"
> command, then we cannot put /dev/console there.
> 
> Fortunately, in this case default builtin initramfs will
> contain /dev/console (before this commit).
> 
> But if we generate builtin initramfs instead, then we will
> not have /dev/console at all. Thus the kernel will be unable to
> open /dev/console, and PID 1 will have stdin, stdout and stderr
> closed.
> 
> This problem can be solved by using gen_init_cpio.
> 
> But I think that proper solution is to ensure that /dev/console
> is always available, no matter what. This is quality-of-implementation
> feature. This will reduce number of possible failure modes. And
> this will make easier for developers to get early boot right.
> (Early boot issues are very hard to debug.)

I'd prefer not to go down this path:
- I think it's reasonable to expect that users who override the default
  internal initramfs know what they're doing WRT /dev/console creation.
- initramfs can be made up of concatenated cpio archives, so tools which
  insist on using GNU cpio and run into mknod EPERM issues could append
  the nodes via gen_init_cpio, while continuing to use GNU cpio for
  everything else.

Thanks, David

