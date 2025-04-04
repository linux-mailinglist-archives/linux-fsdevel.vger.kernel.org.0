Return-Path: <linux-fsdevel+bounces-45746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE58A7BA98
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 12:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700AB3B562C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762E11AB6C8;
	Fri,  4 Apr 2025 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXYP1zPz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4219D8B7;
	Fri,  4 Apr 2025 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762079; cv=none; b=uKy6QlL9fiR7RQYIctpQ8/j4PYX6R4dw9AqD1ZqPwWPnva+WELVmNYJ//OS26Ey54qC0nLC/KYFGb7bLUmiXy/f0nL5o/0PbTNyx3o1v4J9VWSMsyj1bjEd7Dd1hxMUVmqoA7DcJAVLbmR67q/AkYBFStqaezAU92ocXBoCW4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762079; c=relaxed/simple;
	bh=XQt8eIVqv+Q06AlV7asbsPZVuoUnLefv21PDw0t3Zho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsJZfyzwD7aLHCK6eUgZNSpJ+7VBBjlhJYpj6LDSig835EBl02WbaB+lg68DVUSpTIewyzBourL1GpCAbYnLQAlE2QQAR3EuW4aFDOJUs8q1OrKcGsmZXyuqhZFeWWYOxcX3FZLXJTpSvnTggu7QnHbaPVmMV9BUQxuUWg1E28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXYP1zPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5495C4CEDD;
	Fri,  4 Apr 2025 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743762077;
	bh=XQt8eIVqv+Q06AlV7asbsPZVuoUnLefv21PDw0t3Zho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXYP1zPzvjrm87YdaZ7lJiHYyBC1QkTzTNocCG4WC/oIsKydmh5yDD+Tdlretk65t
	 vDr9xr4f4JWfYrrAlr7bz+a0UETlZAAF1meN/PZm31190cWWa4/an/H3nZa4mT1iJT
	 Z8+C+1UmP5YeJLooWO8EqnserKCEHypH8dyToqMBmDkiJewVV5jriaKQBfFQjDigP2
	 hYKEENbd4JDJqfIyaZakOFtgZ7hVXMG5oiy6ydbUSQyYl4CRKYH329/tcR8U1lGipq
	 MUvBuE1ppiVO8yEcqG8DSywVbKLl0BjNZa6JnQ0pG4RyDSCZxMUaGHz5BjSCOxDO7h
	 g5ybKRq0Iksng==
Date: Fri, 4 Apr 2025 12:21:13 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fanotify: Document mount namespace events
Message-ID: <wrrbbdfca6j7bxbtyghf56cjjgwir6slf25s2amha7uxp3zgxc@6jicin3vldaw>
References: <20250404075624.1700284-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xc75cfsa7xwbutvq"
Content-Disposition: inline
In-Reply-To: <20250404075624.1700284-1-amir73il@gmail.com>


--xc75cfsa7xwbutvq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fanotify: Document mount namespace events
References: <20250404075624.1700284-1-amir73il@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20250404075624.1700284-1-amir73il@gmail.com>

Hi Amir,

On Fri, Apr 04, 2025 at 09:56:24AM +0200, Amir Goldstein wrote:
> Used to subscribe for notifications for when mounts
> are attached/detached from a mount namespace.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

The patches don't apply, and there are so many that I lost track of in
which order I should apply them.  Could you please rebase everything you
have on top of current master, and resend everything in the order in
which I should apply?  Sorry for the inconveniences!


Have a lovely day!
Alex

