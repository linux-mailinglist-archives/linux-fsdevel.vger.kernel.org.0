Return-Path: <linux-fsdevel+bounces-55914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1190B0FDCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 01:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29CE548422
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 23:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A9627380A;
	Wed, 23 Jul 2025 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="xs3esqA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0E215055;
	Wed, 23 Jul 2025 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753314932; cv=none; b=XX8+a/WXI/dm/Waj+FS0Bw6Zzs8y0YMUlLqiHRfr95Xqu7Taaqes9QnNqhEd8Pfrngbma+gUqdfdELwXzJsA2OVwEWYnG73wTG0QcONJZNlRP7GVyJzdtPasrSo2d/OhVbYJ/wKS9v2dDdgeP7+HgpQEPuRBKhZV1+PtLBZkmdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753314932; c=relaxed/simple;
	bh=5Rkl6QkujiSWyv84mlJ0xwNtng60dAwf1DJAIOq9JbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4kuGg0cqSm3bmR5xYI+coSvNd8ENj7ClrLuegZTO6F+r4Bq1/vWwwwTpvqklRtGigspjVLV3ctj4DZm6N6hiM4DWAIRJtsI8MO41XhiXOL5emwbyeVhzUikK+ycGealUnDIFhMuayL9noJrEn2H/O7XTeiZTDdiI7dayPsGmKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=xs3esqA+; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bnWGc3P5sz9ssw;
	Thu, 24 Jul 2025 01:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753314920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adkKVU2xcTSCol5IeKbXbR2OHCXr05cLR6HT03bl1E8=;
	b=xs3esqA+LbZikdpw0S1ONQQsAJpNNRItL+NhgVpCCBvSmDJvo/Cghe6Ldn7FVrH4QfegqY
	WVs4QBukb5HrYTE+wN+kxmukZtaZZ/2sW8qkJ3WdRZdNYrfev7vK0U++E/MBdqhihbm6Im
	+MVV2PH24WP0dXnROYRAEKP3BZh9kyrNSLHr0bxovByxKvi6VQhEvLT9SY2/n3ZmSwP0ga
	g4D1mwDAJmqPPsseQTW0y4HRbBOPAib55PK33Vlhti+otkyCg+AIKt5McnHdSKYYYybwQ8
	uAStCNBzUXyziMmWl4KfxBv3Ca6PEsdz6zEfjMZt41XtaG/B+gs4QJpzQvU6FQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 24 Jul 2025 09:55:05 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] procfs: make reference pidns more user-visible
Message-ID: <2025-07-23.1753314869-silly-creamer-crushed-cabana-proper-jury-FaB28g@cyphar.com>
References: <20250721-procfs-pidns-api-v1-0-5cd9007e512d@cyphar.com>
 <CALCETrVo+Mdj7as2R0R+FqTBbjqwTkXu5Zkj=dg8EVM9xRhBPw@mail.gmail.com>
 <20250721.150803-lavish.ninja.rigid.racism-OCjeOw80sO9@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i6lgalhwjitwn6se"
Content-Disposition: inline
In-Reply-To: <20250721.150803-lavish.ninja.rigid.racism-OCjeOw80sO9@cyphar.com>
X-Rspamd-Queue-Id: 4bnWGc3P5sz9ssw


--i6lgalhwjitwn6se
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 0/4] procfs: make reference pidns more user-visible
MIME-Version: 1.0

