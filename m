Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0096DC2DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Apr 2023 05:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDJDFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Apr 2023 23:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJDFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Apr 2023 23:05:45 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F209B3A85
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Apr 2023 20:05:42 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230410030536epoutp0495d5992f3ada28dd10d8b8dc7b5aa79b~Uc9joSus80873108731epoutp04C
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 03:05:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230410030536epoutp0495d5992f3ada28dd10d8b8dc7b5aa79b~Uc9joSus80873108731epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681095936;
        bh=SRTeLE9lQ3b/QiJsBXYPDVIGRjiZ1RqLSwa/G+aVphI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QY28z1y5nnvErGsEEOshEXhyonfXsQNp8DcyAE2njfK/489zUHWcfjBuB6TfoV0Tn
         AndF/8vO9UPAMpeoAxxPFj6zWyf7hejMmHKJiyqQpldLoZSsm7t92/VKMarzqC2Zl+
         rfAIQ573pkLD42kQUnDTOdcGvBs7/Tv7oN1tq3/g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230410030534epcas2p167ef3050097e2507e98f957af3e96d7b~Uc9hhQAue1950019500epcas2p1M;
        Mon, 10 Apr 2023 03:05:34 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Pvv3x2lNkz4x9Pv; Mon, 10 Apr
        2023 03:05:33 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.87.09650.DFC73346; Mon, 10 Apr 2023 12:05:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230410030532epcas2p49eae675396bf81658c1a3401796da1d4~Uc9gRgJqf0469904699epcas2p4O;
        Mon, 10 Apr 2023 03:05:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230410030532epsmtrp2e937a887cd70c1d269f082f6e901f107~Uc9gQwOwZ2512825128epsmtrp2e;
        Mon, 10 Apr 2023 03:05:32 +0000 (GMT)
X-AuditID: b6c32a48-dc7ff700000025b2-34-64337cfd53e7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.84.08609.CFC73346; Mon, 10 Apr 2023 12:05:32 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230410030532epsmtip1b9af32e7980eee83fb3add941a66ca7d~Uc9gC5Wx_0228302283epsmtip1Y;
        Mon, 10 Apr 2023 03:05:32 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     dragan@stancevic.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory
