Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508C620983A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 03:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbgFYBZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 21:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388928AbgFYBZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 21:25:23 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F299DC061573;
        Wed, 24 Jun 2020 18:25:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49sj4c29Z7z9sSt;
        Thu, 25 Jun 2020 11:25:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1593048321;
        bh=wZqYCZ4rzjYy8J0Uc//CISQWPwtAY2uNSf3i5tgRVVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P1LfKqFcSwtX9D0asb00y5WoSuSk2j7NvHv1XE/LT3TXlwVwM+gB8N8UpdgSojiA/
         ZokR68IqW22ZB+xz7paQqsPkUENIOyCq4VFTy6IFUbUnKZrwKexu6J/W6lgOyLhZxh
         8BhnXrFGNWvOJDQUrLu3DohcQa+Zv1dOMnYV7Li4rQ0Wo/NEwurKEIQdm/mEZVM24c
         aEbRSa1PUnRtLF63tmmkeCLZCSiQTfH/hJJaSkUj6fdi84kN5esGUxBo1URiEBMAR1
         lgol+MoKlXXu5JX5A1ajBQF6zwwTiNcOKJ7V7eQj2eDhxSTXPJBT2PwEsnKkreYYye
         Z5p2zVngSmqgw==
Date:   Thu, 25 Jun 2020 11:25:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Qian Cai <cai@lca.pw>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        paulmck@kernel.org, rcu@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: Null-ptr-deref due to "vfs, fsinfo: Add an RCU safe per-ns
 mount list"
Message-ID: <20200625112517.4cf8f3a9@canb.auug.org.au>
In-Reply-To: <20200624155707.GA1259@lca.pw>
References: <31941725-BEB0-4839-945A-4952C2B5ADC7@lca.pw>
        <2961585.1589326192@warthog.procyon.org.uk>
        <20200624155707.GA1259@lca.pw>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t.bTb4R9aiObfQs2q7bZVl/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/t.bTb4R9aiObfQs2q7bZVl/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 24 Jun 2020 11:57:07 -0400 Qian Cai <cai@lca.pw> wrote:
>
> On Wed, May 13, 2020 at 12:29:52AM +0100, David Howells wrote:
> > Qian Cai <cai@lca.pw> wrote:
> >  =20
> > > Reverted the linux-next commit ee8ad8190cb1 (=E2=80=9Cvfs, fsinfo: Ad=
d an RCU safe per-ns mount list=E2=80=9D) fixed the null-ptr-deref. =20
> >=20
> > Okay, I'm dropping this commit for now. =20
>=20
> What's the point of re-adding this buggy patch to linux-next again since
> 0621 without fixing the previous reported issue at all? Reverting the
> commit will still fix the crash below immediately, i.e.,
>=20
> dbc87e74d022 ("vfs, fsinfo: Add an RCU safe per-ns mount list")

I have added a revert of that commit to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/t.bTb4R9aiObfQs2q7bZVl/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7z/P0ACgkQAVBC80lX
0GzqtggAhCC4k0Z3m35GbDRg7iW8yoeoyG5WHwIfVompDg7cqrbQs6XjVthYCghl
B+/FDUDfo3wfGBy5PH1NdJRoZxwqYXWu69YvqA2jP+sNqDdsqu1uziKd2sDvthed
FOEtxYWPYWQitRelIp2XF6T4K3wlsyP7nGZUUx987veQeL0Za8QFGln5LiGVywZr
ZulkTHbDrMZBcDfUNjU4WHE1cVF0SfdwrknS7biVgJNtduBVVqCn3IVWJew3Z76R
sv00DDNGe2FJiwvRPh48yXGjXLuDLFtJXnegEx2aojP8W/c09a5jsinmpnFRD70r
O/xQWiHBqS8361DqqE09QtGStQFtpw==
=/b6E
-----END PGP SIGNATURE-----

--Sig_/t.bTb4R9aiObfQs2q7bZVl/--
