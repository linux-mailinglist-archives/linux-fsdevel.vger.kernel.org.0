Return-Path: <linux-fsdevel+bounces-7983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCF082DFE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628381C219CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955391863B;
	Mon, 15 Jan 2024 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ewfr4tYE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7EA18632
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705343394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ag0vJpAxvy1phP8+DiRzay9dH6w6lEOujjJkwdgW3Ms=;
	b=Ewfr4tYEGPJ+c6+E+QeaWaA/m/KISiCO6OGGZ19RgjMPHKNrQRqutkDHCKQtffSU8nGDfo
	bp0nC3B/VqJMxn2jTWiRG3TYF848V0FCvN5jDPTFAvVHRismZwp6Widr4N+rCyPZv2AGzo
	mVGL0HpVdmdNsIYW0oLnJFjkR5RwcBo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-gtPuUKmVNkepiGK9gfrrwA-1; Mon, 15 Jan 2024 13:29:50 -0500
X-MC-Unique: gtPuUKmVNkepiGK9gfrrwA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6C8A185A781;
	Mon, 15 Jan 2024 18:29:49 +0000 (UTC)
Received: from localhost (unknown [10.39.192.194])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 10F5B492BC6;
	Mon, 15 Jan 2024 18:29:48 +0000 (UTC)
Date: Mon, 15 Jan 2024 13:29:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: vgoyal@redhat.com, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] virtio_fs: remove duplicate check if queue is broken
Message-ID: <20240115182944.GA1143584@fedora>
References: <20240115071505.43917-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyER+1Wr1RKIsoXg"
Content-Disposition: inline
In-Reply-To: <20240115071505.43917-1-lirongqing@baidu.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


--oyER+1Wr1RKIsoXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 03:15:05PM +0800, Li RongQing wrote:
> virtqueue_enable_cb() will call virtqueue_poll() which will check if
> queue is broken at beginning, so remove the virtqueue_is_broken() call
>=20
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  fs/fuse/virtio_fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oyER+1Wr1RKIsoXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWleZgACgkQnKSrs4Gr
c8jYHggAhlBI7bzkMxhpKyBi8eW4EuEJcsAowxkBQFjFDSA9QGamf4cLDJnTIfO+
j0DpLOaLXUo+gXvBdw15pdt47xzafnNZnyhP4kVwh2uuL8tTPIUFmEzWPAlz20IN
rpwoZ+q/3mlCVsQdbndpy9azgTng/TF9rtSp7guYNuKiU8xGvncnT8/dxSU9XBrZ
l9Z9tn60P5Q8xqyXvP+LVoUhIuo9RNTBp5fj7UBHZNpM533tMCRRnXJiYFExMkeP
KH2spR6aXa63kibnU2r6N2pEko1//B+NEpKsI9cZBsNPW3K0TfXndb/JMQOmRRnF
09NV9nyh6y3zP3UdYtLU4iX6ug4Lyw==
=YjaL
-----END PGP SIGNATURE-----

--oyER+1Wr1RKIsoXg--


