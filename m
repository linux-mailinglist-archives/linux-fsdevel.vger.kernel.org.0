Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A67123B5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 01:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLRAJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 19:09:08 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:33515 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLRAJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:09:08 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191218000905epoutp03e121a883402c2d201934b4e5e706dec6~hTpTF995P2956929569epoutp03p
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 00:09:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191218000905epoutp03e121a883402c2d201934b4e5e706dec6~hTpTF995P2956929569epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576627745;
        bh=ZN9xUok03wojfck5X29qiSCp6pV0bXbuVMqbinHqCFw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=oDT0ivPpbDExZir+X6rmdg7ndbCtIbH7saBg4Z64/lhNVpvV3A/8gtdROrqf+JF4n
         oocimbnGnSAhLaZMIr3KZmpbNrK8gVaps+Podv3Igfbr1AIocMF0igcrMXEMiKmbCP
         Pk2Gj5EG8s1oo1l0AHQ8qezd1NN2KFrJ1tiP5h3c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191218000905epcas1p351524d8a92065fe9994033b3551333c5~hTpSzMG3y2959629596epcas1p3h;
        Wed, 18 Dec 2019 00:09:05 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47cwNJ1pKpzMqYkf; Wed, 18 Dec
        2019 00:09:04 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.7C.48498.F1E69FD5; Wed, 18 Dec 2019 09:09:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191218000903epcas1p4dac913df29b69ad4bb7b10ab7c5f3ed9~hTpRSNClN0750607506epcas1p4S;
        Wed, 18 Dec 2019 00:09:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191218000903epsmtrp2dbf53d8f6e910a02fcb199bbe380db8a~hTpRRfGPK2559725597epsmtrp2N;
        Wed, 18 Dec 2019 00:09:03 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-cb-5df96e1f3fca
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.12.06569.F1E69FD5; Wed, 18 Dec 2019 09:09:03 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20191218000903epsmtip1c8cbf3f94ca6a37a6cadfe3048133823~hTpRHGy3F1844618446epsmtip1T;
        Wed, 18 Dec 2019 00:09:03 +0000 (GMT)
From:   =?UTF-8?Q?=EC=A0=84=EB=82=A8=EC=9E=AC/S/W_Platform_Lab=28VD=29/Staff_E?=
         =?UTF-8?Q?ngineer/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90?= 
        <namjae.jeon@samsung.com>
To:     "'Enrico Weigelt, metux IT consult'" <lkml@metux.net>
Cc:     <linux-kernel@vger.kernel.org>, "'Christoph Hellwig'" <hch@lst.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        =?UTF-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@vt.edu>,
        <linux-fsdevel@vger.kernel.org>
In-Reply-To: <c6698d0c-d909-c9dc-5608-0b986d63a471@metux.net>
Subject: RE: [PATCH v7 01/13] exfat: add in-memory and on-disk structures
 and headers
