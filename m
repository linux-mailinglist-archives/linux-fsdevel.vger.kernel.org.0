Return-Path: <linux-fsdevel+bounces-79338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFMUN2kKqGn2nQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 11:33:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B36B1FE638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 11:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C98D30898C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1683A2573;
	Wed,  4 Mar 2026 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="siZp4t3A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hRWnixAt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sucmmmmn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yA1+3gNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D943A256F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620224; cv=none; b=d/gv9wkH55s2edaQIFo9AEdo+/FogHDo7puAeCUDDS8Y6vYlyXJu4UscGU5w50jVVuDerKjr60fxgv0e8d2X/zoXZ1idhPwPvPIOpVxi68Yi+TwAcneXMX37p2R4FFry/x+WJ8wm7gwAQbFkdtl5z02Me5YfIYwHGMnl3v4Y5q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620224; c=relaxed/simple;
	bh=7a/WUUQxacqPYN/i8eDfaudF6ynDdM6mXdn4w7XcwU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnsucRUk6uygzDzXSlwEHW1vCnurBLF0xSUYlYCAOiHwK4esWn53G+W/gBNfZ7B3qAa7otBRmTpwGtD2BwBY+CEH8EZnfQP7XLjyjSeP2daulrsZxZ7D5ylLJ584eNSff4zHoonZzPwW53JsWTMyGaBrgPKx7RJ810An6aijojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=siZp4t3A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hRWnixAt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sucmmmmn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yA1+3gNC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B41D45BDE4;
	Wed,  4 Mar 2026 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772620220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sA285zy6QvyW+5GYqPLWOMtmxarDFnIGsLox5OjCH6I=;
	b=siZp4t3A6Gf7DGpcxsRRqAstaAJIVoTJ994JqZJ/yzRrFrOsdoZfaoBS/Eyhe87hyvPA6V
	ACbOl0dkkPmrlELO+M4o7JsWRHqGmA/3Et7bHuhWfPXJJNQc3bJda66Hz5nrMN3c07qkn8
	brVXr3gB0cqoE93ekYMuAdwUe3mH1rU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772620220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sA285zy6QvyW+5GYqPLWOMtmxarDFnIGsLox5OjCH6I=;
	b=hRWnixAtmwxt16gQu446BAjJv3l0nr8nlvQ2Y2YP7RqDe3+cF9h8sOnCox5H4/p8I4ATlu
	9KBD82KihbPdmGBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772620219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sA285zy6QvyW+5GYqPLWOMtmxarDFnIGsLox5OjCH6I=;
	b=sucmmmmnugeUmrf/mrx7P0vgvqWX5k1t//3lGg5lXWEFgGqkO7enjSQGkoD+bl+uIrL0A1
	LzxnMykHZHeYYQ7dbmpG1Szz+IVO/cZq4nFgfrK3Kqd6rta6XPvnnxnBbXGYmTHT+XiXON
	A6tZeLKBsCIWIy+dxSwdE3CXglxjUtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772620219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sA285zy6QvyW+5GYqPLWOMtmxarDFnIGsLox5OjCH6I=;
	b=yA1+3gNCGVL6lZ/iRstT5HJ6afRStjV0CxO209O7gedN2drYGBQdK9Tc9YwtNB62iHONEH
	X7suKX7Zsk9/HoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A41743EA6C;
	Wed,  4 Mar 2026 10:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IWsNKLsJqGmFDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Mar 2026 10:30:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67F9AA0A1B; Wed,  4 Mar 2026 11:30:19 +0100 (CET)
Date: Wed, 4 Mar 2026 11:30:19 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, 
	Ted Tso <tytso@mit.edu>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
	David Sterba <dsterba@suse.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, linux-aio@kvack.org, 
	Benjamin LaHaise <bcrl@kvack.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 21/32] bdev: Drop pointless invalidate_mapping_buffers()
 call
Message-ID: <7irr5gqmatluutbkywhvom7ryzn6j7cl4sw7q2d7e5q3grd7u2@mk54kpnqbi52>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-53-jack@suse.cz>
 <aabqTRvKIWo2mHz1@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabqTRvKIWo2mHz1@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 5B36B1FE638
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79338-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,kernel.dk];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue 03-03-26 06:03:57, Christoph Hellwig wrote:
> > diff --git a/block/bdev.c b/block/bdev.c
> > index ed022f8c48c7..ad1660b6b324 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -420,7 +420,6 @@ static void init_once(void *data)
> >  static void bdev_evict_inode(struct inode *inode)
> >  {
> >  	truncate_inode_pages_final(&inode->i_data);
> > -	invalidate_inode_buffers(inode); /* is it needed here? */
> >  	clear_inode(inode);
> >  }
> 
> With this, bdev_evict_inode can go away as it is equivalent to the
> default action when no ->evict_inode is provided.

Good point. I'll remove bdev_evict_inode(). Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

