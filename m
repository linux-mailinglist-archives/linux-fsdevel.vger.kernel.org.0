Return-Path: <linux-fsdevel+bounces-70303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8486FC96409
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 09:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6500342166
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 08:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F372FDC23;
	Mon,  1 Dec 2025 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LjWpmNrj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PAppTOzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B62F5474;
	Mon,  1 Dec 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579066; cv=none; b=I+RRW7+jlccAQ3M9lK+eeJsGbfIN4Wc6eKFR1jsaLj1w+l8wWaMjvIpi1oMd7C78vdCYlM2fG/QQ77BpWc1T4Vq27fEpz+C7DCTlw7XPffh9+8Ll87J+spMs0IPmaH+f6ZyCxgBBMsmAdWsh7mk8agl5DJkW0kjsvDL0znGDKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579066; c=relaxed/simple;
	bh=De9sBT3y3s7irsQrNI5Gq6PZxEq8lADGi/gDAnUsSiI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=mYJh93baPCzmxZ4lCP9GoDlekeNUIyL8oLezVJ36AFWCDTD5jAVp7MStBi0r1gttsVJawNfDewzuNCUs7FXDX0ymAr+70LdOgX4Km92dBaMEkxw57X/7TXm62SVAF2ac6MgkhkSsPYHZ2A51XA4QBOIcV+FO/hc5BomRNT7xILg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LjWpmNrj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PAppTOzH; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 57EA013800D1;
	Mon,  1 Dec 2025 03:51:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 01 Dec 2025 03:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1764579063; x=1764586263; bh=YyBZuzpD1IkRw0eQQkgIAhIfOHF12FK7W5+
	17BDo/Xg=; b=LjWpmNrjh+5rFjHM/Qx0/gkQI2OKgMcBCzhMvymnBhPkwljL+JF
	uw2eVAmBfnf4fKZGivqicUaxPCu1RO4bndiAVAkzRBV6qBiqZkvLfVE/ryANr2eT
	gXCmyhfOKMX3W3GjKVTjzAt1eJLELu7itvrVZcHMxKopu8eVt8jTbdlgmIoPTZ/N
	PRoY7AU8UHVs4KQpY3hduYK+oqJZv1RS3vZcb39T8m8QFy/VpxsvNCrEs34u514B
	mCWTyYj6gvbD7gblobTtF2buunyi0t5R92HOouJu/y2vV1Bbwvf0xseyilfdJqR7
	nP7ISpRTGu27skswAyjoEChynpf5cQI3n1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764579063; x=
	1764586263; bh=YyBZuzpD1IkRw0eQQkgIAhIfOHF12FK7W5+17BDo/Xg=; b=P
	AppTOzHR83BRi//Utj+ZNRcR3q82rYyVdrMPQOXdnM72mtRiRKdztzMdDQvj3+at
	mHziX0zJQKJ8savc2YFgg1A+kTft2qdI4Cejkd/IG3rt3ZuzRwF/W7+7sIaio3Nj
	Gq4OQAtWXXPeSj0zfMfn3pg5hN2rw2M8Rjr2rvL6xHsXDfJSy+LVsRMTpfo09nTC
	dUgzSaXIkvRpg+qUlIStq9xLBz4j/kG1oC06URv1xAWy5rMLdzLlfMrMuAZ1XOR8
	2qBIdlA/gFQZaRl1R/FQRVrhM3VBF9vBuUN7jgw8k4ITAbFApybyfoVcOmmLF9kC
	UCOoid8es/li0NPaWhgEw==
X-ME-Sender: <xms:9VYtaUJHDAk8-MAybPbZjgmQmqW8fiYHTtPvutKYgI61mbCFoFHoTg>
    <xme:9VYtaQVPvLH3RaI6PjluWDw9oUBYFoTDNUs4UoSztl14wPNgmfTYL5mduDzkrj6Ih
    HfdXZ2HLulw3TsVLp2AH08UgwykPI4ubA--UJoxYmDIeK_R>
X-ME-Received: <xmr:9VYtab2JmA9fAL1fgdk3jf9RYCK2GnSJXWkKUx5JG31ufm_UOOdwPIUJ1dgb_2xbSCy4a3u_tnQfRF-xF_Z1t1vFe9Q74n4TWGBKPsQXYLOf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hprghmfghrlhculdeftddtmdenucfjughrpegtgfgghffvvefujghffffkrhesthhqredt
    tddtjeenucfhrhhomheppfgvihhluehrohifnhcuoehnvghilhgssehofihnmhgrihhlrd
    hnvghtqeenucggtffrrghtthgvrhhnpedvueetleekjeekveetteevtdekgeeludeifedt
    feetgfdttdeljefglefgveffieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuuf
    hprghmfghrlhephhhtthhpshemsddslhhorhgvrdhkvghrnhgvlhdrohhrghdsrghllhds
    udeltdejtggvfeefqdgtfeehledqiegvvdefqdgrjeehtgdqvggvtgegtdehtdehnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsges
    ohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedupdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhr
    tghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:9VYtac_VeX4sP-vIBN2nLpf1SCEgST6EZjDROcbeHir4h_Ij-bfL5w>
    <xmx:9VYtacuiP876XaELYxny91QpGl6xpo-HLDGGHM94dFj961UcjDhy5Q>
    <xmx:9VYtaSqIO0xbbjwIHoIAwT689dcqwnldURpCsSGf-OWOFENp7hQ4Mg>
    <xmx:9VYtacDoU4HSthRg0wbR7cRZYJIuYsCO8U_zxXW4-83fPhm7Pdgz0A>
    <xmx:91Ytab3XcSBpl-ps_uzxR1QKKAf5lbUJfALIg15bQxQ4ulx8VEwqqCEo>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 03:50:51 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Val Packett" <val@packett.cool>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chris Mason" <clm@fb.com>, "David Sterba" <dsterba@suse.com>,
 "David Howells" <dhowells@redhat.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Namjae Jeon" <linkinjeon@kernel.org>,
 "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Carlos Maiolino" <cem@kernel.org>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Stefan Berger" <stefanb@linux.ibm.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] fuse: fix conversion of fuse_reverse_inval_entry() to
 start_removing()
