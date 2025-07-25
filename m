Return-Path: <linux-fsdevel+bounces-55999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22854B1163E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 04:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A208D7B7117
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3B3210F65;
	Fri, 25 Jul 2025 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="0aomYNVx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987C613B58B;
	Fri, 25 Jul 2025 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753409609; cv=none; b=iqz1CKrMgj7OCequXypMo5u9xu3+moyLgZ5T3jvmDBiOW3bwaDlxcn/nmXLdwRxItu8SQ+OvjmCv5zOXf3AXhEecaAX2z2RgC6IVsEwCdbttYCzaGdE4CfJlPXODDrJ8eKhYPFuZWOmP6hYpw8hqOyqkKpqkwRn15po+KQqNwqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753409609; c=relaxed/simple;
	bh=E1s2up6hfgesBwyxr9XiIA3NTVEOck0F1Suyauc0Ju4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGKwR7LsFavqpGnDK+X1uXrxk1xsqLtUoGfu67N9MIyIit3eBhNoDIrDqCcBzWNzrtPurYIQgSb8XaR3tNZeDrZiL+BKZ18IYxC37MPOv7ItUZCcWfYLJZZxspVYTtHalaNIfeplyXKD3FcbsSLPYU+K3SueIMFCnPUNTtjg8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=0aomYNVx; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bpBHL38Xbz9sSs;
	Fri, 25 Jul 2025 04:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753409598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PbqJc5y9mQaYNYaiR3kWnI5AcKmau8ioADlnL1uolvs=;
	b=0aomYNVxPiZhQAnzoqXShauikSav4VMZJnQitL18BBSw505r5tum7Rpi+qkVNlU7/wCiUm
	ahkdnVnWKYrViVluO/GO4BsPuHlN/W+8Ly9QDWZywJYDLYPF04DJv2ZTECrQQcTObMkDYq
	kWHmameBCD6SAdJjZYD5Eye7bEeL3ItMNNCctZVkka69xz4mcJUh0fqQjcMCAbVZMqw2Jm
	aYA3QhH54BofIvsnw7hda+uugRLCqv8dias9aiTGTIEFg0RYm7BP2kw1/RKibMs5T5rpR2
	gLlIQFsDAdaCUt3lcnXrWmGos7es3BhBGg273XXFeWTBucz9bXCiV2yZ92kL7A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Fri, 25 Jul 2025 12:13:03 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/4] procfs: add "pidns" mount option
Message-ID: <2025-07-24.1753364886-sleek-serves-calm-fiat-canned-carnivals-jmzVpR@cyphar.com>
References: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
 <20250723-procfs-pidns-api-v2-2-621e7edd8e40@cyphar.com>
 <20250724-ammoniak-gepinselt-6dd6255c2368@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vpew4s6fgwoaddcn"
Content-Disposition: inline
In-Reply-To: <20250724-ammoniak-gepinselt-6dd6255c2368@brauner>
X-Rspamd-Queue-Id: 4bpBHL38Xbz9sSs


--vpew4s6fgwoaddcn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v2 2/4] procfs: add "pidns" mount option
MIME-Version: 1.0

On 2025-07-24, Christian Brauner <brauner@kernel.org> wrote:
> On Wed, Jul 23, 2025 at 09:18:52AM +1000, Aleksa Sarai wrote:
> > Since the introduction of pid namespaces, their interaction with procfs
> > has been entirely implicit in ways that require a lot of dancing around
> > by programs that need to construct sandboxes with different PID
> > namespaces.
> >=20
> > Being able to explicitly specify the pid namespace to use when
> > constructing a procfs super block will allow programs to no longer need
> > to fork off a process which does then does unshare(2) / setns(2) and
> > forks again in order to construct a procfs in a pidns.
> >=20
> > So, provide a "pidns" mount option which allows such users to just
> > explicitly state which pid namespace they want that procfs instance to
> > use. This interface can be used with fsconfig(2) either with a file
> > descriptor or a path:
> >=20
> >   fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
> >   fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid", 0=
);
>=20
> Fwiw, namespace mount options could just be VFS generic mount options.
> But it's not something that we need to solve right now.

Yeah if we add this to sysfs it probably should be made generic, but
let's punt this to later. :D

