Return-Path: <linux-fsdevel+bounces-45631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39767A7A132
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 12:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6103B59A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB2924A079;
	Thu,  3 Apr 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF1a49IT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F031E04AC;
	Thu,  3 Apr 2025 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676918; cv=none; b=f7+ws6zKWApgfXQscPGyplLHGY9KwMcb6fYuUIbDSVpdL2lkNNW344zSEMhpTSj/0klFAGrb9veKJ+JuZLcbVKPNKXcBMkdX4YB8OptjeVONaoY9KWNLyCWSQywkGshKc4++B74/72IiG73ndGr/u3xn0yibPviK6FE0r8k8Nco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676918; c=relaxed/simple;
	bh=spUwOu8aFOkGg9vJW892/j33ITNF7CpX85SNYXCWuxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnlSBGBeh2YrqyMhGEXVMzFq4dvlDq0tH3GGVbYpf4eJ9NWTP2PnI7yU1S1x0jiMpPOvMf29GwD8t2zbiNeRkhFqGj7ni/bG5O1/MyXJbt/opmcv2d00EkrLmFv7p1mR1IBDkxBY5hm1dPLIXfrJ/ZD9AmbKzVaRXwFoBYsQ35I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF1a49IT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0758BC4CEE3;
	Thu,  3 Apr 2025 10:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743676917;
	bh=spUwOu8aFOkGg9vJW892/j33ITNF7CpX85SNYXCWuxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vF1a49ITAox0CjAtOAh9coeTRFKDj9XTB8oOmYHVVFRmSE9fxlAgJdys6Yt5RBUdm
	 30rcLSaYleMve0rnMP8RTiY4DhJIzaWKyNfLn92EGmJhvQjBO4GwD+XvitH9OWaDLB
	 WPN5hyqKQx0KpwWxESp9fDV5+SOK8bRp/SIufIKseX/fLnDXmCr8H4p0geN16iNQBW
	 A9HVQxrwAoDN8tdCOCUqjeyoukx2zH0gYPcBhSbvewWFJAIvvB8vhgmPMCmm51lIDu
	 6ablbtiWiLYXng9DybQLISR45oRDicV2R9E9nPkxHYwmdq2vdq4XcnBp/zBE7OWcp9
	 8bFhz59E0XP6g==
Date: Thu, 3 Apr 2025 12:41:53 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: Document FAN_PRE_ACCESS event
Message-ID: <tfze44pnruxyqskrp3oqanzwp6qqjdlphfnyvqzxzptx45xsgj@e27hp2fuoa7a>
References: <20250330125536.1408939-1-amir73il@gmail.com>
 <de54ad3do3vz3mi7swdojhwzrpssxk6rzqrfzlrmjaxz4pud6r@ha64lyrespvy>
 <CAOQ4uxgpvJDYfvRxO-AG43hkDKeKAvbH6YgPF+Au83JHM6vGJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d22zcjqtlitji737"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgpvJDYfvRxO-AG43hkDKeKAvbH6YgPF+Au83JHM6vGJg@mail.gmail.com>


--d22zcjqtlitji737
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: Document FAN_PRE_ACCESS event
References: <20250330125536.1408939-1-amir73il@gmail.com>
 <de54ad3do3vz3mi7swdojhwzrpssxk6rzqrfzlrmjaxz4pud6r@ha64lyrespvy>
 <CAOQ4uxgpvJDYfvRxO-AG43hkDKeKAvbH6YgPF+Au83JHM6vGJg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgpvJDYfvRxO-AG43hkDKeKAvbH6YgPF+Au83JHM6vGJg@mail.gmail.com>