On 2025-07-22, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2025-07-21, Andy Lutomirski <luto@amacapital.net> wrote:
> > On Mon, Jul 21, 2025 at 1:44=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com=
> wrote:
> > >
> > > Ever since the introduction of pid namespaces, procfs has had very
> > > implicit behaviour surrounding them (the pidns used by a procfs mount=
 is
> > > auto-selected based on the mounting process's active pidns, and the
> > > pidns itself is basically hidden once the mount has been constructed).
> > > This has historically meant that userspace was required to do some
> > > special dances in order to configure the pidns of a procfs mount as
> > > desired. Examples include:
> > >
> > >  * In order to bypass the mnt_too_revealing() check, Kubernetes creat=
es
> > >    a procfs mount from an empty pidns so that user namespaced contain=
ers
> > >    can be nested (without this, the nested containers would fail to
> > >    mount procfs). But this requires forking off a helper process beca=
use
> > >    you cannot just one-shot this using mount(2).
> > >
> > >  * Container runtimes in general need to fork into a container before
> > >    configuring its mounts, which can lead to security issues in the c=
ase
> > >    of shared-pidns containers (a privileged process in the pidns can
> > >    interact with your container runtime process). While
> > >    SUID_DUMP_DISABLE and user namespaces make this less of an issue, =
the
> > >    strict need for this due to a minor uAPI wart is kind of unfortuna=
te.
> > >
> > > Things would be much easier if there was a way for userspace to just
> > > specify the pidns they want. Patch 1 implements a new "pidns" argument
> > > which can be set using fsconfig(2):
> > >
> > >     fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
> > >     fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid=
", 0);
> > >
> > > or classic mount(2) / mount(8):
> > >
> > >     // mount -t proc -o pidns=3D/proc/self/ns/pid proc /tmp/proc
> > >     mount("proc", "/tmp/proc", "proc", MS_..., "pidns=3D/proc/self/ns=
/pid");
> > >
> > > The initial security model I have in this RFC is to be as conservative
> > > as possible and just mirror the security model for setns(2) -- which
> > > means that you can only set pidns=3D... to pid namespaces that your
> > > current pid namespace is a direct ancestor of. This fulfils the
> > > requirements of container runtimes, but I suspect that this may be too
> > > strict for some usecases.
> > >
> > > The pidns argument is not displayed in mountinfo -- it's not clear to=
 me
> > > what value it would make sense to show (maybe we could just use ns_dn=
ame
> > > to provide an identifier for the namespace, but this number would be
> > > fairly useless to userspace). I'm open to suggestions.
> > >
> > > In addition, being able to figure out what pid namespace is being used
> > > by a procfs mount is quite useful when you have an administrative
> > > process (such as a container runtime) which wants to figure out the
> > > correct way of mapping PIDs between its own namespace and the namespa=
ce
> > > for procfs (using NS_GET_{PID,TGID}_{IN,FROM}_PIDNS). There are
> > > alternative ways to do this, but they all rely on ancillary informati=
on
> > > that third-party libraries and tools do not necessarily have access t=
o.
> > >
> > > To make this easier, add a new ioctl (PROCFS_GET_PID_NAMESPACE) which
> > > can be used to get a reference to the pidns that a procfs is using.
> > >
> > > It's not quite clear what is the correct security model for this API,
> > > but the current approach I've taken is to:
> > >
> > >  * Make the ioctl only valid on the root (meaning that a process with=
out
> > >    access to the procfs root -- such as only having an fd to a procfs
> > >    file or some open_tree(2)-like subset -- cannot use this API).
> > >
> > >  * Require that the process requesting either has access to
> > >    /proc/1/ns/pid anyway (i.e. has ptrace-read access to the pidns
> > >    pid1), has CAP_SYS_ADMIN access to the pidns (i.e. has administrat=
ive
> > >    access to it and can join it if they had a handle), or is in a pid=
ns
> > >    that is a direct ancestor of the target pidns (i.e. all of the pids
> > >    are already visible in the procfs for the current process's pidns).
> >=20
> > What's the motivation for the ptrace-read option?  While I don't see
> > an attack off the top of my head, it seems like creating a procfs
> > mount may give write-ish access to things in the pidns (because the
> > creator is likely to have CAP_DAC_OVERRIDE, etc) and possibly even
> > access to namespace-wide things that aren't inherently visible to
> > PID1.
>=20
> This latter section is about the privilege model for
> ioctl(PROCFS_GET_PID_NAMESPACE), not the pidns=3D mount flag. pidns=3D
> requires CAP_SYS_ADMIN for pidns->user_ns, in addition to the same
> restrictions as pidns_install() (must be a direct ancestor). Maybe I
> should add some headers in this cover letter for v2...
>=20
> For the ioctl -- if the user can ptrace-read pid1 in the pidns, they can
> open a handle to /proc/1/ns/pid which is exactly the same thing they'd
> get from PROCFS_GET_PID_NAMESPACE.
>=20
> > Even the ancestor check seems dicey.  Imagine that uid 1000 makes an
> > unprivileged container complete with a userns.  Then uid 1001 (outside
> > the container) makes its own userns and mountns but stays in the init
> > pidns and then mounts (and owns, with all filesystem-related
> > capabilities) that mount.  Is this really safe?
>=20
> As for the ancestor check (for the ioctl), the logic I had was that
> being in an ancestor pidns means that you already can see all of the
> subprocesses in your own pidns, so it seems strange to not be able to
> get a handle to their pidns. Maybe this isn't quite right, idk.
>=20
> Ultimately there isn't too much you can do with a pidns fd if you don't
> have privileges to join it (the only thing I can think of is that you
> could bind-mount it, which could maybe be used to trick an
> administrative process if they trusted your mountns for some reason).
>=20
> > CAP_SYS_ADMIN seems about right.
>=20
> For pidns=3D, sure. For the ioctl, I think this is overkill.

My bad, I forgot to add you to Cc for v2 Andy. PTAL:

 <https://lore.kernel.org/all/20250723-procfs-pidns-api-v2-0-621e7edd8e40@c=
yphar.com/>

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--i6lgalhwjitwn6se
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaIF2WQAKCRAol/rSt+lE
byrQAQDSb5GrHSNEL0F882yj0V9aT+2idljnDmsMGNvtV4Yb8QD+PnGyDg9rgG4f
NMqT6s5tlpun08MU8faoFumIO4Nhrw4=
=ZeKP
-----END PGP SIGNATURE-----

--i6lgalhwjitwn6se--

