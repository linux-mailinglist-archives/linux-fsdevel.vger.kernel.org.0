Return-Path: <linux-fsdevel+bounces-2494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1967E6427
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 08:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31511C2096E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97C96AA7;
	Thu,  9 Nov 2023 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Et95KPOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1153469F
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:05:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB38186
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 23:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699513517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ib412gg361UBr3KGxp8suM9D8jIYCTiMjXkQ32rtHi4=;
	b=Et95KPOPomZ3TdbRv5sclxUnJJcoK3nr9mrmosX+nZ39lyz37KN4ONDZz5BOD9A/BEDnP6
	nFZQPPR12YxdBioUpdVF5nOz6dWDBhb5Y0w9/9dKKwQwp6l4qSdc1rm8PxDQmB1hGCmnyY
	W6fpOTdo1f0jvhgbVTWMr7y2Wo1S6DI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338--NJ9VRwwM5KQCsv56K8Lhg-1; Thu, 09 Nov 2023 02:05:13 -0500
X-MC-Unique: -NJ9VRwwM5KQCsv56K8Lhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68D7985A58A;
	Thu,  9 Nov 2023 07:05:13 +0000 (UTC)
Received: from localhost (unknown [10.39.192.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A3EB2166B26;
	Thu,  9 Nov 2023 07:05:12 +0000 (UTC)
Date: Thu, 9 Nov 2023 09:28:25 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	mzxreary@0pointer.de, gmaglione@redhat.com, hi@alyssa.is
Subject: Re: [PATCH v2] virtiofs: Export filesystem tags through sysfs
Message-ID: <20231109012825.GB1101655@fedora>
References: <20231108213333.132599-1-vgoyal@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uYOZS1syTIcNUvXa"
Content-Disposition: inline
In-Reply-To: <20231108213333.132599-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


--uYOZS1syTIcNUvXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 04:33:33PM -0500, Vivek Goyal wrote:
> virtiofs filesystem is mounted using a "tag" which is exported by the
> virtiofs device. virtiofs driver knows about all the available tags but
> these are not exported to user space.
>=20
> People have asked these tags to be exported to user space. Most recently
> Lennart Poettering has asked for it as he wants to scan the tags and mount
> virtiofs automatically in certain cases.
>=20
> https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
>=20
> This patch exports tags through sysfs. One tag is associated with each
> virtiofs device. A new "tag" file appears under virtiofs device dir.
> Actual filesystem tag can be obtained by reading this "tag" file.
>=20
> For example, if a virtiofs device exports tag "myfs", a new file "tag"
> will show up here. Tag has a newline char at the end.
>=20
> /sys/bus/virtio/devices/virtio<N>/tag
>=20
> # cat /sys/bus/virtio/devices/virtio<N>/tag
> myfs
>=20
> Note, tag is available at KOBJ_BIND time and not at KOBJ_ADD event time.
>=20
> v2:
> - Add a newline char at the end in tag file. (Alyssa Ross)
> - Add a line in commit logs about tag file being available at KOBJ_BIND
>   time and not KOBJ_ADD time.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 5f1be1da92ce..9f76c9697e6f 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -107,6 +107,21 @@ static const struct fs_parameter_spec virtio_fs_para=
meters[] =3D {
>  	{}
>  };
> =20
> +/* Forward Declarations */
> +static void virtio_fs_stop_all_queues(struct virtio_fs *fs);
> +
> +/* sysfs related */
> +static ssize_t tag_show(struct device *dev, struct device_attribute *att=
r,
> +			char *buf)
> +{
> +	struct virtio_device *vdev =3D container_of(dev, struct virtio_device,
> +						  dev);
> +	struct virtio_fs *fs =3D vdev->priv;
> +
> +	return sysfs_emit(buf, "%s\n", fs->tag);
> +}
> +static DEVICE_ATTR_RO(tag);

Is there a race between tag_show() and virtio_fs_remove()?
virtio_fs_mutex is not held. I'm thinking of the case where userspace
opens the sysfs file and invokes read(2) on one CPU while
virtio_fs_remove() runs on another CPU.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--uYOZS1syTIcNUvXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVMNbkACgkQnKSrs4Gr
c8giAgf/SVXOUBhXSSZePRtGEIZ/hJ7mXPA0QTDAREXWl0wJHlijwBlWwPHJ6k0F
Oi/AxJ9ypy0EBPn+UNkLUjALdP81XyGN17NgzuXiM+LYnpvUcIGFTyQWthHwOz1k
Bqi4wtp7YRY9BZnWQE0TzlhKqny7of1SX/N0f+86bUTNPe6/ig9cwXt3np3bXdrR
7ijo4CmN/Qa8HxTpyFQFDn0iWX/E9NITAumKMjKgmrLZxvQdyZsI9LGNcKOxzCQm
jyOx1yEDZM2TrZqFwa6E5LI4bXfVlQUb70biKWOyJW3AAe0heZr+q7nim3TO8gkA
cFTwNh4QXCTK+OTFwCS201PF/5hA2Q==
=DP+h
-----END PGP SIGNATURE-----

--uYOZS1syTIcNUvXa--


