Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319C6A1A2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 14:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfH2Mfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 08:35:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbfH2Mfa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:35:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79F1A18B3D85;
        Thu, 29 Aug 2019 12:35:30 +0000 (UTC)
Received: from localhost (ovpn-117-104.ams2.redhat.com [10.36.117.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D1B5600C1;
        Thu, 29 Aug 2019 12:35:29 +0000 (UTC)
Date:   Thu, 29 Aug 2019 13:35:28 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual
 machines
Message-ID: <20190829123528.GA18693@stefanha-x1.localdomain>
References: <20190821173742.24574-1-vgoyal@redhat.com>
 <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Thu, 29 Aug 2019 12:35:30 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2019 at 11:28:27AM +0200, Miklos Szeredi wrote:
> On Wed, Aug 21, 2019 at 7:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:

Thanks!

>  - removed option parsing completely.  Virtiofs config is fixed to "-o
> rootmode=040000,user_id=0,group_id=0,allow_other,default_permissions".
> Does this sound reasonable?

That simplifies things for users and I've never seen a need to change
these options in virtio-fs.  If we need the control for some reason in
the future we can add options back in again.

> I think we also need something in
> "Documentation/filesystems/virtiofs.rst" which describes the design
> (how  request gets to userspace and back) and how to set up the
> server, etc...  Stefan, Vivek can you do something like that?

Sure.  I'll send a patch.

Stefan

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1nxpAACgkQnKSrs4Gr
c8jjQwgAvWE4oapn65FxQy/VdB7RtefE3yzw3Eqivc7NYcdOZJxKNpfeU7w5HEgY
QK6WGmXSW7udfIoPEmVO9MLd9G4+sjbewz5OhGKYm8b0rDfGXPTD9JZO75MkvrSO
3nTLOX7Qoe2omYOyCcwQRXqFujBerFwsY22L0+QnubAWgHgHuV4+vgUKc1iJ6PlD
7jDG5W6l0omMY2G7kym4QYr/jk67cRdzUonm3rYTKIy1q0xLzg/XeQta/rvXVfFB
vCx5+Fks5LZ6bO9Sj+SkzyP3etHAQH8dzYXtcuAsZk7clqcuYqGn4NSAHt+AqNFx
1e6kZW2gsPPyUfBAAIDYRkFJ28Dy9g==
=PAGO
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
