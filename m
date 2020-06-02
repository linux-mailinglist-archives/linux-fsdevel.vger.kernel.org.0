Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19301EB5D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 08:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgFBGdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 02:33:15 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:51140 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFBGdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 02:33:14 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200602063310epoutp01b9236027ca8eb3f138a493f2748a134d~UpnVB5wy40674206742epoutp01N
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2020 06:33:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200602063310epoutp01b9236027ca8eb3f138a493f2748a134d~UpnVB5wy40674206742epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591079590;
        bh=SKTSQHN27yku0aCMVC0SXjrdfRnYbfPM0BNdMKlfeqs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=GaBAQhGI1P9XBuLD34JqT0Nl3lZ7bKNmGenl4z4tagc7w8s0GsyxQjwJPVmjr2fky
         04h9TqkCqYTNyG2GXlj4zxjFZJ9zgTty8OIWhbVOyKynbEKpBjt0cl91hw02ZiiqOH
         L1XhWYwW9+8UjPVYPt5skQBAPgjceTlWd2/y+NA0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200602063310epcas1p25d70858f33640f535c6f8900b5beff1f~UpnUX1Zyi2915829158epcas1p2b;
        Tue,  2 Jun 2020 06:33:10 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49bj0P0sc6zMqYm1; Tue,  2 Jun
        2020 06:33:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.EA.28581.3A2F5DE5; Tue,  2 Jun 2020 15:33:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200602063307epcas1p1ac6a463514f46a1025d372a9806abcba~UpnRm0tY13253132531epcas1p1e;
        Tue,  2 Jun 2020 06:33:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200602063307epsmtrp20ed0b8d91e867394124c4c960689c9f2~UpnRiHgk41350113501epsmtrp2E;
        Tue,  2 Jun 2020 06:33:07 +0000 (GMT)
X-AuditID: b6c32a38-85df1a8000006fa5-66-5ed5f2a37644
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.04.08382.2A2F5DE5; Tue,  2 Jun 2020 15:33:07 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200602063306epsmtip15578da615ea3679a13e7110229905f0a~UpnRTr4ey2646826468epsmtip1B;
        Tue,  2 Jun 2020 06:33:06 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <1ffc01d6380d$656e3520$304a9f60$@samsung.com>
