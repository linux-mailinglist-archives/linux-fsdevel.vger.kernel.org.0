Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6181420FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 00:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgASXyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 18:54:32 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:13317 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgASXyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 18:54:32 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200119235430epoutp04d1618fc2c333a1b36e46fe50d00eb2c1~rbu_5uOc32535025350epoutp04s
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2020 23:54:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200119235430epoutp04d1618fc2c333a1b36e46fe50d00eb2c1~rbu_5uOc32535025350epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579478070;
        bh=6JSnqzl0EvdTU31qaFR96V0SipqLwPhqMod9gJdOwkY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=J7H6nIisdfpkKMorURU2XZLHQvAkvPvqZMRI/i2ZV5fHohftgHvp0Kvwc5kVZISlN
         7o4FR3kBAWhzd/2GVOWy9OQkIokI5loonv7nHKGyz7fEeqPV8cDeVp1YuMfwzFPrAb
         5GadEsqkru8x5gw9yn2KQrSwhYUtyQddTY4R4VF4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200119235429epcas1p4974acc4d054d1003f7327108f4c8f8ce~rbu_gDzry0198301983epcas1p4G;
        Sun, 19 Jan 2020 23:54:29 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 481BVD57b3zMqYkV; Sun, 19 Jan
        2020 23:54:28 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.94.48019.43CE42E5; Mon, 20 Jan 2020 08:54:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200119235428epcas1p39533727823a84621968a6ceae337c67e~rbu9DBAdv2284122841epcas1p35;
        Sun, 19 Jan 2020 23:54:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200119235428epsmtrp29ba7048776effc36a4283c7961c77612~rbu9CDgft0811308113epsmtrp2R;
        Sun, 19 Jan 2020 23:54:28 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-a8-5e24ec3496f1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.25.06569.43CE42E5; Mon, 20 Jan 2020 08:54:28 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200119235428epsmtip2a86b257f32fa53f44737cf1572d13baa~rbu82_ass0720507205epsmtip2K;
        Sun, 19 Jan 2020 23:54:28 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Christoph Hellwig'" <hch@lst.de>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <valdis.kletnieks@vt.edu>,
        <sj1557.seo@samsung.com>, <pali.rohar@gmail.com>, <arnd@arndb.de>,
        "'Namjae Jeon'" <linkinjeon@gmail.com>
In-Reply-To: <20200119223436.GF4890@lst.de>
Subject: RE: [PATCH v11 12/14] exfat: add exfat in fs/Kconfig and
 fs/Makefile
