Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE06C7BF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 10:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCXJuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCXJuh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:50:37 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2832135A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 02:50:36 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230324095034epoutp048d153dc8580d750402faa0d2fe5f168a~PUhSG8Kri0871408714epoutp04C
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 09:50:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230324095034epoutp048d153dc8580d750402faa0d2fe5f168a~PUhSG8Kri0871408714epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679651434;
        bh=fNG+NfokszMqErj+zrj3B6XcYcvLtdCG61STw+G5JU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWTzx3uVT9cgBxrsiALFsFAyjESDNLcbRhVcYCyHZbOU+AJqU+bfsluSe3nm+G7bZ
         DJomcqGGP3E8ZKA7b4/pXtc4KMwqW1ast6Udvzt1eQvRAqQoE66ZlJJBkgOHqYK+g5
         QierlvqsQ84g4b78uOE5anqD3DWcKea4SKR//oHg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230324095032epcas2p1b30f92cd47185a6755a9e4a72d0d7bdb~PUhRCMlby1512315123epcas2p1_;
        Fri, 24 Mar 2023 09:50:32 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Pjcs42hQcz4x9Pp; Fri, 24 Mar
        2023 09:50:32 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.36.61927.8627D146; Fri, 24 Mar 2023 18:50:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230324095031epcas2p284095ae90b25a47360b5098478dffdaa~PUhQB-x5k3258732587epcas2p2I;
        Fri, 24 Mar 2023 09:50:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230324095031epsmtrp2c7c6e363505c55083162df20215d8800~PUhP9kMnd1597815978epsmtrp2g;
        Fri, 24 Mar 2023 09:50:31 +0000 (GMT)
X-AuditID: b6c32a45-8bdf87000001f1e7-2d-641d72688487
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.A0.31821.7627D146; Fri, 24 Mar 2023 18:50:31 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230324095031epsmtip1499ebbb0c866ca8ff809195238195cb1~PUhPwacid0993709937epsmtip1a;
        Fri, 24 Mar 2023 09:50:31 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     david@redhat.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com
Subject: RE(3): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Fri, 24 Mar 2023 18:50:31 +0900
Message-Id: <20230324095031.148164-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <91d02705-1c3f-5f55-158a-1a68120df2f4@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmqW5GkWyKwYZvQhbTDytaTJ96gdHi
        6/pfzBbnZ51isdiz9ySLxb01/1kt9r3ey2zRseENowOHx78Ta9g8Fu95yeSx6dMkdo/JN5Yz
        erzfd5XNo2/LKkaPz5vkAtijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
        EnNTbZVcfAJ03TJzgI5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YW
        l+al6+WlllgZGhgYmQIVJmRnrLv3halggkLFt+/fWRoY10h1MXJySAiYSLx9+Iuti5GLQ0hg
        B6PEvy/dTBDOJ0aJ+VcbWCGcz4wSyzY+YIRp6br7ghkisYtRYl/PeRYIp4tJ4taSD0wgVWwC
        2hJ/rpxnA7FFBEQkfjx8yQhSxCxwnlFi24vf7CAJYQF3idmnHjGD2CwCqhI7H/8Ai/MK2Eh8
        PnKIBWKdvMTMS9/B4pwCdhKdL26zQdQISpyc+QSshhmopnnrbLCTJAQaOSSaXsxmhWh2kTiz
        rpkJwhaWeHV8CzuELSXx+d1eNgi7WOLx639Q8RKJw0t+Qy02lnh38znQHA6gBZoS63fpg5gS
        AsoSR25BreWT6Dj8lx0izCvR0SYE0agisf3fcmaYRaf3b4Iq8ZDY9D4MElQTGSVOf7zLOIFR
        YRaSZ2YheWYWwt4FjMyrGMVSC4pz01OLjQoM4TGcnJ+7iRGcSLVcdzBOfvtB7xAjEwfjIUYJ
        DmYlEd53IbIpQrwpiZVVqUX58UWlOanFhxhNgUE9kVlKNDkfmMrzSuINTSwNTMzMDM2NTA3M
        lcR5pW1PJgsJpCeWpGanphakFsH0MXFwSjUwnXE/fkrkdsq5yrT76WWyn4RnxPR8PfDFv8JU
        oXVtcmL8qZ4pIgWS+37wWGiGzKh9pmfbV9v4Ydd3017tEE/P9s0PvU/esZ/mcmO2d50oq+J8
        hbrcbw9EZ7FU19VtnNFeveUR34PLarfdFyzI9EphXVfsXTXL4lOANOfkD44TLB/or9J63hTd
        LV88u0yDgWGqm7XB7zyjywts5nr2cW9+tH7y1vf3tgVe/sWkuevlg8YXCQu/zVxaF/110vW0
        I8x2DFNEf7vMEtnl5e52vv940vl0zv171m6VevvswBqJfa9iS6Y7qRemWR3ds/dKcujWR9FF
        C0KuNK8Umm+gVnbn8sbVrusNGc8oyN7l/REXrsRSnJFoqMVcVJwIAGN5xrgtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSnG56kWyKwb/tOhbTDytaTJ96gdHi
        6/pfzBbnZ51isdiz9ySLxb01/1kt9r3ey2zRseENowOHx78Ta9g8Fu95yeSx6dMkdo/JN5Yz
        erzfd5XNo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDLW3fvCVDBBoeLb9+8sDYxrpLoYOTkk
        BEwkuu6+YO5i5OIQEtjBKHFmwU12iISUxPvTbVC2sMT9liOsEEUdTBKnHl5hBEmwCWhL/Lly
        ng3EFhEQkfjx8CUjSBGzwFVGiY8vVjKDJIQF3CVmn3oEZrMIqErsfPwDbCqvgI3E5yOHWCA2
        yEvMvPQdLM4pYCfR+eI20FAOoG22EjuP50KUC0qcnPkErJwZqLx562zmCYwCs5CkZiFJLWBk
        WsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERzyWlo7GPes+qB3iJGJg/EQowQHs5II
        77sQ2RQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamBJn
        lnhMMu+4lvO2Loll4cRHyyVSkzinrF/brK9utcBx5xxGbQfD9ebnNW7N6Fn7s0W0PP/QiQau
        1gqFzktMPk0GV5Mn8Hvejt+0yf3blOtb/hZ47b1h6z1/VttWu3eMMfNb8rdbdRaxzWnbtab5
        dutCywNpN0+Glv75dkOd6ceMCatY5Bx+zYzY76TBumnhg2rGrLTb128YXcp6cztCV9w6JdVW
        pGye5bzf375techbFr6Xozj/qMfis9LpmxsEF/FPCb65XuDDCbn1BxQErcPf1B3mv3nsnrPo
        N7Oo1wJHEp/mv56UL9jddzr8/smXbsJztZbKnvTg0Fx5+U/mE/01TNOfJZQqZpTYBGusn6bE
        UpyRaKjFXFScCAC7bWl76AIAAA==
