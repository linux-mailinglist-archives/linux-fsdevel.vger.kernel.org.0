Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42E21B0004
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 04:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgDTCvt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 22:51:49 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:39465 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgDTCvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 22:51:47 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200420025144epoutp04fe0a1d6225ade3d42f3163cd2ba15129~HZ2t5uNyG0117701177epoutp04N
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 02:51:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200420025144epoutp04fe0a1d6225ade3d42f3163cd2ba15129~HZ2t5uNyG0117701177epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587351105;
        bh=8RlXmKz8QkC04fCSaNMcmCEssoPxGLUFth6XfKd3Nz0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=j7LmsKTbswiPdL3tyyc37KooWnKEm4AoLxKtGDI4p877QMCEZ5GEiKVYtCstZu3nG
         4CNLY2EZawl8FEe52GOw8LqVoH/e52EtYcsRRCUndPvk9TYVmdS0M9eCdN9/fayrt8
         dj34ZGKTpLDwlmRHpdr1uohEEACbtp/nyiBDDwxk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200420025144epcas1p22444062d0d038bdab61830b19afc910a~HZ2teqVBu3044930449epcas1p2h;
        Mon, 20 Apr 2020 02:51:44 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 495B6l0wKTzMqYkg; Mon, 20 Apr
        2020 02:51:43 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.AD.04744.F3E0D9E5; Mon, 20 Apr 2020 11:51:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200420025142epcas1p14718dfb0b17f851b4086dbb47f99c9c6~HZ2rzjh290279902799epcas1p1D;
        Mon, 20 Apr 2020 02:51:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200420025142epsmtrp15ae30756dfaa08132c970fb0d1ac49d0~HZ2ry2uha0867708677epsmtrp1J;
        Mon, 20 Apr 2020 02:51:42 +0000 (GMT)
X-AuditID: b6c32a38-253ff70000001288-db-5e9d0e3f0f60
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.B2.04024.E3E0D9E5; Mon, 20 Apr 2020 11:51:42 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200420025142epsmtip2e99aa6298b02e05adff0559a36a30a58~HZ2rmmVj63023330233epsmtip2U;
        Mon, 20 Apr 2020 02:51:42 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>,
        "'Tetsuhiro Kohada'" <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <b250254c-3b88-9457-652d-f96c4c15e454@gmail.com>
Subject: RE: [PATCH v3] exfat: replace 'time_ms' with 'time_cs'
Date:   Mon, 20 Apr 2020 11:51:42 +0900
Message-ID: <000001d616be$9f4513b0$ddcf3b10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFivWokrSbtdWWlBCyBJ+5kie97TAJblN7TAlgE3H8CLx+Gk6kw10GA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURDHed3ttqjVtYBOajR1EzwDtrSF1VAgkZAmYNLoJ41SV3gWYi+7
        rRH9ghoLEqMQg4YCIlGLoEZFNKgQI3iEL6KC8YrW+0bkEPAIuu2WyLffzPznzfFGTigbKZW8
        0OHBbgdnY6gp5OXOxYkJ6dNrczW9Ryl2rPYZyX7tqiTZtvYuku25WkOxPX8HSTYwfIhkW8Zv
        SjNkpuGaOzKT79C4zLTndiNluuJ/LjMdaGlCpqHmeWZqnS21AHP52K3GjjxnfqHDamSy11hW
        WgzJGm2CdjmbwqgdnB0bmcwcc0JWoU3ohVFv42xewWXmeJ5Zlpbqdno9WF3g5D1GBrvybS6t
        xpXIc3be67Am5jntK7QaTZJBUG60FRw8Mky4LsRtD/ZPLUYnlGUoWg60Hk6P1ElCrKRbEQy9
        tJShKQIPIrh18ZJUNEYQvG/rRRMZ5/eOScRAO4LR4vqI8QnB4fvvqZCKohNg/M/1MMfSXggO
        +ImQiKC7EZSXjxOhQDRthDd/f5MhjqHToTHYLQ0xScfDld9Pwk0p6OVwsuYxEnkmdFW9DesJ
        eikE6r8QYktq+PkuIBWLZcHxphcRTSxU7/OFCwM9REHDSF0kIRN+PTpDihwDn++0yERWwaeD
        PoHlAu+EgesReSmCj6NGkXXw5Nx5aUhC0Ivh3NVlonu+0HItEstOh28/9kvFVxRQ6ousOh4O
        POiUiDwHykq+y8oR4580mH/SYP5JA/j/FzuGyCY0C7t4uxXzWpd+8l83o/CZLmFbUdvdnA5E
        yxEzTRFVXZOrlHLb+CJ7BwI5wcQqbmRV5SoV+VzRDux2WtxeG+Y7kEHYewWhistzCkfv8Fi0
        hiSdTsfqk1OSDTpmtqLykS1XSVs5D96CsQu7J/Ik8mhVMUpZtDvjQ2Bn61pH+tf2OM/Cs3vq
        yjZLVGPDUekZH68NpnSX/NoU/LHat6qCGz3yasMpfSbu35XU8HBh7f7K5q1JqdHY3D+3SnV2
        jjG7p7rvqc/6un3r+k1ZVN/UE/c6M2aseLkg7Wi24d6GeQ/RNfOL+9+/xZVIKlb26dsSLwZN
        o4EPDMkXcNolhJvn/gGVTeS0vAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSvK4d39w4g+0XVC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBbFZZOSmpNZllqkb5fAldHa0sFY8FekYt2bBywNjA8Euxg5OSQETCQ2tP5g6mLk
        4hAS2M0ose7zNXaIhLTEsRNnmLsYOYBsYYnDh4shap4zSnyf3ckIUsMmoCvx789+NhBbRKBU
        4t/eiWCDmAUuMkr8P7eODaKjiUmif+0RsCpOAVuJx/9/s4DYwgL2Eivvn2cFsVkEVCV2/r7J
        BGLzClhKLJ1zgxHCFpQ4OfMJWD2zgLbE05tP4exlC18zQ1yqIPHz6TJWiCvcJBavugdVIyIx
        u7ONeQKj8Cwko2YhGTULyahZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQI
        ji0tzR2Ml5fEH2IU4GBU4uFlmD0nTog1say4MvcQowQHs5II70G3mXFCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1MGYzRKmUTLtsckTAjJ01ne2paQGj
        ffe2Gdd2yHqpLj6wPZLF/3fnorBAPQ+hpP0Nf7Y+8W84dXPN+n0TBXyeBqlKxdv0GKk+fPx2
        A99jXZvsK+sW3mXpOLXAXEVs79GkrRM+r1doX969bJru1F5R2Zj5BduMRfsLZBlfLdofscvV
        d8vkv+nX4pRYijMSDbWYi4oTAUamYxmpAgAA
