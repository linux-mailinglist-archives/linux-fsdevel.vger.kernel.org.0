Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83EA56D8A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 03:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfGSB7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 21:59:39 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:55986 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfGSB7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:59:39 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 492A272CA65;
        Fri, 19 Jul 2019 04:59:34 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 3B39E7CC774; Fri, 19 Jul 2019 04:59:34 +0300 (MSK)
Date:   Fri, 19 Jul 2019 04:59:34 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 08/10] open: openat2(2) syscall
Message-ID: <20190719015933.GA18022@altlinux.org>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-9-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20190706145737.5299-9-cyphar@cyphar.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 07, 2019 at 12:57:35AM +1000, Aleksa Sarai wrote:
[...]
> +/**
> + * Arguments for how openat2(2) should open the target path. If @extra i=
s zero,
> + * then openat2(2) is identical to openat(2).
> + *
> + * @flags: O_* flags (unknown flags ignored).

What was the rationale for implementing this semantics?
Ignoring unknown flags makes potential extension of this new interface
problematic.  This has bitten us many times already, so ...

> + * @mode: O_CREAT file mode (ignored otherwise).
> + * @upgrade_mask: restrict how the O_PATH may be re-opened (ignored othe=
rwise).
> + * @resolve: RESOLVE_* flags (-EINVAL on unknown flags).

=2E.. could you consider implementing this (-EINVAL on unknown flags) seman=
tics
for @flags as well, please?


--=20
ldv

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJdMSQFAAoJEAVFT+BVnCUIuaAP/3pgUoQA466F6S8jYN6F/icf
oiQHExdeO3ruxRdNl1gi7af0RxQCiprfNIoD7KQyWSnyUyUm0Cdd7PzpEKXuumQi
pN6ZTEO2bQeSs7AjCNpLrTgKcuOo/pZbNN7InAHKLB7k2xKKeBbdaVypgGiAEDjT
JK+4s+8JcJoSg+d69G428QP2qpoHyIZJ5437gYv5rJbL9BRihwwvWF2OQ4TXrd6I
YnyxPFRRZnfiN3HNbNlJjtMgt5g0AisLuahpJaDMq0NaXnBOosDm9jBAhVOX0CSB
LUNByCygXeBKv9VuyrO4KnLXS3ORGfK38SDGqz3kFYy1quNRAGKgOXPnGXfb2xbZ
bRCqyuxkSUOIfLKA6q9jnqO9RoUeOtLglFUT/5JpixTaoxSFN3Y6GlJFcnw+cVm+
oWH4A/IoST68FCfbOMff976O36pakuWbsVGVsdv384OEHfWaf7c10P9EQc3fhgF3
JoeY5ht9R1k8HWNOlCuCeHfTwSyLG3T/TROuZYtz65RdPemuuPSPERr+GzOtO9Fn
+wQmK99JlE3nhoyv5CmtqCmMQWhYZedqjbjs5wIq7tjalerg6TakNMmhzTGz5l8T
i+3EfyMHhEtwq+2YNhdaPEmjfdBzyI3stxtEkURya0BnCgbYsP2mTIP8UbLGDqsY
EJZiRtPRFfVoePwqT8Ux
=zLLc
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
