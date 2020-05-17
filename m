Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B0D1D6683
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 10:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgEQIJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 04:09:23 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:39940 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgEQIJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 04:09:23 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 49Pvtn2pqNzQlK8;
        Sun, 17 May 2020 10:09:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id XKHUs3xL-9GD; Sun, 17 May 2020 10:09:17 +0200 (CEST)
Date:   Sun, 17 May 2020 18:09:09 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     fuse-devel@lists.sourceforge.net, miklos <mszeredi@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Determining owner of a (fuse) mountpoint?
Message-ID: <20200517080909.lod7sjfio5jvsjr3@yavin.dot.cyphar.com>
References: <874kshqa1d.fsf@vostro.rath.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vwaa6hi3p5s7sdic"
Content-Disposition: inline
In-Reply-To: <874kshqa1d.fsf@vostro.rath.org>
X-Rspamd-Queue-Id: F3A391756
X-Rspamd-Score: -6.07 / 15.00 / 15.00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--vwaa6hi3p5s7sdic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-15, Nikolaus Rath <Nikolaus@rath.org> wrote:
> Given a (FUSE) mountpoint (potentially mounted without -o allow_root),
> is there a way for root to determine its "owner" (i.e. the user who has
> started the FUSE process and invoked fusermount) that does not depend on
> cooperation of the user/filesystem?

The mount options of a FUSE mount contain the entries "user_id=3DN" and
"group_id=3DM" which correspond to the "mount owner" and those entries are
filled by fusermount. Is that not sufficient?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--vwaa6hi3p5s7sdic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXsDxIgAKCRCdlLljIbnQ
EiCnAP9SisahB3KoNSWWO/WJ3fmXmGuD21wLeuFQHLFUgCQtOwD+PLUDnHAjIjxv
qkt7mrPsZTyldXmYQjnpIC5AgY6UnAM=
=+yaL
-----END PGP SIGNATURE-----

--vwaa6hi3p5s7sdic--
