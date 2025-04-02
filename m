Return-Path: <linux-fsdevel+bounces-45555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AABBA7966A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 22:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD463B1D7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B573A1EFFA9;
	Wed,  2 Apr 2025 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko34/DTy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB7CB674;
	Wed,  2 Apr 2025 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743625227; cv=none; b=bMVRbrFqYsM+RgJa6kGof81mXoRQelbzlp7ftsi2l928uwzm9D2Ku+Usg38T+KPYZXbyYXZG33sASMMo2f7tw0jWfTSjCs8zttW4h5Dw3j5+1pfjeqEX5fAFRTh8oBwN+OE+uFupSbkEtnkuuYnmxmiu15FlV7NlrfOouKf3yB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743625227; c=relaxed/simple;
	bh=aAf9EiurP4BTs1kUMrfMfUSUEXaWAvP/8DPVkccSzAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gd6r1tM4ERpapY/2apYgl6y3TRIOyvgUtpWgbnFfHBoSKGhDfzTZelmN7rEyLd2pkK7T8moIgoWbaKG6foH6sFAl3p9i8zCSwKwzpY7yqn4LyWuB5cEg0YbI+uXa0N2y8C+lF2RooTydQaw3G0IXPVOqSItzAZyN/+U7lc/FTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko34/DTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BFCC4CEDD;
	Wed,  2 Apr 2025 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743625226;
	bh=aAf9EiurP4BTs1kUMrfMfUSUEXaWAvP/8DPVkccSzAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ko34/DTys88M2Y66+NU+vzWl171FIbjjDh5mMrrGF492smjaZ1+nypemTWHcY9OZ9
	 JCS8bxmljKQimEr9z0Olb7ysnCQCk5dFiw8Wgl2Ue8u72OQzLvbeM6N9M1/v77S75V
	 Gjfx3m1KW93msqNLPrtL0Bk7wfMWUUaZWMDiwWA180hL+p/3zSX+bpZP6nDWoMCI9+
	 aj2ZLwxinmV8yZ62/A3zUDLXYhaxP3wtKFz6UXho7/ZXZK/BQyVh7pCb32BFsQts0r
	 QL4lq9fLKdLB5TSHHrBg0XK7rYrR0Qy8KGXTad9Rj+mkiCMDDRRy9RCbv/g/6bVpqZ
	 MXgW21fE2ZgKg==
Date: Wed, 2 Apr 2025 22:20:22 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fanotify: Document mount namespace events
Message-ID: <6gjqzfp252aiv6jqsw4tv2gbz7r6cjuiitkv4uzucpl2eotw3s@fmwqa26bjaco>
References: <20250401194629.1535477-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d7a6civljid6vvx7"
Content-Disposition: inline
In-Reply-To: <20250401194629.1535477-1-amir73il@gmail.com>


--d7a6civljid6vvx7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fanotify: Document mount namespace events
References: <20250401194629.1535477-1-amir73il@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20250401194629.1535477-1-amir73il@gmail.com>

Hi Amir,

On Tue, Apr 01, 2025 at 09:46:29PM +0200, Amir Goldstein wrote:
> Used to subscribe for notifications for when mounts
> are attached/detached from a mount namespace.
>=20
> Cc: Jan Kara <jack@suse.cz>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>=20
> Changes since v1:
> - Add RVB
> - Add reference to statx() unique mnt_id (Jan)
> - Fix description of MARK_MNTNS path (Miklos)
>=20
>  man/man2/fanotify_init.2 | 20 ++++++++++++++++++
>  man/man2/fanotify_mark.2 | 35 +++++++++++++++++++++++++++++++-
>  man/man7/fanotify.7      | 44 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 98 insertions(+), 1 deletion(-)
>=20
> diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> index 699b6f054..26289c496 100644
> --- a/man/man2/fanotify_init.2
> +++ b/man/man2/fanotify_init.2
> @@ -330,6 +330,26 @@ that the directory entry is referring to.
>  This is a synonym for
>  .RB ( FAN_REPORT_DFID_NAME | FAN_REPORT_FID | FAN_REPORT_TARGET_FID ).
>  .TP
> +.BR FAN_REPORT_MNT " (since Linux 6.14)"
> +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> +This value allows the receipt of events which contain additional informa=
tion
> +about the underlying mount correlated to an event.
> +An additional record of type
> +.B FAN_EVENT_INFO_TYPE_MNT
> +encapsulates the information about the mount and is included alongside t=
he
> +generic event metadata structure.
> +The use of
> +.BR FAN_CLASS_CONTENT ,
> +.BR FAN_CLASS_PRE_CONTENT,
> +or any of the
> +.B FAN_REPORT_DFID_NAME_TARGET