> > or with classic mount(2) / mount(8):
> >=20
> >   // mount -t proc -o pidns=3D/proc/self/ns/pid proc /tmp/proc
> >   mount("proc", "/tmp/proc", "proc", MS_..., "pidns=3D/proc/self/ns/pid=
");
> >=20
> > As this new API is effectively shorthand for setns(2) followed by
> > mount(2), the permission model for this mirrors pidns_install() to avoid
> > opening up new attack surfaces by loosening the existing permission
> > model.
> >=20
> > Note that the mount infrastructure also allows userspace to reconfigure
> > the pidns of an existing procfs mount, which may or may not be useful to
> > some users.
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  Documentation/filesystems/proc.rst |  6 +++
> >  fs/proc/root.c                     | 90 ++++++++++++++++++++++++++++++=
+++++---
> >  2 files changed, 90 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesys=
tems/proc.rst
> > index 5236cb52e357..c520b9f8a3fd 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -2360,6 +2360,7 @@ The following mount options are supported:
> >  	hidepid=3D	Set /proc/<pid>/ access mode.
> >  	gid=3D		Set the group authorized to learn processes information.
> >  	subset=3D		Show only the specified subset of procfs.
> > +	pidns=3D		Specify a the namespace used by this procfs.
> >  	=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  hidepid=3Doff or hidepid=3D0 means classic mode - everybody may access=
 all
> > @@ -2392,6 +2393,11 @@ information about processes information, just ad=
d identd to this group.
> >  subset=3Dpid hides all top level files and directories in the procfs t=
hat
> >  are not related to tasks.
> > =20
> > +pidns=3D specifies a pid namespace (either as a string path to somethi=
ng like
> > +`/proc/$pid/ns/pid`, or a file descriptor when using `FSCONFIG_SET_FD`=
) that
> > +will be used by the procfs instance when translating pids. By default,=
 procfs
> > +will use the calling process's active pid namespace.
> > +
> >  Chapter 5: Filesystem behavior
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > =20
> > diff --git a/fs/proc/root.c b/fs/proc/root.c
> > index ed86ac710384..057c8a125c6e 100644
> > --- a/fs/proc/root.c
> > +++ b/fs/proc/root.c
> > @@ -38,12 +38,18 @@ enum proc_param {
> >  	Opt_gid,
> >  	Opt_hidepid,
> >  	Opt_subset,
> > +#ifdef CONFIG_PID_NS
> > +	Opt_pidns,
> > +#endif
> >  };
> > =20
> >  static const struct fs_parameter_spec proc_fs_parameters[] =3D {
> > -	fsparam_u32("gid",	Opt_gid),
> > +	fsparam_u32("gid",		Opt_gid),
> >  	fsparam_string("hidepid",	Opt_hidepid),
> >  	fsparam_string("subset",	Opt_subset),
> > +#ifdef CONFIG_PID_NS
> > +	fsparam_file_or_string("pidns",	Opt_pidns),
> > +#endif
> >  	{}
> >  };
> > =20
> > @@ -109,11 +115,67 @@ static int proc_parse_subset_param(struct fs_cont=
ext *fc, char *value)
> >  	return 0;
> >  }
> > =20
> > +#ifdef CONFIG_PID_NS
> > +static int proc_parse_pidns_param(struct fs_context *fc,
> > +				  struct fs_parameter *param,
> > +				  struct fs_parse_result *result)
> > +{
> > +	struct proc_fs_context *ctx =3D fc->fs_private;
> > +	struct pid_namespace *target, *active =3D task_active_pid_ns(current);
> > +	struct ns_common *ns;
> > +	struct file *ns_filp __free(fput) =3D NULL;
> > +
> > +	switch (param->type) {
> > +	case fs_value_is_file:
> > +		/* came throug fsconfig, steal the file reference */
> > +		ns_filp =3D param->file;
> > +		param->file =3D NULL;
>=20
> This can be shortened to:
>=20
> ns_filp =3D no_free_ptr(param->file);

I really need to take a closer look at <linux/cleanup.h>, each time I
look at it I learn about another handy helper.

> > +		break;
> > +	case fs_value_is_string:
> > +		ns_filp =3D filp_open(param->string, O_RDONLY, 0);
> > +		break;
> > +	default:
> > +		WARN_ON_ONCE(true);
> > +		break;
> > +	}
> > +	if (!ns_filp)
> > +		ns_filp =3D ERR_PTR(-EBADF);
> > +	if (IS_ERR(ns_filp)) {
> > +		errorfc(fc, "could not get file from pidns argument");
> > +		return PTR_ERR(ns_filp);
> > +	}
> > +
> > +	if (!proc_ns_file(ns_filp))
> > +		return invalfc(fc, "pidns argument is not an nsfs file");
> > +	ns =3D get_proc_ns(file_inode(ns_filp));
> > +	if (ns->ops->type !=3D CLONE_NEWPID)
> > +		return invalfc(fc, "pidns argument is not a pidns file");
> > +	target =3D container_of(ns, struct pid_namespace, ns);
> > +
> > +	/*
> > +	 * pidns=3D is shorthand for joining the pidns to get a fsopen fd, so=
 the
> > +	 * permission model should be the same as pidns_install().
> > +	 */
> > +	if (!ns_capable(target->user_ns, CAP_SYS_ADMIN)) {
> > +		errorfc(fc, "insufficient permissions to set pidns");
> > +		return -EPERM;
> > +	}
> > +	if (!pidns_is_ancestor(target, active))
> > +		return invalfc(fc, "cannot set pidns to non-descendant pidns");
>=20
> This made me think. If one rewrote this as:
>=20
> if (!ns_capable(task_active_pidns(current)->user_ns, CAP_SYS_ADMIN))
>=20
> if (!pidns_is_ancestor(target, active))
>=20
> that would also work, right? IOW, you'd be checking whether you're
> capable over your current pid namespace owning userns and if the target
> pidns is an ancestor it's also implied by the first check that you're
> capable over it.
>=20
> The only way this would not be true is if a descendant pidns would be
> owned by a userns over which you don't hold privileges and I wondered
> whether that's even possible? I don't think it is but maybe you see a
> way.

Well, if you run a setuid binary, it could create a pidns that is a
child but is owned by a more privileged userns than you. My main goal
here was to just mirror pidns_install() exactly, to make sure that the
permission model was identical.

> > +
> > +	put_pid_ns(ctx->pid_ns);
> > +	ctx->pid_ns =3D get_pid_ns(target);
> > +	put_user_ns(fc->user_ns);
> > +	fc->user_ns =3D get_user_ns(ctx->pid_ns->user_ns);
> > +	return 0;
> > +}
> > +#endif /* CONFIG_PID_NS */
> > +
> >  static int proc_parse_param(struct fs_context *fc, struct fs_parameter=
 *param)
