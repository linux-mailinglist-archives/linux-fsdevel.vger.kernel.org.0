Return-Path: <linux-fsdevel+bounces-5500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6C380CEB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F09C1C21057
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70F2495F8;
	Mon, 11 Dec 2023 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hiw99xfZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ldLqAVRu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hiw99xfZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ldLqAVRu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117C6C5
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 06:53:53 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 39820223F2;
	Mon, 11 Dec 2023 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702306431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mmo6at6yIBU8d1Iy2VZaNoVRU5I1f7JEQTYoa96u9c=;
	b=hiw99xfZk/Lufmqdif6zT1C1siwagSfeVrHARsfw70YOppcqsHU9Wz22sNWgsymBQekzCU
	0DGwJRCNmRt8trdJrUyFjcg96OwOHxmNaJn9gU1EA7rBxVKPE9n8aLev8KVjVH/+SqvdO6
	ykDBpT/RRmZu2f+jn1yQYG3EmrUM2Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702306431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mmo6at6yIBU8d1Iy2VZaNoVRU5I1f7JEQTYoa96u9c=;
	b=ldLqAVRug5ehSZWtYPDVLjWGHRB/sstj+FC7LBkAqljfOuR+3XNVs0LmFwA8CR1wtbbbbL
	gyzYYjwrhr1buhDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702306431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mmo6at6yIBU8d1Iy2VZaNoVRU5I1f7JEQTYoa96u9c=;
	b=hiw99xfZk/Lufmqdif6zT1C1siwagSfeVrHARsfw70YOppcqsHU9Wz22sNWgsymBQekzCU
	0DGwJRCNmRt8trdJrUyFjcg96OwOHxmNaJn9gU1EA7rBxVKPE9n8aLev8KVjVH/+SqvdO6
	ykDBpT/RRmZu2f+jn1yQYG3EmrUM2Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702306431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mmo6at6yIBU8d1Iy2VZaNoVRU5I1f7JEQTYoa96u9c=;
	b=ldLqAVRug5ehSZWtYPDVLjWGHRB/sstj+FC7LBkAqljfOuR+3XNVs0LmFwA8CR1wtbbbbL
	gyzYYjwrhr1buhDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D623134B0;
	Mon, 11 Dec 2023 14:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id PN8gB38id2XSbwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 14:53:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 762BEA07E3; Mon, 11 Dec 2023 15:53:46 +0100 (CET)
Date: Mon, 11 Dec 2023 15:53:46 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] fsnotify: pass access range in file permission hooks
Message-ID: <20231211145346.7fmrxkyp36fi5d6w@quack3>
References: <20231207123825.4011620-1-amir73il@gmail.com>
 <20231207123825.4011620-5-amir73il@gmail.com>
 <20231208185302.wkzvwthf5vuuuk3s@quack3>
 <CAOQ4uxi+6VMAdyREODOpMLiZ26Q_1R981H-eOwOA8gJsrsSqrA@mail.gmail.com>
 <CAOQ4uxiLtwp1QLQN1VBa10kLf4z+dx=UiDtB_WSqNXcoLYbvfw@mail.gmail.com>
 <20231211114905.jbmm7oxlmh3nt4j7@quack3>
 <CAOQ4uxj7zbC9ue7oZyzSY4u3rwTSNkW2VpLeXCuLPtzhyVtrzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj7zbC9ue7oZyzSY4u3rwTSNkW2VpLeXCuLPtzhyVtrzg@mail.gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80
Authentication-Results: smtp-out1.suse.de;
	none

On Mon 11-12-23 14:00:58, Amir Goldstein wrote:
> On Mon, Dec 11, 2023 at 1:49 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sun 10-12-23 15:24:00, Amir Goldstein wrote:
> > > > > > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > > > > > index 0a9d6a8a747a..45e6ecbca057 100644
> > > > > > --- a/include/linux/fsnotify.h
> > > > > > +++ b/include/linux/fsnotify.h
> > > > > > @@ -103,7 +103,8 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
> > > > > >  /*
> > > > > >   * fsnotify_file_perm - permission hook before file access
> > > > > >   */
> > > > > > -static inline int fsnotify_file_perm(struct file *file, int perm_mask)
> > > > > > +static inline int fsnotify_file_perm(struct file *file, int perm_mask,
> > > > > > +                                  const loff_t *ppos, size_t count)
> > > > > >  {
> > > > > >       __u32 fsnotify_mask = FS_ACCESS_PERM;
> > > > >
> > > > > Also why do you actually pass in loff_t * instead of plain loff_t? You
> > > > > don't plan to change it, do you?
> > > >
> > > > No I don't.
> > >
> > > Please note that the pointer is to const loff_t.
> > >
> > > >
> > > > I used NULL to communicate "no range info" to fanotify.
> > > > It is currently only used from iterate_dir(), but filesystems may need to
> > > > use that to report other cases of pre-content access with no clear range info.
> > >
> > > Correction. iterate_dir() is not the only case.
> > > The callers that use file_ppos(), namely ksys_{read,write}, do_{readv,writev}()
> > > will pass a NULL ppos for an FMODE_STREAM file.
> > > The only sane behavior I could come up with for those cases
> > > is to not report range_info with the FAN_PRE_ACCESS event.
> >
> > OK, understood. But isn't anything with len == 0 in fact "no valid range
> > provided" case? So we could use that to identify a case where we simply
> > don't report any range with the event without a need to pass the pointer?
> >
> 
> IDK. read(2) and pread(2) with count=0 is a valid use case.
> and we have reported FAN_ACCESS_PERM for those 0 length calls so far.
> reporting those call with no range would be bad for HSM, because all
> HSM can do with these events is to fill the entire file content.

Yes, reading or writing 0 bytes is valid but I was wondering whether we
are issuing event for that. Now that I've checked we indeed do so let's not
complicate this further...

> Filling the entire file content is a valid action if the backing file does not
> support seek or if it is a directory, but it is not a valid action for
> an application
> induced pread() with zero length.
> 
> Did I misunderstand what you meant?

Yeah, ok, let's leave the calling convention as you have it now. We can 
always change it when we come up with something more elegant.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