What do you mean by any of the flags?  Is _NAME_ a placeholder?  If so,
the placeholder should be in italics:

	.BI FOO_ placeholder _BAR

> +flags along with this flag is not permitted
> +and will result in the error
> +.BR EINVAL .
> +See
> +.BR fanotify (7)
> +for additional details.
> +.TP
>  .BR FAN_REPORT_PIDFD " (since Linux 5.15 and 5.10.220)"
>  .\" commit af579beb666aefb17e9a335c12c788c92932baf1
>  Events for fanotify groups initialized with this flag will contain
> diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
> index da569279b..dab7e1a32 100644
> --- a/man/man2/fanotify_mark.2
> +++ b/man/man2/fanotify_mark.2
> @@ -67,7 +67,8 @@ contains
>  all marks for filesystems are removed from the group.
>  Otherwise, all marks for directories and files are removed.
>  No flag other than, and at most one of, the flags
> -.B FAN_MARK_MOUNT
> +.BR FAN_MARK_MNTNS ,
> +.BR FAN_MARK_MOUNT ,
>  or
>  .B FAN_MARK_FILESYSTEM
>  can be used in conjunction with
> @@ -99,6 +100,20 @@ If the filesystem object to be marked is not a direct=
ory, the error
>  .B ENOTDIR
>  shall be raised.
>  .TP
> +.BR FAN_MARK_MNTNS " (since Linux 6.14)"
> +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> +Mark the mount namespace specified by
> +.IR pathname .
> +If the
> +.I pathname
> +is not a path that represents a mount namespace (e.g.
> +.BR /proc/ pid /ns/mnt ),

Paths should be in italics, not bold.

	.IR /proc/ pid /ns/mnt ),

> +the call fails with the error
> +.BR EINVAL .
> +An fanotify group that is initialized with flag

The fanotify group must have been initialized previously, I assume.  If
so, I think we should say s/is/have been/.  Or maybe s/is/was/.

> +.B FAN_REPORT_MNT
> +is required.
> +.TP
>  .B FAN_MARK_MOUNT
>  Mark the mount specified by
>  .IR pathname .
> @@ -395,6 +410,24 @@ Create an event when a marked file or directory itse=
lf has been moved.
>  An fanotify group that identifies filesystem objects by file handles
>  is required.
>  .TP
> +.BR FAN_MNT_ATTACH ", " FAN_MNT_DETACH " (since Linux 6.14)"

Let's use two separate tags.  We can do like sched_setattr(2):


            SCHED_FLAG_UTIL_CLAMP_MIN
            SCHED_FLAG_UTIL_CLAMP_MAX (both since Linux 5.3)
                   These flags  indicate  that  the  sched_util_min  or
                   sched_util_max  fields,  respectively,  are present,
                   representing the expected minimum and  maximum  uti=E2=
=80=90
                   lization of the thread.

                   The  utilization  attributes  provide  the scheduler
                   with boundaries within which it should schedule  the
                   thread,  potentially informing its decisions regard=E2=
=80=90
                   ing task placement and frequency selection.

This would be coded as:

	.TP
	.B FAN_MNT_ATTACH
	.TQ
	.BR FAN_MNT_DETACH " (both since Linux 6.14)"

> +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> +Create an event when a mount was attached to or detached from a marked m=
ount namespace.

Please don't go past 80 columns in source code.  Here, I'd break after
'event', for example, and maybe also before 'marked'.

> +An attempt to set this flag on an inode, mount or filesystem mark

If I'm reading this correctly, I think you should add a comma after
'mount'.

