Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E39DD17DE98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 12:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCILUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 07:20:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25212 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726383AbgCILUO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583752813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGKDlp64eqfw82x0A9BrgwM+zay7edpF8+9+SYb3/QU=;
        b=EXFYZ501jewc97K1XGgAP0xDnjKLRU8CarIkoWZJh540IL5lwtmfkftDwL+9YHMqq8PGey
        RzqQHsCXFC4r80+uMLntIQ1DgZ32twmcH+7zW4xkm5i2VnxG9OW9XT4bih5YNRnHDvrDNb
        65FKLOx4B/cH3Hmhk7Y/u5x5EDLeswI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-JXVcC7B1M5udn93owMfY9g-1; Mon, 09 Mar 2020 07:20:11 -0400
X-MC-Unique: JXVcC7B1M5udn93owMfY9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E786DB22;
        Mon,  9 Mar 2020 11:20:10 +0000 (UTC)
Received: from localhost (unknown [10.36.118.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FD588F354;
        Mon,  9 Mar 2020 11:20:04 +0000 (UTC)
Date:   Mon, 9 Mar 2020 11:20:03 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Liu Bo <bo.liu@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        mszeredi@redhat.com, vgoyal@redhat.com
Subject: Re: [Virtio-fs] [PATCH] fuse: make written data persistent after
 writing
Message-ID: <20200309112003.GF7668@stefanha-x1.localdomain>
References: <1583270111-76859-1-git-send-email-bo.liu@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1583270111-76859-1-git-send-email-bo.liu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 05:15:11AM +0800, Liu Bo wrote:
> If this is a DSYNC write, make sure we push it to stable storage now
> that we've written data.
>=20
> Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> ---
> This patch is based on 5.5-rc5.
>=20
>  fs/fuse/file.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5mJmMACgkQnKSrs4Gr
c8gF4wf/dq14AeiyjEeDwv785+ZycspoYOw1vPEcBu0sLtwsTAGG78PiPS4SUfuX
4mWTo4V8Cn0KzWTyMaWjCeYw0YMeju5BjTqzWZHByGr97iNbKI+LK4PloiheePDZ
Lbn5gGL5qhvFRSWj7Fani87PeO9dpI1MQL6m/NmEeHZ1UMbNyS1d4Qb9rWhIkSub
iomsvrHL1Ub2qw/K7NkG6Jtoz9P/UE+Herr/U0nAIVCBIPSjZ+Zvf1uavc72ygkF
7mfG6wxXf0ZrRDVdaiRKxgCKxchVRIh0zCWqTrrCrk5aoWUZQ5aPzV2pG8obDvT5
FMaFXxWFmVezO2rIeBpH7vbU/ydlUg==
=ePRU
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--

