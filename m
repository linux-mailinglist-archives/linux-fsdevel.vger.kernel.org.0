Return-Path: <linux-fsdevel+bounces-511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E263F7CBEAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 11:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C4BB2110F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A59D3F4C0;
	Tue, 17 Oct 2023 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDEE27721
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 09:13:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378548E
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 02:13:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qsg9C-000471-Mz; Tue, 17 Oct 2023 11:13:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qsg9C-002HmY-7w; Tue, 17 Oct 2023 11:13:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qsg9B-0009Zy-V3; Tue, 17 Oct 2023 11:13:53 +0200
Date: Tue, 17 Oct 2023 11:13:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH] chardev: Simplify usage of try_module_get()
Message-ID: <20231017091353.6fhpmrcx66jj2jls@pengutronix.de>
References: <20231013132441.1406200-2-u.kleine-koenig@pengutronix.de>
 <20231016224311.GI800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qf5kc5bqy2ce2zac"
Content-Disposition: inline
In-Reply-To: <20231016224311.GI800259@ZenIV>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--qf5kc5bqy2ce2zac
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 11:43:11PM +0100, Al Viro wrote:
> On Fri, Oct 13, 2023 at 03:24:42PM +0200, Uwe Kleine-K=F6nig wrote:
> > try_module_get(NULL) is true, so there is no need to check owner being
> > NULL.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  fs/char_dev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/char_dev.c b/fs/char_dev.c
> > index 950b6919fb87..6ba032442b39 100644
> > --- a/fs/char_dev.c
> > +++ b/fs/char_dev.c
> > @@ -350,7 +350,7 @@ static struct kobject *cdev_get(struct cdev *p)
> >  	struct module *owner =3D p->owner;
> >  	struct kobject *kobj;
> > =20
> > -	if (owner && !try_module_get(owner))
> > +	if (!try_module_get(owner))
> >  		return NULL;
> >  	kobj =3D kobject_get_unless_zero(&p->kobj);
> >  	if (!kobj)
>=20
> I wouldn't mind that, if that logics in try_module_get() was inlined.
> It isn't...

I don't understand what you intend to say here. What is "that"? Are you
talking about

	owner && !try_module_get(owner)

vs

	!try_module_get(owner)

or the following line with kobject_get_unless_zero? Do you doubt the
validity of my patch, or is it about something try_module_get()
could/should do more than it currently does?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qf5kc5bqy2ce2zac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUuUFEACgkQj4D7WH0S
/k5J8wf/U6ztkvUGlgmbMOhDFtQxTecM1daemwfE40sVEGvLXuZmHjf01lia2R1b
XfqE5gCQ/yOUmFyh2eT9RyvJv4XBAZvGiji7uTHIsYagWAqRA1tYItTEP8quAkae
Hhd9EAtK9T6MOnzdTlASbtK2VotUoZRuARxQbfvnkGOBm7cP+upmwSv7Z75hD38g
bkQIqrINo15UUcHBJJmqYjY0G0Jh7l/Q1wOdwhaMZt/yPoi2do7eYqCJ2mIh45S2
LvUQQ1n0zA/CtGk9V09/ox0//8swWQF8xWLw4DbdBv+Ps/pWr8MCNdEp0W4sFo5z
yiR96DK5WyA3uTPcXa7nowAimPsOvw==
=ropI
-----END PGP SIGNATURE-----

--qf5kc5bqy2ce2zac--

