Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F67C4885E8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 21:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiAHUaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 15:30:01 -0500
Received: from mout.web.de ([212.227.15.4]:33395 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbiAHUaB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641673773;
        bh=QFZg+bg1P8kqTX2//hD6BrVKJC1HEPIw1TpHP7jDhuQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=YDYSrvQcvwE24Fl0PJjFoZMe/6Rponqhaj8yAzAxSW/7E5fCaI/TT41iq3lrKUxih
         gz0nuCOHSZeDU70jQ92lGUeu9yevkwf9cnEgy0J80yuAKxn4TEphTe5IOvI9U6lmSZ
         Nj8eL2kq+7WLXSgkElUGNRwk8935zusfGcK6neyo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.151.24]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOUxu-1mjfQB0CkA-00QH8k; Sat, 08
 Jan 2022 21:29:33 +0100
Date:   Sat, 8 Jan 2022 20:29:22 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        linux-raid@vger.kernel.org
Subject: Re: [dm-devel] Proper way to test RAID456?
Message-ID: <20220108202922.6b00de19@gecko>
In-Reply-To: <20220108195259.33e9bdf0@gecko>
References: <0535d6c3-dec3-fb49-3707-709e8d26b538@gmx.com>
        <20220108195259.33e9bdf0@gecko>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bleRxGKigDWXtjWdAU2Z=W3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:QDvD7CzCcfEct07ZG6h2ro0ZPpjryenoHtIY5TobsDPGc/+cmT0
 2bko9etukW3oeqt/RGAIGu4AcwhGoH1PawViXyai8IvWS8f3CPfADXijS63sl0l/80ZgOp9
 VQmsnTwoW0807gbb60fKng7c1gXi16moKPeBs909k6OCDKgQHxXUPY04fSDXNr0xrBlBRYc
 k8ZpcHwdBoafussgaVxXw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:19N37SIn/9U=:jzbu+QDfSMu05HvW0J9QPU
 dpdGna+tta8TfclN/RHQe1kgRxHIzP0qinXcQfkIEoa1YVWyecQCE1swScHj9pipBa7N9xk75
 r/gbciKiGmz8+JZuaOoks0we+0s7fgIQjW3lJ5HKwVhmUq0/FLgsndhXhbbLdCTELyJuJCVLJ
 NYJ6Rjy0Wwgo8qlYawVK0xTAdAm72Wsf1+3MyWY7BHzP9rF1JRfNENlVrbyimH7Obuh3z6Uai
 71p6COcdE02VnCTVz2yH6+xAVL5xAzxNQCUO36iwFKGRtO5Cj1Fna3CNlYcCRuGo5jiARw7LA
 lxguTPXCZjIQELv2NkXeU3yZR/X+nCROkAhpVBcX0IiiPlC76xslX86m+aAT9LQPJVY+KD9ZM
 sxf67cZJBlYisCmThA9EbSsbGVG9nhfFzlAfrQQ4LgWDONW7LyxfGb5G2xtsW9YEA6r5HZlxC
 vkBy7kyeGL56UIY8mRbwtZpfvfuNO4a9kmGGRdFoj6ZT6n1PwLtn4tQ6Rv58JzwhnMgxavvXh
 usv4fJ9DFYhWiFRp7kvHSQZrDsI0mlJ03lRBC3jvav4hAk6j+bzGNHADKwHL0uktNhK5S4q8K
 cvinXjT4dNco7tPo3VUWPYkXsVDn0/3OUtDnu1cRZawqquFRja64ExUofNh0jLTbNR1aew+FM
 llOL0z8TzD/8fUmcwcXZ6mKKzorNDc43DBBNdTjf+LXG+uPlc1Grs8AXL15wDWxOfKSPOTP++
 dvwRRFbNF0kQP7zHuctRmanI6Izz+MXJCc17vBisy+jmS8X8/OUr2fkETQsCxMvDv7vqBb4Uh
 +fvncmbDftwFGDcl2IkbQPZ6IfV7Nmv3gDZXsoiSXMPiY49axwyNMajf2oNIb+tirCNE55a+y
 Jm0ZRh93sGV8Sm2HhJ4gqRrwI6VypWdUl4mQB3ENMUNWmUJZOL9YI1ATI1taJo9RARG0S+kl1
 StAOfjAuAT9bfXGAnsCSPuCnss2jygyz0WfiVC4ydHecDQUvMiP2HvJJxXJVkCZsO9J5QkmWO
 D5luLhatfr2ARwBBAyxRFCk4I8ZL4O2AxoXLWHkHWHczv+Z1uhLluZiprog/T/1yA4UCc3NS+
 AGV10TfNy4lgf8=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/bleRxGKigDWXtjWdAU2Z=W3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 8 Jan 2022 19:52:59 +0000
