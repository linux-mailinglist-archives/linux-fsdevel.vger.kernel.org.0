Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEDE725714
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 10:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbjFGIN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbjFGINY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:13:24 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F3F10F8;
        Wed,  7 Jun 2023 01:13:22 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230607081319euoutp02ba206291cc16219583f81eb14fd24aa0~mUkya1ABq2541525415euoutp02I;
        Wed,  7 Jun 2023 08:13:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230607081319euoutp02ba206291cc16219583f81eb14fd24aa0~mUkya1ABq2541525415euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686125599;
        bh=3DPXiR/hjyfEzK7m9HH5XmbFqxbHSFl1tAr4AZcydFk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=nD1t9nwk/zIO3Zo/sh2GTi8aAQR48SdDNHZ79t+ooGr+eu5d5RftK51ZS7+//LZru
         13YLrWajmJKg4uk/Mq+MHnG/Ds9F+fZvgFLwJBYPPCNWeAx5lw+ZZ87ir3u4Rk5K/k
         akJAF3sc6NSCjaOTTs8wreiNYV8wDmxPQ+DJjj24=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230607081319eucas1p1201a9cb1a327701cfda8116b790bd093~mUkyK8Cvh3228032280eucas1p1p;
        Wed,  7 Jun 2023 08:13:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F1.E0.11320.F1C30846; Wed,  7
        Jun 2023 09:13:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230607081318eucas1p1c5adbc6abaa1bd9b236e596f7a08b2fb~mUkxqu-ZS0835808358eucas1p1y;
        Wed,  7 Jun 2023 08:13:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230607081318eusmtrp21efa925f6e52fc458e9528eac5814e52~mUkxqOiP02069120691eusmtrp2a;
        Wed,  7 Jun 2023 08:13:18 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-7c-64803c1f9329
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0E.93.10549.E1C30846; Wed,  7
        Jun 2023 09:13:18 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230607081318eusmtip289b582a54a5ca24c7a7e99924d10757c~mUkxYrL8K2854628546eusmtip20;
        Wed,  7 Jun 2023 08:13:18 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 7 Jun 2023 09:13:17 +0100
Date:   Wed, 7 Jun 2023 10:13:16 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 0/8] Remove child from struct ctl_table
Message-ID: <20230607081316.wlnj5w5megkphcbd@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="tzto3k5whkt5xwze"
Content-Disposition: inline
In-Reply-To: <ZH+BWiQOSQGNDQCv@bombadil.infradead.org>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7ryNg0pBm93s1vs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRXHZpKTmZJalFunbJXBlPFn4hLngtETF/V89jA2M
        80S6GDk5JARMJOb9amDuYuTiEBJYwShxZPdjKOcLo8SV759ZQaqEBD4zSjybqdHFyAHW0XlW
        BKJmOaPEgcdPGCEcoJoVH94wQTibGSU+33zBAtLNIqAi8erBdCYQm01AR+L8mzvMILaIgIbE
        vgm9YHFmgQyJVS+ug8WFBawlDi06BbaZV8Bc4vCr/4wQtqDEyZlPWECuYBaokFjfmQBhSkss
        /8cBUsEpYCbRMHcZK8RnShJf3/RC2bUSp7bcAjtNQuANh8T/1nUsEM+4SBydXwJRIyzx6vgW
        dghbRuL/zvlQ9ZMZJfb/+8AO4axmlFjW+JUJospaouXKE3aIQY4SW+6XQph8EjfeCkJ8xScx
        adt0Zogwr0RHmxBEo5rE6ntvWCYwKs9C8tcshL9mIfw1C2yOjsSC3Z/YMIS1JZYtfM0MYdtK
        rFv3nmUBI/sqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwDR0+t/xLzsYl7/6qHeIkYmD
        8RCjClDzow2rLzBKseTl56UqifBm2denCPGmJFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQ
        nliSmp2aWpBaBJNl4uCUamDazCqass124xmh006Lnr4LO5CYNXn5FfvzM05kVWSoH2vYrLDT
        kn+1Y1Lvt41G8s1TNomknM/cNr9to7Vk2fyymNPeX/mlH2wRy1GylE7I54n4lznvo7T1/l2b
        2n9MNPcUS1jGET9HyZTXwyy4ozBYbq/YliqPiEPi5w4Flkcc8943r2lm6AUFpS9nrsmuP2Fe
        4/f6ZmRmXpKlefiirQaJitccbNf9XHXtyZ/3t0W+u9RE/t//965J3uN9re8kVrbd3qhgk/ek
        6n1AxQfTgg2tztFffm+Kk3LjCmkQONP1tt/D+nDotfKE+o3Gx1M2VL04llzd0Cb1v1qvwZ6r
        2cvv9Zon3JzxL1VCZnqsFldiKc5INNRiLipOBADsGXEAvgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7pyNg0pBm37VSz27D3JYnF51xw2
        i+l33rNZ3JjwlNGBxWPTqk42j8+b5AKYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
        zWOtjEyV9O1sUlJzMstSi/TtEvQyvn75xlxwUqLi2d9OpgbGOSJdjBwcEgImEp1ngUxODiGB
        pYwSm98WgtgSAjISG79cZYWwhSX+XOti62LkAqr5yCixaGkLE4SzmVHi387t7CBVLAIqEq8e
        TGcCsdkEdCTOv7nDDGKLCGhI7JvQCxZnFsiQWPXiOlhcWMBa4tCiU2AbeAXMJQ6/+s8IMXQP
        o8T9Lw+YIRKCEidnPmGBaC6TuPqtkQ3kamYBaYnl/zhAwpwCZhINc5dBXaok8fVNL5RdK/H5
        7zPGCYzCs5BMmoVk0iyESRBhLYkb/14yYQhrSyxb+JoZwraVWLfuPcsCRvZVjCKppcW56bnF
        hnrFibnFpXnpesn5uZsYgTG57djPzTsY5736qHeIkYmD8RCjClDnow2rLzBKseTl56UqifBm
        2denCPGmJFZWpRblxxeV5qQWH2I0BYbiRGYp0eR8YLLIK4k3NDMwNTQxszQwtTQzVhLn9Szo
        SBQSSE8sSc1OTS1ILYLpY+LglGpgmnH607G8YOZNf1YYim68b7VjiuW9S7+PZXOwZirMLOM5
        u3layezmJWtdnf9u6mHf9ln8+USf6+9lV0Y0XGHZde/qb0OW3/MWJhbqdb7fMzfprqPI9pw0
        6ZkHOjUnnJK7f+K4+N3T+plN9zUO7X71edGCjKx5j83PbXp+op5T8fmEqXoyuu539L7atu5b
        mbux2sc1IjXraFlO9yr5dxNv5P5YuyM+42b2rMf33fRcDlryl7W4Fp5g85ryo5apf3eYTpN4
        Qun79DPzt1mkJ92/+GAbn2XG2fkC1/JaeHxqtrZ9FV0w3eT+oRqzXqU1PqU1gd98xPo9cvZO
        VvD9c6/x+s6TT2b7P52U9Hshc8n/VSeUWIozEg21mIuKEwEO9LqmXgMAAA==