> >  {
> >  	struct proc_fs_context *ctx =3D fc->fs_private;
> >  	struct fs_parse_result result;
> > -	int opt;
> > +	int opt, err;
> > =20
> >  	opt =3D fs_parse(fc, proc_fs_parameters, param, &result);
> >  	if (opt < 0)
> > @@ -125,14 +187,24 @@ static int proc_parse_param(struct fs_context *fc=
, struct fs_parameter *param)
> >  		break;
> > =20
> >  	case Opt_hidepid:
> > -		if (proc_parse_hidepid_param(fc, param))
> > -			return -EINVAL;
> > +		err =3D proc_parse_hidepid_param(fc, param);
> > +		if (err)
> > +			return err;
> >  		break;
> > =20
> >  	case Opt_subset:
> > -		if (proc_parse_subset_param(fc, param->string) < 0)
> > -			return -EINVAL;
> > +		err =3D proc_parse_subset_param(fc, param->string);
> > +		if (err)
> > +			return err;
> > +		break;
> > +
> > +#ifdef CONFIG_PID_NS
> > +	case Opt_pidns:
>=20
> I think it would be easier if we returned EOPNOTSUPP when !CONFIG_PID_NS
> instead of EINVALing this?
>=20
> > +		err =3D proc_parse_pidns_param(fc, param, &result);
> > +		if (err)
> > +			return err;
> >  		break;
> > +#endif
> > =20
> >  	default:
> >  		return -EINVAL;
> > @@ -154,6 +226,12 @@ static void proc_apply_options(struct proc_fs_info=
 *fs_info,
> >  		fs_info->hide_pid =3D ctx->hidepid;
> >  	if (ctx->mask & (1 << Opt_subset))
> >  		fs_info->pidonly =3D ctx->pidonly;
> > +#ifdef CONFIG_PID_NS
> > +	if (ctx->mask & (1 << Opt_pidns)) {
> > +		put_pid_ns(fs_info->pid_ns);
> > +		fs_info->pid_ns =3D get_pid_ns(ctx->pid_ns);
> > +	}
> > +#endif
> >  }
> > =20
> >  static int proc_fill_super(struct super_block *s, struct fs_context *f=
c)
> >=20
> > --=20
> > 2.50.0
> >=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--vpew4s6fgwoaddcn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaILoLwAKCRAol/rSt+lE
b25zAQCDF0JaQRm5jAxxXKIbNdVmzJk6u4mw0soZh7GxLzwK+wEAys/DziwhrFR3
DqOGSuKWcHB3shQV5Dhi4QXIgqGKtQ0=
=RgtU
-----END PGP SIGNATURE-----

--vpew4s6fgwoaddcn--

