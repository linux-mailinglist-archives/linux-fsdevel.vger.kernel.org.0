Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC91F332F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 06:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgFIEzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 00:55:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:52920 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIEzO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 00:55:14 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200609045511epoutp026cdcd018ff5f3a8a6b16f19f89ce901c~WxyxEbU301731817318epoutp02H
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 04:55:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200609045511epoutp026cdcd018ff5f3a8a6b16f19f89ce901c~WxyxEbU301731817318epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591678511;
        bh=sFqZtgF2jYir0RBwYAvr5uMEa0KhGF1zOG1Wl37JcLQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=tutSCH6qeLsRTnR2hccPGV633u+q5tdurT6jtW+EvlC8DlACAoDwMfzA68gJS0D0a
         GY3+6z942xat/nKv9Vwd3LWeOUljBeBvMoe6CW7KCbCnyRGJXo46NDomSLNFFkW+80
         UlSBga941OxHenOw+AYZr8ZHQSDGHCIim+8zfwBQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200609045510epcas1p49fb5246e181c59ad7667ae3190cc5f39~WxyweGUzb0719607196epcas1p4C;
        Tue,  9 Jun 2020 04:55:10 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49gyV54rnBzMqYkd; Tue,  9 Jun
        2020 04:55:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.A6.28581.C261FDE5; Tue,  9 Jun 2020 13:55:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200609045507epcas1p40d89c4d8c4939871654336b7dba5cfc1~WxytrTezL0719807198epcas1p41;
        Tue,  9 Jun 2020 04:55:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200609045507epsmtrp28742c4f6c34fe7755eddadfcd249ac49~WxytqqT1S1352813528epsmtrp2y;
        Tue,  9 Jun 2020 04:55:07 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-22-5edf162cd461
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.57.08382.B261FDE5; Tue,  9 Jun 2020 13:55:07 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200609045507epsmtip167a1f6635c1b8da46e65216f1be3fa7b~WxytfvU6B1757017570epsmtip1m;
        Tue,  9 Jun 2020 04:55:07 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'hyeongseok'" <hyeongseok@gmail.com>, <namjae.jeon@samsung.com>
