Return-Path: <linux-fsdevel+bounces-2891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C18D7EC33C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 14:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF0A1C20997
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 13:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DFE18B1B;
	Wed, 15 Nov 2023 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrmlXy76"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572F17992
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 13:04:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C9B109
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 05:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700053474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASjpeUJB5mjGnnSvE3V+nI6DjtGoKlE0YAKGN+OViqA=;
	b=KrmlXy76TqXEwfuZOHKQSjIcwooEduCPqfYJABQO3rXz7TR+WnfareeJ0tp/t/tNLz09UP
	EqrU7TtaZ59dvjZ/ga6PKoRWt5rFeb3Hy+3PQ8rCE99TJS4nu/FLO4Q5tj7zcnNCLYLHol
	GSHZ543MDFH8V8j+q9Pvk6RO+p3b9yk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-L5oebJtMMmyTA4byX7W30A-1; Wed, 15 Nov 2023 08:04:31 -0500
X-MC-Unique: L5oebJtMMmyTA4byX7W30A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A1B485A5BD;
	Wed, 15 Nov 2023 13:04:31 +0000 (UTC)
Received: from localhost (unknown [10.39.193.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9F3440C6EB9;
	Wed, 15 Nov 2023 13:04:29 +0000 (UTC)
Date: Wed, 15 Nov 2023 08:04:28 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, mzxreary@0pointer.de,
	gmaglione@redhat.com, hi@alyssa.is
Subject: Re: [PATCH v2] virtiofs: Export filesystem tags through sysfs
Message-ID: <20231115130428.GC301867@fedora>
References: <20231108213333.132599-1-vgoyal@redhat.com>
 <20231109012825.GB1101655@fedora>
 <ZVKvC0F1PSwqrACn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hzifRtHsLTRZAfE+"
Content-Disposition: inline
In-Reply-To: <ZVKvC0F1PSwqrACn@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


--hzifRtHsLTRZAfE+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 06:19:39PM -0500, Vivek Goyal wrote:
> On Thu, Nov 09, 2023 at 09:28:25AM +0800, Stefan Hajnoczi wrote:
> > On Wed, Nov 08, 2023 at 04:33:33PM -0500, Vivek Goyal wrote:
> > > virtiofs filesystem is mounted using a "tag" which is exported by the
> > > virtiofs device. virtiofs driver knows about all the available tags b=
ut
> > > these are not exported to user space.
> > >=20
> > > People have asked these tags to be exported to user space. Most recen=
tly
> > > Lennart Poettering has asked for it as he wants to scan the tags and =
mount
> > > virtiofs automatically in certain cases.
> > >=20
> > > https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
> > >=20
> > > This patch exports tags through sysfs. One tag is associated with each
> > > virtiofs device. A new "tag" file appears under virtiofs device dir.
> > > Actual filesystem tag can be obtained by reading this "tag" file.
> > >=20
> > > For example, if a virtiofs device exports tag "myfs", a new file "tag"
> > > will show up here. Tag has a newline char at the end.
> > >=20
> > > /sys/bus/virtio/devices/virtio<N>/tag
> > >=20
> > > # cat /sys/bus/virtio/devices/virtio<N>/tag
> > > myfs
> > >=20
> > > Note, tag is available at KOBJ_BIND time and not at KOBJ_ADD event ti=
me.
> > >=20
> > > v2:
> > > - Add a newline char at the end in tag file. (Alyssa Ross)
> > > - Add a line in commit logs about tag file being available at KOBJ_BI=
ND
> > >   time and not KOBJ_ADD time.
> > >=20
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  fs/fuse/virtio_fs.c | 34 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > >=20
> > > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > > index 5f1be1da92ce..9f76c9697e6f 100644
> > > --- a/fs/fuse/virtio_fs.c
> > > +++ b/fs/fuse/virtio_fs.c
> > > @@ -107,6 +107,21 @@ static const struct fs_parameter_spec virtio_fs_=
parameters[] =3D {
> > >  	{}
> > >  };
> > > =20
> > > +/* Forward Declarations */
> > > +static void virtio_fs_stop_all_queues(struct virtio_fs *fs);
> > > +
> > > +/* sysfs related */
> > > +static ssize_t tag_show(struct device *dev, struct device_attribute =
*attr,
> > > +			char *buf)
> > > +{
> > > +	struct virtio_device *vdev =3D container_of(dev, struct virtio_devi=
ce,
> > > +						  dev);
> > > +	struct virtio_fs *fs =3D vdev->priv;
> > > +
> > > +	return sysfs_emit(buf, "%s\n", fs->tag);
> > > +}
> > > +static DEVICE_ATTR_RO(tag);
> >=20
> > Is there a race between tag_show() and virtio_fs_remove()?
> > virtio_fs_mutex is not held. I'm thinking of the case where userspace
> > opens the sysfs file and invokes read(2) on one CPU while
> > virtio_fs_remove() runs on another CPU.
>=20
> Hi Stefan,
>=20
> Good point. I started testing it and realized that something else
> is providing mutual exclusion and race does not occur. I added
> an artifial msleep(10 seconds) in tag_show() and removed the device
> and let tag_show() continue, hoping kernel will crash. But that
> did not happen.=20
>=20
> Further investation revealed that device_remove_file() call in=20
> virtio_fs_remove() blocks till tag_show() has finished.
>=20
> I have not looked too deep but my guess is that is is probably
> kernfs_node->kernfs_rwsem which is providing mutual exclusion
> and eliminating this race.
>=20
> So I don't think we need to take virtio_fs_mutex in tag_show().

Nice. That explains why other ->show() functions in the kernel also
don't have much in the way of explicit synchronization.

Thank you!

Stefan

--hzifRtHsLTRZAfE+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVUwdwACgkQnKSrs4Gr
c8hv7wf/bCWie2f+H+HjRJjEEkAEGz/NI3saCXMa0Nwj/aLG9c3oc9+Lqho2iMm3
RJRhIq0UnNTTPiC0Afeqk8bbWQgzhViRP0TVy4izpWT7HKxGcBKLA/f7yisKxPWN
FLsUvWtTm94dxbLWVZWQxFC8FwXm+aV9XH3ilp9iD3fCRQS6zgM15VO0IwuO5SNU
SEngwuk00Tt4Y5HIeQZI6DFRC6w3nIPoxVYWS8Pfk2JIEgPjwhYIz83M6Mc/FzRe
wmGf0N28TmY003wVj643EJZ553+DEpb+wFuTQVoE5FEpyynEHlnnJYKxd36S5VOe
k76R3BmK0HuV3JWbiWQOg4QphgCCxw==
=AyVr
-----END PGP SIGNATURE-----

--hzifRtHsLTRZAfE+--