In-reply-to:
 <CAOQ4uxjihcBxJzckbJis8hGcWO61QKhiqeGH+hDkTUkDhu23Ww@mail.gmail.com>
References: <20251113002050.676694-1-neilb@ownmail.net>,
 <20251113002050.676694-7-neilb@ownmail.net>,
 <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool>,
 <176454037897.634289.3566631742434963788@noble.neil.brown.name>,
 <CAOQ4uxjihcBxJzckbJis8hGcWO61QKhiqeGH+hDkTUkDhu23Ww@mail.gmail.com>
Date: Mon, 01 Dec 2025 19:50:43 +1100
Message-id: <176457904303.16766.13791656192264803692@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 01 Dec 2025, Amir Goldstein wrote:
> On Sun, Nov 30, 2025 at 11:06=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrot=
e:
> >
> >
> > From: NeilBrown <neil@brown.name>
> >
> > The recent conversion of fuse_reverse_inval_entry() to use
> > start_removing() was wrong.
> > As Val Packett points out the original code did not call ->lookup
> > while the new code does.  This can lead to a deadlock.
> >
> > Rather than using full_name_hash() and d_lookup() as the old code
> > did, we can use try_lookup_noperm() which combines these.  Then
> > the result can be given to start_removing_dentry() to get the required
> > locks for removal.  We then double check that the name hasn't
> > changed.
> >
> > As 'dir' needs to be used several times now, we load the dput() until
> > the end, and initialise to NULL so dput() is always safe.
> >
> > Reported-by: Val Packett <val@packett.cool>
> > Closes: https://lore.kernel.org/all/6713ea38-b583-4c86-b74a-bea55652851d@=
packett.cool
> > Fixes: c9ba789dad15 ("VFS: introduce start_creating_noperm() and start_re=
moving_noperm()")
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/fuse/dir.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index a0d5b302bcc2..8384fa96cf53 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -1390,8 +1390,8 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, =
u64 parent_nodeid,
> >  {
> >         int err =3D -ENOTDIR;
> >         struct inode *parent;
> > -       struct dentry *dir;
> > -       struct dentry *entry;
> > +       struct dentry *dir =3D NULL;
> > +       struct dentry *entry =3D NULL;
> >
> >         parent =3D fuse_ilookup(fc, parent_nodeid, NULL);
> >         if (!parent)
> > @@ -1404,11 +1404,19 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc=
, u64 parent_nodeid,
> >         dir =3D d_find_alias(parent);
> >         if (!dir)
> >                 goto put_parent;
> > -
> > -       entry =3D start_removing_noperm(dir, name);
> > -       dput(dir);
> > -       if (IS_ERR(entry))
> > -               goto put_parent;
> > +       while (!entry) {
> > +               struct dentry *child =3D try_lookup_noperm(name, dir);
> > +               if (!child || IS_ERR(child))
> > +                       goto put_parent;
> > +               entry =3D start_removing_dentry(dir, child);
> > +               dput(child);
> > +               if (IS_ERR(entry))
> > +                       goto put_parent;
> > +               if (!d_same_name(entry, dir, name)) {
> > +                       end_removing(entry);
> > +                       entry =3D NULL;
> > +               }
> > +       }
>=20
> Can you explain why it is so important to use
> start_removing_dentry() around shrink_dcache_parent()?

Is it shrink_dcache_parent() that is being protected? or d_delete()?  or
....

Why was the original code locking the parent inode?  Whatever that was
protecting, we need to keep protecting it.  That is what
start_removing_dentry() is there to do.

>=20
> Is there a problem with reverting the change in this function
> instead of accomodating start_removing_dentry()?

Yes.  I want to change the rules for protecting dentries.  Ultimately
the vfs won't take the parent lock except for readdir.  Individual
filesystems can take the lock if they want to, but the VFS won't care.
To do that, we need to centralise all locking of the parent so we can
smoothly change it.

The next change - after this current series has all the problems ironed
out - is to switch the order of d_alloc_parallel() and
inode_lock(parent).
Currently d_alloc_parallel() can wait while holding the parent lock.  I
need to change that so that the parent lock can be taken while holding
a d_in_lookup() dentry (which will block an conflicting
d_alloc_parallel()).

I guess I don't strictly need to remove inode_lock() from this code for
that as it doesn't do a lookup, but there will be a patch set which will
need to change the locking here.  It will be much cleaner if the locking
is centralised.

>=20
> I don't think there is a point in optimizing parallel dir operations
> with FUSE server cache invalidation, but maybe I am missing
> something.

This isn't about supporting parallel dir ops everywhere.  This is about
refactoring code so that we can cleanly support parallel dir ops
anywhere.

Thanks,
NeilBrown

