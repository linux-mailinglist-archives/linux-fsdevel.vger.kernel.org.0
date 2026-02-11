Return-Path: <linux-fsdevel+bounces-76925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH34Ejjsi2nEdQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:40:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8855120CD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A577A30626CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B5933FE27;
	Wed, 11 Feb 2026 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A6IdvQcP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5luqw0c7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A6IdvQcP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5luqw0c7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F112F585
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770777645; cv=none; b=rvc8Dq3hUd1D04kqelQZm3+GuU8AlAwao6HS+6bco8l1udq4PMbsGNQi6WPY9glCc8dwoQNTActQKN+dJl0AFJNPBhlvFvqLOi1Vjk8ULJ57iA+/iFEDqAJgLhVdE/f7vvSoEWZqeBZFh/8C0iAEYLbK6E5A3rhr4OlBTN/YIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770777645; c=relaxed/simple;
	bh=LcY6J49s4myOjU615R/O1NvQ01KDK3N7Pq+rLOwdpN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbcgbpIaMTKcFEqdV48EAnyVt/XNDJ1vuSv/w2TpIPaxIwQB+zEeoptQLDopb/EUy5ESV1m6K4alGYJkj5Gh4zID7KG4TLxlJULISgBctXDgLswDzmVrZsWHq80njoK47xL2I+SUJWzEoDdn3yirxbhFTJ+IuID4wdhIGILCDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A6IdvQcP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5luqw0c7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A6IdvQcP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5luqw0c7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D2D63E724;
	Wed, 11 Feb 2026 02:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770777642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpAZh4J9N2AyiI8wFEX/VZ91FOS1QAchLtumN9R7uN8=;
	b=A6IdvQcPl6pGAQ7Tupc9q64d9j0TOiE0q84ApfYD9ukWTLZbwe+htRGujugZzYs2i0ggN7
	GO9UJxELkT2yVumZnHCPTBy9pjEB/jT7nAmR270vxosz9u6iVYHKr948RX4K4ED1JyNJHh
	0hrUzP4xgyYBqmdUlUqyuoWjOjycv7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770777642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpAZh4J9N2AyiI8wFEX/VZ91FOS1QAchLtumN9R7uN8=;
	b=5luqw0c76RTwSzepKruW5tuefEBYxfvkO3adNegel7by2WVYl51sUVyZfFsshhBQNI1c3X
	K5Y2gD+xN+HIzyCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A6IdvQcP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5luqw0c7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770777642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpAZh4J9N2AyiI8wFEX/VZ91FOS1QAchLtumN9R7uN8=;
	b=A6IdvQcPl6pGAQ7Tupc9q64d9j0TOiE0q84ApfYD9ukWTLZbwe+htRGujugZzYs2i0ggN7
	GO9UJxELkT2yVumZnHCPTBy9pjEB/jT7nAmR270vxosz9u6iVYHKr948RX4K4ED1JyNJHh
	0hrUzP4xgyYBqmdUlUqyuoWjOjycv7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770777642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpAZh4J9N2AyiI8wFEX/VZ91FOS1QAchLtumN9R7uN8=;
	b=5luqw0c76RTwSzepKruW5tuefEBYxfvkO3adNegel7by2WVYl51sUVyZfFsshhBQNI1c3X
	K5Y2gD+xN+HIzyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D46D33EA62;
	Wed, 11 Feb 2026 02:40:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BsUfIifsi2m6KgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 11 Feb 2026 02:40:39 +0000
Date: Wed, 11 Feb 2026 13:40:25 +1100
From: David Disseldorp <ddiss@suse.de>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Dmitry Safonov <0x7f454c46@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] initramfs: correctly handle space in path on cpio
 list generation
Message-ID: <20260211134025.57a4d249.ddiss@suse.de>
In-Reply-To: <698bd439.050a0220.38f6b4.a251@mx.google.com>
References: <20260209153800.28228-1-ansuelsmth@gmail.com>
	<20260210223431.6bf63673.ddiss@suse.de>
	<698b6ced.050a0220.9e34a.3e08@mx.google.com>
	<20260211113308.4c5b0b82.ddiss@suse.de>
	<698bd439.050a0220.38f6b4.a251@mx.google.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76925-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8855120CD6
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 01:58:27 +0100, Christian Marangi wrote:

> > What happens when someone wants support for filenames containing spaces
> > and quotes?
> >   
> 
> I mean... it's a less common case where filename start to have almost invalid
> char but yes it's a valid point.
> 
> > > I'm open to both solution. Lets just agree on one of the 2.  
> > 
> > I don't think any of the options will be particularly simple, but
> > nul-byte delimited field support might be the most straightforward.
> >   
> 
> Yes that was the initial idea but was quickly scrapped as major work is needed
> in the .c tool to handle NULL separated entry.
> 
> Can you by chance point to me how the GNU tool work with --null ?
> 
> 
> They also create a cpio_list file with entry NULL separated?

E.g. dracut uses the GNU cpio --null alongside find -print0:

  cd "$initdir"
  find . -print0 | sort -z \
      | cpio ${CPIO_REPRODUCIBLE:+--reproducible} --null ${cpio_owner:+-R "$cpio_owner"} -H newc -o --quiet \
      | $compress >> "${DRACUT_TMPDIR}/initramfs.img"