>=20
> Changes since v2:
> - Added more RVB
> - Formatting review fixes
>=20
>  man/man2/fanotify_init.2 | 20 ++++++++++++++++++
>  man/man2/fanotify_mark.2 | 37 ++++++++++++++++++++++++++++++++-
>  man/man7/fanotify.7      | 45 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 101 insertions(+), 1 deletion(-)
>=20
> diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> index b90e91707..93887b875 100644
> --- a/man/man2/fanotify_init.2
> +++ b/man/man2/fanotify_init.2
> @@ -331,6 +331,26 @@ that the directory entry is referring to.
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
> index a6d80ad68..2c9d6e9b9 100644
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
> +.IR /proc/ pid /ns/mnt ),
> +the call fails with the error
> +.BR EINVAL .
> +An fanotify group that was initialized with flag
> +.B FAN_REPORT_MNT
> +is required.
> +.TP
>  .B FAN_MARK_MOUNT
>  Mark the mount specified by
>  .IR path .
> @@ -395,6 +410,26 @@ Create an event when a marked file or directory itse=
lf has been moved.
>  An fanotify group that identifies filesystem objects by file handles
>  is required.
>  .TP
> +.B FAN_MNT_ATTACH
> +.TQ
> +.BR FAN_MNT_DETACH " (both since Linux 6.14)"
> +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> +Create an event when a mount was attached to or detached from a marked m=
ount namespace, respectively.
> +An attempt to set this flag on an inode, mount, or filesystem mark
> +will result in the error
> +.BR EINVAL .
> +An fanotify group that was initialized with flag
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
> index 68e930930..de0ea8e55 100644
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
> @@ -540,6 +563,8 @@ The value of this field can be set to one of the foll=
owing.
>  .B FAN_EVENT_INFO_TYPE_ERROR
>  .TQ
>  .B FAN_EVENT_INFO_TYPE_RANGE
> +.TQ
> +.B FAN_EVENT_INFO_TYPE_MNT
>  .RE
>  .IP
>  The value set for this field
> @@ -725,6 +750,26 @@ in case of a terminated process, the value will be
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
> +It is a 64-bit unique mount id as the one returned by
> +.BR statx (2)
> +with the
> +.B STATX_MNT_ID_UNIQUE
> +flag.
> +.P
> +The fields of the
>  .I fanotify_event_info_error
>  structure are as follows:
>  .TP
> --=20
> 2.34.1
>=20

--=20
<https://www.alejandro-colomar.es/>
<https://www.alejandro-colomar.es:8443/>
<http://www.alejandro-colomar.es:8080/>

--xc75cfsa7xwbutvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmfvspMACgkQ64mZXMKQ
wqmlEQ//dm+cmRmOTFhBSds6nroeLRBGi7ETJbd+OtE1PTPAAjLtQ3IBoN9UYpDy
a2qanhZVPxYdye2GquA2OufiJpo3mymMhtxfYJgDaCHcku4ru3cWLZKM1FsAUBbY
/AMLYdCUDid7BSp8g3grNPTJqmB6wxVtHhzSaE/+/eStnLxDhfaP4HvavPxyTyLT
yp/aotFsyZazwNjhoD1Do/Mxuwy/Ik+Majl81u5+JgaYCzBnwLul8P5QzDbPfgUE
Vn3jHwLLHU90Qyn8F3ju+b+uJ4AStXyb0VJEXvzcKUTrkjyxLfb1FxHDV6zg3vAb
TJb6zZ7w3lfDpj4m+M8CM4QP/gOXLZmOzMPvfvoDr/EUhZnUfavKdHR50kiC7D4K
G8zQUtSj5xQJNsZtUp1JBTItjxAbOOX/Lgtt2VCXpDknPX/l7Z7pCUJPTD9F9W1m
Bl10uALaZLfGY7HsifoJI2GkHzgIxcY765GlNTMiDr6IyG75D4zwMuCZgFWobyiN
L8wvxYW+ytFjZ43WwaV1NQjP8Pe9CFqO7lj3rgz4yYZhyDH+Hy2xuNIXVlncsFoc
2vi7tqC4fPxJW1LD3JKeAq+m+OJJ5BYpEVhdYGynDscBUY+wnlCjtUIu4Lyv3p/k
HJFupqSdW6+j3JPP83qeqrLyVQJR3yV5c4q7p31OPwHQ9SnZPq4=
=Urw2
-----END PGP SIGNATURE-----

--xc75cfsa7xwbutvq--

