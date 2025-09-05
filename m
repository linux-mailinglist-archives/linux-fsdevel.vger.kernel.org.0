Return-Path: <linux-fsdevel+bounces-60364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F6CB45AE9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 16:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31022A4532C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9203728B3;
	Fri,  5 Sep 2025 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="0THawW7w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E490536CDE5;
	Fri,  5 Sep 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083713; cv=none; b=mrQ5PWecnpLb03nyZS2gbFWz30vPWFHd8bfzFmmlJUdBjcMl3P1DM4dghI57QU7JLVsAD0yI7yp5ZqQ8YY0RSalK9zS84VXus3vKpRL6o/d2eYYYjX7LPN9HNwo6DIrRj3/TwDeZxZeNBQNgJgJn3jQAIkl0P36EumM8Z0BXvMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083713; c=relaxed/simple;
	bh=IeuCwHP7fxBMyZnUg7lRAegA+KMiIxaSfVE4kK3bhJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkcykVlyiggWhuhXbWVIl8/2WJP/KESF70iDWybknVmL14MyHbi2jwRmOPD2r1JX7JCcVxqJIf2EfODfYxafOcLBevrS85CqzOIbroltFm2JWz8r1o2BiRJBNyLQ5qWwJYD74m5Dvl5qXkSJaPzKm+fVHM3b2UsbS3L8E8P8Kg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=0THawW7w; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cJK3G0wV2z9spq;
	Fri,  5 Sep 2025 16:48:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1757083706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2yxz7OYC7knSMwqm1/ga1qwzQ1qS/2PhiFrxz5xbnhg=;
	b=0THawW7wLt4yGtJVklnGykWYvtdY8tmFTAYk6XeFDA+dALD0RH0oFkl36NAnq5puArcylf
	3jMlvKTeGHbF28yVP4qN7S4zrKl6yWo8wnAARcZPsylin9gDNCSnIdV0ykR+S4SPJoK8Fq
	02Emfx/ZPuEQalW9jyhYm4OPs4Xrhk1wbjkdl5i8i3hPndBGVjw+0Gj94XJIRQb+yFU2e0
	FQqf2K/6UeL5hdIw1cdYeLMsXupx9uNPzPYvd9EONNfjL+SpSS/03/nzkM1dMbPbXH3Is1
	o7WCb/Bow5ALIIPYd+A9RZ2Laizw2G1waOO3dQG+qcdXoyRzwDRxihdk/9JY1w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Sat, 6 Sep 2025 00:48:13 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/4] procfs: make reference pidns more user-visible
Message-ID: <2025-09-05-kinky-napping-auction-creeks-pbN1Vi@cyphar.com>
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
 <20250902-gehofft-ruheraum-3c286b25b6d3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s6blnnuwdbg65wg3"
Content-Disposition: inline
In-Reply-To: <20250902-gehofft-ruheraum-3c286b25b6d3@brauner>
X-Rspamd-Queue-Id: 4cJK3G0wV2z9spq


--s6blnnuwdbg65wg3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/4] procfs: make reference pidns more user-visible
MIME-Version: 1.0

On 2025-09-02, Christian Brauner <brauner@kernel.org> wrote:
> On Tue, Aug 05, 2025 at 03:45:07PM +1000, Aleksa Sarai wrote:
> > Ever since the introduction of pid namespaces, procfs has had very
> > implicit behaviour surrounding them (the pidns used by a procfs mount is
> > auto-selected based on the mounting process's active pidns, and the
> > pidns itself is basically hidden once the mount has been constructed).
> >=20
> > /* pidns mount option for procfs */
> >=20
> > This implicit behaviour has historically meant that userspace was
> > required to do some special dances in order to configure the pidns of a
> > procfs mount as desired. Examples include:
> >=20
> >  * In order to bypass the mnt_too_revealing() check, Kubernetes creates
> >    a procfs mount from an empty pidns so that user namespaced containers
> >    can be nested (without this, the nested containers would fail to
> >    mount procfs). But this requires forking off a helper process because
> >    you cannot just one-shot this using mount(2).
> >=20
> >  * Container runtimes in general need to fork into a container before
> >    configuring its mounts, which can lead to security issues in the case
> >    of shared-pidns containers (a privileged process in the pidns can
> >    interact with your container runtime process). While
> >    SUID_DUMP_DISABLE and user namespaces make this less of an issue, the
> >    strict need for this due to a minor uAPI wart is kind of unfortunate.
> >=20
> > Things would be much easier if there was a way for userspace to just
> > specify the pidns they want. Patch 1 implements a new "pidns" argument
> > which can be set using fsconfig(2):
> >=20
> >     fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
> >     fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid",=
 0);
