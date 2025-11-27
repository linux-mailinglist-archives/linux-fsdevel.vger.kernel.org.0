Return-Path: <linux-fsdevel+bounces-70000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF9C8DE34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65453AF8BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7880832C331;
	Thu, 27 Nov 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GVNTlZZX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mbZ70rTo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8E328637;
	Thu, 27 Nov 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241431; cv=none; b=qLFozd/DDiY0g5ItNBjpAN+Z3JU8tJhrb9ogMU+ne+kzmzOkmIn1Vcv3DaergFKDc20zciA4vCu437lCFmjugTu+e13pdOuYCHBkz3GecPMUWKdIipC++FH5VtduaK7QMH9ms0DLqD1u754Gyex2QB4PytbtW1MCDgUygHJU6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241431; c=relaxed/simple;
	bh=NsXtBtBSrNCzyIpRGfmI/7r7ZAmCIkllSGeN88p0MCE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=s/fp78BI4nyPpkr6IpejoznyBhBmNtXH3wo/nfNTBnI6NLq/qAP96ZFU4fdhXs9HWGVq1Q/LU95wTDEfySOI8ixIC8ZXug6dV4BuQZTZbTcBfASCsyleySx/ym30+zpDeyUvqVNeYpyCWVwPo/T+ITyominOIagh1FBYyugSgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GVNTlZZX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mbZ70rTo; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CA9021D00019;
	Thu, 27 Nov 2025 06:03:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 27 Nov 2025 06:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1764241426; x=1764327826; bh=zSb4aHSYinyWLeQVPRtnSym6urqwkXvceWO
	yqA0Qx08=; b=GVNTlZZXDy60hK6v8r56oOl1HzVNrS7VOQSP4Wri0rynZ0Dvhpo
	ovsASGEhFYORALFWWJCzhulLEHQ7DiFmHY4NfonrYzNP+7NVy93RCl8HJdgbV8fr
	OruEF7jajOKAYkcqZ9OkMajqS21xPiS2l/xHKHmTkaPhPtzpeGjHawndABINAq+I
	U1e1yd8I+2O7MBgxMl3NfVFM3p8sIiOnuQoCj0zyhAHVV+mkJF1cs56IHQv6DxhT
	+Ca5kfjo6D3S0pZVW1cz4MKkKE1osoMme232E3lwctnImAFCy/bOQJrsN7l7hUTO
	BWCmxh7UFIob0kvfbFhEJORkFWNuWzt5iyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764241426; x=
	1764327826; bh=zSb4aHSYinyWLeQVPRtnSym6urqwkXvceWOyqA0Qx08=; b=m
	bZ70rTof8Y5TKwBdNwclFtogXlFLqMJgE019LtqZenmC2DOLmwULRcT2ivkSVbqd
	/CRl7I8bEI5G/qadMcPOoftQh446/wMDSFOj0AdzOZCapCJWYSJumXaTU2kjoHTR
	CuzqD5qVOTW5dRrhaMB+a2C5iWkH/cr8YRho0V/gNoPmYzV+lUzlTyKlxVKMml3c
	oep8KBUjaFxi+4ApH2RZBsCuJ5er7WM7JmQgyuYt7JnbSzTT7BNJMjJ+G1m0EmBw
	rplInOhlctklYjrH6p+MHLJJ59Wdv/EyPU/khAnuMoz58jH+K1Cs0FSF2K8Fix1z
	IHCXOTLMbLrhHYptIBheg==
X-ME-Sender: <xms:EjAoaa4ggWNjCDyagD_9lITAPRFZ4-lCjkUcYX1_OaT-aNyDj7jC2w>
    <xme:EjAoacAPvpBCySkqoYhyUdHUgn0Lcg1Pa9-MGYw9D3rhL1qM_aLbBaarXEkzM1C_0
    NzAwyzu5T0wY4J6by04ZKxHIBEbZ0ycoPrhOx3BncGZ9EzikA>
X-ME-Received: <xmr:EjAoaY9CrDE4aAxlm4floHTDjY9Zocf-k7w7YOkjbMClMNoAQkYhHYy5tL_ht8Q5c26-ilWTtD8XZz6-gOCpbe2lF3MGjgkCELAxSxfU9fW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeejtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epteehgefgieeihfehjeetudejleffveehtdegkeduudffiefhgeduhfekfeehfeeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghdpudelrdguihhrvggtthhorhihnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohif
    nhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepohgvqdhlkhhpsehlihhsthhsrdhlihhnuhigrdguvghvpdhr
    tghpthhtohepnhgvthhfsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    hjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeholhhivhgvrhdrshgrnhhgsehinhhtvghlrd
    gtohhm
X-ME-Proxy: <xmx:EjAoaXFPY5r3lD1qoFMFQU7Kx8StyTj7M-mrBt6URIWXNfrZABsIHw>
    <xmx:EjAoaaR6xKwOkBDqu4FRB_DfxjRXunXKfYchGn9nYUZQB7nHjD2Ljg>
    <xmx:EjAoaWQvdcLskjTdEKW0wVAhRLw8T9MOvvJD_fN4Ejr2643i9sE87Q>
    <xmx:EjAoaV0QkxUz4k-5i180WZM2OPliblUBgSMvjyrPEnAgm-wj-EhwVw>
    <xmx:EjAoad3RRhhhaGMxTuckJ1uvlNqk-YCMiIY4Lg6fD7E45kVu-iMEfmLv>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 06:03:43 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Amir Goldstein" <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "kernel test robot" <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [VFS/nfsd/cachefiles/ovl] 7ab96df840:
 WARNING:at_fs/dcache.c:#umount_check
