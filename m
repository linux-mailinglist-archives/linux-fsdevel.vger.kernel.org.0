Return-Path: <linux-fsdevel+bounces-6241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ECE8153C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 23:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763F61C24690
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F11018ED8;
	Fri, 15 Dec 2023 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pSbRV4Xz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1i2TRR2V";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pSbRV4Xz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1i2TRR2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2B18EBD;
	Fri, 15 Dec 2023 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E1D51F88B;
	Fri, 15 Dec 2023 22:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702679791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDOM5cciuA7gZCkDhQB2rHKAA8F9J8XyMkH9vahcTC0=;
	b=pSbRV4XzcRQMsQ1TnrTizbWu5fM0Tekn+EzMtyjFCUh/I1YSYB7wjp8qu+NjScH5Xwnckq
	7lPPwZbit/U5qPiGt/e8ePL1+sDCI1j5y0V8BD4NBgEA2tz8gHeUTp/STWYljUV3VwZHtE
	F/jIItoV1zqk+T9EcqKD3N87j4rvKcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702679791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDOM5cciuA7gZCkDhQB2rHKAA8F9J8XyMkH9vahcTC0=;
	b=1i2TRR2VjuT1ES7TrxrmpS7tUVIZ95ylzOo8HAXssIfqjZVJ67MQCfe7rZ3P7ScjQsuf+6
	tbcVQh0ZdGnyXLDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702679791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDOM5cciuA7gZCkDhQB2rHKAA8F9J8XyMkH9vahcTC0=;
	b=pSbRV4XzcRQMsQ1TnrTizbWu5fM0Tekn+EzMtyjFCUh/I1YSYB7wjp8qu+NjScH5Xwnckq
	7lPPwZbit/U5qPiGt/e8ePL1+sDCI1j5y0V8BD4NBgEA2tz8gHeUTp/STWYljUV3VwZHtE
	F/jIItoV1zqk+T9EcqKD3N87j4rvKcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702679791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDOM5cciuA7gZCkDhQB2rHKAA8F9J8XyMkH9vahcTC0=;
	b=1i2TRR2VjuT1ES7TrxrmpS7tUVIZ95ylzOo8HAXssIfqjZVJ67MQCfe7rZ3P7ScjQsuf+6
	tbcVQh0ZdGnyXLDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EC9E137D4;
	Fri, 15 Dec 2023 22:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1xndOevUfGVrTgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Dec 2023 22:36:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "David Laight" <David.Laight@ACULAB.COM>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Oleg Nesterov" <oleg@redhat.com>, "Jeff Layton" <jlayton@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject:
 RE: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of files.
In-reply-to: <ac74bdb82e114d71b26864fe51f6433b@AcuMS.aculab.com>
References: <20231208033006.5546-1-neilb@suse.de>,
 <20231208033006.5546-2-neilb@suse.de>,
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>,
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>,
 <20231211191117.GD1674809@ZenIV>,
 <170233343177.12910.2316815312951521227@noble.neil.brown.name>,
 <20231211231330.GE1674809@ZenIV>, <20231211232135.GF1674809@ZenIV>,
 <170242728484.12910.12134295135043081177@noble.neil.brown.name>,
 <ac74bdb82e114d71b26864fe51f6433b@AcuMS.aculab.com>
Date: Sat, 16 Dec 2023 09:36:25 +1100
Message-id: <170267978502.12910.3767924819236993323@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -3.10
X-Spam-Flag: NO

On Sat, 16 Dec 2023, David Laight wrote:
> ...
> > > PS: put it that way - I can buy "nfsd is doing that only to regular
> > > files and not on an arbitrary filesystem, at that; having the thread
> > > wait on that sucker is not going to cause too much trouble"; I do *not*
> > > buy turning it into a thing usable outside of a very narrow set of
> > > circumstances.
> > >
> >=20
> > Can you say more about "not on an arbitrary filesystem" ?
> > I guess you means that procfs and/or sysfs might be problematic as may
> > similar virtual filesystems (nfsd maybe).
>=20
> Can nfs export an ext4 fs that is on a loopback mount on a file
> that is remotely nfs (or other) mounted?

Sure.  There is no reason this would cause a problem.
If the nfs mount were also a loopback mount, that might be interesting.
i.e.  You have a local filesystem, containing a file with a filesystem
image.
You nfs-export that local filesystem, and nfs mount it on the same host.
Then you loop-mount that file in the nfs-mounted filesystem.  Now you
are getting into uncharted waters.  I've testing loop-back NFS mounting
and assure that it works.  I haven't tried the double-loop.
But if that caused problem, I though it would be fput.  It would be
fsync or writeback which causes the problem.

>=20
> As soon as you get loops like that you might find that fput() starts
> being problematic.

When calling fput on a regular file there are, I think, only two problem
areas.  One is that the fput might lead to a lazy-filesystem unmount
completing.  That only applies to MNT_INTERNAL filesystems, and they are
unlikely to be exported (probably it's impossible, but I haven't
checked).
The other is synchronous (or even async) IO in the filesystem code,
maybe completing an unlink or a truncate.  This is no worse than any
other synchronous IO that nfsd does.

Thanks,
NeilBrown


>=20
> I'm also sure I remember that nfs wasn't supposed to respond to a write
> until it had issued the actual disk write - but maybe no one do that
> any more because it really is too slow.
> (Especially if the 'disk' is a USB stick.)
>=20
> 	David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
> Registration No: 1397386 (Wales)
>=20