> >=20
> > or classic mount(2) / mount(8):
> >=20
> >     // mount -t proc -o pidns=3D/proc/self/ns/pid proc /tmp/proc
> >     mount("proc", "/tmp/proc", "proc", MS_..., "pidns=3D/proc/self/ns/p=
id");
> >=20
> > The initial security model I have in this RFC is to be as conservative
> > as possible and just mirror the security model for setns(2) -- which
> > means that you can only set pidns=3D... to pid namespaces that your
> > current pid namespace is a direct ancestor of and you have CAP_SYS_ADMIN
> > privileges over the pid namespace. This fulfils the requirements of
> > container runtimes, but I suspect that this may be too strict for some
> > usecases.
> >=20
> > The pidns argument is not displayed in mountinfo -- it's not clear to me
> > what value it would make sense to show (maybe we could just use ns_dname
> > to provide an identifier for the namespace, but this number would be
> > fairly useless to userspace). I'm open to suggestions. Note that
> > PROCFS_GET_PID_NAMESPACE (see below) does at least let userspace get
> > information about this outside of mountinfo.
> >=20
> > Note that you cannot change the pidns of an already-created procfs
> > instance. The primary reason is that allowing this to be changed would
> > require RCU-protecting proc_pid_ns(sb) and thus auditing all of
> > fs/proc/* and some of the users in fs/* to make sure they wouldn't UAF
> > the pid namespace. Since creating procfs instances is very cheap, it
> > seems unnecessary to overcomplicate this upfront. Trying to reconfigure
> > procfs this way errors out with -EBUSY.
> >=20
> > /* ioctl(PROCFS_GET_PID_NAMESPACE) */
> >=20
> > In addition, being able to figure out what pid namespace is being used
> > by a procfs mount is quite useful when you have an administrative
> > process (such as a container runtime) which wants to figure out the
> > correct way of mapping PIDs between its own namespace and the namespace
> > for procfs (using NS_GET_{PID,TGID}_{IN,FROM}_PIDNS). There are
> > alternative ways to do this, but they all rely on ancillary information
> > that third-party libraries and tools do not necessarily have access to.
> >=20
> > To make this easier, add a new ioctl (PROCFS_GET_PID_NAMESPACE) which
> > can be used to get a reference to the pidns that a procfs is using.
> >=20
> > Rather than copying the (fairly strict) security model for setns(2),
> > apply a slightly looser model to better match what userspace can already
> > do:
> >=20
> >  * Make the ioctl only valid on the root (meaning that a process without
> >    access to the procfs root -- such as only having an fd to a procfs
> >    file or some open_tree(2)-like subset -- cannot use this API). This
> >    means that the process already has some level of access to the
> >    /proc/$pid directories.
> >=20
> >  * If the calling process is in an ancestor pidns, then they can already
> >    create pidfd for processes inside the pidns, which is morally
> >    equivalent to a pidns file descriptor according to setns(2). So it
> >    seems reasonable to just allow it in this case. (The justification
> >    for this model was suggested by Christian.)
> >=20
> >  * If the process has access to /proc/1/ns/pid already (i.e. has
> >    ptrace-read access to the pidns pid1), then this ioctl is equivalent
> >    to just opening a handle to it that way.
> >=20
> >    Ideally we would check for ptrace-read access against all processes
> >    in the pidns (which is very likely to be true for at least one
> >    process, as SUID_DUMP_DISABLE is cleared on exec(2) and is rarely set
> >    by most programs), but this would obviously not scale.
> >=20
> > I'm open to suggestions for whether we need to make this stricter (or
> > possibly allow more cases).
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>=20
> Thanks for the patchset. Being able to specify what pid namespace the
> procfs instance is supposed to belong to is super useful and will make
> things easier for userspace for sure.

I was going to send a new version changing the whole thing to be struct
path based (and adding FSCONFIG_SET_PATH{,_EMPTY} support) so we don't
need to allocate a file explicitly for the non-FSCONFIG_SET_FD case, but
we can do that as a follow-up I guess.

> The code you added contains a minor wrinkle that I disliked which I've
> changed and you tell me if you can live with this restriction or not.
>=20
> The way you've implemented it specifying a pid namespace that the caller
> holds privilege over would silently also override the user namespace the
> filesystem is supposed to belong to.
>=20
> Specifically, you did something like:
>=20
>         put_pid_ns(ctx->pid_ns);
>         ctx->pid_ns =3D get_pid_ns(target);
>         put_user_ns(fc->user_ns);
>         fc->user_ns =3D get_user_ns(ctx->pid_ns->user_ns);
>=20
> This silently overrides the user namespace recorded at fsopen() time. I
> think that's too subtle and we should just not allow that at all for
> now.
>=20
> Instead I've changed this to:
>=20
>         if (fc->user_ns !=3D target->user_ns)
>                 return invalfc(fc, "owning user namespace of pid namespac=
e doesn't match procfs user namespace");
>=20
>         put_pid_ns(ctx->pid_ns);
>         ctx->pid_ns =3D get_pid_ns(target);
>=20
> so we just refuse different owernship.

That sounds fine, I wasn't quite sure what to do with fc->user_ns to be
honest. Being more conservative is probably the right call here.

> I've also dropped the procfs ioctl because I'm not sure how much value
> it will actually add given that you can do this via /proc/1/ns/pid.
>=20
> If that is something that libpathrs despearately needs I would like to
> do it as a separate patch anyways.

The main issues are:

1. pid1 can often be non-dumpable, which can block you from doing that.
   In principle, because the dumpable flag is reset on execve, it is
   theoretically possible to get access to /proc/$pid/ns/pid if you win
   the race in a pid namespace with lots of process activity, but this
   kind of sucks.

2. This approach doesn't work for empty pid namesapces.
   pidns_for_children doesn't let you get a handle to an empty pid
   namespace either (I briefly looked at the history and it seems this
   was silently changed in v2 of the patchset based on some feedback
   that I'm not sure was entirely correct).

3. Now that you can configure the procfs mount, it seems like a
   half-baked interface to not provide diagnostic information about the
   namespace. (I suspect the criu folks would be happy to have this too
   ;).)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--s6blnnuwdbg65wg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaLr4LRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+mLwD+OBLrKDjD/AagMCzfrvCF
gB1Co3GReX99caLh6G7vUqMA/2ZGF2udlINLu5ajN5rT7zw4nvJfvN+ZrkwDzJ9A
9YwG
=VwoX
-----END PGP SIGNATURE-----

--s6blnnuwdbg65wg3--