Date:   Wed, 18 Dec 2019 09:09:03 +0900
Message-ID: <000701d5b537$5b196f80$114c4e80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFm2LC/h6nQOwj4JCuWUtKX9oQxIwE+vU/YAbPr/rABlbE1VAIBAPMfqGhx/ZA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTu3b27u1qL61p2MMp1oaBktrm2buX6IIlRK6x+BNmwm95U2he7
        W6T90IxsipWRFNoH2SjQPpy5/Kr1sSlmQmplOcR+REmfakmZBNXmXeS/5znvc85zznkPiclq
        iQQyz+rkHFbWTBOxeFNwqVKZaJ00qRp/KpmjnnqCqb3eIWLu+btw5nnbBYLxe5oljO93u5h5
        NjqGr5cYHly8ITHcDRURhoqxL4ThpK8OGcZvLzQEmj8T6cRuc2oux2ZzDgVnzbJl51lz9PSW
        nZkbM7U6lVqpXsWspBVW1sLp6TRjunJTnjncC604yJpd4VA6y/P08rWpDpvLySlybbxTT3P2
        bLNdrbIn86yFd1lzkrNsltVqlSpFG1buNec2hI4Q9gB5qLjyjKQIeSRlKIYEagUM33siLkOx
        pIxqQXBq4FaUfEPQG3wTJT/CpLUK/UvxTj6UCA9+BD8G6nGBfEAQvNkoihCCuoqgcvQFHkmR
        U6vgcWMrFsEYVS6CmpdxERxD6aG7uHhKM4faBadKO6YwTi2Gjj/DYQuSlIZz71clRcJSKg66
        qt7iQpkkuFbzCRM6UsDku2viiFxObYMT7XMFiRzOl5ZgkXaAmiCgpaE/OkEadF5qj+I58LHT
        F11GAoyP+IlIHaAOw9cH0fJuBO8n9ALWQKjeO2WFUUuhvm25EF4Erb8uIsF2Nox8LxcLVaTg
        LpEJksVw8llQJOD5UHZ8TFKB6Oppc1VPm6t62gDV/80uI7wOxXN23pLD8Wp7yvS/vo2mznSZ
        rgVdeWoMIIpE9CypasakSSZmD/L5lgACEqPl0hbFhEkmzWbzCziHLdPhMnN8AGnDWz+NJczN
        soWP3urMVGtTNBoNs0K3UqfV0POk5M8+k4zKYZ3cAY6zc45/eSIyJqEI3ZG/WKeYaQn6ffs3
        GTVXxre+aXVPZLjdSyoKjfnipJ7QZ08edF0ddSVl7H0UJHoponeHN44Xq+wZjnML2poKywsy
        zm5ucIeae74XjOxpN4aGLr16HT+o6wuNDJiODx1h1mzobnLG9A9+KrVsVyuTC33eworEY/sS
        g7dm1Xg/0Dify6qXYQ6e/QtSr4/YvAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSnK583s9YgzvTJCyaF69ns1i5+iiT
        xZ69J1ksLu+aw2axd/F2dost/46wWlx6/4HFgd1j/9w17B67bzaweUz48JbNo2/LKkaPz5vk
        PA5tf8MWwBbFZZOSmpNZllqkb5fAlXHp3CGmgqvsFbc2rGJuYOxg62Lk5JAQMJHY8PMAexcj
        F4eQwG5GiVnf3jBDJKQljp04A2RzANnCEocPF0PUPGeUmLp3GjOIwyawmFGirecOE0iDiICl
        xInNO8ESzAITmCQ2TepkhmiZxSRx8N5PsLGcArYSp5uaWEBsYYFQiRWHH4HdwSKgKnH0/zN2
        kHW8QJP2zdQGCfMKCEqcnPkErJxZQFui92ErI4y9bOFrqEsVJH4+XcYK0ioi4CfRe0QUokRE
        YnZnG/MERuFZSCbNQjJpFpJJs5C0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJ
        ERxZWlo7GE+ciD/EKMDBqMTDe+Pvj1gh1sSy4srcQ4wSHMxKIrw7FL7HCvGmJFZWpRblxxeV
        5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCUamBUeGFxaEdB0bOWb4UfWkVXHkpn
        mFXlav3PZOc7ma+ieusLZuVMnGxtsObc/wPvrhyJ/3Tl2AWHBwEWqewH/qx8v/PMhLlH63aH
        /JpWfG2W1skHXuZfalO6QvzUd3z5bSWiOalRjlPU5cDmQ8/7pef5u+zkuPkib76yhwPvCV62
        v6u/fXLMKJbpUmIpzkg01GIuKk4EAMle7fqoAgAA
X-CMS-MailID: 20191218000903epcas1p4dac913df29b69ad4bb7b10ab7c5f3ed9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191216135033epcas5p3f2ec096506b1a48535ce0796fef23b9e
References: <20191213055028.5574-2-namjae.jeon@samsung.com>
        <CGME20191216135033epcas5p3f2ec096506b1a48535ce0796fef23b9e@epcas5p3.samsung.com>
        <088a50ad-dc67-4ff6-624d-a1ac2008b420@web.de>
        <002401d5b46d$543f7ee0$fcbe7ca0$@samsung.com>
        <c6698d0c-d909-c9dc-5608-0b986d63a471@metux.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> By the way: do you think the driver is already stable enough for
> production use ?
Yes, I think it's stable enough. Our exfat has been in our products for yea=
rs
and many issues have been fixed.
If you find any issue, Let me know it.

> Are there any limitations we have to consider ?
Well, I think that there is currently no proper mkfs(format), fsck(repair) =
tool for linux-exfat.
I am working on it and will announce it here as soon as possible.

> I just have a client, who wants to use it in a semi-embedded (telemetry)
> device, for recording to an external USB drive.
>=20
>=20
> --mtx
>=20
>=20
> --
> ---
> Hinweis: unverschl=C3=BCsselte=20E-Mails=20k=C3=B6nnen=20leicht=20abgeh=
=C3=B6rt=20und=20manipuliert=0D=0A>=20werden=20=21=20F=C3=BCr=20eine=20vert=
rauliche=20Kommunikation=20senden=20Sie=20bitte=20ihren=0D=0A>=20GPG/PGP-Sc=
hl=C3=BCssel=20zu.=0D=0A>=20---=0D=0A>=20Enrico=20Weigelt,=20metux=20IT=20c=
onsult=0D=0A>=20Free=20software=20and=20Linux=20embedded=20engineering=20in=
fo=40metux.net=20--=20+49-151-=0D=0A>=2027565287=0D=0A=0D=0A
