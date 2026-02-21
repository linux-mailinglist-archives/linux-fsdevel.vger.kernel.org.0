Return-Path: <linux-fsdevel+bounces-77865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM+oCZ4bmmnZYgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 21:54:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B916DD9A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 21:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 650DA30166E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 20:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B4D30DECB;
	Sat, 21 Feb 2026 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Shmt745R";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="YPgydMHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2086A1F5821
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771707291; cv=none; b=nbaHgn1spB3prAOQepswrNBCeTc5XTItvbxZ8uFMwzJHEKhaolnQsld3Fb1lNph2YNzQLPS+65ZlpCj1XeAY6sU57nQaKMAJ306ibjr+h7QMllv68HkvkHEXH5HwjRwmI5e8atKwdFz/7m6JQXsoTngm4kV06gUHDCvjzIT1YzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771707291; c=relaxed/simple;
	bh=1FLSnJJwFzgCN2DNjXqWIoCXuNJVyBDH2pejoIcm2NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPbTMi0zNlJp4zmU+OoIjy862lmUW8JuMlaMQtzphlcjWWXtbljepbvylocmKHUxho/NpcLUUS5EvZ7iccLnp3YQCdceZvo9toTXrmkpbfdLjptAD8JIoQS8okJQ9hMZ7+TxXK7TerLQvq2HeE+TAt7lWPn9iFx+65Kp6a0tYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Shmt745R reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=YPgydMHs; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1771708189; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=+iLIVd2IaggnfcWfPzgeVDaeJzo1dvYtJEbqPBKfZu4=; b=Shmt745R3cxG64JQ00/lYHJAEj
	2Dlpw6P8LCGUnxMQyxFzisXqk5ZsNjgZogS/Sc7j1LWBQI+KsK3N98Qvn/E9EqshMyNIlr2w/UixA
	+Q862zXI328trHUpVrTci5pQj8Ldc/CzpNeNyQnYand/RkDPLpaDJ2eI2sDkj0r8oF97vfPzU4xCH
	qYw811AB+MfWWMMpb6VaMee9u3aVwTp74rPu+GlT4rZP9dT3LWOPTN4bkQNaliDca/cQOocmOKUDW
	hubHbyQHq3MfWUUCPIATT/yp/K+A4czAuQJk8U+gFbeuyxD2zZPkyPf1Hmq373HkOGSGLATV+HH/b
	6S0+e8eQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1771707289; h=from : subject
 : to : message-id : date;
 bh=+iLIVd2IaggnfcWfPzgeVDaeJzo1dvYtJEbqPBKfZu4=;
 b=YPgydMHsrsCfmQ1wa+YHwej4gn8dEgdj8B4aSYeYIjdOuIKNXGttal4P5DHQT8xnJrROP
 bgaBtuYNQaYHlCcLavo4IdG08zAdKiA8uc3zJ+2yKt8rIL2llt68+DSiWfwYXxt5wx82peu
 hBlNxS6oOvQOoCWwZbAkzhvlKSlIBN0DYhwzAcfnEmr4D7zbEMg8eXXsVUfEfXdxCpnP7YR
 gC2IOsN/ifmAjSUOJaUpoTfwGQKZvcIBXp/AW+HeDjRNLP1fGeHnMqpaHWVXS7rHtJQjeoi
 MHTfzAQF4VGMrf4o8WTwdTSaHbuK5OCPsp+hyYDrEV/bLLM1kJ0Prsj6wY6A==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vttzp-TRjwl8-1h; Sat, 21 Feb 2026 20:54:37 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vttzo-AIkwcC8uaYC-K0GS; Sat, 21 Feb 2026 20:54:36 +0000
Date: Sat, 21 Feb 2026 21:35:52 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v2 1/3] 9p: Cache negative dentries for lookup performance
Message-ID: <aZoXKN8pPOqEBBBz@pilgrim>
References: <cover.1769013622.git.repk@triplefau.lt>
 <51afd44abb72d251e2022fbb4d53dd05a03aeed0.1769013622.git.repk@triplefau.lt>
 <10801068.nUPlyArG6x@weasel> <aY2aXG4ljulj1QRh@pilgrim>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY2aXG4ljulj1QRh@pilgrim>
