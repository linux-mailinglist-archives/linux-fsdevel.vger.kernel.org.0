Return-Path: <linux-fsdevel+bounces-45303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC68A75B8E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 19:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D64A7A3AD4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E5E1DC98C;
	Sun, 30 Mar 2025 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImQ5PeWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DA114B08A;
	Sun, 30 Mar 2025 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743357144; cv=none; b=c598Glss5CX9b7zOT+Tqy57CKXhP6H2eEtiGIPaglt29ezudbF2m+DGgbX1ECt4VrJBmM+JgVSAQD8ru0gmhLl17zcZbuligWdeTvBihsCO45Zhhp8z6OgdkaF+TyddrvYFqHx3Rc9MQpkyxQw+RTQrxI5VCalbNf+e9cpnOejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743357144; c=relaxed/simple;
	bh=N2X01LKe53G2Joohd54qU4KslJZY126vBbDToIG86zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYF5Pg/EUdFkpvVHD76l5NTvSf1swtzjGIrY8TUSEO42oX0gxZPBEG6PpqMeQ9i+9oYzEkuazJ6iTCUef2PMoLpewy7rXS6HxDsL8DnQKHpH+0/l4JV2SjAq3bssOeOG/eUf0cUc6zhgyrBTaXmVzDkLPf8cwk4n3/axwpqYFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImQ5PeWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B69C4CEDD;
	Sun, 30 Mar 2025 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743357143;
	bh=N2X01LKe53G2Joohd54qU4KslJZY126vBbDToIG86zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImQ5PeWOsFfcg6Xp/yCO7SABE6KJjH4lmdilvinpwsNgyTmIKnzrjFucVoYCJ4K4j
	 KgCulvFEp7l7qNwAlPYbnckgKdwqV5pcUrTimP94aas1w2Goqc3chjJa0eQhCPHoOs
	 wMGAY++8wy8tX4+Q4ZW49ra3Intb6tPHMIUL372vYxGPAAhnUErINIm89POZ1Gh1em
	 eR7TD27r1KoTECYgJ0xnnQ8CTI9f/yvsuvdYthKB4H1st0ahO/s83K5/iR0tndrV1K
	 nRkf4Ld7HCbEf2BttX0I0EiNC1IB0+8NfaB+qOkFmmZCayZnmGvcs9UtuAd/+eYY6Y
	 NX4g08uU9QAig==
Date: Sun, 30 Mar 2025 19:52:19 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH] fanotify.7: Document extended response to permission
 events
Message-ID: <mwttu4y4pvussz2zug6dlmgioqcfwgqsup3fqhyfa437mi2k2p@bl5orpxlsa4z>
References: <20250330153326.1412509-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7e2ef2uam4my3q3r"
Content-Disposition: inline
In-Reply-To: <20250330153326.1412509-1-amir73il@gmail.com>


--7e2ef2uam4my3q3r
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH] fanotify.7: Document extended response to permission
 events
References: <20250330153326.1412509-1-amir73il@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20250330153326.1412509-1-amir73il@gmail.com>

Hi Amir,

On Sun, Mar 30, 2025 at 05:33:26PM +0200, Amir Goldstein wrote:
> Document FAN_DENY_ERRNO(), that was added in v6.13 and the
> FAN_RESPONSE_INFO_AUDIT_RULE extended response info record
> that was added in v6.3.
>=20
> Cc: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>=20
> Alejandro,
>=20
> I was working on man page updates to fanotify features that landed
> in v6.14 and found a few bits from v6.3 that were out of date, so
> I added them along with this change.
>=20
> If you want me to split them out I can, but I did not see much point.

I prefer them in two patches.  You can send them in the same patch set,
though.

> This change to the documentation of fanotify permission event response
> is independent of the previous patches I posted to document the new
> FAN_PRE_ACCESS event (also v6.14) and the fanotify_init(2) flag
> FAN_REPORT_FD_ERROR (v6.13).
>=20
> There is another fanotify feature in v6.14 (mount events).
> I will try to catch up on documenting that one as well.
>=20
> Thanks,
> Amir.
>=20
>  man/man7/fanotify.7 | 60 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
>=20
> diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> index 6f3a9496e..c7b53901a 100644
> --- a/man/man7/fanotify.7
> +++ b/man/man7/fanotify.7
> @@ -820,7 +820,7 @@ This is the file descriptor from the structure
>  .TP
>  .I response
>  This field indicates whether or not the permission is to be granted.
> -Its value must be either
> +Its value must contain either the flag

This seems unrelated.  Please keep it out of the patches.  If you want
to do it, please have a third trivial patch with "wfix" in the subject.

