Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA24F41EE67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 15:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhJANVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 09:21:07 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:25560 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352696AbhJANVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:21:04 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211001131911epoutp01a0efa263904c81decbe0a243b8945d41~p6qkdc81W0729107291epoutp01o
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Oct 2021 13:19:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211001131911epoutp01a0efa263904c81decbe0a243b8945d41~p6qkdc81W0729107291epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1633094352;
        bh=Uoq8lJdkPEySjR00dTt/XhZVBdKIweEujHidGpEDP7E=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=CeabwzhkPS+EgeSt4ePwbkklXrJ8HJoad9vUB8xvhb9v9SRuTvinFR8c0qGf2zWRE
         zE1LGmllQ+TBL7JX0XUt7EW9KmsYQgGPVebG5Q0qxtfxoVkGZFnftpR3RVGY8XIEmz
         r55sByz6S/BLwLhnp3kZUxBGAIitJTegBuGl6Pac=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211001131911epcas1p3ef202b1fbbc229cb3013d3e72bd08a13~p6qj-YDEH2548425484epcas1p3d;
        Fri,  1 Oct 2021 13:19:11 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.250]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HLW0Y6QsQz4x9Pw; Fri,  1 Oct
        2021 13:19:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.5E.24398.CCA07516; Fri,  1 Oct 2021 22:19:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211001131908epcas1p36430ce381613d8e0f9f613f3e0ebadb5~p6qhSRmqs2548425484epcas1p3a;
        Fri,  1 Oct 2021 13:19:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211001131908epsmtrp1731e9a23852b65d7d00835d1408f7c6b~p6qhP6OC02253322533epsmtrp1-;
        Fri,  1 Oct 2021 13:19:08 +0000 (GMT)
X-AuditID: b6c32a35-0d7ff70000005f4e-81-61570accd885
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.F3.09091.BCA07516; Fri,  1 Oct 2021 22:19:07 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20211001131908epsmtip2dd46e9e0b840b8a6217e5632f523fd59~p6qhEzMTo1763117631epsmtip2E;
        Fri,  1 Oct 2021 13:19:08 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>,
        "'Chung-Chiang Cheng'" <cccheng@synology.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shepjeng@gmail.com>, <sj1557.seo@samsung.com>
In-Reply-To: <CAKYAXd_1ys-xQ9HusgqSr5GHaP6R2pK4JswfZzoqZ=wTnwSiOw@mail.gmail.com>
Subject: RE: [PATCH] exfat: use local UTC offset when EXFAT_TZ_VALID isn't
 set
Date:   Fri, 1 Oct 2021 22:19:07 +0900
Message-ID: <997a01d7b6c6$ea0c3f50$be24bdf0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGbLD2CCutv2trCrUWvFxdYN9vjigGoD6NLAWfhRkasHqXMoA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmvu4ZrvBEgyVthhZbnx1ntZg4bSmz
        xZ69J1ksLu+aw2bROlvSYsu/I6wObB47Z91l99i0qpPNo2/LKkaPGR/2s3p83iQXwBqVbZOR
        mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdICSQlliTilQ
        KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj2b+t
        rAX3+CtOXvjI3sC4jLeLkZNDQsBEYvGk64xdjFwcQgI7GCXO9z9mgnA+MUoc/HuTDcL5xiix
        59hZJpiW3e2/oBJ7GSV+n9zBCuG8ZJT433kZrIpNQFfiyY2fzCC2iECMxMQlr9hBbGaBUonb
        K1aygticAoESV/YvBqsXFgiQ6J15ASzOIqAicej8JDCbV8BSouf2c3YIW1Di5MwnLBBztCWW
        LXzNDHGRgsTuT0dZIXY5SZxb2MQEUSMiMbuzDaqmk0Oi9X4EhO0iMefmHahvhCVeHd/CDmFL
        Sbzsb4Oy6yX+z1/LDvKYhEALo8TDT9uAGjiAHHuJ95csQExmAU2J9bv0IcoVJXb+nssIsZZP
        4t3XHlaIal6JjjYhiBIVie8fdrLAbLry4yrTBEalWUgem4XksVlIHpiFsGwBI8sqRrHUguLc
        9NRiwwJDeGQn5+duYgSnTS3THYwT337QO8TIxMF4iFGCg1lJhPeHeHCiEG9KYmVValF+fFFp
        TmrxIUZTYFBPZJYSTc4HJu68knhDE0sDEzMjEwtjS2MzJXHeY68tE4UE0hNLUrNTUwtSi2D6
        mDg4pRqYKjcIP/w9iy/hSJbq7cmKvjnON+02vCjVumrcvdp56/zH6fdlUpIfPN8UwVMuveTg
        Md7dDMKyJQJHfm7IuK+84VXAjUz3CY0fzb7qLby8oz6Rj2+qrv3my1etM10Lq53Viy5c3vd7
        xXt1XwWPitRN3m/dVJeW2DT1fWhkyhJP3T9/yylz30ZrlUuefm4ztlZGXfncduqpZWp7b41G
        vKFp6bSZxUY7LDPvZpdo7Y94edGs6J3YypwpbRoGFzqdWDx12JdXJP70+HQt7JTNmpRtDrVL
        1IXu751R+GeLh73fF/OSKdGREybfdJTv+VHf3Wknx6tjKJETszWoo23Tl9hSDva3rCe827N4
        LY1+3FFiKc5INNRiLipOBACC5FMwJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSvO5prvBEgylLzC22PjvOajFx2lJm
        iz17T7JYXN41h82idbakxZZ/R1gd2Dx2zrrL7rFpVSebR9+WVYweMz7sZ/X4vEkugDWKyyYl
        NSezLLVI3y6BK+PLvfyCA/wV/Q/fMjYwtvB2MXJySAiYSOxu/8XWxcjFISSwm1Hi4ObN7F2M
        HEAJKYmD+zQhTGGJw4eLIUqeM0pc3bqUDaSXTUBX4smNn8wgtohAjMSPN9/YQWxmgUqJMx+f
        s0A0XGSU2PNrIitIglMgUOLK/sVMIEOFBfwk5u+0BwmzCKhIHDo/CayEV8BSouf2c3YIW1Di
        5MwnLBAztSV6H7YywtjLFr5mhrhfQWL3p6OsEDc4SZxb2MQEUSMiMbuzjXkCo/AsJKNmIRk1
        C8moWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4eLc0djNtXfdA7xMjE
        wXiIUYKDWUmE94d4cKIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotg
        skwcnFINTLX6aSryrv02YqyHbH5XT1h91Fj9NYPgN26Denk77njPMlXzbL7Hx/+sVbuc1vYt
        sXeiy6JgqTtLed7JyBb5bTvA4XFZ5e81w/oGxaNzM+5+vZ+3yWneJcXex46OjbqP/ufsP3s4
        VmKP46+5Ue+iOGzPXOd4lnHMrytl34fo30d6r8//wXH9RP3CjaEr2K0S9/CplLLvzF6xttQ1
        Q23VLRnF2L1vTHIOLou48d7KNeDoC9Vfoue2Jf+be+Ujk9GCySe/rlEo+pM9e4vwj78bJhf3
        Js9xEwq6aW/D9Dri2Oqbk+w/TnMN5MoT65SSYK/u1lxx4b2kxfR1fvl5ZVJNq+fHLp75NThZ
        Rnlr34LDAkosxRmJhlrMRcWJAMZ/D+UNAwAA
