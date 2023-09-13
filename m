Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0BD79EB2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 16:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbjIMOf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 10:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjIMOf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:35:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9272391;
        Wed, 13 Sep 2023 07:35:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE452C433C9;
        Wed, 13 Sep 2023 14:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694615723;
        bh=cfyYnzfLuMJIjcnP59Cc2Ovv2IiXsjzUwiev3pUOe6E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TiGHBh7agVMf5kiP2KeNHGnJJPfjLzE60MlwRkMXnneU4YxpSYsMrR1kGxQkDcs9v
         xViONpc5rqFP+oIrOjrRxACIBlx1g+3q9RleVWDKLWNvicgVnF2WCT56K61RhrPJV4
         J+DIcg3tbTppwNpzCH02IrVNwAXl6fdRzrJ578M59USXJ1v7WYLaCkyGTO17A8x3T0
         OjyW5hN2MbVrvg2TtZXlDYKCvYelSVVpmZDOiHGaLZbgiCYeoTPtbOVvzoSPbxtvkV
         7kUwqO3So4BgJmLpYs7CMIdWdRS8/3kyllq3gHl3jUlunhmqM4ZxiBkZ6Qr8n0BCbL
         fv1dhvS8eZFjw==
Message-ID: <0e7962b0-4d66-4d86-b245-a695dd421d01@kernel.org>
Date:   Wed, 13 Sep 2023 16:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Document impact of user namespaces and negative
 permissions
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, christian@brauner.io,
        ipedrosa@redhat.com, gscrivan@redhat.com,
        =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        acl-devel@nongnu.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ebiederm <ebiederm@xmission.com>
References: <20230829205833.14873-1-richard@nod.at>
 <81098c50-bfec-9aa2-a302-abfebd0ff332@kernel.org>
 <1972367750.1870193.1693344767957.JavaMail.zimbra@nod.at>
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <1972367750.1870193.1693344767957.JavaMail.zimbra@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------R067x8bkytjlXEcwvcELanPQ"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------R067x8bkytjlXEcwvcELanPQ
Content-Type: multipart/mixed; boundary="------------GMl6HaueBBR2zGyR2tgyaqkP";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, christian@brauner.io,
 ipedrosa@redhat.com, gscrivan@redhat.com,
 =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
 acl-devel@nongnu.org, linux-man@vger.kernel.org, linux-api@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 ebiederm <ebiederm@xmission.com>
Message-ID: <0e7962b0-4d66-4d86-b245-a695dd421d01@kernel.org>
Subject: Re: [PATCH 0/3] Document impact of user namespaces and negative
 permissions
References: <20230829205833.14873-1-richard@nod.at>
 <81098c50-bfec-9aa2-a302-abfebd0ff332@kernel.org>
 <1972367750.1870193.1693344767957.JavaMail.zimbra@nod.at>
In-Reply-To: <1972367750.1870193.1693344767957.JavaMail.zimbra@nod.at>

--------------GMl6HaueBBR2zGyR2tgyaqkP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 2023-08-29 23:32, Richard Weinberger wrote:
> ----- Urspr=C3=BCngliche Mail -----
>> Von: "Alejandro Colomar" <alx@kernel.org>
>> Can you please provide a small shell session where this is exemplified=
?
>=20
> Sure. I sent the following to the shadow maintainers privately on Frida=
y,
> but since the issue is already known for years I don't hesitate to shar=
e.
>=20
> # On a Debian Bookworm
> # So far no entries are installed.
> $ cat /etc/subuid
>=20
> # useradd automatically does so.
> $ useradd -m rw
> $ cat /etc/subuid
> rw:100000:65536
>=20
> # Let's create a folder where the group "nogames" has no permissions.
> $ mkdir /games
> $ echo win > /games/game.txt
> $ groupadd nogames
> $ chown -R root:nogames /games
> $ chmod 705 /games
>=20
> # User "rw" must not play games
> $ usermod -G nogames rw
>=20
> # Works as expected
> rw@localhost:~$ id
> uid=3D1000(rw) gid=3D1000(rw) groups=3D1000(rw),1001(nogames)
> rw@localhost:~$ cat /games/game.txt
> cat: /games/game.txt: Permission denied
>=20
> # By using unshare (which utilizes the newuidmap helper) we can get rid=
 of the "nogames" group.
> rw@localhost:~$ unshare -S 0 -G 0 --map-users=3D100000,0,65536 --map-gr=
oups=3D100000,0,65536 id
> uid=3D0(root) gid=3D0(root) groups=3D0(root)
>=20
> rw@localhost:~$ unshare -S 0 -G 0 --map-users=3D100000,0,65536 --map-gr=
oups=3D100000,0,65536 cat /games/game.txt
> win
>=20
> Thanks,
> //richard

Thanks!

Please include this in the commit message (at least for the Linux man-pag=
es
one).

Cheers,
Alex

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------GMl6HaueBBR2zGyR2tgyaqkP--

--------------R067x8bkytjlXEcwvcELanPQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUByKYACgkQnowa+77/
2zLaag//XpTmNOOuHlT3NLLq2+3NZY2xnbClvJMlT09jYC6VCXrawIBbbZANRmuC
KNDx8bcVevZUDcBnN7+2tsNpQF+fQWBF4ItAUuwNYPQY+D5sopQaum5at2Tx5YJJ
CQlbY9nvjaRgewIn9+DaRjaPQ3lgK/d1XcxxVbimV61fRfLdiak9wUs6Fsrp75XP
zf0Y9jQvYPZk0Np/VCRR7jjzSrEIMOL4XmrcZe7bwrC/kw2cj9Gku+HcHt6FfMq/
RCJl+MjTVbxafi8PZHpNqAlUY3wtJfd7p/XKf/hHybhFB/x2aWjT3YZ5HC2aN0yD
ozDgubckLCDZ/4EGnQGLe+QokblXMUbMcotVh7D3ELpKIIDY/hLbi/DmfEWs/1LK
tr0KwOavX5Koqd6rxcUR6xCC+0q5DZSC7E7lna0r++uUSrkUjdOZAo4pujSJWAEC
3YMwb/ZlCFMofGc2AEq0jMWDsAw2zob8Q3QKZFSVGGJ9Yf6rfUZlO+jIYztjar90
cuxZBzzuIVAkq0pwObIWF/Fu3z7F+miG9LSQad4lMJt0T/DaQDQtxXLWRpXwC1PF
yuVVJv8iV5zK7o2VVnuKePL9yPDNtZZCk81y+6lUZAt9mmlagLjbOieorfMXwLzR
Qf5sBldhwBjejyuFQTQb1tvi/z0JLiQBzi7L0RjTBpK/b7ZRHpg=
=SNJR
-----END PGP SIGNATURE-----

--------------R067x8bkytjlXEcwvcELanPQ--
