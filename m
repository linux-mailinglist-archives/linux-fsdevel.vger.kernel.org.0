Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287EF7652BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 13:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjG0Ln0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 07:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjG0LnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:43:25 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FDE2109;
        Thu, 27 Jul 2023 04:43:24 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230727114322euoutp0134004c8a77ac176e91161a8d5b51acc6~1tsdL9YlV0082500825euoutp01d;
        Thu, 27 Jul 2023 11:43:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230727114322euoutp0134004c8a77ac176e91161a8d5b51acc6~1tsdL9YlV0082500825euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690458202;
        bh=hmpNR9U6LTorqWJzfNPkY5F9nV+bEnuWiv2TwR92kxM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=m10tv1G6HDR7M+JA6KMXYvf/Y9PKDJHfZmoE0f3iDA3meFCLns3IB/Np8+7+A/Iyr
         HYrXI8Z2DTRbJ2UDea0o1BMmpJl3hdLCV09CqxKfBiz2IABQM2mdOP7b+jxFB+p9uK
         bZw1cRF2RDDzTOhHoN4DppVKMm9E3m1HOC6iyi3E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230727114322eucas1p25c1f527c05b944e9023faf4ae2c7c42b~1tsdAgKHa0792707927eucas1p2n;
        Thu, 27 Jul 2023 11:43:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4A.82.37758.95852C46; Thu, 27
        Jul 2023 12:43:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230727114321eucas1p2a249d5e24184b2b770d61d1e81537eec~1tsctCw-s0770607706eucas1p2o;
        Thu, 27 Jul 2023 11:43:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230727114321eusmtrp12382e8d4f22ebb7631d34ce39a02871e~1tscsYUFi0189401894eusmtrp1O;
        Thu, 27 Jul 2023 11:43:21 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-77-64c258591d85
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.73.14344.95852C46; Thu, 27
        Jul 2023 12:43:21 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230727114321eusmtip11e0511ba785bbe4a381a3b1f9ad6d6df~1tsceeQ5K2178121781eusmtip1C;
        Thu, 27 Jul 2023 11:43:21 +0000 (GMT)
Received: from localhost (106.210.248.223) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 27 Jul 2023 12:43:20 +0100
Date:   Thu, 27 Jul 2023 13:43:18 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, <willy@infradead.org>,
        <josh@joshtriplett.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 00/14] sysctl: Add a size argument to register functions
 in sysctl