X-CMS-MailID: 20211001131908epcas1p36430ce381613d8e0f9f613f3e0ebadb5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210910010035epcas1p496dd515369b9f2481ccd1c0de5904bbd
References: <20210909065543.164329-1-cccheng@synology.com>
        <CGME20210910010035epcas1p496dd515369b9f2481ccd1c0de5904bbd@epcas1p4.samsung.com>
        <CAKYAXd_1ys-xQ9HusgqSr5GHaP6R2pK4JswfZzoqZ=wTnwSiOw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Namjae,

I found an important difference between the code we first wrote and the cod=
e that has changed since our initial patch review. This difference seems to=
 cause compatibility issues when reading saved timestamps without timezone.=
 (In our initial patch review, there were concerns about possible compatibi=
lity issues.)
I think the code that reads timestamps without timezone should go back to t=
he concept we wrote in the first place like reported patch.
It could be an answer of another timestamp issue.

Could you please let me know what you think?

Thanks.
> -----Original Message-----
> From: Namjae Jeon =5Bmailto:linkinjeon=40kernel.org=5D
> Sent: Friday, September 10, 2021 10:01 AM
> To: Chung-Chiang Cheng <cccheng=40synology.com>
> Cc: sj1557.seo=40samsung.com; linux-fsdevel=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; shepjeng=40gmail.com
> Subject: Re: =5BPATCH=5D exfat: use local UTC offset when EXFAT_TZ_VALID =
isn't
> set
>=20
> 2021-09-09 15:55 GMT+09:00, Chung-Chiang Cheng <cccheng=40synology.com>:
> > EXFAT_TZ_VALID is corresponding to OffsetValid field in exfat
> > specification =5B1=5D. If this bit isn't set, timestamps should be trea=
ted
> > as having the same UTC offset as the current local time.
> >
> > This patch uses the existing mount option 'time_offset' as fat does.
> > If time_offset isn't set, local UTC offset in sys_tz will be used as
> > the default value.
> >
> > Link: =5B1=5D
> > https://protect2.fireeye.com/v1/url?k=3Dcba4edf5-943fd4c8-cba566ba-0cc4=
7
> > a31309a-e70aa065be678729&q=3D1&e=3D225feff2-841f-404c-9a2e-c12064b232d0=
&u=3D
> > https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows%2Fwin32%2Ffileio%2F
> > exfat-specification%2374102-offsetvalid-field
> > Signed-off-by: Chung-Chiang Cheng <cccheng=40synology.com>
> Please read this discussion:
>  https://patchwork.kernel.org/project/linux-
> fsdevel/patch/20200115082447.19520-10-namjae.jeon=40samsung.com/
>=20
> Thanks=21