Cc:     <linux-fsdevel@vger.kernel.org>
In-Reply-To: <583c96d1-d875-c3a1-8d62-e0380c9d4e63@gmail.com>
Subject: RE: [PATCH] exfat: clear filename field before setting initial name
Date:   Tue, 9 Jun 2020 13:55:07 +0900
Message-ID: <027c01d63e1a$2587fff0$7097ffd0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIaR7nlruHlYoYAFufzYvF3kOuM3AGb8AD6AqGj75QB4X4h2agWk/iA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmga6O2P04g90rBC3+TvzEZLFn70kW
        ix/T6x2YPXbOusvu0bdlFaPH501yAcxROTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqG
        lhbmSgp5ibmptkouPgG6bpk5QHuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWG
        BgV6xYm5xaV56XrJ+blWhgYGRqZAlQk5GR1XFjEXPOSqmL3pH1MD416OLkZODgkBE4lzj9+z
        dTFycQgJ7GCUePngNyOE84lR4sSZD8wQzjdGiQmnFrLCtLyaMJsJIrGXUaJh3lUo5yWjxNld
        65hAqtgEdCWe3PgJ1M7BISLgIjF1tRuIySygLLHySzBIBaeArcTnCQ/AqoUFfCSa9k5iASlh
        EVCRaH7vDxLmFbCU2DD7ERuELShxcuYTFhCbWUBeYvvbOcwQ5yhI7P50FOw0EQE3iQ8zJrBC
        1IhIzO5sA7tfQuAlu8ST17Og7neRaN0/kQ3CFpZ4dXwLO4QtJfH53V6oeL3E7lWnWCCaGxgl
        jjxayAKRMJaY37KQGeIXTYn1u/QhwooSO3/PZYRYzCfx7msPK0iJhACvREebEESJisT3DztZ
        YFZd+XGVaQKj0iwkr81C8tosJC/MQli2gJFlFaNYakFxbnpqsWGBCXJcb2IEJ0Etix2Mc99+
        0DvEyMTBeIhRgoNZSYS3+sGdOCHelMTKqtSi/Pii0pzU4kOMpsCwnsgsJZqcD0zDeSXxhqZG
        xsbGFiZm5mamxkrivCetLsQJCaQnlqRmp6YWpBbB9DFxcEo1MHkmu70RKGL5q/BO9/km8cyH
        3mdniUlZbUp0b1H68LMz92zyRKu/icvNmmOuZP85c+ql8+XSZ+IbPZR0ZzOntHOtVRXni6xb
        bP9qaY1CHK/6bjWlJJkX+pI7zy1rnPOt4+gUS4eXOXcPCKQu1DUWD5DKZjHbpzq3X8vZbMfh
        SdH7g7Z+cb5+cw5L7q5vryeYtJs29zE232L0fCIvmCOeJcDJ8ezN5JgbpSmZZ+1dfGrzpBnu
        784ruVn47G/Z+4Atx9+yePM7TBX6ErraRa7rNWOA4xut7+Vff8z6xPgixLRz4be3F/LcOE9u
        st565KjgO78VSxpq/Wef9bfqD2DesKK/IPr/Be0dToKTF0edVGIpzkg01GIuKk4EAF47pCcL
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnK622P04gxXXFS3+TvzEZLFn70kW
        ix/T6x2YPXbOusvu0bdlFaPH501yAcxRXDYpqTmZZalF+nYJXBkdVxYxFzzkqpi96R9TA+Ne
        ji5GTg4JAROJVxNmM3UxcnEICexmlPj0t42li5EDKCElcXCfJoQpLHH4cDFIuZDAc0aJ43u5
        QGw2AV2JJzd+MoPYIgJuEjfPbQTrZBZQllj5JRhi4hdGiU2N79hAajgFbCU+T3jABGILC/hI
        NO2dBFbPIqAi0fzeHyTMK2ApsWH2IzYIW1Di5MwnLCA2s4C2RO/DVkYIW15i+9s5zBDXK0js
        /nSUFeaEDzMmsELUiEjM7mxjnsAoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQsM81LL
        9YoTc4tL89L1kvNzNzGCI0FLcwfj9lUf9A4xMnEwHmKU4GBWEuGtfnAnTog3JbGyKrUoP76o
        NCe1+BCjNAeLkjjvjcKFcUIC6YklqdmpqQWpRTBZJg5OqQamhaypL/qj1ulP5nxmsGD5hOO9
        M7m7TA7suqrEfNtfsmiyiuWGO/teySaWV+h/X8iXZ1H/fpfUBsvve4r8jPyPTVCf/l35n1qy
        sALj79VfY37kJL7S4C1TPiT6U7dt6iYhhrXrLskt7tn0t/XfvmuenIUzzwcwHLm5uODJ2u2R
        q8J6mDev4ZHbfSRzYknKXlHVvKVzj65V+737RPhxj07vKLOM7kV/FiWXz838v4xfc09vujrz
        3SUMt9uY5JqsP8ZaRwtsDJ+u0f80iJWN+4vuFy+t3VdF4y3Na2+vKgrbmeSbPXW6PPNEs20Z
        91tf6zIYHy6aM986XPHzVHvd+AupO8JCujPe+bImf07f5GOjxFKckWioxVxUnAgAwXiRH/MC
        AAA=
X-CMS-MailID: 20200609045507epcas1p40d89c4d8c4939871654336b7dba5cfc1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609004931epcas1p3aa54bf8fdf85e021beab20d402226551
References: <CGME20200609004931epcas1p3aa54bf8fdf85e021beab20d402226551@epcas1p3.samsung.com>
        <1591663760-6418-1-git-send-email-Hyeongseok@gmail.com>
        <000001d63e0a$88a83b50$99f8b1f0$@samsung.com>
        <583c96d1-d875-c3a1-8d62-e0380c9d4e63@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 6/9/20 12:03 PM, Sungjong Seo wrote:
> >> Some fsck tool complain that padding part of the FileName Field is
> >> not set to the value 0000h. So let's follow the filesystem spec.
> > As I know, it's specified as not "shall" but "should".
> > That is, it is not a mandatory for compatibility.
> > Have you checked it on Windows?
> Right, it's not mandatory and only some fsck'er do complain for this.
> But, there's no benefit by leaving the garbage bytes in the filename entry.
> Isn't it?
> Or, are you saying about the commit message?

The latter, I'm just saying this is not a spec-violation :)

> >> Signed-off-by: Hyeongseok.Kim <Hyeongseok@gmail.com>
> >> ---
> >>   fs/exfat/dir.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index de43534..6c9810b
> >> 100644
> >> --- a/fs/exfat/dir.c
> >> +++ b/fs/exfat/dir.c
> >> @@ -424,6 +424,9 @@ static void exfat_init_name_entry(struct
> >> exfat_dentry *ep,
> >>   	exfat_set_entry_type(ep, TYPE_EXTEND);
> >>   	ep->dentry.name.flags = 0x0;
> >>
> >> +	memset(ep->dentry.name.unicode_0_14, 0,
> >> +		sizeof(ep->dentry.name.unicode_0_14));
> >> +
> >>   	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
> >>   		ep->dentry.name.unicode_0_14[i] = cpu_to_le16(*uniname);
> >>   		if (*uniname == 0x0)
> >> --
> >> 2.7.4
> >
> >


