Return-Path: <linux-fsdevel+bounces-75340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNSLCq8odGmX2gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 03:04:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D36FC7C2C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 03:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75F5230146A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 02:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB36212564;
	Sat, 24 Jan 2026 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="vxou7VK4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C13fVbRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78393EBF09;
	Sat, 24 Jan 2026 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769220257; cv=none; b=p5c9UwwRLY5HNQK2yjd+I1Z7ZYJb0SbHthMHsBHVTliBs6BmXgRuZ88TUUrEzeeZTrt7fp4FiZOtv5nTk7XY3AbloEslgS93DrTf3DxWiYDUYKjeiv5c/ROYcguRNiRkPG15ITUB+9sT7/9w1dRLwezXX22bsjnC0RdKIBxSY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769220257; c=relaxed/simple;
	bh=EeKnc/5YoCEu6smEqT6pXz/HyqqmaoQc18xnh+4s8Fw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HDvEk4M9ASiNQPe2C4/nlGQ1SSOaBl/DTRyNCti6L/4SwCMxo0oujCup0tPDyxktgiZLWglIEWRIohxuFscmdfk9dxWzfDHb8YMn7mWzP12RjNfkHwuf257Umrp10qGjw+fsigZVZ2If/JpeaUp/TMmtMtTjSdwOnXiSty2cB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=vxou7VK4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C13fVbRT; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BF7F7EC017B;
	Fri, 23 Jan 2026 21:04:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 23 Jan 2026 21:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769220254; x=1769306654; bh=P+5M6oEbQqEcmFz9eJ5wAxCG+JfxnZsGnWd
	Wi9pUZI0=; b=vxou7VK4iK9Fxw/GfLEcvYGX4Un8YRH+CYTmvTAMqNQPbcbObGC
	IIflcost5JBR67hapxCYsu7NboayTOYuCABSCw2HvSya4vjnTZEJjMhlhxOoWY9S
	N/HCFgGlABzPV6Vkrg3Ulk0yatPLHbRqquAOKFLabS7/RRZYWKORWmC0hPyKgA0F
	5cq4pI3klOo8gk8JRZqYslXIXf7WjyAualccxNP13hlPI1lUSc8XwA6IVGqRwiZk
	GIWTQARWASeXlBCSrfG63keNGfkElpkb5DeTpTTKJeDsZW4Gr26jVKVbFjvRPt4H
	k3zjM5YeOsvztYad/N8u9VND/Ro9iWaVoZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769220254; x=
	1769306654; bh=P+5M6oEbQqEcmFz9eJ5wAxCG+JfxnZsGnWdWi9pUZI0=; b=C
	13fVbRTMwT+2hhFdRSncUrd5XSXGn+hjAixL89jLFufl+c2bZBrnPLHFGldu8Vr/
	ywHk8/1dJ9lt+PehC/fNGZYgGI5EA6Wzsjd1yJKeeK+4M6qTJ0eMEgTJ0ek2WU9O
	ElNJ4d5rC12lY7XOSt8Pz7momyG1eVzmkBW6LcM+PEfW81PnMTzsfcrcgIvX7Tg3
	Nci849q/60UQCLF6stblPCkA7elnukWiF5k40a+XUxr9C9+tHCs0gavPKo4cGS03
	5KSprlAZ7CLXdgXtyDqhH9vfvnYHBnABqOtCwltCgIOb9zu8mHVdh6Y7iY3ADyFA
	Qo711shabyVu+TXY8fe5w==
X-ME-Sender: <xms:nih0aQh31ma3rkOeA1l9mSMuIrIFjY1PI2L3akpPidtfovTrhfkVGw>
    <xme:nih0afBVpPxmbMd4VqDITzIB5bIyom5boAlwr44ikVApHuck51vlD_j0V52aaNFwO
    Iw3mmv5SMlKFQoTXUYMf2rNIDvwXXWvy-oQouSy338_gp0CNQ>
