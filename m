Return-Path: <linux-fsdevel+bounces-2781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8927E91D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 18:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E03280C65
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD05E1548F;
	Sun, 12 Nov 2023 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV+NgaTy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FFC1548E
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 17:43:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF33259D
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 09:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699811026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yENEZ4zAUn1toySI3djc9GlB3SXIGA1Y6s0caf4Yvwo=;
	b=LV+NgaTyijfcGMwQvkdjlyYbPdKSGGGNWbfx4eDYQ0YyFyLwOjCaInyuJpE5QEy86IxXH0
	U1TzjDaFG/Kuht3Ai2iNw9pOn5cxWAzDUcNaVbj3002Dn/2FH2KNXOsLZS/Lal3fQZJI1N
	oPSTfW8FYg2nbkq6YGIQEIjS8RA3oGc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-XY0N8ty8OuiKwn8ncUwK7g-1; Sun, 12 Nov 2023 12:43:43 -0500
X-MC-Unique: XY0N8ty8OuiKwn8ncUwK7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B16C85A58A;
	Sun, 12 Nov 2023 17:43:43 +0000 (UTC)
Received: from localhost (unknown [10.39.192.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E963E502A;
	Sun, 12 Nov 2023 17:43:42 +0000 (UTC)
Date: Sun, 12 Nov 2023 18:10:41 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
	virtio-fs@lists.linux.dev, miklos@szeredi.hu, mzxreary@0pointer.de,
	gmaglione@redhat.com
Subject: Re: [PATCH] virtiofs: Export filesystem tags through sysfs
Message-ID: <20231112101041.GB207186@fedora>
References: <20231005203030.223489-1-vgoyal@redhat.com>
 <zdor636rec2ni6oxuic3x55khtr4bkcpqazu3xjdhvlbemsylr@pwjyz2qfa4mm>
 <ZUv56DRM/aiBRspd@redhat.com>
 <87r0ky538y.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UMvxPYDDsHjt+o/o"
Content-Disposition: inline
In-Reply-To: <87r0ky538y.fsf@alyssa.is>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


--UMvxPYDDsHjt+o/o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 04:57:01PM +0100, Alyssa Ross wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
>=20
> > On Sat, Oct 21, 2023 at 04:10:21PM +0000, Alyssa Ross wrote:
> >> Are you still thinking about exposing this in the uevent as well?
> >> That would be much more convenient for me, because with this approach
> >> by the time the "remove" uevent arrives, it's no longer possible to
> >> check what tag was associated with the device =E2=80=94 you have to st=
ore it
> >> somewhere when the device appears, so you can look it up again when the
> >> device is removed.  (Not everybody uses udev.)
> >
> > Looks like systemd + udev combination can already take care of it. I ju=
st
> > had to specify "StopWhenUnneeded=3Dtrue" in my systemd .mount unit file=
=2E And
> > that made sure that when device goes away, virtiofs is unmounted and
> > service is deactivated.
>=20
> My point is that, if it's not exposed in the uevent, the tag information
> has to be tracked somehow.  systemd/udev may do that already, but every
> other system people might be using (mine uses mdevd) also has to track
> that state.  Whereas if the uevent did contain that information,
> userspace would be able to do the unmount directly, without needing to
> look up some information it has previously saved.
>=20
> Relying on tracking state from previous events also introduces potential
> reliability problems =E2=80=94 it's possible to miss uevents if the netli=
nk
> queue fills up.  Suppose I have a system where virtiofs filesystems
> should always be unmounted when the device goes away.  I miss the uevent
> for the device being added, the user mounts the filesystem anyway, and
> then when the device removal uevent comes in, unless that uevent
> contains the filesystem tag, I'm not going to know which filesystem to
> unmount.

I agree that it's hard for userspace to react when a virtiofs device is
removed. Looking at the Linux device remove code, it appears the sysfs
attr is already gone when the UNBIND event is emitted.

My naive idea as a sysfs newbie is that the driver's ->remove() should
be able to produce an envp[] argument to the later kobject_uevent_env()
call. This would allow the driver to pass additional information to
userspace. Then the virtiofs driver could include the tag string in the
UNBIND event.

I'm a bit surprised that this functionality doesn't already exist. Maybe
there is another way of solving this?

(A different approach that feels wrong is to leave the "tag" attr on the
virtio device and just make sure it gets cleaned up when the virtio bus
driver removes the device kobj. That way unbind udev rules could
continue to use the sysfs attr.)

Stefan

>=20
> > Following is my mount unit file.
> >
> > $ cat /etc/systemd/system/mnt-virtiofs.mount
> >
> > [Unit]
> > Description=3DVirtiofs mount myfs
> > DefaultDependencies=3Dno
> > ConditionPathExists=3D/mnt/virtiofs
> > ConditionCapability=3DCAP_SYS_ADMIN
> > Before=3Dsysinit.target
> > StopWhenUnneeded=3Dtrue=20
> >
> > [Mount]
> > What=3Dmyfs
> > Where=3D/mnt/virtiofs
> > Type=3Dvirtiofs
> >
> > And following is the udev rule I used.
> >
> > $ cat /etc/udev/rules.d/80-local.rules
> > SUBSYSTEM=3D=3D"virtio", DRIVER=3D=3D"virtiofs", ATTR{tag}=3D=3D"myfs",=
 TAG+=3D"systemd", ENV{SYSTEMD_WANTS}+=3D"mnt-virtiofs.mount"
> >
> > And a combination of above two seems to work. virtiofs is automatically
> > mounted when device is hotplugged and it is unmounted when device is
> > hot unplugged.



--UMvxPYDDsHjt+o/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVQpKEACgkQnKSrs4Gr
c8iK/gf9Ejk0LkI1EvOy9u0bNsLKRo/6etF91Qdnk9uWMXO0ujX9RZXn6JIGZG8A
/ci7wS57tVCvodkA966rhwVfhZCVQLZCzt85OEXMjOOBz0EnozXrBRPn0UWTvb3b
dV8DzPi/Xx9hybcIpEiWLvPueoBhtuuErtlhZdom0M+ZIB0UZyj8d1x1KkPklOEo
yW6sfPyNzmBXv3CfcDcRRRxmXCeaA+RkrTec7k+ytPlOAbuE6Y3FMxl7/hzyWeaF
ZXwLPhEgrpa1qKSn4yu2J6vgT02Ypyyc4IuZLoTSeWsMi0aPRJeLYs/YTqVXdPbg
AF+0+RgtAQ9QjOve7n+fl1j9yXKkWA==
=l+RU
-----END PGP SIGNATURE-----

--UMvxPYDDsHjt+o/o--