Date:   Mon, 10 Apr 2023 12:05:32 +0900
Message-Id: <20230410030532.427842-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmqe7fGuMUg5c3hS2mH1a0mD71AqPF
        obk32S3OzzrFYrFn70kWi3tr/rNa7Hu9l9niRedxJouODW8YLTbef8fmwOXx78QaNo/Fe14y
        eWz6NIndY/KN5YwefVtWMXosXmrj8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZ
        gaGuoaWFuZJCXmJuqq2Si0+ArltmDtB1SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSC
        lJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjFO/eQqOc1Qs2SbQwPidrYuRk0NCwETie8cB
        IJuLQ0hgB6PEqmlTGUESQgKfGCU+HwmCSHxmlNi04wQLTMfPB5dYIBK7GCWuTWiFau9ikri+
        /S9YFZuAtsSfK+fBdogISEjsW7MIbCyzwD9GiT2XJUFsYQFXif2/1zOD2CwCqhJ981ewg9i8
        AjYSk2fthdomLzHz0newOKeAo0T3s89MEDWCEidnPmGBmCkv0bx1NjPIERICrRwS5979YIVo
        dpGY2PIHapCwxKvjW9ghbCmJz+/2QgOgWOLx639Q8RKJw0t+Q9UbS7y7+RxoDgfQAk2J9bv0
        QUwJAWWJI7eg1vJJdBz+yw4R5pXoaBOCaFSR2P5vOTPMotP7N0EN95BoP7CZGRJUUxglbi65
        xjSBUWEWkm9mIflmFsLiBYzMqxjFUguKc9NTi40KTODRm5yfu4kRnFS1PHYwzn77Qe8QIxMH
        4yFGCQ5mJRFeG26DFCHelMTKqtSi/Pii0pzU4kOMpsCwnsgsJZqcD0zreSXxhiaWBiZmZobm
        RqYG5krivB87lFOEBNITS1KzU1MLUotg+pg4OKUamLZaXnz16nGv1bMFkf8tpmns3nif5ebk
        JdHPjHlZ8n21RN8KJ3hrSF945/hMaX709FiOuY9lHn5Z7PJR97WMzM9X/fNWP1zIZyy/6u5h
        XbGn5W6d709e+9a1xGSJ4NN3qj97LNYm1yr+ESwI3dHWFx4mWm3M/f+3TNGJne8bl81sYz6r
        VFNgv8nchPdY7LQ9r1T6GzbIqJiZ5vw8afH4a6te1ff8+Wlt0+Pt0k732yTXFk20Sq/S23Yp
        U7DhDuOEV0/uGymb/at4MacrPmEOa6bUraywPawrLdWOPtXfaTmZ6eaWW+uaA1v79fVy3JWm
        PIo9c+HJIblpHwJnrl5VuzM/tre7pplzfbj29ZV6nkosxRmJhlrMRcWJAP0ort8zBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnO6fGuMUg0crtCymH1a0mD71AqPF
        obk32S3OzzrFYrFn70kWi3tr/rNa7Hu9l9niRedxJouODW8YLTbef8fmwOXx78QaNo/Fe14y
        eWz6NIndY/KN5YwefVtWMXosXmrj8XmTXAB7FJdNSmpOZllqkb5dAlfGqd88Bcc5KpZsE2hg
        /M7WxcjJISFgIvHzwSWWLkYuDiGBHYwSO6bfZIRISEm8P93GDmELS9xvOcIKYgsJdDBJHP9Q
        D2KzCWhL/LlyHmyQiICExL41ixhBBjGD1Gy9PB0sISzgKrH/93pmEJtFQFWib/4KsKG8AjYS
        k2ftZYFYIC8x89J3sDingKNE97PPTBDLHCSutdxhhqgXlDg58wlYPTNQffPW2cwTGAVmIUnN
        QpJawMi0ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOAK0tHYw7ln1Qe8QIxMH4yFG
        CQ5mJRFeG26DFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4
        pRqYVjDXBD05W//Xaw8z4923USLLJyl1XNp76G2A054twv86LtvNevntXsXPdecZviXc7N2s
        nC1149KBLjZOtrlr7p6fcHBR0cZlWxTDXUMuC+dlfgkzrpKa1lR4Vnaj1Qd3Yc73eVaeIndn
        LxEX+fMuei6zeXpXwuIvFjJLfM+Z3zWxLeK6ePvRnfydr+Z7+EmdDEg7fk7Hd5PdqzPBhzW/
        zvt57a2i8s3++hq2xuqAm37XSw354nvywtfKVk5+yugvY2nSKPlWZybfzINFX9+4+P3s0Vor
        KbeeX9d3VeNzgb1GgW8fz9p359/y6cYslkLzLxUZLgsUUT3uEfV1z0qHX9Mv+jrcnWZfcmr/
        nq+8qUosxRmJhlrMRcWJACcs5mrvAgAA
X-CMS-MailID: 20230410030532epcas2p49eae675396bf81658c1a3401796da1d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230410030532epcas2p49eae675396bf81658c1a3401796da1d4
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
        <CGME20230410030532epcas2p49eae675396bf81658c1a3401796da1d4@epcas2p4.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>Hi folks-
>
>if it's not too late for the schedule...
>
>I am starting to tackle VM live migration and hypervisor clustering over
>switched CXL memory[1][2], intended for cloud virtualization types of loads.
>
>I'd be interested in doing a small BoF session with some slides and get
>into a discussion/brainstorming with other people that deal with VM/LM
>cloud loads. Among other things to discuss would be page migrations over
>switched CXL memory, shared in-memory ABI to allow VM hand-off between
>hypervisors, etc...
>
>A few of us discussed some of this under the ZONE_XMEM thread, but I
>figured it might be better to start a separate thread.
>
>If there is interested, thank you.

I would like join the discussion as well.
Let me kindly suggest it would be more great if it includes the data flow of VM/hypervisor as background and kernel interaction expected.

>
>
>[1]. High-level overview available at http://nil-migration.org/
>[2]. Based on CXL spec 3.0
>
>--
>Peace can only come as a natural consequence
>of universal enlightenment -Dr. Nikola Tesla