X-ME-Received: <xmr:nih0aS6gLiQq0dVfueh8KUV-t0PWSO-AkRotADcSj9VNq0O0XlfxFGdzrAbuIYYiq0HHbaZ0QpbFvpUTbvwzK0HDAfAHxuG1KOg_F9RzJ91K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    grhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomh
X-ME-Proxy: <xmx:nih0aUGYnZy9K1ZcJuyNNE65YtI9KPytKwHdr2VIfSASRrF_FzxiIw>
    <xmx:nih0adD7SokQ-5UvRN5O7QQ9VBt_WqHoy5oldpqKibC0Uufe8fi5YQ>
    <xmx:nih0aZydYrnVcpRqW7GXsfS5k4rXG6pCK0apYYjNDcebnRA1szgkaw>
    <xmx:nih0aR6HtRMwYSWnN5pM3mdbUUlN0JJgN6eMdVE4lvWmfrughodbaw>
    <xmx:nih0aR3VrA2xGmbUVy097aDgjvKL7-mwBp2sPkmfZamzc6s1FGLjjhcC>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 21:04:11 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH/RFC] nfsd: rate limit requests that result in -ESTALE from
 the filesystem
In-reply-to: <d1e5a45b5c3d8ac2d92ac15c8ae7ff79dafdef92.camel@kernel.org>
References: <176920977124.16766.1785815212991547773@noble.neil.brown.name>,
 <d1e5a45b5c3d8ac2d92ac15c8ae7ff79dafdef92.camel@kernel.org>
Date: Sat, 24 Jan 2026 13:04:09 +1100
Message-id: <176922024977.16766.3757451159050621194@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75340-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,hammerspace.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,noble.neil.brown.name:mid,brown.name:replyto,brown.name:email,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D36FC7C2C4
X-Rspamd-Action: no action