>  .B FAN_ALLOW
>  to allow the file operation or
>  .B FAN_DENY
> @@ -829,6 +829,24 @@ to deny the file operation.
>  If access is denied, the requesting application call will receive an
>  .B EPERM
>  error.
> +Since Linux 6.14,
> +.\" commit b4b2ff4f61ded819bfa22e50fdec7693f51cbbee
> +if a notification group is initialized with class
> +.BR FAN_CLASS_PRE_CONTENT ,
> +the following error values could be returned to the application
> +by setting the
> +.I response
> +value using the
> +.BR FAN_DENY_ERRNO(err)

This formatting is incorrect.  BR means alternating Bold and Roman, but
this only has one token.

> +macro:
> +.BR EPERM ,
> +.BR EIO ,
> +.BR EBUSY ,
> +.BR ETXTBSY ,
> +.BR EAGAIN ,
> +.BR ENOSPC ,
> +.BR EDQUOT .

Should we have a manual page for FAN_DENY_ERRNO()?  (I think we should.)
I don't understand how it's supposed to work from this paragraph.

> +.P
>  Additionally, if the notification group has been created with the
>  .B FAN_ENABLE_AUDIT
>  flag, then the
> @@ -838,6 +856,46 @@ flag can be set in the
>  field.
>  In that case, the audit subsystem will log information about the access
>  decision to the audit logs.

Do we want to start a new paragraph maybe?

> +Since Linux 6.3,
> +.\" commit 70529a199574c15a40f46b14256633b02ba10ca2
> +the
> +.B FAN_INFO
> +flag can be set in the
> +.I response
> +to indicate that extra variable length response record follows struct

s/variable length/variable-length/

And we usually say 'XXX structure' instead of 'struct XXX'.

> +.IR fanotify_response .

The above sentence is too long.  I'd split it into two:

Since Linux 6.3, the FAN_INFO flag can be set in the response field.  It
indicates that an extra variable-length response record follows the
fanotify_response structure.

> +Extra response records start with a common header:
> +.P
> +.in +4n
> +.EX
> +struct fanotify_response_info_header {
> +    __u8 type;
> +    __u8 pad;
> +    __u16 len;
> +};
> +.EE
> +.in
> +.P
> +The value of
> +.I type

I'd say '.type' instead of 'type'.  I know there's no consistency about
it, but I'm going to globally fix that eventually.  Let's do it good for
new documentation.  The '.' allows one to easily know that we're talking
about a struct or union member.


Have a lovely day!
Alex

> +determines the format of the extra response record.
> +In case the value of
> +.I type
> +is
> +.BR FAN_RESPONSE_INFO_AUDIT_RULE ,
> +the following response record is expected
> +with extra details for the audit log:
> +.P
> +.in +4n
> +.EX
> +struct fanotify_response_info_audit_rule {
> +    struct fanotify_response_info_header hdr;
> +    __u32 rule_number;
> +    __u32 subj_trust;
> +    __u32 obj_trust;
> +};
> +.EE
> +.in
>  .\"
>  .SS Monitoring filesystems for errors
>  A single
> --=20
> 2.34.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--7e2ef2uam4my3q3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmfphMwACgkQ64mZXMKQ
wqnoSQ/+Jh4q6oO2C/n0Ihmihypc71UnGD0rETYjJ1gO4ZJdlxoSobhvKsq36x5n
eNIYbDJfXZ/X90xhuwWXNb9OCu68EHYPDwQQ26MHb5g2gWdzkSewUWcNzO0tb1AD
Wh/Tr+nhaoy7ugyRCAhB6k8Wpi3AWo0Sl7Ah+ih+pWZY+om1rJ1S8SZHGnqMhdkY
Hy3HcTxLTs6Uw5sqc2yQpjVV981kclak8Ds+lT8C+NShkseSTxZNDvsXliGRxq35
AQE6lUOocEN1QNh+gFv4+YWd8SaMI6c2ffcaRMQKfK60IUkM3p9B1M1V58JD3etu
qhufQ6HLP7vTDpIkk2Sbc3z/P60Gy9DhnF+VKRR2xHz/zBW6E63llArAx66WEGfC
kR8N5kn0EChK+bMpsUR100U2n1uqlqEchalNZdq7Q9hLQoMqacR6NaXY0D3YCS05
7XtZBw84wqGEGl/x1zS+Ak1VuA8QD35R67Rdph4CFuoqH+8g3TUOfQ3KX99kBpTt
X2C+7V1wilC9pNKxp+YXAX8htvC8VscXex6RxcUm9ke1OI8mxKTnaG197EfVuqiT
5P9a8+/2gKHkS5qxc5v/0jHLoQb5SoTPzzH2ZIjTs60CdQvgjIprB8qun83qPJXo
nJkedoq850W9mrYzDvG7ABJEZ76i5BvNqj/XD6qvLxfPBbqBSyo=
=fHQE
-----END PGP SIGNATURE-----

--7e2ef2uam4my3q3r--

