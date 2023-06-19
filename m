Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BF9734C6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 09:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjFSHcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 03:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFSHcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:32:17 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97921A8;
        Mon, 19 Jun 2023 00:32:15 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230619073213euoutp024d0e7c73ce95ccf6f0ad8c2073c3ef30~p-wUnPPuQ1986219862euoutp02d;
        Mon, 19 Jun 2023 07:32:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230619073213euoutp024d0e7c73ce95ccf6f0ad8c2073c3ef30~p-wUnPPuQ1986219862euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687159933;
        bh=bGsQMMH36FeIp20BbiDuqLy3UEs4/0VEDllfDa10Zu8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=nL6k5s10Rg5oUDU5B4OPCNcVLAnNJKp54Ai65Xc0pvRE9vTy62WKqdy0KPI34DYm/
         2oImkWSZpQuc8d/SmU8RJYpPppqifcTQIKmyV0Oj2dFFWkP/qUya1ij2suRx0AanKR
         vmGKh5woL2ofW07aPI/MY5sYc1rK/tB6on8xzqoA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230619073212eucas1p18b63ba5a3907c7be3a8f15eb1110051d~p-wUgBFRM0881108811eucas1p1d;
        Mon, 19 Jun 2023 07:32:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3A.3F.42423.C7400946; Mon, 19
        Jun 2023 08:32:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230619073212eucas1p161c80ba0d0ee6f2b60163a404dab86c0~p-wUOjeec0147601476eucas1p17;
        Mon, 19 Jun 2023 07:32:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230619073212eusmtrp258b61abffc723cb007963bc51d2e6614~p-wUN1lOB1191211912eusmtrp2k;
        Mon, 19 Jun 2023 07:32:12 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-7c-6490047c8a07
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 73.F9.10549.C7400946; Mon, 19
        Jun 2023 08:32:12 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230619073212eusmtip1bac64a5168f4aaa56cd225ef1000765a~p-wT_rv7u0463604636eusmtip1L;
        Mon, 19 Jun 2023 07:32:12 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 19 Jun 2023 08:32:11 +0100
Date:   Mon, 19 Jun 2023 09:32:12 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] Remove child from struct ctl_table
Message-ID: <20230619073212.cwx7qvytrhiyyq74@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="25fuaebjjqwa3iru"
Content-Disposition: inline
In-Reply-To: <ZI7Pbw5WcJDDISYI@bombadil.infradead.org>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87o1LBNSDP5PN7bYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgiuKySUnNySxLLdK3S+DKmL3JuuCVWMWva6uYGxjf
        CXUxcnJICJhIPD3czNLFyMUhJLCCUeLS47mMEM4XRolXjQ3MEM5nRokNN9tY4VqeLWGFSCxn
        lPi1bRkjXFV3y0aoYVsYJXpfT2UCaWERUJW4uOEFWDubgI7E+Td3mEFsEQENiX0TesFqmAUy
        JL7OP8gOYgsL2EnsuD+dBcTmFTCXuDD1BCOELShxcuYToDgHUH2FxKGeYghTWmL5Pw4Qk1PA
        TGLXajeIO5Ukvr7phbq5VuLUlltMIJdJCLzgkDi/7QETRMJF4urJT1C2sMSr41vYIWwZif87
        50M1TGaU2P/vAzuEs5pRYlnjV6gOa4mWK0+gOhwl3rUdA7tNQoBP4sZbQYi3+CQmbZvODBHm
        lehog4a7msTqe29YJjAqz0Ly2CyEx2YhPDYLbI6OxILdn9gwhLUlli18zQxh20qsW/eeZQEj
        +ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAVHT63/FPOxjnvvqod4iRiYPxEKMKUPOj
        DasvMEqx5OXnpSqJ8Abt7UsR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqttezJZSCA9sSQ1OzW1
        ILUIJsvEwSnVwGRu9LCg/GVBsU7tro37v5/kk6i9ZP/S5OzlzqpJHMveH2i7ZprVWR6c2aGo
        mGDqLpLHuGOjUL3eyUSJTYsnnnod2Mqhc8Mg9+etog8yYcZ/pjv1uNzJEq8P3xfOY+zYt71e
        pv3c9vf9L9JmCKvUX/+Z9vNqbeIBpd17ZJ83TrZv1rRglO/pFazyfd3+/eA9y+/zfOcsf/1t
        e/jr/73CtS490kKb/0UdyJ3B2m62XImt8oHeeekVzMrsK4qys0XPahcvPKdwP6Ktqebtfcmk
        7ksnEpb3310lvqPXJqXVl1Uu4q0cl8th7+Vhu26brPz96c/VPZntvcmtvy60VHPemh1k+UJ0
        Wta1fus/10v9lViKMxINtZiLihMBY40PnMADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7o1LBNSDKa0ylns2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehltPw/xFbwQqyiZcl09gbGN0JdjJwcEgImEk+fLWHtYuTi
        EBJYyijRtuM8K0RCRmLjl6tQtrDEn2tdbBBFHxklFl3czQThbGGUePdyPiNIFYuAqsTFDS/A
        OtgEdCTOv7nDDGKLCGhI7JvQywRiMwtkSHydf5AdxBYWsJPYcX86C4jNK2AucWHqCUaIoXsZ
        Jd5f+8sMkRCUODnzCQtEc5nEj94FQM0cQLa0xPJ/HCAmp4CZxK7VbhCHKkl8fdMLdXStxOe/
        zxgnMArPQjJoFpJBsxAGQYS1JG78e8mEIawtsWzha2YI21Zi3br3LAsY2VcxiqSWFuem5xYb
        6hUn5haX5qXrJefnbmIERuW2Yz8372Cc9+qj3iFGJg7GQ4wqQJ2PNqy+wCjFkpefl6okwhu0
        ty9FiDclsbIqtSg/vqg0J7X4EKMpMBAnMkuJJucD00VeSbyhmYGpoYmZpYGppZmxkjivZ0FH
        opBAemJJanZqakFqEUwfEwenVANT/b0odqkq8cZ/+aq/VcQ/6Nuv7Ilyrr/46brtIpfu02Li
        D4Nf5k++GGrz80XvdUfVeJU5YZZV21e6nbks5pLOmLXHY0vXsfLXZ1+Yfn77pSh38zWrjCNn
        5VMr3XrVfhVr7ZStLToWLejmorGh88zzjdscoo/NO39v56KXrt/sL1pYLVd/wZ+x63q63fTY
        T4d+yylXrvRMquiRzVNcEvv1fZCizcaXDdvVoxbvXNgyr33rHOUv4psOWIcx3xdmu/bF4+2h
        H/vnTr+cxBb70HlPpMxeO7uja42DAvd8KTud3HJhbeKhKv+CtPYOOWvbexM/bKpf/9p699V9
        ee2TV1S+XnAk6+yB98b+gtom09sFlFiKMxINtZiLihMBQgbVFF8DAAA=
