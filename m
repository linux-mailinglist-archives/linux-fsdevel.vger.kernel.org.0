Return-Path: <linux-fsdevel+bounces-5586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FAC80DDD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 23:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDB8282591
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 22:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37F855774;
	Mon, 11 Dec 2023 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SL2SqI/p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q9fqFzq9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kgVyROpG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yaNuErKC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BAAA6;
	Mon, 11 Dec 2023 14:05:06 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0A2922438;
	Mon, 11 Dec 2023 22:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702332305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TIaWu3Q8oYRkZTPwzgobmJiblgVb0c4yy3Nx8qquRxQ=;
	b=SL2SqI/pf6wGaZIXBjed0h9sjebgjCcn6V4gPFu16QE0wvV/cs3fT/AS35F0or8bftmdig
	SnDuL1LtNjfsncL3CMtWB0oauUAAjFws3Piu+XtdQTbSyyoR+7Qfj35x3/6iIkKh2QCCdv
	PQrfRRj9TXRecq5nAB63fWyt7U9HdhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702332305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TIaWu3Q8oYRkZTPwzgobmJiblgVb0c4yy3Nx8qquRxQ=;
	b=q9fqFzq9qYxH/Wr5JzGIPQk+LhYkXHOZPUfLPenPlTqCDVlW8sn5pgDiZzvtHqPLq0ct3/
	OzPHlcixACkbIXBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702332304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TIaWu3Q8oYRkZTPwzgobmJiblgVb0c4yy3Nx8qquRxQ=;
	b=kgVyROpGG8i60SOzIhAszuNuNa49rbaHfCsf/ZOFZOrQ/MvilrL+8CYcjSX1rYz8s9H6Ez
	4vky7kqsf7MNoGaSRoavdo9mfvxLNtr8JwfYtrbAfI1GjCajYTM39jLN5wuVaXPZ+Su8I2
	blzaYDZFNFrXEUVxvJjTGHr3yM4nO7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702332304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TIaWu3Q8oYRkZTPwzgobmJiblgVb0c4yy3Nx8qquRxQ=;
	b=yaNuErKCdqqEPScMw3UXoWSpDS35DQMqneBh50TiUWaxY8utNu3707MdGjLQlvpR3Dar7S
	3ouKnxxb7XsYW8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC629132DA;
	Mon, 11 Dec 2023 22:05:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RDQvGo2Hd2WqNQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Dec 2023 22:05:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Oleg Nesterov" <oleg@redhat.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of files.
In-reply-to: <ZXdck2thv7tz1ee3@tissot.1015granger.net>
References: <20231208033006.5546-1-neilb@suse.de>,
 <20231208033006.5546-2-neilb@suse.de>,
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>,
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>,
 <ZXdck2thv7tz1ee3@tissot.1015granger.net>