On Thu, Apr 03, 2025 at 12:06:18PM +0200, Amir Goldstein wrote:
> On Wed, Apr 2, 2025 at 10:58=E2=80=AFPM Alejandro Colomar <alx@kernel.org=
> wrote:
> >
> > Hi Amir,
> >
> > On Sun, Mar 30, 2025 at 02:55:36PM +0200, Amir Goldstein wrote:
> > > The new FAN_PRE_ACCESS events are created before access to a file ran=
ge,
> > > to provides an opportunity for the event listener to modify the conte=
nt
> > > of the object before the user can accesss it.
> > >
> > > Those events are available for group in class FAN_CLASS_PRE_CONTENT
> > > They are reported with FAN_EVENT_INFO_TYPE_RANGE info record.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  man/man2/fanotify_init.2 |  4 ++--
> > >  man/man2/fanotify_mark.2 | 14 +++++++++++++
> > >  man/man7/fanotify.7      | 43 ++++++++++++++++++++++++++++++++++++++=
--
> > >  3 files changed, 57 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> > > index 23fbe126f..b1ef8018c 100644
> > > --- a/man/man2/fanotify_init.2
> > > +++ b/man/man2/fanotify_init.2
> > > @@ -57,8 +57,8 @@ Only one of the following notification classes may =
be specified in
> > >  .B FAN_CLASS_PRE_CONTENT
> > >  This value allows the receipt of events notifying that a file has be=
en
> > >  accessed and events for permission decisions if a file may be access=
ed.
> > > -It is intended for event listeners that need to access files before =
they
> > > -contain their final data.
> > > +It is intended for event listeners that may need to write data to fi=
les
> > > +before their final data can be accessed.
> > >  This notification class might be used by hierarchical storage manage=
rs,
> > >  for example.
> > >  Use of this flag requires the
> > > diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
> > > index 47cafb21c..edbcdc592 100644
> > > --- a/man/man2/fanotify_mark.2
> > > +++ b/man/man2/fanotify_mark.2
> > > @@ -445,6 +445,20 @@ or
> > >  .B FAN_CLASS_CONTENT
> > >  is required.
> > >  .TP
> > > +.BR FAN_PRE_ACCESS " (since Linux 6.14)"
> > > +.\" commit 4f8afa33817a6420398d1c177c6e220a05081f51
> > > +Create an event before read or write access to a file range,
> > > +that provides an opportunity for the event listener
> > > +to modify the content of the file
> > > +before access to the content
> > > +in the specified range.
> > > +An additional information record of type
> > > +.B FAN_EVENT_INFO_TYPE_RANGE
> > > +is returned for each event in the read buffer.
> > > +An fanotify file descriptor created with
> > > +.B FAN_CLASS_PRE_CONTENT
> > > +is required.
> > > +.TP
> > >  .B FAN_ONDIR
> > >  Create events for directories\[em]for example, when
> > >  .BR opendir (3),
> > > diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> > > index 7844f52f6..6f3a9496e 100644
> > > --- a/man/man7/fanotify.7
> > > +++ b/man/man7/fanotify.7
> > > @@ -247,6 +247,26 @@ struct fanotify_event_info_error {
> > >  .EE
> > >  .in
> > >  .P
> > > +In case of
> > > +.B FAN_PRE_ACCESS
> > > +events,
> > > +an additional information record describing the access range
> > > +is returned alongside the generic
> > > +.I fanotify_event_metadata
> > > +structure within the read buffer.
> > > +This structure is defined as follows:
> > > +.P
> > > +.in +4n
> > > +.EX
> > > +struct fanotify_event_info_range {
> > > +    struct fanotify_event_info_header hdr;
> > > +    __u32 pad;
> > > +    __u64 offset;
> > > +    __u64 count;
> > > +};
> > > +.EE
> > > +.in
> > > +.P
> > >  All information records contain a nested structure of type
> > >  .IR fanotify_event_info_header .
> > >  This structure holds meta-information about the information record
> > > @@ -509,8 +529,9 @@ The value of this field can be set to one of the =
following:
> > >  .BR FAN_EVENT_INFO_TYPE_FID ,
> > >  .BR FAN_EVENT_INFO_TYPE_DFID ,
> > >  .BR FAN_EVENT_INFO_TYPE_DFID_NAME ,
> > > -or
> > > -.BR FAN_EVENT_INFO_TYPE_PIDFD .
> > > +.BR FAN_EVENT_INFO_TYPE_PIDFD ,
> > > +.BR FAN_EVENT_INFO_TYPE_ERROR ,
> > > +.BR FAN_EVENT_INFO_TYPE_RANGE .
> > >  The value set for this field
> > >  is dependent on the flags that have been supplied to
> > >  .BR fanotify_init (2).
> > > @@ -711,6 +732,24 @@ Identifies the type of error that occurred.
> > >  This is a counter of the number of errors suppressed
> > >  since the last error was read.
> > >  .P
> > > +The fields of the
> > > +.I fanotify_event_info_range
> > > +structure are as follows:
> > > +.TP
> > > +.I hdr
> >
> > We should use .hdr here too (and in the fields below, '.' too), right?
> >
>=20
> Sure that was your idea.
> I am fine with it.
>=20
> I guess it could be changed later with other instances,

Okay, I'll do it post-merge.


Cheers,
Alex

>=20
> Thanks,
> Amir.

--=20
<https://www.alejandro-colomar.es/>
<https://www.alejandro-colomar.es:8443/>
<http://www.alejandro-colomar.es:8080/>

--d22zcjqtlitji737
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmfuZfEACgkQ64mZXMKQ
wqnSeQ//Tb79ZA3TLH89RgsYIS0JH1piVYtvtsSPUymiSR2tPm6DJTJLsYKgueaW
evsIz4ecX8sPPJ5anuopsUiYWyuZ+jDvtUilUGddla93xWpmpilCbk0bs3lMD24l
VbzhFphAHDjZvs7LVppbsA9RuIfVqNrc+XQypJw+aETqX+gcgy9OsY8rezHNrd4b
C6XaIqPit4xzUPXs8KaJIk6q7dTh3VyxT7weII1O65h35/IVcuE7NOiBZnGYOPgm
cyktHy3UelchAwomrdCbiQxfPUQ7nEPy4Y82jtgctblxMHM/g2oYcwKtTehSzmQw
v8Ho2TDqklBKGEl1R6VNGJu1gbVuwWaDeguVvCU9t28ktmzCcZBBxMqthyHeaWLz
dECKXs/l7hcDxvRkRajVDvc/QiJ0nMte1Dxjrb84MboeUPdmRGjJ2KXPmJstPUjq
r9mVVjO1jWJm3xl0HPpBjbasBGi33s3UVdH0UT17FBFLHW0ue8ZgbiF4aFKocXQ/
JjZ5z/5xlCnMlCjnuNt37noEIyctnUr0Q4fFsU+8mndr0kJDX6298L7I4V+9I4F9
h1m1fVafWxTJiFaKiSzaTw2Na0HfXsGNQ+m9Mq2Fz9QOeMOrFKEFNc92rHHGWw8M
0mEoIB5MdvxwBsfHzKZfhu4sriRefcElIt73K6ec8/ZJTFqiQ70=
=wDiY
-----END PGP SIGNATURE-----

--d22zcjqtlitji737--

