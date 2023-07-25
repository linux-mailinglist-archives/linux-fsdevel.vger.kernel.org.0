Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEFD761F9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 18:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjGYQxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 12:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjGYQwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:52:50 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF04212C;
        Tue, 25 Jul 2023 09:52:28 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4R9NMl0vV4z9sT1;
        Tue, 25 Jul 2023 18:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1690303875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oXu7I2w2GulAbsjkAbhBaZ0d5Ez9Ymu2aocx4QCikLk=;
        b=kSmWzfYu0h5RiTQdQhuOq6it0MoOiZSf3kDgxT/+cq1LY2gaqgps8UYFoHqeIEJZu3gl3Y
        6NfO6pwEzKCD/FvCRHx/mqdIegvQ/xl7XBtbCWyNeZKkLoJYNVo2fbFaa337PF09aPHP6s
        Pl0K38zR38aZQ86S1uv2GiAEqLJIYLuc9RjcsgJwCXiQ911NIuvw8DS1OGefalEOwy3G4n
        KQ6maBX4klVBvsIqPSP4EVbp/eKJmPJVCbjW7W/CHYeRncxiKGHJavwOxVN7JsO5FrBQZc
        nb3oLM1e0fdNJTRxem86wTiDhq20paUp4CP7Y3BaHa+ddyDai81fX7CP4bOPqg==
Date:   Wed, 26 Jul 2023 02:50:50 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        James.Bottomley@hansenpartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        fenghua.yu@intel.com, fweimer@redhat.com, geert@linux-m68k.org,
        glebfm@altlinux.org, gor@linux.ibm.com, hare@suse.com,
        hpa@zytor.com, ink@jurassic.park.msu.ru, jhogan@kernel.org,
        kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, namhyung@kernel.org,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: Add fchmodat2() - or add a more general syscall?
Message-ID: <u7lakye7ikvyu6g2ktxbzixt5hnvqtzt5s4g72j74tgg4bwlpu@7pcqd4ah5tah>
References: <cover.1689092120.git.legion@kernel.org>
 <cover.1689074739.git.legion@kernel.org>
 <104971.1690300714@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sqz3gv5iaglclup7"
Content-Disposition: inline
In-Reply-To: <104971.1690300714@warthog.procyon.org.uk>
X-Rspamd-Queue-Id: 4R9NMl0vV4z9sT1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--sqz3gv5iaglclup7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-25, David Howells <dhowells@redhat.com> wrote:
> Rather than adding a fchmodat2() syscall, should we add a "set_file_attrs=
()"
> syscall that takes a mask and allows you to set a bunch of stuff all in o=
ne
> go?  Basically, an interface to notify_change() in the kernel that would =
allow
> several stats to be set atomically.  This might be of particular interest=
 to
> network filesystems.

Presumably looking something like statx(2) (except hopefully with
extensible structs this time :P)? I think that could also be useful, but
given this is a fairly straight-forward syscall addition (and it also
would resolve the AT_EMPTY_PATH issue for chmod as well as simplify the
glibc wrapper), I think it makes sense to take this and we can do
set_statx(2) separately?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--sqz3gv5iaglclup7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZL/9agAKCRAol/rSt+lE
b9muAP9aP2TUmAAHS6rOFH9Gf6v2e1/S/NcOkGphCidcAt2ZiwEAzjtee/kbCs2+
akroOcjwVI11LFf34VRyguX0zOzOWQ4=
=pGFN
-----END PGP SIGNATURE-----

--sqz3gv5iaglclup7--
