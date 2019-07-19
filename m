Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2070C6D8CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 04:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfGSCMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 22:12:22 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:36266 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfGSCMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 22:12:22 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6C8B372CA65;
        Fri, 19 Jul 2019 05:12:18 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 5F3667CC774; Fri, 19 Jul 2019 05:12:18 +0300 (MSK)
Date:   Fri, 19 Jul 2019 05:12:18 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
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
        containers@lists.linux-foundation.org,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v9 08/10] open: openat2(2) syscall
Message-ID: <20190719021218.GB18022@altlinux.org>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-9-cyphar@cyphar.com>
 <CAK8P3a33rGhPDFfRBAQyLTMG_WoEgX_toDgWR2O7rSwxKsZG+w@mail.gmail.com>
 <20190718161231.xcno272nvqpln3wj@yavin>
 <CAK8P3a3MiYK4bJiA3G_m5H-TpfN5__--b+=szsJBhG7_it+NQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3MiYK4bJiA3G_m5H-TpfN5__--b+=szsJBhG7_it+NQg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2019 at 11:29:50PM +0200, Arnd Bergmann wrote:
[...]
> 5. you get the same problem with seccomp and strace that
>    clone3() has -- these and others only track the register
>    arguments by default.

Just for the record, this is definitely not the case for strace:
it decodes arrays, structures, netlink messages, and so on by default.


--=20
ldv

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJdMScCAAoJEAVFT+BVnCUIYvwQANcM+eTRdr/OJd9417suNuao
fK6ZbVTB/aaBGBsln3InsvqjxtiOe72mbflNqDDxwP0oUq2xEEAAdYmkEIRJ5pEn
N2R2uSpSqZFIDhR+lm6eAfA28Suec+rb0A9HwKKGHPpd5YrqWaxWEVfRxnCngswi
BH6aC+g9yXIRMR7ge0KVES+Gd5dU1jU8qfQETkko32Ezsnec88dLUftqKIhKWIDd
VnH8ew6RK6aje6oxhHbvqdJnSFXrMeV6Ws//cp2OLF4A4EKOm7q/Rhf0+yFF5ePQ
awYV/U0TdWkjIU9bQDCNDphS5p25MAv3g6AIXaUAotT3gaWe6WpFMSEKMgmBLph1
PsaazyUgw8nOh9RwDFT9yek4gmPF5x0HWrZsI85fKIsOt1t1wX3CHRQ3JVjYkpTC
d4GxWgiiAgTg8b1wjTUAjiMYqVrtSwx9srn6GA6ej9fopN2j4iWkARDLk//+xHWC
UfqMUw42wEY6PNKhY3YCa1M9joeXUlWSbz65v9ZAZRPCoXvo7eNw8EePrwMBX3QM
3pzUI2Ljakux7pASi/YYLl5Vpl1yHqEEi7ToQchsUfTJD/Geqj6528ht9GqBgaYf
s5a/eS/MD0AnBD7ytiDIfimWqrLJrLCpWLEufV60EOzRBFDxoS5QNOhQYbHVsZbh
ZLQTIMZM09jpTHhYqh4r
=2x2F
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
