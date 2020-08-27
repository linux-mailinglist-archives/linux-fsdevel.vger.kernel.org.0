Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4372549B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgH0PmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgH0PmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:42:06 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AD3C061264;
        Thu, 27 Aug 2020 08:41:59 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Bcn5t3dKJzQl8P;
        Thu, 27 Aug 2020 17:41:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id OOd35QMJSPWg; Thu, 27 Aug 2020 17:41:50 +0200 (CEST)
Date:   Fri, 28 Aug 2020 01:41:39 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v8 1/2] Add a "nosymfollow" mount option.
Message-ID: <20200827154139.vwuflrlvj257krnw@yavin.dot.cyphar.com>
References: <20200819164317.637421-1-zwisler@google.com>
 <20200826204819.GA4414@google.com>
 <20200827015940.GY1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ylgwp663kchqyfqy"
Content-Disposition: inline
In-Reply-To: <20200827015940.GY1236603@ZenIV.linux.org.uk>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -7.65 / 15.00 / 15.00
X-Rspamd-Queue-Id: EB1AD179E
X-Rspamd-UID: d7ba09
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ylgwp663kchqyfqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-27, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Aug 26, 2020 at 02:48:19PM -0600, Ross Zwisler wrote:
>=20
> > Al, now that the changes to fs/namei.c have landed and we're past the m=
erge
> > window for v5.9, what are your thoughts on this patch and the associate=
d test?
>=20
> Humm...  should that be nd->path.mnt->mnt_flags or link->mnt->mnt_flags?
> Usually it's the same thing, but they might differ.  IOW, is that about t=
he
> directory we'd found it in, or is it about the link itself?

Now that you mention it, I think link->mnt->mnt_flags makes more sense.
The restriction should apply in the context of whatever filesystem
contains the symlink, and that would matches FreeBSD's semantics (at
least as far as I can tell from a quick look at sys/kern/vfs_lookup.c).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ylgwp663kchqyfqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCX0fULwAKCRCdlLljIbnQ
EnZCAP4+fXAsTWkSGZi6M5GB5CszbuzshNh586bsaZW11vQU7QEArCC+2bjdBmuT
jArxG3CPumBoXcAHgAJquKQGdsh50wM=
=NnGT
-----END PGP SIGNATURE-----

--ylgwp663kchqyfqy--