X-Smtpcorp-Track: 48ZLaFHWHQrq.dgyQrneEazmY.7sCGTQI2zSp
Feedback-ID: 510616m:510616apGKSTK:510616shlp15QIr_
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77865-lists,linux-fsdevel=lfdr.de];
	DKIM_MIXED(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_PERMFAIL(0.00)[smtpservice.net:s=maxzs0.a1-4.dyn];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[smtpservice.net:~,triplefau.lt:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 901B916DD9A
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 10:16:13AM +0100, Remi Pommarel wrote:
> On Wed, Feb 11, 2026 at 04:49:19PM +0100, Christian Schoenebeck wrote:
> > On Wednesday, 21 January 2026 20:56:08 CET Remi Pommarel wrote:
> > > Not caching negative dentries can result in poor performance for
> > > workloads that repeatedly look up non-existent paths. Each such
> > > lookup triggers a full 9P transaction with the server, adding
> > > unnecessary overhead.
> > > 
> > > A typical example is source compilation, where multiple cc1 processes
> > > are spawned and repeatedly search for the same missing header files
> > > over and over again.
> > > 
> > > This change enables caching of negative dentries, so that lookups for
> > > known non-existent paths do not require a full 9P transaction. The
> > > cached negative dentries are retained for a configurable duration
> > > (expressed in milliseconds), as specified by the ndentry_timeout
> > > field in struct v9fs_session_info. If set to -1, negative dentries
> > > are cached indefinitely.
> > > 
> > > This optimization reduces lookup overhead and improves performance for
> > > workloads involving frequent access to non-existent paths.
> > > 
> > > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > > ---
> > >  fs/9p/fid.c             |  11 +++--
> > >  fs/9p/v9fs.c            |   1 +
> > >  fs/9p/v9fs.h            |   2 +
> > >  fs/9p/v9fs_vfs.h        |  15 ++++++
> > >  fs/9p/vfs_dentry.c      | 105 ++++++++++++++++++++++++++++++++++------
> > >  fs/9p/vfs_inode.c       |   7 +--
> > >  fs/9p/vfs_super.c       |   1 +
> > >  include/net/9p/client.h |   2 +
> > >  8 files changed, 122 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/fs/9p/fid.c b/fs/9p/fid.c
> > > index f84412290a30..76242d450aa7 100644
> > > --- a/fs/9p/fid.c
> > > +++ b/fs/9p/fid.c
> > > @@ -20,7 +20,9 @@
> > > 
> > >  static inline void __add_fid(struct dentry *dentry, struct p9_fid *fid)
> > >  {
> > > -	hlist_add_head(&fid->dlist, (struct hlist_head *)&dentry->d_fsdata);
> > > +	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
> > > +
> > > +	hlist_add_head(&fid->dlist, &v9fs_dentry->head);
> > >  }
> > > 
> > > 
> > > @@ -112,6 +114,7 @@ void v9fs_open_fid_add(struct inode *inode, struct
> > > p9_fid **pfid)
> > > 
> > >  static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int
> > > any) {
> > > +	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
> > >  	struct p9_fid *fid, *ret;
> > > 
> > >  	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p) uid %d any %d\n",
> > > @@ -119,11 +122,9 @@ static struct p9_fid *v9fs_fid_find(struct dentry
> > > *dentry, kuid_t uid, int any) any);
> > >  	ret = NULL;
> > >  	/* we'll recheck under lock if there's anything to look in */
> > > -	if (dentry->d_fsdata) {
> > > -		struct hlist_head *h = (struct hlist_head *)&dentry->d_fsdata;
> > > -
> > > +	if (!hlist_empty(&v9fs_dentry->head)) {
> > >  		spin_lock(&dentry->d_lock);
> > > -		hlist_for_each_entry(fid, h, dlist) {
> > > +		hlist_for_each_entry(fid, &v9fs_dentry->head, dlist) {
> > >  			if (any || uid_eq(fid->uid, uid)) {
> > >  				ret = fid;
> > >  				p9_fid_get(ret);
> > > diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> > > index 057487efaaeb..1da7ab186478 100644
> > > --- a/fs/9p/v9fs.c
> > > +++ b/fs/9p/v9fs.c
> > > @@ -422,6 +422,7 @@ static void v9fs_apply_options(struct v9fs_session_info
> > > *v9ses, v9ses->cache = ctx->session_opts.cache;
> > >  	v9ses->uid = ctx->session_opts.uid;
> > >  	v9ses->session_lock_timeout = ctx->session_opts.session_lock_timeout;
> > > +	v9ses->ndentry_timeout = ctx->session_opts.ndentry_timeout;
> > >  }
> > > 
> > >  /**
> > > diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
> > > index 6a12445d3858..99d1a0ff3368 100644
> > > --- a/fs/9p/v9fs.h
> > > +++ b/fs/9p/v9fs.h
> > > @@ -91,6 +91,7 @@ enum p9_cache_bits {
> > >   * @debug: debug level
> > >   * @afid: authentication handle
> > >   * @cache: cache mode of type &p9_cache_bits
> > > + * @ndentry_timeout: Negative dentry lookup cache retention time in ms
> > >   * @cachetag: the tag of the cache associated with this session
> > >   * @fscache: session cookie associated with FS-Cache
> > >   * @uname: string user name to mount hierarchy as
> > > @@ -116,6 +117,7 @@ struct v9fs_session_info {
> > >  	unsigned short debug;
> > >  	unsigned int afid;
> > >  	unsigned int cache;
> > > +	unsigned int ndentry_timeout;
> > 
> > Why not (signed) long?
> 
> I first though 40+ days of cache retention was enough but that is just
> an useless limitation, I will change it to signed long.

Well now that I think about it, this is supposed to be set from a mount
options. However, with the new mount API in use, there is currently no
support for fsparam_long or fsparam_s64.

While it could be implemented using a custom __fsparam, is the effort
truly justified here? Also in that case maybe a long long would be a bit
more portable across 32-bit and 64-bit platform?

Thanks,

-- 
Remi