On Sat, 24 Jan 2026, Jeff Layton wrote:
> On Sat, 2026-01-24 at 10:09 +1100, NeilBrown wrote:
> > This is an idea for an alternate approach to address the problem that
> > Ben is trying to address by signing file handles.
> >=20
> > The reasons I think an alternate is worth considering are:
> >=20
> >  - Ben's approach requires some configuration, though not much.
> >    This approach requires zero configuration which is always better.
> >=20
> >  - Ben's approach adds a siphash calculation or two to (almost) every
> >    NFS request.  This may not be a great cost but it is still some time
> >    and some power.  Less is more.
> >=20
> > Filehandles already contain 32 bits of randomness.  Rather than adding
> > another 64 bits as Ben's patch does, this patch increase the time it
> > take to test all possible values for those 32 bits to make it an
> > impractical attack.
> >=20
> > Comments welcome.
> >=20
> > Thanks,
> > NeilBrown
> >=20
> >=20
> >=20
> > From: NeilBrown <neil@brown.name>
> > Subject: [PATCH] nfsd: rate limit requests that result in -ESTALE from the
> >  filesystem
> >=20
> > NFS file handles typically contain a 32 bit generation number which is
> > randomly generated by the filesystem when the inode (or inode number) is
> > allocated.  This makes it hard to guess correct file handles.  Hard but
> > not impossible on a low latency network with a high speed server.
> >=20
> > The NFS server will reject a request to access the file associated with
> > a filehandle if the user credential given is now allowed the access the
> > file, but it is not able to check if the user (or client) should be
> > allowed to even know that filehandle.  This would require knowing all
> > the paths to a given file, all the credential that the client has access
> > to, when whether some combination of those credential can complete a
> > walk down any of the paths.
> >=20
> > So the NFS server currently depends on the client to "do the right
> > thing".
> >=20
> > In some circumstances the client may not be sufficiently trusted, and
> > path-based access controls may be an important part of the access
> > management strategy.  In these cases the protection provided by nfsd may
> > not be sufficient.
> >=20
> > The only known attack methodology is to guess the inode number of a file
> > of interest, then iterate over all possible generation numbers.  This
> > would be expected to achieve success (if the inode number is valid) in,
> > on average, 2^31 guesses.  At one per microsecond this is less than one
> > hour.  At one per 10 microseconds this is less than one day.
> >=20
> > When presented with an incorrect guess the filesystem with report an
> > error to nfsd, either NULL or ERR_PTR(-ESTALE).  This patch causes nfsd
> > to detect those errors and insert a 15ms delay.  It also take a lock so
> > that all such delays are serialised.  This increases the expected time
> > to success to 1 year.
> >=20
> > Normally NFSERR_STALE errors are rare and are no on a fast path.
> > Normal accesses which use a filehandle which has become stale will now
> > incur a 15msec does which is likely to be unnoticeable.  An attack will
> > notice an intolerable delay.
> >=20
> > Possible this code could detect if there are ever a large number of
> > requests over an extended time and then take more firm action.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/netns.h  |  2 ++
> >  fs/nfsd/nfsctl.c |  1 +
> >  fs/nfsd/nfsfh.c  | 15 +++++++++++++++
> >  3 files changed, 18 insertions(+)
> >=20
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 9fa600602658..f7229d1f9d86 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -219,6 +219,8 @@ struct nfsd_net {
> >  	/* last time an admin-revoke happened for NFSv4.0 */
> >  	time64_t		nfs40_last_revoke;
> > =20
> > +	struct mutex		estale_rate_limit_mutex;
> > +
> >  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> >  	/* Local clients to be invalidated when net is shut down */
> >  	spinlock_t              local_clients_lock;
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 7587c64bf26d..55d25d9b414f 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -2198,6 +2198,7 @@ static __net_init int nfsd_net_init(struct net *net)
> >  	nfsd4_init_leases_net(nn);
> >  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> >  	seqlock_init(&nn->writeverf_lock);
> > +	mutex_init(&nn->estale_rate_limit_mutex);
> >  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> >  	spin_lock_init(&nn->local_clients_lock);
> >  	INIT_LIST_HEAD(&nn->local_clients);
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index ed85dd43da18..7032f65fe21a 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -244,6 +244,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqs=
tp, struct net *net,
> >  						data_left, fileid_type, 0,
> >  						nfsd_acceptable, exp);
> >  		if (IS_ERR_OR_NULL(dentry)) {
> > +			struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +
> >  			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
> >  					dentry ?  PTR_ERR(dentry) : -ESTALE);
> >  			switch (PTR_ERR(dentry)) {
> > @@ -252,6 +254,19 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rq=
stp, struct net *net,
> >  				break;
> >  			default:
> >  				dentry =3D ERR_PTR(-ESTALE);
> > +				/* We limit ESTALE returns to 1 every
> > +				 * 15 milliseconds (across all threads) to
> > +				 * prevent a client from guessing the
> > +				 * correct (32 bit) generation number
> > +				 * for an given inode in significantly
> > +				 * less than 1 year.  This ensures clients
> > +				 * can only access files for which they
> > +				 * are allowed to access a path from the
> > +				 * exported root.
> > +				 */
> > +				mutex_lock(&nn->estale_rate_limit_mutex);
> > +				msleep(15);
> > +				mutex_unlock(&nn->estale_rate_limit_mutex);
>=20
> Hmm...maybe a mutex_trylock and if it fails do an immediate -EAGAIN
> return (which hopefully becomes NFSERR3_JUKEBOX or NFS4ERR_DELAY)? This
> could be a way to DoS the server, otherwise.

Returning NFS4ERR_DELAY immediately instead of NFS4ERR_STALE gives
the attacking client nearly identical information.  It would not resend
the request that reported NFS4ERR_DELAY.

Triggering a DoS is part of the point - it both defeats the attack and
makes the attack obvious.  If an attack is going to be obvious it will
likely be caught so the potential attacker is unlikely to try.

A client with authority to make requests can already generate a high
rate of high cost request without waiting for replies and so potentially
DoS the server.  Remember that we aren't aiming to protect against
completely unauthorised client, but only clients which do have some
authority.

>=20
> >  			}
> >  		}
> >  	}
>=20
>=20
> FWIW, I don't necessarily see this as a replacement for Ben's work, but
> it might be a nice complement.

If you knew that an attack couldn't succeed, why would you bother
setting sign_fh ?

Thanks,
NeilBrown

