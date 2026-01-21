Return-Path: <linux-fsdevel+bounces-74844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOqDBN+5cGmWZQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 12:34:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F41E15610A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 12:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA00E684C1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B613AE71C;
	Wed, 21 Jan 2026 11:29:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8233F38B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994968; cv=none; b=OdnLzbr77JzQY1kr13tp1/f/BrposbRNz724HYEsfrqjVRBJpu/lbtAcQKLWD3czio0FpCXtrLrAJY7aG7rrK+ERrgynSXrJIX8lSvk1WhlW45gNeam7kiJRKpyt+hwECXXYFoZPUVPvOvFoAcufnlIqvCnKx3x6xC/V34D+Yrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994968; c=relaxed/simple;
	bh=tYSkd0F3Ch3JF6AUtujuwT6EeUTQkagaVfANESe2U4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFtc57BZaZOtum0TfW0BR1GL690sl7CkAAdYKLRT9sJqQVkXTt3P5wmdua9Lt8YpPDEZJAx194g/W/JP5PUYHoeEroQQNQUGPMbQV/2hLrPQKSZEuSlhWSoX6mEE/6Vig3ckAj4HpblVN06B+q5i8px3pnapwB5vRsY3jLxdAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E66053368B;
	Wed, 21 Jan 2026 11:29:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D65823EA63;
	Wed, 21 Jan 2026 11:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HDGIOpO4cGkoNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 11:29:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C07B7A09E9; Wed, 21 Jan 2026 12:29:19 +0100 (CET)
Date: Wed, 21 Jan 2026 12:29:19 +0100
From: Jan Kara <jack@suse.cz>
To: Jan Kara <jack@suse.cz>
Cc: bernd@bsbernd.com, Joanne Koong <joannelkoong@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] flex_proportions: Make fprop_new_period() hardirq safe
Message-ID: <ic7afxqrfrxjwhggezekc56oqmc7vapqxmffvwrd5xmrvjnimo@rhdbmk5hfydb>
References: <20260121091355.14209-2-jack@suse.cz>
 <zftwpsgfwct5bx55usazm6ulnthi4yvnhpaudtmby5tq2zf7zg@wz77c6nlvquv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zftwpsgfwct5bx55usazm6ulnthi4yvnhpaudtmby5tq2zf7zg@wz77c6nlvquv>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-0.76 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74844-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[bsbernd.com,gmail.com,szeredi.hu,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,bsbernd.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: F41E15610A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed 21-01-26 10:22:23, Jan Kara wrote:
> On Wed 21-01-26 10:13:56, Jan Kara wrote:
> > Bernd has reported a lockdep splat from flexible proportions code that
> > is essentially complaining about the following race:
> > 
> > <timer fires>
> > run_timer_softirq - we are in softirq context
> >   call_timer_fn
> >     writeout_period
> >       fprop_new_period
> >         write_seqcount_begin(&p->sequence);
> > 
> >         <hardirq is raised>
> >         ...
> >         blk_mq_end_request()
> > 	  blk_update_request()
> > 	    ext4_end_bio()
> > 	      folio_end_writeback()
> > 		__wb_writeout_add()
> > 		  __fprop_add_percpu_max()
> > 		    if (unlikely(max_frac < FPROP_FRAC_BASE)) {
> > 		      fprop_fraction_percpu()
> > 			seq = read_seqcount_begin(&p->sequence);
> > 			  - sees odd sequence so loops indefinitely
> > 
> > Note that a deadlock like this is only possible if the bdi has
> > configured maximum fraction of writeout throughput which is very rare
> > in general but frequent for example for FUSE bdis. To fix this problem
> > we have to make sure write section of the sequence counter is irqsafe.
> > 
> > Reported-by: Bernd Schubert <bernd@bsbernd.com>
> > Link: https://lore.kernel.org/all/9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com/
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Forgot to add some tags:
> 
> CC: stable@vger.kernel.org
> Fixes: a91befde3503 ("lib/flex_proportions.c: remove local_irq_ops in fprop_new_period()")

Drat, now I've noticed I've messed up Andrew's address. I'll send v2. Sorry
for the noise.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