X-CMS-MailID: 20230619073212eucas1p161c80ba0d0ee6f2b60163a404dab86c0
X-Msg-Generator: CA
X-RootMTR: 20230616085926eucas1p10709e25a4c0246ed2b22da602f919b4e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230616085926eucas1p10709e25a4c0246ed2b22da602f919b4e
References: <CGME20230616085926eucas1p10709e25a4c0246ed2b22da602f919b4e@eucas1p1.samsung.com>
        <20230616085922.3066990-1-j.granados@samsung.com>
        <ZI7Pbw5WcJDDISYI@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--25fuaebjjqwa3iru
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 18, 2023 at 02:33:35AM -0700, Luis Chamberlain wrote:
> On Fri, Jun 16, 2023 at 10:59:14AM +0200, Joel Granados wrote:
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
> > 1. parport fixes: This is related to my previous series and it plugs a =
sysct
> >    table leak in the parport driver. @mcgrof: I'm just leaving this her=
e so we
> >    don't have to retest the parport stuff
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
> > 4. Replaced the child pointer in struct ctl_table with an enum which is=
 used to
> >    differentiate between permanently empty targets and non-empty ones.
> >=20
> > V2: Replaced the u8 flag with an enumeration.
>=20
> Thanks, I dropped the old patches and applied this new set. Pushed out
> to sysctl-next.
Awesome! thx.
>=20
>   Luis

--=20

Joel Granados

--25fuaebjjqwa3iru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSQBHwACgkQupfNUreW
QU9JFwwAhczAs8To972VFYR8Y1vQt5VoRblkCfKn7tBW2MM0acT3X2Uvjmnbt7qM
/cZXilAewh/4Ds4URg50s74+7+J8rXMyDkORSem6nu5hDZip95e9JbhLQTHLLG5T
Tx9/w9O6rIJq+FOJOYjb9Ei5TUUop86fQjRgkJLS6uqMOkh1f2Mm5Zw6TYM6U7Bs
YhBLkLbOD/vuast69lW+iLSYh6OOFeVaCJ1Ppl7/WH3CK4jpDrOO7wdcZTpC9kuA
DCjoTqIsEY11ZrExZkkQSW/igMr75fGkpHMO+EFew4QVIRdv37zn/c5n0uQCXMZs
L7THfQ3jw4IeAhqMqOR7GlFV38YzqunCW7ZtTLwGYpD1rX+hl201n6VT6keZFUNb
8v3vCW14Ey0F+adVX7PQ30ABn9oBmiXOSVY+GctZWVPC9lv/aC2fFhqpglYggjcl
Fsu1E/hnn/aPFtq7tO926pX4skYfmAj0kqbNQMhhgwbBxWX2hLeX8JSrTGWBc7xi
vj5Tfm0p
=YPb0
-----END PGP SIGNATURE-----

--25fuaebjjqwa3iru--