X-CMS-MailID: 20230607081318eucas1p1c5adbc6abaa1bd9b236e596f7a08b2fb
X-Msg-Generator: CA
X-RootMTR: 20230602110640eucas1p11b79cbd7f116be6828a670f9873ed24e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602110640eucas1p11b79cbd7f116be6828a670f9873ed24e
References: <CGME20230602110640eucas1p11b79cbd7f116be6828a670f9873ed24e@eucas1p1.samsung.com>
        <20230602110638.789426-1-j.granados@samsung.com>
        <ZH+BWiQOSQGNDQCv@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--tzto3k5whkt5xwze
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 11:56:26AM -0700, Luis Chamberlain wrote:
> On Fri, Jun 02, 2023 at 01:06:30PM +0200, Joel Granados wrote:
> > Resending as the first set got mangled with smtp error.
> >=20
> > This is part of the effort to remove the empty element of the ctl_table
> > structures (used to calculate size) and replace it with an ARRAY_SIZE c=
all. By
> > replacing the child element in struct ctl_table with a flags element we=
 make
> > sure that there are no forward recursions on child nodes and therefore =
set
> > ourselves up for just using an ARRAY_SIZE. We also added some self test=
s to
> > make sure that we do not break anything.
> >=20
> > Patchset is separated in 4: parport fixes, selftests fixes, selftests a=
dditions and
> > replacement of child element. Tested everything with sysctl self tests =
and everything
> > seems "ok".
> >=20
> > 1. parport fixes: @mcgrof: this is related to my previous series and it=
 plugs a
> >    sysct table leak in the parport driver. Please tell me if you want m=
e to repost
> >    the parport series with this one stiched in.
> >=20
> > 2. Selftests fixes: Remove the prefixed zeros when passing a awk field =
to the
> >    awk print command because it was causing $0009 to be interpreted as =
$0.
> >    Replaced continue with return in sysctl.sh(test_case) so the test ac=
tually
> >    gets skipped. The skip decision is now in sysctl.sh(skip_test).
> >=20
> > 3. Selftest additions: New test to confirm that unregister actually rem=
oves
> >    targets. New test to confirm that permanently empty targets are inde=
ed
> >    created and that no other targets can be created "on top".
> >=20
> > 4. Replaced the child pointer in struct ctl_table with a u8 flag. The f=
lag
> >    is used to differentiate between permanently empty targets and non-e=
mpty ones.
> >=20
> > Comments/feedback greatly appreciated
>=20
> This all looks great, thanks so much for doing all this work! I pushed
> to sysctl-next.
I have a version where I replace the u8 flag with an enumeration with
two memebers. Tell me if it make sense to post the V2 and I'll send it
out after fixing it up a bit.

Best

Joel Granados

--tzto3k5whkt5xwze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSAPBYACgkQupfNUreW
QU/B3Qv7BliPNCxcKiu609ndtujxW6iO7EA/HFy7swUM+02NicOH2cjTWtW68W/n
4oT534vjY9rCTopitHQ6xqgJIqM02L5YFRAoq+BV2NyX2X/qNIcEb1Sv7+j1cPzO
z0D+UvnlqIb9Fu46dg3uLdWIXT2gzUuObwPfC4FTM1D2j8pp7ZdS4mQwSvDSNCSw
p2KzQQPsWzRt4UNAFsXo3cuDfPs/K3TiC7Cs3aV68MuH8MhUm3LjfKIw6FSlhqPi
pegwNEj+mGgABl0K/cPf0uuKaieQKNmx2PORr/3nZ5d14aUuYR/k6JSyWNq2DmJT
siBGSAz5l1BaqCKvVmVUbjfAXF3wTKOV+idoh0W1IGZnExu3EToAIIGLlghbOfYc
CNsp6LDRoGo2VFVveKhG01GYRSfv9fAbgwYjNDj0tHICB+vdRUAii2Y4pIwyDeGu
8Zw63t+SYhyOH94EJatbTDlCw187ypm35l5G8aEpNzYDu35L9VwESwckvupRK4wU
SWuXixYO
=lAan
-----END PGP SIGNATURE-----

--tzto3k5whkt5xwze--
