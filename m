Return-Path: <linux-fsdevel+bounces-28608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6044896C5C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185C1287435
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B721E1A28;
	Wed,  4 Sep 2024 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="1a0jFqqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D31E00AF;
	Wed,  4 Sep 2024 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472419; cv=none; b=aeiV4Z6i3sn+0VC9Sw3CyH66ZAXrJUbMxnx3bZegQwW5lr9x4OgRoPRaVLBvEEg7rr0ukj7PHP5JDxtd5EYqJinHZsFyOFcfWX1PaPpfdZuulXehxc7h1XqoxMHiU+mu1Z2h9haKxNiSb2cZrm8v6V7BX/0gtu8sC25tMGMAKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472419; c=relaxed/simple;
	bh=+iOA0p81T6D+b7dL88cQfXEKiGSHHFexNpERoZi42iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRAKmPLDVObjRP1JH2S4bYB+v0wKk7dupwfRBwMWb+Dfd/MjmS6mzkXiXQYt88YbIAvOM2JvlrX7WTfZ1xp3j6xnvt2DYi7LzAJm7TYCvxmnftdZ2zjhR9spzHTt9lwKkew0o+3Zjl7grWTKyD5A98qV0AH3GN54iiYAW7lue5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=1a0jFqqS; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WzVTg232gz9sWc;
	Wed,  4 Sep 2024 19:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725472407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwlQBWXYq/opPvFlbWP173b1Nlq+n+PtL6lZzaZ58hA=;
	b=1a0jFqqSgV+SpmrZuk4pkJP3Hm5AIush1Kk6IRRTxwmTOFYaE3Z1XMFsPs/AOTnUoozMyU
	YYc1ZC7NAACOLdVoJhhmKu1kBVVE8+DkpZJ7kHrT29SPMs2mkEWKOMaR8BB+sFDxSqnteC
	GLm0NAh2MgsmkrHibJzytx8h9Lvkhg+n9+bZ+Cb2tzUD/m6+n6wiKpwIT2r4k5kieWI4EM
	3ru7kHCPk5KrVMysb+KOCsvKp9JbiPlgzBnnaeAG5wwbif8vX9h7NMHthZvGZWb+Fc+43x
	x7Ps1t1d1cORzplQdki0kjM1hC16kLxqOtGoGrl5zhvpDbjEQkDji/GZcnnnng==
Date: Thu, 5 Sep 2024 03:53:07 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Alexander Aring <alex.aring@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Christoph Hellwig <hch@infradead.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH xfstests v2 2/2] open_by_handle: add tests for u64 mount
 ID
Message-ID: <20240904.170511-plaid.cupcake.bright.comedy-wgajfvBqCgUK@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240902164554.928371-1-cyphar@cyphar.com>
 <20240902164554.928371-2-cyphar@cyphar.com>
 <CAOQ4uxgS6DvsbUsEoM1Vr2wcd_7Bj=xFXMAy4z9PphTu+G6RaQ@mail.gmail.com>
 <20240903.044647-some.sprint.silent.snacks-jdKnAVp7XuBZ@cyphar.com>
 <CAOQ4uxhXa-1Xjd58p8oGd9Q4hgfDtGnae1YrmDWwQp3t5uGHeg@mail.gmail.com>
 <20240904.162424-novel.fangs.vital.nursery-BQvjXGlIi7vb@cyphar.com>
 <CAOQ4uxg7EgOH5s_RZz27XpVSwgWu9bROT9JRzTycxi8D2_3d3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="desv3b7yboboqrpl"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg7EgOH5s_RZz27XpVSwgWu9bROT9JRzTycxi8D2_3d3A@mail.gmail.com>
X-Rspamd-Queue-Id: 4WzVTg232gz9sWc


--desv3b7yboboqrpl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-04, Amir Goldstein <amir73il@gmail.com> wrote:
> On Wed, Sep 4, 2024 at 6:31=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
> >
> > On 2024-09-03, Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Tue, Sep 3, 2024 at 8:41=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.co=
m> wrote:
> > > >
> > > > On 2024-09-02, Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > On Mon, Sep 2, 2024 at 6:46=E2=80=AFPM Aleksa Sarai <cyphar@cypha=
r.com> wrote:
> > > > > >
> > > > > > Now that open_by_handle_at(2) can return u64 mount IDs, do some=
 tests to