Subject: RE: [PATCH] exfat: optimize dir-cache
Date:   Tue, 2 Jun 2020 15:33:06 +0900
Message-ID: <011201d638a7$ad371350$07a539f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKbEd8GOCYeHYQBe/Vm0kX/gmqw5wMD/7F2Af7EGpmnExSvgA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmru7iT1fjDHa90bV4c3Iqi8WevSdZ
        LC7vmsNmcfn/JxaLZV8ms1hs+XeE1YHN48uc4+webZP/sXs0H1vJ5tG3ZRWjx+dNcgGsUTk2
        GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKCmUJeaU
        AoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKDA0K9IoTc4tL89L1kvNzrQwNDIxMgSoTcjJe
        /V/JVPCKuWLhopOsDYy9zF2MnBwSAiYSX/9dB7OFBHYwSlx54tbFyAVkf2KU2L3oBDuE841R
        Yu2iy2wwHbOPLWCDSOxllPjdsIYRwnnJKDGpt40dpIpNQFfi35/9YB0iAu4SOxYeYAEpYhY4
        zygxY/VvsASngJXE2Yt/wJYLC+hJfPz2kgnEZhFQkbi1YSULiM0rYCmxdeZPRghbUOLkzCdg
        cWYBeYntb+dAPaEg8fPpMlaIZU4Sd+f9YIaoEZGY3dnGDLJYQmAih8SCb08YIRpcJDa+7GWC
        sIUlXh3fwg5hS0l8frcX6DgOILta4uN+qPkdjBIvvttC2MYSN9dvYAUpYRbQlFi/Sx8irCix
        8/dcRoi1fBLvvvawQkzhlehoE4IoUZXou3QYaqm0RFf7B/YJjEqzkDw2C8ljs5A8MAth2QJG
        llWMYqkFxbnpqcWGBSbIkb2JEZw6tSx2MM59+0HvECMTB+MhRgkOZiUR3snql+KEeFMSK6tS
        i/Lji0pzUosPMZoCg3ois5Rocj4weeeVxBuaGhkbG1uYmJmbmRorifOetLoQJySQnliSmp2a
        WpBaBNPHxMEp1cAk39mg+/3vW+YJHLlrG/OOxu17c+CpB9vLLKVHNsfKcxs+Tjtvyt3N8PCF
        h9YqywKeWRO/R5ge6ePVU9PQjVvjW/B5w7Zr93g+uKswOORd1eI+lT/LZvK2rGlq6vvzv334
        cO/0/g2bS9YyzF76rXjyi6/p/8Ru8MqcOevnFbr/60OtFUdaMg+6qAQUrZn2t27aZlO/nKlq
        DU9/15eF53LYvNjVUnJLcsnvKrbLx5c9Lfd+W7pcj9e6cpfqXY01pnO0qsU9K1/9YNKIzP/K
        f95R97OTbUV8ANPFC58yf0akTE6d4HAqrnBau8MVtiTvhvuGr0Of7z1e8mZrwFaWO5H7m1Pe
        LReyLN8p61T94s5hJZbijERDLeai4kQAxtGWkyYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnO7iT1fjDHpXMVu8OTmVxWLP3pMs
        Fpd3zWGzuPz/E4vFsi+TWSy2/DvC6sDm8WXOcXaPtsn/2D2aj61k8+jbsorR4/MmuQDWKC6b
        lNSczLLUIn27BK6MV/9XMhW8Yq5YuOgkawNjL3MXIyeHhICJxOxjC9i6GLk4hAR2M0o07ehg
        g0hISxw7cQaoiAPIFpY4fLgYouY5o8SPDR3sIDVsAroS//7sB6sXEXCX2LHwAAtIEbPARUaJ
        VQ0tzBAdQM7sbaeZQKo4Bawkzl78A7ZaWEBP4uO3l2BxFgEViVsbVrKA2LwClhJbZ/5khLAF
        JU7OfAIWZxbQluh92MoIYctLbH87B+oFBYmfT5exQlzhJHF33g9miBoRidmdbcwTGIVnIRk1
        C8moWUhGzULSsoCRZRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnAcaWnuYNy+6oPe
        IUYmDsZDjBIczEoivJPVL8UJ8aYkVlalFuXHF5XmpBYfYpTmYFES571RuDBOSCA9sSQ1OzW1
        ILUIJsvEwSnVwGSZOCslRMA2dP5E+8qzYcxsKYvO3jm1SvLPC2uz/yJBhYLha5o/lT510i7n
        fXTvnkbZ6icvWNb4hppZHDiv0Fkx/Wf3l27VoiUmiY2zSm/+7dp5Nb8neXb7kWcBDaHz5lws
        YNFeryF0JDlC5NW6vQGBSx7/Nz9m1qdm7pd++v0TjxMtWyOtzfWrFXZ9nZpgLJLYvin/5NfA
        ixMOObaWSTGVZD4S08x6p7m+uV36QsOv8IMnP3/2y1G13Cje0O5VH/HD6mzcg8eG25TZ3k1c
        OlXie5+4m8KNtYe3vGDnt1jVsngp+/7lLhLvz/8KYQ6ePGuOyeyTty95P/xZ8XZu8eXZNRv0
        RTZtZPZ5zm6UJKrEUpyRaKjFXFScCADAwsh3EgMAAA==
X-CMS-MailID: 20200602063307epcas1p1ac6a463514f46a1025d372a9806abcba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200520075735epcas1p269372d222e25f3fd51b7979f5b7cdc61
References: <CGME20200520075735epcas1p269372d222e25f3fd51b7979f5b7cdc61@epcas1p2.samsung.com>
        <20200520075641.32441-1-kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
        <1ffc01d6380d$656e3520$304a9f60$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Optimize directory access based on exfat_entry_set_cache.
> >  - Hold bh instead of copied d-entry.
> >  - Modify bh->data directly instead of the copied d-entry.
> >  - Write back the retained bh instead of rescanning the d-entry-set.
> > And
> >  - Remove unused cache related definitions.
> >
> > Signed-off-by: Tetsuhiro Kohada
> > <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
> 
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied your 5 patches.
Thanks!