> +will result in the error
> +.BR EINVAL .
> +An fanotify group that is initialized with flag
> +.B FAN_REPORT_MNT
> +and the mark flag
> +.B FAN_MARK_MNTNS
> +are required.
> +An additional information record of type
> +.B FAN_EVENT_INFO_TYPE_MNT
> +is returned with the event.
> +See
> +.BR fanotify (7)
> +for additional details.
> +.TP
>  .BR FAN_FS_ERROR " (since Linux 5.16, 5.15.154, and 5.10.220)"
>  .\" commit 9709bd548f11a092d124698118013f66e1740f9b
>  Create an event when a filesystem error
> diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> index 77dcb8aa5..a2f766839 100644
> --- a/man/man7/fanotify.7
> +++ b/man/man7/fanotify.7
> @@ -228,6 +228,23 @@ struct fanotify_event_info_pidfd {
>  .EE
>  .in
>  .P
> +In cases where an fanotify group is initialized with
> +.BR FAN_REPORT_MNT ,
> +event listeners should expect to receive the below
> +information record object alongside the generic

I'd break the sentence after 'receive' and before 'alongside'.

> +.I fanotify_event_metadata
> +structure within the read buffer.
> +This structure is defined as follows:
> +.P
> +.in +4n
> +.EX
> +struct fanotify_event_info_mnt {
> +    struct fanotify_event_info_header hdr;
> +    __u64 mnt_id;
> +};
> +.EE
> +.in
> +.P
>  In case of a
>  .B FAN_FS_ERROR
>  event,
> @@ -442,6 +459,12 @@ A file or directory that was opened read-only
>  .RB ( O_RDONLY )
>  was closed.
>  .TP
> +.BR FAN_MNT_ATTACH
> +A mount was attached to mount namespace.
> +.TP
> +.BR FAN_MNT_DETACH
> +A mount was detached from mount namespace.
> +.TP
>  .B FAN_FS_ERROR
>  A filesystem error was detected.
>  .TP
> @@ -540,6 +563,7 @@ The value of this field can be set to one of the foll=
owing:
>  .BR FAN_EVENT_INFO_TYPE_FID ,
>  .BR FAN_EVENT_INFO_TYPE_DFID ,
>  .BR FAN_EVENT_INFO_TYPE_DFID_NAME ,
> +.BR FAN_EVENT_INFO_TYPE_MNT ,
>  .BR FAN_EVENT_INFO_TYPE_ERROR ,
>  .BR FAN_EVENT_INFO_TYPE_RANGE ,
>  or
> @@ -727,6 +751,26 @@ in case of a terminated process, the value will be
>  .BR \-ESRCH .
>  .P
>  The fields of the
> +.I fanotify_event_info_mnt
> +structure are as follows:
> +.TP
> +.I .hdr
> +This is a structure of type
> +.IR fanotify_event_info_header .
> +The
> +.I .info_type
> +field is set to
> +.BR FAN_EVENT_INFO_TYPE_MNT .
> +.TP
> +.I .mnt_id
> +Identifies the mount associated with the event.
> +It is a 64bit unique mount id as the one returned by

s/64bit/64-bit/

> +.BR statx (2)
> +with the
> +.BR STATX_MNT_ID_UNIQUE

s/BR/B/

> +flag.
> +.P
> +The fields of the
>  .I fanotify_event_info_error
>  structure are as follows:
>  .TP

Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>
<https://www.alejandro-colomar.es:8443/>
<http://www.alejandro-colomar.es:8080/>

--d7a6civljid6vvx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmftnAAACgkQ64mZXMKQ
wqn6JhAAmhtLn4kV3TawGRCrDL0917s+Kt3fnYxjPsJy5os5ZXLgAmCfnKz65rBU
6S5YNqC63HyA1rIfH2r112P6OQiqFnuorG8ozWJpfD2z5IR+7/J4EmCfoo9f9Qhw
D+QAA3U2x7AJmAPo5XbO14fUEwfi/0gkteuWodpys/IGmhH/d8RT3/v8Zc9Vm09W
tG1DgKg++riSgFyknwzEWHlwL8QaCw8wfvwIncgjtS0+oC+t63r7HWWgvSQVRQzZ
qmX3wA+ZPZUwpZAkWnh1vSV1L8+ZPjAizftNrAPJXs1Oy7ckqz5mTmLcltrezACU
6nCporwlVPY9T/b0g84QVC71UpYTfy4N22idwnIfqzqUiqD7BE/l4eaxXIEo2rpE
lelifQ/gfjppV5709wD+j8S7FPdWQnpn8DXjQLzF+ZtI/cFHEr5n6/nQyXxdY0V+
IkjwoJkssdT5KHbHSH+qk0NkY++aPvY9CFpTh5hSebmlz+C/inKIeGMBEN2ysOCJ
aKu3eLDH2XIIUEGp/34QziBUrdwhkkuHFJcoYC85HH/dohoCO/QW5X7wvikXoOPj
u0NpagytmAvXYAeGp2RVY08LFwD0rz8XR01gd1lFSxyzoIcdQ+0VJUEj7H+yEn+4
uqMW11/PFEYE9GIbL8HJXVgXj34ZW/TasXQeuNm4j0FN4SEhK6Y=
=qQVp
-----END PGP SIGNATURE-----

--d7a6civljid6vvx7--