X-CMS-MailID: 20230324095031epcas2p284095ae90b25a47360b5098478dffdaa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230324095031epcas2p284095ae90b25a47360b5098478dffdaa
References: <91d02705-1c3f-5f55-158a-1a68120df2f4@redhat.com>
        <CGME20230324095031epcas2p284095ae90b25a47360b5098478dffdaa@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On 24.03.23 10:27, Kyungsan Kim wrote:
>>> On 24.03.23 10:09, Kyungsan Kim wrote:
>>>> Thank you David Hinderbrand for your interest on this topic.
>>>>
>>>>>>
>>>>>>> Kyungsan Kim wrote:
>>>>>>> [..]
>>>>>>>>> In addition to CXL memory, we may have other kind of memory in the
>>>>>>>>> system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>>>>>>>> memory in GPU card, etc.  I guess that we need to consider them
>>>>>>>>> together.  Do we need to add one zone type for each kind of memory?
>>>>>>>>
>>>>>>>> We also don't think a new zone is needed for every single memory
>>>>>>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>>>>>>> manage multiple volatile memory devices due to the increased device
>>>>>>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>>>>>>> represent extended volatile memories that have different HW
>>>>>>>> characteristics.
>>>>>>>
>>>>>>> Some advice for the LSF/MM discussion, the rationale will need to be
>>>>>>> more than "we think the ZONE_EXMEM can be used to represent extended
>>>>>>> volatile memories that have different HW characteristics". It needs to
>>>>>>> be along the lines of "yes, to date Linux has been able to describe DDR
>>>>>>> with NUMA effects, PMEM with high write overhead, and HBM with improved
>>>>>>> bandwidth not necessarily latency, all without adding a new ZONE, but a
>>>>>>> new ZONE is absolutely required now to enable use case FOO, or address
>>>>>>> unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>>>>>>> maintainability concern of "fewer degress of freedom in the ZONE
>>>>>>> dimension" starts to dominate.
>>>>>>
>>>>>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>>>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>>>>
>>>>> That sounds like a bad hack :) .
>>>> I consent you.
>>>>
>>>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>>>>
>>>>> I once raised the idea of a ZONE_PREFER_MOVABLE [1], maybe that's
>>>>> similar to what you have in mind here. In general, adding new zones is
>>>>> frowned upon.
>>>>
>>>> Actually, we have already studied your idea and thought it is similar with us in 2 aspects.
>>>> 1. ZONE_PREFER_MOVABLE allows a kernelspace allocation using a new zone
>>>> 2. ZONE_PREFER_MOVABLE helps less fragmentation by splitting zones, and ordering allocation requests from the zones.
>>>>
>>>> We think ZONE_EXMEM also helps less fragmentation.
>>>> Because it is a separated zone and handles a page allocation as movable by default.
>>>
>>> So how is it different that it would justify a different (more confusing
>>> IMHO) name? :) Of course, names don't matter that much, but I'd be
>>> interested in which other aspect that zone would be "special".
>>
>> FYI for the first time I named it as ZONE_CXLMEM, but we thought it would be needed to cover other extended memory types as well.
>> So I changed it as ZONE_EXMEM.
>> We also would like to point out a "special" zone aspeact, which is different from ZONE_NORMAL for tranditional DDR DRAM.
>> Of course, a symbol naming is important more or less to represent it very nicely, though.
>> Do you prefer ZONE_SPECIAL? :)
>
>I called it ZONE_PREFER_MOVABLE. If you studied that approach there must
>be a good reason to name it differently?
>

The intention of ZONE_EXMEM is a separated logical management dimension originated from the HW diffrences of extended memory devices.
Althought the ZONE_EXMEM considers the movable and frementation aspect, it is not all what ZONE_EXMEM considers.
So it is named as it.

