Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6667E1B3401
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 02:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDVAhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 20:37:45 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:13971 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgDVAho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:37:44 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200422003742epoutp04dbd8cf8143b6f436fc2022a859966a7b~H-UP8gDLV1818818188epoutp041
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 00:37:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200422003742epoutp04dbd8cf8143b6f436fc2022a859966a7b~H-UP8gDLV1818818188epoutp041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587515862;
        bh=JUtWdBk4gEp4wIEtsm8HRAKasmYjOYdmUVp75RUzDvs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rNRNe/m5Sg/l6Ykw3VmMreLHbqkLP9zL0BPIdQ++Rofk2X2QPd2jTPGauyIqFj9pj
         SXNNNJeDV6j92maGSR1VDZ6jS24SemXBSCcXQ1tdd3aV9XOHuVm4wfvhPT8dkyhFy1
         o1SzOKDBdO0oNoaMJ85fPz6Fpm6Q4o26/aMPgMqk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200422003741epcas1p3159e7cc2d563c0dbcf78f81244ee5e14~H-UPOQYNn1897218972epcas1p3a;
        Wed, 22 Apr 2020 00:37:41 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 496M376s5lzMqYkn; Wed, 22 Apr
        2020 00:37:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.C7.04744.3D19F9E5; Wed, 22 Apr 2020 09:37:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200422003739epcas1p29eac770a848e04a6721a9af12d29269b~H-UNdqANN2453324533epcas1p2v;
        Wed, 22 Apr 2020 00:37:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200422003739epsmtrp2d1b08f3d923e26ffde3da3f09521c285~H-UNc0e9S1288012880epsmtrp2-;
        Wed, 22 Apr 2020 00:37:39 +0000 (GMT)
X-AuditID: b6c32a38-26bff70000001288-da-5e9f91d343c8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.4A.04158.3D19F9E5; Wed, 22 Apr 2020 09:37:39 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200422003739epsmtip1f4cc1988430140dba15a645018a1db74~H-UNQ5r072988729887epsmtip1c;
        Wed, 22 Apr 2020 00:37:39 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>, <kohada88@hotmail.com>
Cc:     <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421015432.14563-1-kohada.t2@gmail.com>
Subject: RE: [PATCH-v4] exfat: replace 'time_ms' with 'time_cs'
Date:   Wed, 22 Apr 2020 09:37:38 +0900
Message-ID: <000001d6183e$39ea6570$adbf3050$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKV2PrI7Vjbk6C65/gyW3xtSSMLUwInVY0LpvOJoFA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNY6bTQqyOteINJlIn8QMM0FKKA4JLEFMjiUQTPoyhTugIaLfM
        FEXUaNRUqIhFcKugxChBjAIVhRIQRQyBqEgx7poo4r4g7lHRaadG/s6979xz7nnvyTBFPREh
        y7fYWc7CmCgiDL9wJUodM1h+LFt99nIS/b36AU7f77tJ0O0dvTg92FZF0IN/RnG69nMFTjeP
        dUsWSPWfq3qkekfFmFTvdT+S6odKrxH6suZ6pP/kmZFJrDSl5LGMkeVUrCXHasy35KZSS1cY
        0gy6RLUmRpNEz6FUFsbMplKLMjJjFuebhF0o1XrGVCC0Mhmep+LmpXDWAjuryrPy9lSKtRlN
        No3aFsszZr7AkhubYzUna9TqeJ3AXG3Ke3xqe4itFCvcff4gvg1dDXGiUBmQCXCvyUc4UZhM
        QbYi+FU2IBGLUQQnh2+FiMVXBAPXWyT/Rhp8j4IjHQi6dvzBxeIVgmfnuqV+FkHGwNivTsKP
        leRi2OMZQX4SRvYjcLnGMP9BKJkEo5eeBmSnkPNhT58X92OcnAUPanYHhuUC50OlTyriydB7
        +FmAg5GR0PKuChNXUsGP4VpBRyaYJYOzqUikKOFIiQPz+wL5k4BOV1sw9SL4Ud4XjDMFXvc0
        S0UcAZ/edxB+HSA3wcfOoHwxgpffUkWshXsNjQErjIyChrY4sT0TvD+rkWg7Ed5/KZWIKnIo
        dihEyiwo810JLjAdnLtGpC5Eucflco/L5R4XwP3frAbh9SictfHmXJbX2BLGP7YHBf5pNN2K
        2m9kdCFShqgJ8rv9R7MVEmY9v9HchUCGUUp54xOhJTcyG4tYzmrgCkws34V0wrWXYxFTc6zC
        r7fYDRpdvFarpRMS5yTqtNQ0+f47pmwFmcvY2XUsa2O5f3MhstCIbShtX9ETXUlDeuXtuPSF
        OjNdnFhzmsqsW/1SO3Qo7UzY3BO9U194U5aePuQsXa6eNJCu2JD1XM+9uV2xuUnp+F071zn0
        0NEd+WbNmZmxd8hVaz9cXLYlGrYWVvYcOL6hLvKAzxNWsmTE0Ph2dnht/F75zqzqC1kOV4vy
        PJdh9aiTK6MonM9jNNEYxzN/AVw9+t69AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnO7lifPjDDrviln8mHubxeLWqQts
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYrHl3xFWB3aPL3OOs3u0Tf7H7rFz1l12j8c9Z9g8+ras
        YvT4vEkugC2KyyYlNSezLLVI3y6BK+Peyiamgh7miu6t01kaGI8ydTFyckgImEisv3SXrYuR
        i0NIYDejxPbuJhaIhLTEsRNnmLsYOYBsYYnDh4shap4zSkw9uZgdpIZNQFfi35/9bCC2iICH
        RNeNTkaQImaBi4wS/8+tg5raxShxcPknZpAqTgFLiU8HHrGC2MIC9hK9p3aCbWMRUJW4vaAb
        bBIvUM37KZfYIWxBiZMzn7CAXMEsoCfRtpERJMwsIC+x/e0cZohDFSR+Pl3GClIiImAl0bWx
        CqJERGJ2ZxvzBEbhWUgGzUIYNAvJoFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dL
        zs/dxAiOKi2tHYwnTsQfYhTgYFTi4b1xfl6cEGtiWXFl7iFGCQ5mJRHeDQ+BQrwpiZVVqUX5
        8UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhjnv/+58ySf2Vpt4X3in4of
        LrCpSZtfVMseXe526Kji8sY7auuX2OjInJ1/bvlO4ZeuWjz/Un7d3cf4Mf1iQVZw4X+dznbF
        WT9cvZcvKjPmeWP7wumB2e2TCZv2xL69GRi0Zq6tnN4v7Z/f/d3OFNRu/HksM2DK5evcHxZc
        f6t/zHz1zV31HWr7lFiKMxINtZiLihMBxklXwqYCAAA=
X-CMS-MailID: 20200422003739epcas1p29eac770a848e04a6721a9af12d29269b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200421015505epcas1p36d86cad3b1214442eac42685694f26da
References: <CGME20200421015505epcas1p36d86cad3b1214442eac42685694f26da@epcas1p3.samsung.com>
        <20200421015432.14563-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Replace "time_ms"  with "time_cs" in the file directory entry structure
> and related functions.
> 
> The unit of create_time_ms/modify_time_ms in File Directory Entry are not
> 'milli-second', but 'centi-second'.
> The exfat specification uses the term '10ms', but instead use 'cs' as in
> "msdos_fs.h".
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
Applied.
Thanks!

