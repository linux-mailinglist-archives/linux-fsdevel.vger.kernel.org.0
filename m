Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80041414C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 00:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgAQXPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 18:15:13 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:56462 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgAQXPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:15:13 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 47zxjp0568zKmMr;
        Sat, 18 Jan 2020 00:15:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id ZU5ubjiWgZHp; Sat, 18 Jan 2020 00:15:06 +0100 (CET)
Date:   Sat, 18 Jan 2020 10:14:48 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: Re: [PATCH v8 2/3] pid: Introduce pidfd_getfd syscall
Message-ID: <20200117231448.btck3qzepvtz5lcp@yavin>
References: <20200103162928.5271-1-sargun@sargun.me>
 <20200103162928.5271-3-sargun@sargun.me>
 <20200117230602.GA31944@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qclidy4gbrtvcf5h"
Content-Disposition: inline
In-Reply-To: <20200117230602.GA31944@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--qclidy4gbrtvcf5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-17, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Jan 03, 2020 at 08:29:27AM -0800, Sargun Dhillon wrote:
> > +SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
> > +		unsigned int, flags)
> > +{
> > +	struct pid *pid;
> > +	struct fd f;
> > +	int ret;
> > +
> > +	/* flags is currently unused - make sure it's unset */
> > +	if (flags)
> > +		return -EINVAL;
>=20
> Is EINVAL the right errno here?  Often we use ENOSYS for bad flags to
> syscalls.

I don't think that's right -- every syscall I've seen gives you -EINVAL
for invalid flags (not to mention -ENOSYS would mean userspace would be
confused as to whether the syscall is actually supported by the kernel).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--qclidy4gbrtvcf5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXiI/4QAKCRCdlLljIbnQ
EsZ4AP4r48SZU+VGb0kNxiTIYaI9vcaP9MHT16G7vRJU0mdV3gD5AVigsJnWLW0m
gZGhf7y0bY18y31c5t2ijCRxidRHWAQ=
=mswC
-----END PGP SIGNATURE-----

--qclidy4gbrtvcf5h--