Message-ID: <20230727114318.q5hxwwnjbwhm37wn@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="un5gp6ss3vtarjvy"
Content-Disposition: inline
In-Reply-To: <ZMFizKFkVxUFtSqa@bombadil.infradead.org>
X-Originating-IP: [106.210.248.223]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSf1CLcRzHffc89jzllsfW8VEdZ/l1LdH59fjRRsL843Kcy6/L1COdtbEV
        xTl1uiQ/KqFVYt11E3MhtaUVtmjaKISbwsmlSM6U7pAba8/8uPPf+/163u/n+bzvHhLjPx4Z
        QCYqkhmVQiYXcn1xQ9O3lhkbYizxszQ9C+ifWiV9/2gSXd/QjNNtdWe5tCPvLaKbtGPpoa9u
        p7uxegkpLUl/hEu1VSnS6xUh0vYPEdKqS0e40oGqCdHcjb6L4xl54h5GNVO81XdHrr2Es8s8
        KXXIlsFJRyWBOciHBGoOmJ1mPAf5knyqAsGnlg6CNV8QdGsrEWsGEFieteG/K/2tBm/qAoJD
        jZn4n9St93Uc1tQgsFbrseEKTk2BF1YXMay5VCi09r3wcH9qOtzMO+4pYNRzBM33jZ6QgIoB
        Y47J8z0eNR/OHXMQrB4DzUVdHo5RqeDI17g56daBcMFFDmMfah6cdb3msKcGg7l8iGD1AbBV
        t3t5oQ+8swtYHQW9zx56pwmg11rtzQeBveCYZxlQBe5lLifBGj0CXcag902LIPNJl7exFC7a
        mkYOHwSUHzg+jmHv9IOThkKMxTzIzuKz6amgf9WH56Hg4n+WFf+zrPjvMhaHgtbUz/0Pi0BX
        9gFjdQRUVn7CtYi4hMYxKeqkBEY9W8HsDVPLktQpioSwOGVSFXL/anaXdbAWVfR+DrMgDoks
        aLK7/Oaq/iEKwBVKBSP059miLfF8XrwsbR+jUsaqUuSM2oICSVw4jieKaI7jUwmyZGYnw+xi
        VL+fckifgHTOSvpUw5Uy+116hU5EPP3YFfKy7WJd5eF3nY2RTU+70u4ZRt9ZWJ+2TWN9A6aD
        Gr0ktu67IDf1YJAkWRPNLOvYjJ0LisnCVi3IQ8aaKFXkxv4r0+SM+MGIE0xp48CyGeIVNdfM
        pcnfbqyZa5RLTJEtEgMRR1nLI/cdFsxWK/0CuT2XP+9pb89Vqor61q4Lxoa6TbbScI19U2EG
        lnEve4PMURMl3n76cmJrbec2UYm2e+r4gb6EnFunhEZJ794yy5TdgxMfONf0dNSX+ztbwzsn
        r3/pd15mDP0uKjqzPEuyJHu/cMsTMbd6VMPX/B+1+Ykj8Pm3nUduZ+73byHCeLpYIa7eIQsP
        wVRq2S9aE8zj5QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xu7qREYdSDNZPUrH4vyDf4kx3rsWe
        vSdZLC7vmsNmcWPCU0aLYwvELH7/APKW7fRz4PCY3XCRxWPBplKPzSu0PG69tvXYtKqTzePz
        JrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9
        jElXWtgK9itWtG4taGCcKd3FyMkhIWAi8en8NvYuRi4OIYGljBJHjh1mh0jISGz8cpUVwhaW
        +HOtiw2i6COjxJTVL1kgnK2MEt+Xv2MBqWIRUJW4c/wfWDebgI7E+Td3mEFsEQENiX0TeplA
        GpgFbjJKnDyzHaxIWCBCYnvXbrBmXgFziXk9N6Du2MsocefzTKiEoMTJmU/AbGaBMomOyRuB
        7uAAsqUllv/jAAlzCphJzPn3gAniVGWJg0t+Q71QK/H57zPGCYzCs5BMmoVk0iyESRBhLYkb
        /14yYQhrSyxb+JoZwraVWLfuPcsCRvZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgZG97djP
        LTsYV776qHeIkYmD8RCjClDnow2rLzBKseTl56UqifCeCjiUIsSbklhZlVqUH19UmpNafIjR
        FBiME5mlRJPzgSknryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qB
        aaELg/v1pKkWsV9e/Jy9TNoi+vDei4lOO79uzzgUVHIiZCfn0wXH9PvWRaq+q3OVu+qw588d
        mxoXtwt7GpauXLYwk99/4626a5n85QHF3Vatz55ft/bdq/Dhm8uXW3zsFry8zW0s50sjkjs+
        WTBGXFgm9EfozHX7j3GmSfvvFkscC1rmnX32RGWKt7k29/MN3vraanIRxZlzfx5nuNs6O0zl
        zePpMU03v7EaGT6/FvDzVv2Tv3fTOb9LvLNt+3bobNuMG8/4H55kjVroMClI6ouRb3PS7f/3
        asRS5fknJ92ewb/n/4LoU/GRcxaeUXc2ZGJbdbs4+Kj+9rqA9r+CO77uXGreULJVLfcWm6VO
        oBJLcUaioRZzUXEiAI+D5TiBAwAA
X-CMS-MailID: 20230727114321eucas1p2a249d5e24184b2b770d61d1e81537eec
X-Msg-Generator: CA
X-RootMTR: 20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd
References: <CGME20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd@eucas1p2.samsung.com>
        <20230726140635.2059334-1-j.granados@samsung.com>
        <ZMFizKFkVxUFtSqa@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--un5gp6ss3vtarjvy
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 11:15:40AM -0700, Luis Chamberlain wrote:
> On Wed, Jul 26, 2023 at 04:06:20PM +0200, Joel Granados wrote:
> > What?
> > These commits set things up so we can start removing the sentinel eleme=
nts.
>=20
> Yes but the why must explained right away.
My intention of putting the "what" first was to explain the chunking and
clarify right away that what was contained in the "why" was not for this
chunk but for the *whole* patchset.

