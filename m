Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29341105647
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 17:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUQAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 11:00:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46627 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbfKUQAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574352015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FaPLEQrdTtUL2Ob9GHzV8gvblPJ9sIr1fQNhRCiAn7Q=;
        b=Rx8caGED5rS97nC++zXG0pZh3YBYgV18Uyft/kjCcjs0rT3FDxI5dAyJE0ttxJjb5ZPoqB
        vzNcJsvzeBd7sS2UV5Kln3vJ9UemirHfsRvaMKLlLyKLAD2e785oeaeet4vTvgQgWOrEto
        qwgh5VKNsxOycyO3zViVswerMDZ9mew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-Jp2VdSAyNJmSVgtfRmHTdw-1; Thu, 21 Nov 2019 11:00:12 -0500
X-MC-Unique: Jp2VdSAyNJmSVgtfRmHTdw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29DA49B3A8;
        Thu, 21 Nov 2019 16:00:11 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B833E1081303;
        Thu, 21 Nov 2019 16:00:03 +0000 (UTC)
Date:   Thu, 21 Nov 2019 16:00:01 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dgilbert@redhat.com,
        miklos@szeredi.hu
Subject: Re: [PATCH 2/4] virtiofs: Add an index to keep track of first
 request queue
Message-ID: <20191121160001.GC445244@stefanha-x1.localdomain>
References: <20191115205705.2046-1-vgoyal@redhat.com>
 <20191115205705.2046-3-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191115205705.2046-3-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 03:57:03PM -0500, Vivek Goyal wrote:
> @@ -1004,6 +1008,7 @@ __releases(fiq->lock)
>  =09spin_unlock(&fiq->lock);
> =20
>  =09fs =3D fiq->priv;
> +=09queue_id =3D fs->first_reqq_idx;

The TODO should be moved here.

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WtIEACgkQnKSrs4Gr
c8gp1wf9FsjNknItwwiYqgaMkCFsD/lJY+7ZWvz25GCPp4aHChGQMvg/GBxEXbUs
d2n5sxD4UcV/wmUt3amPMondoXmfLu//QOg0X5+ftyWLbVK7Tq0rO+hPkysOeP+6
2svIACl5UtYuzU3SxRS5nY3CGZ3/HxLKgJyLVhorSNXacI6ijRHZLnLDEqXU/90o
GCVuxTJfvf8UMQ42KSjwmCM+hyWb9HlNj/NoSZ63K8Zq6Y41N45bx+36k9J8LIlQ
UaFITc5HT6wWTHN0tVJxRQVsV5ZEBx1lauzDLxKCsD47+AJOMDhX/5mbVkndJZS/
xuPiSOtg8Is+zto/rTm+wN9K4/gEAw==
=Cosk
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--