In-reply-to: <20251127-engel-eschenholz-805b54630656@brauner>
References: <202511252132.2c621407-lkp@intel.com>,
 <20251126-beerdigen-spanplatten-d86d4e9eaaa7@brauner>,
 <CAOQ4uxgHqKyaRfXAugnCP4sozgwiOGTGDYvx2A-XJdxfswo-Ug@mail.gmail.com>,
 <176419027888.634289.8284458326359928729@noble.neil.brown.name>,
 <20251127-engel-eschenholz-805b54630656@brauner>
Date: Thu, 27 Nov 2025 22:03:31 +1100
Message-id: <176424141191.634289.800675023484871934@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 27 Nov 2025, Christian Brauner wrote:
> On Thu, Nov 27, 2025 at 07:51:18AM +1100, NeilBrown wrote:
> > On Wed, 26 Nov 2025, Amir Goldstein wrote:
> > > On Wed, Nov 26, 2025 at 11:42=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > >
> > > > On Tue, Nov 25, 2025 at 09:48:18PM +0800, kernel test robot wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > kernel test robot noticed "WARNING:at_fs/dcache.c:#umount_check" on:
> > > > >
> > > > > commit: 7ab96df840e60eb933abfe65fc5fe44e72f16dc0 ("VFS/nfsd/cachefi=
les/ovl: add start_creating() and end_creating()")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git ma=
ster
> > > > >
> > > > > [test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c=
09d64f5]
> > > >
> > > > Neil, can you please take a look at this soon?
> > > > I plan on sending the batch of PRs for this cycle on Friday.
> > > >
> > > > >
> > > > > in testcase: filebench
> > > > > version: filebench-x86_64-22620e6-1_20251009
> > > > > with following parameters:
> > > > >
> > > > >       disk: 1SSD
> > > > >       fs: ext4
> > > > >       fs2: nfsv4
> > > > >       test: ratelimcopyfiles.f
> > > > >       cpufreq_governor: performance
> > > > >
> > >=20
> > > Test is copying to nfsv4 so that's the immediate suspect.
> > > WARN_ON is in unmount of ext4, but I suspect that nfs
> > > was loop mounted for the test.
> > >=20
> > > FWIW, nfsd_proc_create() looks very suspicious.
> > >=20
> > > nfsd_create_locked() does end_creating() internally (internal API chang=
e)
> > > but nfsd_create_locked() still does end_creating() regardless.
> >=20
> > Thanks for looking at this Amir.  That omission in nfsproc.c is
> > certainly part of the problem but not all of it.
> > By skipping the end_creating() there, we avoid a duplicate unlock, but
> > also lose a dput() which we need.  Both callers of nfsd_create_locked()
> > have the same problem.
> > I think this should fix it.  The resulting code is a bit ugly but I can
> > fix that with the nfsd team once this gets upstream.
> >=20
> > (FYI nfsd_proc_create() is only used for NFSv2 and as it was an nfsv4 tes=
t,
> >  that could wouldn't have been run)
> >=20
> > Thanks,
> > NeilBrown
> >=20
> > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > index 28f03a6a3cc3..481e789a7697 100644
> > --- a/fs/nfsd/nfsproc.c
> > +++ b/fs/nfsd/nfsproc.c
> > @@ -407,6 +407,9 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> >  		/* File doesn't exist. Create it and set attrs */
> >  		resp->status =3D nfsd_create_locked(rqstp, dirfhp, &attrs, type,
> >  						  rdev, newfhp);
> > +		/* nfsd_create_locked() unlocked the parent */
> > +		dput(dchild);
> > +		goto out_write;
> >  	} else if (type =3D=3D S_IFREG) {
> >  		dprintk("nfsd:   existing %s, valid=3D%x, size=3D%ld\n",
> >  			argp->name, attr->ia_valid, (long) attr->ia_size);
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 145f1c8d124d..4688f3fd59e2 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1633,16 +1633,14 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
> >  		return nfserrno(host_err);
> > =20
> >  	err =3D fh_compose(resfhp, fhp->fh_export, dchild, fhp);
> > -	/*
> > -	 * We unconditionally drop our ref to dchild as fh_compose will have
> > -	 * already grabbed its own ref for it.
> > -	 */
> >  	if (err)
> >  		goto out_unlock;
> >  	err =3D fh_fill_pre_attrs(fhp);
> >  	if (err !=3D nfs_ok)
> >  		goto out_unlock;
> >  	err =3D nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
> > +	/* nfsd_create_locked() unlocked the parent */
> > +	dput(dchild);
> >  	return err;
> > =20
> >  out_unlock:
>=20
> Thanks for the quick fix. I've added a patch to
> vfs-6.19.directory.unlocking which I attributed to you.
> It'd be easier if you just shoot something I can apply directly next
> time. :)
>=20

Thanks looks good ( on vfs-6.19.directory.locking of course not
unlocking :-)

Though I prefer
Signed-off-by: NeilBrown <neil@brown.name>

(I received mail at that address but cannot send it because of SPF
 silliness at brown.name).

I'll make sure it is a properly formatted patch if there is a next
time.

Thanks,
NeilBrown

