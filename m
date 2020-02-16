Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8436916016C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 03:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBPCQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Feb 2020 21:16:42 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:59998 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgBPCQm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Feb 2020 21:16:42 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 48KrMr1SVbzKmbF;
        Sun, 16 Feb 2020 03:16:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 8iYdHKaMdLHw; Sun, 16 Feb 2020 03:16:35 +0100 (CET)
Date:   Sun, 16 Feb 2020 13:16:15 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 3/6] configfd: syscall: wire up configfd syscalls
Message-ID: <20200216021615.letuocbf4jvqk6nj@yavin>
References: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
 <20200215153609.23797-4-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h64qxmwly5oqdbdg"
Content-Disposition: inline
In-Reply-To: <20200215153609.23797-4-James.Bottomley@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--h64qxmwly5oqdbdg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-15, James Bottomley <James.Bottomley@HansenPartnership.com> wrot=
e:
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/sysc=
alls/syscall_32.tbl
> index c17cb77eb150..fc5101e9e6c4 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -442,3 +442,5 @@
>  435	i386	clone3			sys_clone3			__ia32_sys_clone3
>  437	i386	openat2			sys_openat2			__ia32_sys_openat2
>  438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
> +436	i386	configfd_open		sys_configfd_open		__ia32_sys_configfd_open
> +437	i386	configfd_action		sys_configfd_action		__ia32_sys_configfd_action

Did you mean:

+439	i386	configfd_open		sys_configfd_open		__ia32_sys_configfd_open
+440	i386	configfd_action		sys_configfd_action		__ia32_sys_configfd_action

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--h64qxmwly5oqdbdg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXkil7AAKCRCdlLljIbnQ
Eu0TAQDOlQ87U0ysJ1x7ME0X/zmNs0RJzt9IMFKwRc+hR1hqXQEAj7vWOFqOmcOn
prMRNx4rbJFvalx5VFhT5mhXf3VK0Ao=
=xJsr
-----END PGP SIGNATURE-----

--h64qxmwly5oqdbdg--
