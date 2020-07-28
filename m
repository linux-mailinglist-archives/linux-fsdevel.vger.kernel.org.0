Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989CA2306DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 11:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgG1Jrc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 05:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgG1Jrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:47:32 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jul 2020 02:47:32 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24775C061794;
        Tue, 28 Jul 2020 02:47:32 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4BGBWj2tvzzQlKZ;
        Tue, 28 Jul 2020 11:41:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id mL45Y320Mr-I; Tue, 28 Jul 2020 11:41:17 +0200 (CEST)
Date:   Tue, 28 Jul 2020 19:41:09 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        linux-pm@vger.kernel.org
Subject: Re: [RFC][PATCH] exec: Freeze the other threads during a
 multi-threaded exec
Message-ID: <20200728092359.jrv7ygt6dwktwsgp@yavin.dot.cyphar.com>
References: <87h7tsllgw.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ifgp4clg667prhsz"
Content-Disposition: inline
In-Reply-To: <87h7tsllgw.fsf@x220.int.ebiederm.org>
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -4.89 / 15.00 / 15.00
X-Rspamd-Queue-Id: E1EE11837
X-Rspamd-UID: 106a35
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ifgp4clg667prhsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-27, Eric W. Biederman <ebiederm@xmission.com> wrote:
> To the best of my knowledge processes with more than one thread
> calling exec are not common, and as all of the threads will be killed
> by exec there does not appear to be any useful work a thread can
> reliably do during exec.

Every Go program which calls exec (this includes runc, Docker, LXD,
Kubernetes, et al) fills the niche of "multi-threaded program that calls
exec" -- all Go programs are multi-threaded and there's no way of
disabling this. This will most likely cause pretty bad performance
regression for basically all container workloads.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ifgp4clg667prhsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXx/ysgAKCRCdlLljIbnQ
EkKKAQDoy8ZD4VcTpwNYsy7hTgaSyJYCrr3BEVWWGgivWDOsTAD/YSG2mqdY6Xxb
/MSwhLo3kjae0B+Zbr6HVENFaTzZjgc=
=1hzK
-----END PGP SIGNATURE-----

--ifgp4clg667prhsz--