Date: Tue, 12 Dec 2023 09:04:58 +1100
Message-id: <170233229855.12910.12943965536699322442@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -4.29
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, 12 Dec 2023, Chuck Lever wrote:
> On Mon, Dec 11, 2023 at 09:47:35AM +1100, NeilBrown wrote:
> > On Sat, 09 Dec 2023, Chuck Lever wrote:
> > > On Fri, Dec 08, 2023 at 02:27:26PM +1100, NeilBrown wrote:
> > > > Calling fput() directly or though filp_close() from a kernel thread l=
ike
> > > > nfsd causes the final __fput() (if necessary) to be called from a
> > > > workqueue.  This means that nfsd is not forced to wait for any work to
> > > > complete.  If the ->release of ->destroy_inode function is slow for a=
ny
> > > > reason, this can result in nfsd closing files more quickly than the
> > > > workqueue can complete the close and the queue of pending closes can
> > > > grow without bounces (30 million has been seen at one customer site,
> > > > though this was in part due to a slowness in xfs which has since been
> > > > fixed).
> > > >=20
> > > > nfsd does not need this.
> > >=20
> > > That is technically true, but IIUC, there is only one case where a
> > > synchronous close matters for the backlog problem, and that's when
> > > nfsd_file_free() is called from nfsd_file_put(). AFAICT all other
> > > call sites (except rename) are error paths, so there aren't negative
> > > consequences for the lack of synchronous wait there...
> >=20
> > What you say is technically true but it isn't the way I see it.
> >=20
> > Firstly I should clarify that __fput_sync() is *not* a flushing close as
> > you describe it below.
> > All it does, apart for some trivial book-keeping, is to call ->release
> > and possibly ->destroy_inode immediately rather than shunting them off
> > to another thread.
> > Apparently ->release sometimes does something that can deadlock with
> > some kernel threads or if some awkward locks are held, so the whole
> > final __fput is delay by default.  But this does not apply to nfsd.
> > Standard fput() is really the wrong interface for nfsd to use. =20
> > It should use __fput_sync() (which shouldn't have such a scary name).
> >=20
> > The comment above flush_delayed_fput() seems to suggest that unmounting
> > is a core issue.  Maybe the fact that __fput() can call
> > dissolve_on_fput() is a reason why it is sometimes safer to leave the
> > work to later.  But I don't see that applying to nfsd.
> >=20
> > Of course a ->release function *could* do synchronous writes just like
> > the XFS ->destroy_inode function used to do synchronous reads.
>=20
> I had assumed ->release for NFS re-export would flush due to close-
> to-open semantics. There seem to be numerous corner cases that
> might result in pile-ups which would change the situation in your
> problem statement but might not result in an overall improvement.

That's the ->flush call in filp_close().

>=20
>=20
> > I don't think we should ever try to hide that by putting it in
> > a workqueue.  It's probably a bug and it is best if bugs are visible.
>=20
>=20
> I'm not objecting, per se, to this change. I would simply like to
> see a little more due diligence before moving forward until it is
> clear how frequently ->release or ->destroy_inode will do I/O (or
> "is slow for any reason" as you say above).
>=20
>=20
> > Note that the XFS ->release function does call filemap_flush() in some
> > cases, but that is an async flush, so __fput_sync doesn't wait for the
> > flush to complete.
>=20
> When Jeff was working on the file cache a year ago, I did some
> performance analysis that shows even an async flush is costly when
> there is a lot of dirty data in the file being closed. The VFS walks
> through the whole file and starts I/O on every dirty page. This is
> quite CPU intensive, and can take on the order of a millisecond
> before the async flush request returns to its caller.
>=20
> IME async flushes are not free.

True, they aren't free.  But some thread has to pay that price.
I think nfsd should.

You might argue that nfsd should wait to pay the price until after it
has sent a reply to the client.  My patches already effectively do that
for garbage-collected files.  Doing it for all files would probably be
easy. But is it really worth the (small) complexity?  I don't know.

>=20
>=20
> > The way I see this patch is that fput() is the wrong interface for nfsd
> > to use, __fput_sync is the right interface.  So we should change.  1
> > patch.
>=20
> The practical matter is I see this as a change with a greater than
> zero risk, and we need to mitigate that risk. Or rather, as a
> maintainer of NFSD, /I/ need to see that the risk is as minimal as
> is practical.
>=20
>=20
> > The details about exhausting memory explain a particular symptom that
> > motivated the examination which revealed that nfsd was using the wrong
> > interface.
> >=20
> > If we have nfsd sometimes using fput() and sometimes __fput_sync, then
> > we need to have clear rules for when to use which.  It is much easier to
> > have a simple rule: always use __fput_sync().
>=20
> I don't agree that we should just flop all these over and hope for
> the best. In particular:
>=20
>  - the changes in fs/nfsd/filecache.c appear to revert a bug
>    fix, so I need to see data that shows that change doesn't
>    cause a re-regression

The bug fix you refer to is
  "nfsd: don't fsync nfsd_files on last close"
The patch doesn't change when fsync (or ->flush) is called, so
it doesn't revert this bugfix.

>=20
>  - the changes in fs/lockd/ can result in long waits while a
>    global mutex is held (global as in all namespaces and all
>    locked files on the server), so I need to see data that
>    demonstrates there won't be a regression

It's probably impossible to provide any such data.
The patch certainly moves work inside that mutex and so would increase
the hold time, if only slightly.  Is that lock hot enough to notice?
Conventional wisdom is that locking is only a tiny fraction of NFS
traffic.  It might be possible to construct a workload that saturates
lockd, but I doubt it would be relevant to the real world.

Maybe we should just break up that lock so that the problem becomes moot.

>=20
>  - the other changes don't appear to have motivation in terms
>    of performance or behavior, and carry similar (if lesser)
>    risks as the other two changes. My preferred solution to
>    potential auditor confusion about the use of __fput_sync()
>    in some places and fput() in others is to document, and
>    leave call sites alone if there's no technical reason to
>    change them at this time.

Sounds to me like a good way to grow technical debt, but I'll do it like
that if you prefer.

>=20
> There is enough of a risk of regression that I need to see a clear
> rationale for each hunk /and/ I need to see data that there is
> no regression. I know that won't be perfect coverage, but it's
> better than not having any data at all.
>=20
>=20
> > I'm certainly happy to revise function documentation and provide
> > wrapper functions if needed.
> >=20
> > It might be good to have
> >=20
> >   void filp_close_sync(struct file *f)
> >   {
> >        get_file(f);
> >        filp_close(f);
> >        __fput_sync(f);
> >   }
> >=20
> > but as that would only be called once, it was hard to motivate.
> > Having it in linux/fs.h would be nice.
> >=20
> > Similarly we could wrap __fput_sync() in a more friendly name, but
> > that would be better if we actually renamed the function.
> >=20
> >   void fput_now(struct file *f)
> >   {
> >       __fput_sync(f);
> >   }
> >=20
> > ??
>=20
> Since this is an issue strictly for nfsd, the place for this
> utility function is in fs/nfsd/vfs.c, IMO, along with a documenting
> comment that provides a rationale for why nfsd does not want plain
> fput() in specific cases.
>=20
> When other subsystems need a similar capability, then let's
> consider a common helper.

fs/smb/server/ probably would benefit from the same helper today.

Thanks,
NeilBrown


>=20
>=20
> --=20
> Chuck Lever
>=20