> > > > > > make sure they match properly as part of the regular open_by_ha=
ndle
> > > > > > tests.
> > > > > >
> > > > > > Link: https://lore.kernel.org/all/20240828-exportfs-u64-mount-i=
d-v3-0-10c2c4c16708@cyphar.com/
> > > > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > > > ---
> > > > > > v2:
> > > > > > - Remove -M argument and always do the mount ID tests. [Amir Go=
ldstein]
> > > > > > - Do not error out if the kernel doesn't support STATX_MNT_ID_U=
NIQUE
> > > > > >   or AT_HANDLE_MNT_ID_UNIQUE. [Amir Goldstein]
> > > > > > - v1: <https://lore.kernel.org/all/20240828103706.2393267-1-cyp=
har@cyphar.com/>
> > > > >
> > > > > Looks good.
> > > > >
> > > > > You may add:
> > > > >
> > > > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > > > >
> > > > > It'd be nice to get a verification that this is indeed tested on =
the latest
> > > > > upstream and does not regress the tests that run the open_by_hand=
le program.
> > > >
> > > > I've tested that the fallback works on mainline and correctly does =
the
> > > > test on patched kernels (by running open_by_handle directly) but I
> > > > haven't run the suite yet (still getting my mkosi testing setup wor=
king
> > > > to run fstests...).
> > >
> > > I am afraid this has to be tested.
> > > I started testing myself and found that it breaks existing tests.
> > > Even if you make the test completely opt-in as in v1 it need to be
> > > tested and _notrun on old kernels.
> > >
> > > If you have a new version, I can test it until you get your fstests s=
etup
> > > ready, because anyway I would want to check that your test also
> > > works with overlayfs which has some specialized exportfs tests.
> > > Test by running ./check -overlay -g exportfs, but I can also do that =
for you.
> >
> > I managed to get fstests running, sorry about that...
> >
> > For the v3 I have ready (which includes a new test using -M), the
> > following runs work in my VM:
> >
> >  - ./check -g exportfs
> >  - ./check -overlay -g exportfs
> >
> > Should I check anything else before sending it?
> >
>=20
> That should be enough.
> So you have one new test that does not run on upstream kernel
> and runs and passes on patched kernel?

Yes. Both of those suite runs succeed without issues on v6.6.49,
v6.11-rc6 and with the AT_HANDLE_MNT_ID_UNIQUE patches.

I also added skipping logic such that it _should_ work on pre-5.8
kernels (pre-STATX_MNT_ID) as well, but I can't test that at the moment
(mkosi-kernel fails to boot kernels that old it seems...).

I'll send it now.

> > Also, when running the tests I think I may have found a bug? Using
> > overlayfs+xfs leads to the following error when doing ./check -overlay
> > if the scratch device is XFS:
> >
> >   ./common/rc: line 299: _xfs_has_feature: command not found
> >     not run: upper fs needs to support d_type
> >
> > The fix I applied was simply:
> >
> > diff --git a/common/rc b/common/rc
> > index 0beaf2ff1126..e6af1b16918f 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -296,6 +296,7 @@ _supports_filetype()
> >         local fstyp=3D`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $2}'`
> >         case "$fstyp" in
> >         xfs)
> > +               . common/xfs
> >                 _xfs_has_feature $dir ftype
> >                 ;;
> >         ext2|ext3|ext4)
> >
> > Should I include this patch as well, or did I make a mistake somewhere?
> > (I could add the import to the top instead if you'd prefer that.)
>=20
> This should already be handled by
> if [ -n "$OVL_BASE_FSTYP" ];then
>         _source_specific_fs $OVL_BASE_FSTYP
> fi
>=20
> in common/overlay
>=20
> I think what you are missing is to
> export FSTYP=3Dxfs
> as README.overlay suggests.
>=20
> It's true that ./check does not *require* defining FSTYP
> and can auto detect the test filesystem, but for running -overlay
> is it a requirement to define the base FSTYP.

Ah okay, I missed that. That fixed the issue, thanks!

> Thanks,
> Amir.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--desv3b7yboboqrpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZtiegwAKCRAol/rSt+lE
b+FxAQDWDbG8ZcUXpeo+h6HVuVli6xVHlHWngRmTvTcWENFkngD/W7QXKg+f3YSB
9oBIQrNw1bMCPg25g/SKHI6VKH85DAM=
=6l+u
-----END PGP SIGNATURE-----

--desv3b7yboboqrpl--