Lukas Straub <lukasstraub2@web.de> wrote:

> CC'ing linux-raid mailing list, where md raid development happens.
> dm-raid is just a different interface to md raid.
>=20
> On Fri, 7 Jan 2022 10:30:56 +0800
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
> > Hi,
> >=20
> > Recently I'm working on refactor btrfs raid56 (with long term objective
> > to add proper journal to solve write-hole), and the coverage of current
> > fstests for btrfs RAID56 is not that ideal.
> >=20
> > Is there any project testing dm/md RAID456 for things like
> > re-silvering/write-hole problems?
> >=20
> > And how you dm guys do the tests for stacked RAID456?
> >=20
> > I really hope to learn some tricks from the existing, tried-and-true
> > RAID456 implementations, and hopefully to solve the known write-hole
> > bugs in btrfs.

Just some thoughts:
Besides the journal to mitigate the write-hole, md raid has another
trick:
The Partial Parity Log
https://www.kernel.org/doc/html/latest/driver-api/md/raid5-ppl.html

When a stripe is partially updated with new data, PPL ensures that the
old data in the stripe will not be corrupted by the write-hole. The new
data on the other hand is still affected by the write hole, but for
btrfs that is no problem.

But there is a even simpler solution for btrfs: It could just not touch
stripes that already contain data.

The big problem will be NOCOW files, since a write to an already
allocated extent will necessarily touch a stripe with old data in it
and the new data also needs to be protected from the write-hole.

Regards,
Lukas Straub

> > Thanks,
> > Qu
> >=20
> >=20
> > --
> > dm-devel mailing list
> > dm-devel@redhat.com
> > https://listman.redhat.com/mailman/listinfo/dm-devel
> >  =20
>=20
>=20
>=20



--=20


--Sig_/bleRxGKigDWXtjWdAU2Z=W3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmHZ9CIACgkQNasLKJxd
sliGvg//T1egoa1W0T4PFUsHLBQ2VCuxBKRczSVau4rZfncHaDA8bkax/al0uBbX
6W5b0nACUL00ZD1QNPEijVP7p4DvAF7I8TRY+WNnZaQmH1OupPI5PNU3KEPrj1at
EkcYNcCJrsZo2D4PitXjU9gt8/UNtbDPh9UROm3psGq9zmK3tFUfmoDmZK9ceVq0
2jecB9uEfQmZBAQLo2Pb+uSLbK6z06K0KkBa2Urt9PPXlJUJ5RD2IHz1+yJbp5hs
N7AqjoD9WPimSftQ0pLYGtUUVYFNc1KA+BXbE1JevRVlS6DdllDhYnmOWNk6Oqgv
yqRRbDZ4UirZsUBMt2HKXjKKZehwMErJ5bO6o2BaH45XpPp1cOrSOR7EV2T4B4sZ
oz07FuxuK2cnDyRGvZlJ4PmXyWRZBg1o+RYKCMJ/niSaRfhWEHX55b7wmJIpoqDd
0eBkNHPHr9SU395BJ25qF0R9oWpixS67BZ5cYuMp+jFuOW3miXcYMaatLN2SXzNH
bQJmaO1P109JCaMOjl39SSiMAT53v5B7PiHbBHOAGOi7s8zL3l0AEqp89QSrJWF2
v3MqSHSyuQqjZbNh0zhC0WH/URErmPb3gzDDQwIHTt+k1pe9XSa87C3Im40y+HQT
2Nfplumm4U8wqXoTdKOQXcHbyH0RRxFEXtwGESls/jwLFUvuIMA=
=DIxA
-----END PGP SIGNATURE-----

--Sig_/bleRxGKigDWXtjWdAU2Z=W3--
