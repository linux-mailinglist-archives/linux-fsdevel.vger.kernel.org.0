Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8B53AEA15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 15:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhFUNeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 09:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbhFUNeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624282312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aRbSdl5QweonziFZCzKBkR/5y5FG2MCCkXcMH71sHgk=;
        b=St9Ae59J/lKK3pmwGlsmvo6ho3+SIrNt2fjzEI9C42pf79XIRpACFbpYUoyEOIPHZE0RWm
        49CKXI3071mORXPZUAKfi0+m+ot0tww+Jo3ibsfCQ1zmGTfUJ3JNQJod+Tw+swlIHwjpJJ
        88BMJA4VbcJVAafhbh17lKr9JPDGvRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-AAHeQQqJNoWPyJst2qT77g-1; Mon, 21 Jun 2021 09:31:49 -0400
X-MC-Unique: AAHeQQqJNoWPyJst2qT77g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1A6319057A6;
        Mon, 21 Jun 2021 13:31:47 +0000 (UTC)
Received: from localhost (ovpn-114-233.ams2.redhat.com [10.36.114.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38D2419C46;
        Mon, 21 Jun 2021 13:31:45 +0000 (UTC)
Date:   Mon, 21 Jun 2021 14:31:44 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] support booting of arbitrary non-blockdevice file
 systems v2
Message-ID: <YNCUwHn0zfmDEWBN@stefanha-x1.localdomain>
References: <20210621062657.3641879-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H1YdTb2mTDFGvvnD"
Content-Disposition: inline
In-Reply-To: <20210621062657.3641879-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--H1YdTb2mTDFGvvnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 21, 2021 at 08:26:55AM +0200, Christoph Hellwig wrote:
> Hi all,
>=20
> this series adds support to boot off arbitrary non-blockdevice root file
> systems, based off an earlier patch from Vivek.
>=20
> Chances since v1:
>  - don't try to mount every registered file system if none is specified
>  - fix various null pointer dereferences when certain kernel paramters are
>    not set
>  - general refactoring.
>=20
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://listman.redhat.com/mailman/listinfo/virtio-fs
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--H1YdTb2mTDFGvvnD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDQlMAACgkQnKSrs4Gr
c8ganQf/dsU6iKVjBTVUSkTJmH1WTbSid1kpQaMUGfq7OVc3uPC8blsmfBdRwlqv
e8rCiAH7mdtjXCVYEKB4q7+m9Yf6cKMYnGJ/yd0hgEnSxFEhYhoBWpOdRx/mj5Sy
JP1xUW110BheBPQrdD786/OHo0plrX7mKOvDA6txgn7sMAmrAtVyjd1dmqqbU/Nu
mYEf5YDcrqpmHFk8H9LHjK471p6pWUeDNwe687dnRaxvONAmg2stGXihP9Ycd4PM
avhMfaReTGAzo+ezyOEqtc6YTnKZrmU3TRcIg5MPpfR42yKGOIvazW6lKXpTiUmt
C8FEVeGCoSRA/kNi4zse1bhi4KpeQw==
=XrUf
-----END PGP SIGNATURE-----

--H1YdTb2mTDFGvvnD--

