Return-Path: <linux-fsdevel+bounces-74688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IA3FX3Hb2mgMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:20:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD34F49572
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1EE156D84B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1113318EE1;
	Tue, 20 Jan 2026 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPlXKkYF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4627D318EC2;
	Tue, 20 Jan 2026 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924689; cv=none; b=ZCx+m8qI9LTFyEN/DHWjqJ0sZ742aWTtwYOb+JaJAoNe7+WLtZZy/iQUV9LAX77tYr5fhu/QxK6q6zyUN0qAYGoRcoZ4MwYeEbq03WA5sJ/kLikz61V41OXlRfT/nUJ0O7gfHZxUgU19iJiY9xISY6Rt0gZk4xQrccLW2G275nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924689; c=relaxed/simple;
	bh=AhstODG38bdyDyLiCc8mj/cuBgvBpuc6n6lZANC27Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pStXJ/XFf3vUkNsOkhDb8xvO67t22KWfH9xOEZXe6DYXy/u6EHgdWblpnHHVAB2uLYopVnkppGhntYkrOXDgfMXCFucJjsTs6/1McTBVMLN26LHymnr8hOGPQIjs0327Mbv6ge2GwpKY0X6fm2nyibyo5u4fIsOTRCZaqRclVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPlXKkYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F13DC16AAE;
	Tue, 20 Jan 2026 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768924689;
	bh=AhstODG38bdyDyLiCc8mj/cuBgvBpuc6n6lZANC27Sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPlXKkYF4Emk7naxVuwIZ7j/DKi2pRUrP0dFkD3gf/WIoKGcLHfFO/mS+fx5wD/P1
	 8KzeyYzjMbHtU7yG5du3wlVZBlydtD2vOSCkfsuPacOB3sm2zDhNZ0ehP3uQawXH/4
	 KLCyQ9j6VHJQJ4B/BvjB+QMnhgKLpH4I9g5LTolB5+iQRBJBGemcGEmsCAjVCQcW4l
	 INx/2o9fW2XDz5QmFDOWAiHZ1kI80Zq0Pm4MLkH2TI1BU7p/SdlKANfjPpFbEilmtj
	 8mEX+PjZ9VvaFNKOEDY1DZ6peNuhCzrgpuWMHGP1BMm1hLJeuU3T06N3JJ90GX+DQn
	 EDM4uX4gqLU3g==
Date: Tue, 20 Jan 2026 16:58:06 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man2const/F_[SG]ETDELEG.2const, man/man2/fcntl.2:
 Document F_SETDELEG and F_GETDELEG
Message-ID: <aW-k3ml5kwHnLkM7@devuan>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <5b283a25dbe2ab9ed78719c132885d9d3157f2bb.1768750908.git.alx@kernel.org>
 <a0916b361406fa52771cf3dd507521fa1cc31d7c.camel@kernel.org>
 <aW-awBnQ6RU8o19b@devuan>
 <1fa92006626f975663c53d903d363e260c0c7ae1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xry7a2t2pjbffvny"
Content-Disposition: inline
In-Reply-To: <1fa92006626f975663c53d903d363e260c0c7ae1.camel@kernel.org>
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74688-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alx@kernel.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,alejandro-colomar.es:url]
X-Rspamd-Queue-Id: AD34F49572
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--xry7a2t2pjbffvny
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man2const/F_[SG]ETDELEG.2const, man/man2/fcntl.2:
 Document F_SETDELEG and F_GETDELEG
Message-ID: <aW-k3ml5kwHnLkM7@devuan>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <5b283a25dbe2ab9ed78719c132885d9d3157f2bb.1768750908.git.alx@kernel.org>
 <a0916b361406fa52771cf3dd507521fa1cc31d7c.camel@kernel.org>
 <aW-awBnQ6RU8o19b@devuan>
 <1fa92006626f975663c53d903d363e260c0c7ae1.camel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1fa92006626f975663c53d903d363e260c0c7ae1.camel@kernel.org>

Hi Jeff,

On Tue, Jan 20, 2026 at 10:30:00AM -0500, Jeff Layton wrote:
> > > > +.SH NOTES
> > > > +Delegations were designed to implement NFSv4 delegations for the L=
inux NFS server.
> >=20
> > Do we have a link to the NFSv4 specification of delegations?  It could
> > be useful, I think.  What do you think?
> >=20
> > [...]
> >=20
>=20
> RFC8881 is the NFSv4.1 spec, and that's what defines them. The
> description is spread out all over the document however. Section 10.2
> probably has the best basic description. It's not exactly succinct
> though.

Ahh, ok.  Then I guess I'll say

	... to implement NFSv4 (RFC 8881) delegations ...

That should be enough for the reader to know where to find the spec if
needed.


I'll tweak that and push this evening.  Thank you!


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--xry7a2t2pjbffvny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmlvpggACgkQ64mZXMKQ
wqnPrQ/9EOnzvGm6dHjOnyISGp5igEK3khcvn+WbxaeuRT7xwEfWRm9eahgMzspz
l45UZ55Jm89exrpetnGLfDpXIk5eHtT4OupuHbH/d24YX26M56KHlrPNO2vjK6i4
YUnTIhxFBL7cp3/ZrM7I8LSZXLpIlf1Fd4SKds4aGT6GVFSkcpA9CTgp44/pPod3
q6Z/xKYbYUPboRiIfvhhKthTDynW9QapHJ34n0QBq9Pqwjpk4rmvw6NHkbkj0x2m
But80kObHcm3vHjEPSqZWZX1Qi1Rm9NubpT5wNxUzMWsq9srAWPxpKfrzbw2yEYk
z//TtraSGWeAnAncUNKfJAoBCbAkTy/etxGKUWUTd0+nyCHjx5fstM4THdVGEVRY
ZiMwtHPqaivnDjSnbYL9naft61zLP1CIaRy3QiVAkZTmlyv681SNJBaEeuJvFnVa
G3klmVVqjVyQq4VAhGC7qI8CvI5LsyZv+MSQ5BW96RsjkdkTyVXQa4PjlPaFU3/Y
IHks4FvX3041giqK9PAhSJ10xuKEQUGKp/t/iJUjFWp5x7320CEadLpaKI3cDh8a
bjZbSpxCB1KJRnZhuQ25nrS+G4IbbbBJrqjxiAUKk202ac6IE/UYEQQtH452d2UT
HpUdAke5npw5V5IoHsMw8poxdhDKiOx7sK36o5AhEaRkmblu3Gk=
=pTpc
-----END PGP SIGNATURE-----

--xry7a2t2pjbffvny--

