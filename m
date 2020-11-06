Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AB72A8F8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 07:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgKFGlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 01:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFGlj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:41:39 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBFFC0613CF;
        Thu,  5 Nov 2020 22:41:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CS9lg543Mz9sRK;
        Fri,  6 Nov 2020 17:41:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1604644897;
        bh=zuk2I0WUJmi0lgQXq3yEuhrLu5JccxAOavoUgTBIxp0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VONiLQt9uhZb71OGYoYD4a9uxCOfw7tYMSQnlsCCfJlita2neZxcJm+lkDWmB93rG
         MYmjgu3PAZ3ODAVxEurq0adooKYa9T/FR8HJXv1es9JaggAQItUON7gvnc7NcbKtPY
         dNTlwy3EsqRMRLUigO1V97zYeMLHrUx3n9DaJVQXiWjUH6JjK4rOj4ETIXH7qpB/47
         hw2JG2zeOCejqaGiL3nXnpKAmpHD6EWuniG5YjyL+bMI58B7pIBTIfHL8x4IFvgcQE
         tpDA/arUqFsmepVUiI3ER4T77qGNi59gfQt0xFjC+NU420dV3qF4c3DtFI4RSJAN6w
         lXsEKSyk2Guyg==
Date:   Fri, 6 Nov 2020 17:41:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anand K Mistry <amistry@google.com>
Cc:     linux-fsdevel@vger.kernel.org, asteinhauser@google.com,
        rppt@kernel.org, joelaf@google.com, tglx@linutronix.de,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] proc: Provide details on indirect branch speculation
Message-ID: <20201106174134.6ccf4cd7@canb.auug.org.au>
In-Reply-To: <20201106131015.v2.1.I7782b0cedb705384a634cfd8898eb7523562da99@changeid>
References: <20201106131015.v2.1.I7782b0cedb705384a634cfd8898eb7523562da99@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g.4oPnOi=DGyHmBq.TSGse_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/g.4oPnOi=DGyHmBq.TSGse_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anand,

On Fri,  6 Nov 2020 13:10:43 +1100 Anand K Mistry <amistry@google.com> wrot=
e:
>
> Similar to speculation store bypass, show information about the indirect
> branch speculation mode of a task in /proc/$pid/status.
>=20
> Signed-off-by: Anand K Mistry <amistry@google.com>
> ---
>=20
> Changes in v2:
> - Remove underscores from field name to workaround documentation issue

I replaced the previous version in linux-next with this today. It fixes
the htmldocs warning from yesterday, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/g.4oPnOi=DGyHmBq.TSGse_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+k8B4ACgkQAVBC80lX
0GzPJgf7BYsEXjhux180lQAOxjPcKaAybcinGW6gjVc4blDLMa0T/GSmHYtOqvKX
dPiv2ijvQAnePFe+JZgrmDX4BafJ59aiY4+/a5/eEMT1mnl7byhsD37EGQA4kzhn
SUwqUqe4Mlve6WA0jjlQ8xPbex7wll5uaj9XnQ6wmdP8pXGve6I5rgMdaeMtbABY
WgXTImVk0Hsq0gZmNzoahn9TAMAHDLaS2H6sEfBtj1jRRNzSr94xuq0BHLj2egrb
KUS2t74axUvVv2Y8xm5DEq62RbxvvswvurUoSYkBgGkV48SesJrTxnSzoYrU8m/5
4Y/z/FWMv3pRVQ4eoaay4sDJrJnGlw==
=38oe
-----END PGP SIGNATURE-----

--Sig_/g.4oPnOi=DGyHmBq.TSGse_--
