Return-Path: <linux-fsdevel+bounces-24827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC694516B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B707AB27A56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5008F1B3F0A;
	Thu,  1 Aug 2024 17:23:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FC1AAE0B
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533033; cv=none; b=Tj1vzAIrTVsEqJSl8lGxpm9HaSOrA1Lk3iSfqFrksQfGR8wEzbIyWxEvVwC+EZGt1vDw4GK20lRruN7oy3I8/oNY9XblJyCYlvRvq+i3uOKQ75KC30fMp1qz7es3jxaAwHERrYxD0LBUBq5YYbb1kKB0FDSxc1qAKVe79eEw+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533033; c=relaxed/simple;
	bh=Lq5/oNHfbEvX0kp5W+8nabNlhkfpECtIm6+WIfim0Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKND5RD2dHL6+1Cxl/m+e/9kvbTb/OpB94zlgMSjP+qTkvIH3zL3CO2igdRc7cc6lGOjul2WTrj+mxzMC8/P6NSNF1MNiEWf8GnRSMQ75p/0oZwAmSNPoZ3ERqV0CEXqJwN1PlmkIMIDC1HbuuFMx4k063YjMJSIElQDPnxyltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC78521A0E;
	Thu,  1 Aug 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90023136CF;
	Thu,  1 Aug 2024 17:23:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UL3XIqXEq2ZjNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 17:23:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3CBDFA08CB; Thu,  1 Aug 2024 19:23:41 +0200 (CEST)
Date: Thu, 1 Aug 2024 19:23:41 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 07/10] fanotify: rename a misnamed constant
Message-ID: <20240801172341.7hu7clhely7nola7@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <20137566913a612692aaa0a9c79bb0345e94c26d.1721931241.git.josef@toxicpanda.com>
 <20240801171950.stcczm6nvi44mqt3@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801171950.stcczm6nvi44mqt3@quack3>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: AC78521A0E
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu 01-08-24 19:19:50, Jan Kara wrote:
> On Thu 25-07-24 14:19:44, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> > 
> > FANOTIFY_PIDFD_INFO_HDR_LEN is not the length of the header.
> > 
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fanotify/fanotify_user.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 3a7101544f30..5ece186d5c50 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -119,7 +119,7 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
> >  #define FANOTIFY_EVENT_ALIGN 4
> >  #define FANOTIFY_FID_INFO_HDR_LEN \
> >  	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
> > -#define FANOTIFY_PIDFD_INFO_HDR_LEN \
> > +#define FANOTIFY_PIDFD_INFO_LEN \
> 
> OK, but then FANOTIFY_FID_INFO_HDR_LEN should be renamed as well? Or what's
> the difference?

Ah, never mind. I've realized that to FID we indeed need to add the file
handle length. So there is a difference and the cleanup makes sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