X-CMS-MailID: 20200420025142epcas1p14718dfb0b17f851b4086dbb47f99c9c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200416085144epcas1p1527b8df86453c7566b1a4d5a85689e69
References: <CGME20200416085144epcas1p1527b8df86453c7566b1a4d5a85689e69@epcas1p1.samsung.com>
        <20200416085121.57495-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
        <003601d61461$7140be60$53c23b20$@samsung.com>
        <b250254c-3b88-9457-652d-f96c4c15e454@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 2020/04/17 11:39, Namjae Jeon wrote:
> >> Replace =22time_ms=22  with =22time_cs=22 in the file directory entry
> >> structure and related functions.
> >>
> >> The unit of create_time_ms/modify_time_ms in File Directory Entry are
> >> not 'milli-second', but 'centi-second'.
> >> The exfat specification uses the term '10ms', but instead use 'cs' as
> >> in =22msdos_fs.h=22.
> >>
> >> Signed-off-by: Tetsuhiro Kohada
> >> <Kohada.Tetsuhiro=40dc.MitsubishiElectric.co.jp>
> >> ---
> > I have run checkpatch.pl on your patch.
> > It give a following warning.
> >
> > WARNING: Missing Signed-off-by: line by nominal patch author
> > 'Tetsuhiro Kohada <Kohada.Tetsuhiro=40dc.mitsubishielectric.co.jp>'
> > total: 0 errors, 1 warnings, 127 lines checked
> >
> > Please fix it.
>=20
> I want to fix it, but I'm not sure what's wrong.
> The my patch has the following line:
>=20
> Signed-off-by: Tetsuhiro Kohada
> <Kohada.Tetsuhiro=40dc.MitsubishiElectric.co.jp>
>=20
> Both my real name and email address are correct.
> Can you give me some advice?
Your address in author line of this patch seems to be different with Your S=
igned-off-by.

From: Tetsuhiro Kohada <Kohada.Tetsuhiro=40dc.mitsubishielectric.co.jp>
=21=3D
Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro=40dc.MitsubishiElectric.c=
o.jp>

What is correct one between the two?
I guess you should fix your mail address in your .gitconfig
Or manually add From: your address under subject in your patch like this.
---------------------------------------------------------------------------=
----
Subject: =5BPATCH v3=5D exfat: replace 'time_ms' with 'time_cs'
From: Tetsuhiro Kohada <Kohada.Tetsuhiro=40dc.MitsubishiElectric.co.jp>

Replace =22time_ms=22  with =22time_cs=22 in the file directory entry struc=
ture
and related functions.

The unit of create_time_ms/modify_time_ms in File Directory Entry are not
'milli-second', but 'centi-second'.
The exfat specification uses the term '10ms', but instead use 'cs' as in
=22msdos_fs.

Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro=40dc.MitsubishiElectric.c=
o.jp>
---------------------------------------------------------------------------=
-----

>=20
> *** Currently I can't use office email, so I'm sending it from private
> email instead.
>=20
>=20
> --
> =E3=81=93=E3=81=AEE=E3=83=A1=E3=83=BC=E3=83=AB=E3=81=AF=E3=82=A2=E3=83=90=
=E3=82=B9=E3=83=88=20=E3=82=A2=E3=83=B3=E3=83=81=E3=82=A6=E3=82=A4=E3=83=AB=
=E3=82=B9=E3=81=AB=E3=82=88=E3=82=8A=E3=82=A6=E3=82=A4=E3=83=AB=E3=82=B9=E3=
=82=B9=E3=82=AD=E3=83=A3=E3=83=B3=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=
=BE=E3=81=99=E3=80=82=0D=0A>=20https://www.avast.com/antivirus=0D=0A=0D=0A=
=0D=0A