Date:   Mon, 20 Jan 2020 08:54:27 +0900
Message-ID: <001901d5cf23$c9054b30$5b0fe190$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE6+DxIhpF/kFPHCFxKjfJup9sXPQH+Y74vAmvezKUBN9/7cqj7RYaQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0hTYRjG+3a2sxlNTvPSm0HNQwZms61terosCq0GGUlWUJB20A9n7sbO
        tBuUrHJmZWmZtBKNwsiK1FZeyozZ/aJm90ACKdDKbqJimrXtLNh/P773fb73eb6LhJC1kFGS
        HLMd28yskSYnC2+0xyoVmq+z05UV/THMn7L7Ymbfuaskc/HSPQHzpuc9wdxqfSRkXrScIZnS
        J2MCxj1xV8R0f/8hXBaiH/tdhvTNrh6xvq3yslh/810BqS9x1yL9YMNMvafxK5kq3mxcYsBs
        FrbJsTnTkpVjztbRq9MykjK0CUqVQrWQSaTlZtaEdXRySqpiZY7Ra42W57PGPO9SKstx9Pyl
        S2yWPDuWGyycXUdja5bRqlJa4znWxOWZs+MzLaZFKqVygdbbudVo6DhwibR2CXc0PW1EBei4
        sBiFSIDSgPthl6AYTZbIqCYEjqFhka8go34hGD66jC8MIzj9qpj4rxh/OUHwhVYEz91uklf0
        I+joXu5jklLAxHibfz2cmgNPRwvFPgFBDSB4/Kwa+QohVBxUDZUKfBxGrYWTwyP+CUIqBl73
        Ofw2pNRCuH7eFeCp8OjUR79vgoqHt+UnSJ7joObsl4A7OYx+qhHxg1fCsxq3iO8Jh9MHC/2u
        gXKK4WD9EzEvSAaHpzzAYfD5gTvAUTD4rdU7QOLl3fCzLbB/EYK+ER3Panh3tU7EczQ0j1Ui
        flYofBs6LOKlUigqlPEtMVDS3S7geQYUO3+IjyHaFZTMFZTMFZTMFZSgGglrUSS2cqZszKms
        muDbbkD+dzuXaUK3OlI8iJIgeoq0mpudLhOx+dxOkweBhKDDpT1HotNl0ix25y5ss2TY8oyY
        8yCt9+RLiaiITIv3F5jtGSrtArVazWgSEhO0anqatCJZni6jslk7zsXYim3/dQJJSFQBepgU
        sc4R6tj/oWzWrPaGKc47Ixuq8s+duVBeOdF7WzldcPj++kXXkgxkV+4WW82qvaL2eQOd5vEr
        EYcWd/7t7dkzpHemaZ4P7nNeu4LRxtBJmu3V2wY8K74UycMNe89PI3pr1+Sqf8pbLm/E9Ttm
        blo8Gqk71ZlcOBJ5t05apfgeu5UWcgZWNZewcew/6jz5Nc0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvK7JG5U4g4/b2C3+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWUw8/ZvJYsu/I6wWl95/YHHg9Pj9axKjx85Zd9k99s9d
        w+6x+2YDm0ffllWMHp83yXkc2v6GLYA9issmJTUnsyy1SN8ugStj/ez9bAWfmSs+XehkamCc
        zdzFyMkhIWAi8efKPyCbi0NIYDejxOHGl4wQCWmJYyfOACU4gGxhicOHiyFqnjNKfNrdxw5S
        wyagK/Hvz342EFtEQE3izM82dpAiZoGvjBKN27pZIDquM0ps2zgLrINTQFti/teJTCC2sICv
        xPlfvWBxFgFViWsvmlhBbF4BS4mtS2ZB2YISJ2c+YQGxmQUMJO4f6mCFsLUlli18DfWCgsTP
        p8tYIa5wkzi7bAtUjYjE7M425gmMwrOQjJqFZNQsJKNmIWlZwMiyilEytaA4Nz232LDAKC+1
        XK84Mbe4NC9dLzk/dxMjOPK0tHYwnjgRf4hRgINRiYd3QbFKnBBrYllxZe4hRgkOZiUR3ru9
        inFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGKcnR/GF
        Luk+7Csnvfn4c7ZohVsnOiS2y/zY/4mrb9b/+l8OJnXs3G5VP3g2X362U2L7gYZih0kzru9d
        JLMxdq6E+S5xTt+SQimmWbYMyQWdyYkxc/feX/Xz6d9vSr9invxPmaZXl812velRkKye7AOJ
        I/E/JIzLuGyX874tDfXOWPrxa5buSyWW4oxEQy3mouJEAL5A1Ha4AgAA
X-CMS-MailID: 20200119235428epcas1p39533727823a84621968a6ceae337c67e
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200119223441epcas1p46dff31055998493dba781f21dd6e9039
References: <20200118150348.9972-1-linkinjeon@gmail.com>
        <20200118150348.9972-13-linkinjeon@gmail.com>
        <CGME20200119223441epcas1p46dff31055998493dba781f21dd6e9039@epcas1p4.samsung.com>
        <20200119223436.GF4890@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Sun, Jan 19, 2020 at 12:03:46AM +0900, Namjae Jeon wrote:
> > From: Namjae Jeon <namjae.jeon=40samsung.com>
> >
> > Add exfat in fs/Kconfig and fs/Makefile.
> >
> > Signed-off-by: Namjae Jeon <namjae.jeon=40samsung.com>
> > Signed-off-by: Sungjong Seo <sj1557.seo=40samsung.com>
> > Reviewed-by: Pali Roh=E1r=20<pali.rohar=40gmail.com>=0D=0A>=20=0D=0A>=
=20I=20would=20have=20merged=20this=20into=20the=20previous=20one,=20but=20=
otherwise:=0D=0AOkay:)=0D=0A>=20=0D=0A>=20Reviewed-by:=20Christoph=20Hellwi=
g=20<hch=40lst.de>=0D=0AThanks=20for=20your=20review=21=0D=0A=0D=0A