I have swapped them in my cover letter as I can see that the ambiguity
is gone once you start reading the "what"

>=20
> > Why?
> > This is part of the push to trim down kernel/sysctl.c by moving the lar=
ge array
> > that was causing merge conflicts.=20
>=20
> Let me elaborate on that:
>=20
> While the move moving over time of array elements out of kernel/sysctl.c
> to their own place helps merge conflicts this patch set does not help
> with that in and of itself, what it does is help make sure the move of
> sysctls to their own files does not bloat the kernel more, and in fact
> helps reduce the overall build time size of the kernel and run time
> memory consumed by the kernel by about ~64 bytes per array.
>=20
> Without this patch set each time we moved a set of sysctls out of
> kernel/sysctl.c to its own subsystem we'd have to add a new sentinel
> element (an empty sysctl entry), and while that helps clean up
> kernel/sysctl.c to avoid merge conflicts, it also bloats the kernel
> by about 64 bytes on average each time.
>=20
> We can do better. We can make those moves *not* have a size penalty, and
> all around also reduce the build / run time of the kernel.
>=20
> *This* is the why, that if we don't do this the cleanup of
> kernel/sysctl.c ends up slowly bloating the kernel. Willy had
> suggested we instead remove the sentinel so that each move does not
> incur a size penalty, but also that in turn reduces the size of the
> kernel at build time / run time by a ballpark about ~64 bytes per
> array.
Thx for this.
This is a more clear wording for the "Why". Do you mind if I copy/paste
it (with some changes to make it flow) into my next cover letter?

>=20
> Then the following is more details about estimates of overall size
> savings, it's not miscellaneous information at all, it's very relevant
> information to this patch set.
Did not mean to downplay the importance here. Just did not have a good
title for the section. I'll change it to "Size saving estimates".
>=20
> > Misc:
> > A consequence of eventually removing all the sentinels (64 bytes per se=
ntinel)
> > is the bytes we save. Here I include numbers for when all sentinels are=
 removed
> > to contextualize this chunk
> >   * bloat-o-meter:
> >     The "yesall" configuration results save 9158 bytes (you can see the=
 output here
> >     https://lore.kernel.org/all/20230621091000.424843-1-j.granados@sams=
ung.com/.
> >     The "tiny" configuration + CONFIG_SYSCTL save 1215 bytes (you can s=
ee the
> >     output here [2])
> >   * memory usage:
> >     As we no longer need the sentinel element within proc_sysctl.c, we =
save some
> >     bytes in main memory as well. In my testing kernel I measured a dif=
ference of
> >     6720 bytes. I include the way to measure this in [1]
>=20
>   Luis

--=20

best

Joel Granados

--un5gp6ss3vtarjvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTCWFUACgkQupfNUreW
QU8gZQv6A/JPdyEMJM+WZNlax/U3RF4zQ82hUr00IwsVsFcKmsO0BE4FqcvJGvaR
aARhNTofi/WyX7nALCwj1lLCcB6FNsJTlprsLd3N8axWlIEoLrpuph4G5b830ogU
MNvrTaS8qKx26baRQ/KR8rniV0H5S2XZzg6xpXo9FMo06NY58YPXOPjaBIvUYaQL
l3R/COZan+15Uow7op8qKTNzU6wQDpRoBz1i5b+IJgHnpJz3QToAGjLiXoPAj11z
Qdclhmlv7oFkmuPH3XUSs4coE2qPypauGHjOiOzwgqOCd9UNI4u25oYPSC7Gf6vy
Mx4TDJkxC/Bn7uWKVrnbP/inppOY5HAsqDjUXyl+526ZhS5vs40PD3u2R3PPvgHq
tbPE+t93g25EQAcyAs5KpiqxvdC4JPjoFhYR6gc6h7FNLgJzHbSk6OwmgnVM4/J5
ZQBH6ADV8gH3XnK6inNAGsyYSIHpelt16cjng8xM6w3Dlp3FNnfP38X9VPzVCNPL
fH92JfWn
=0ihf
-----END PGP SIGNATURE-----

--un5gp6ss3vtarjvy--
