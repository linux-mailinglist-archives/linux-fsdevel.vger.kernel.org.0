Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606BE6C7AD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 10:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjCXJJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 05:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjCXJJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:09:30 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA90715CB3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 02:09:27 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230324090925epoutp03c6237e6a80d86f7008e9e92657e9234f~PT9W1hZcO1498614986epoutp03x
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 09:09:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230324090925epoutp03c6237e6a80d86f7008e9e92657e9234f~PT9W1hZcO1498614986epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679648965;
        bh=f0X0PgQNIRa18Zw3p+myDnTTd6jspyLZGnNukXyxcyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oM49UQ5XrdrSdpmt2oANKRBgMXxLmhlzwtj/Pq7VRbDl8ZmXkWwxf0jRgX7rqmrvW
         po7JDK/Dy0kxa+zj9bxynudfPyTkl5O7eQ4Iy4KciUWFNZKc20f4mRy51mxNVbFg85
         VND0TTznGqA3BVppAX5trbnFVPKpxOjiFl13jpV8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230324090924epcas2p3df4027204c33d6ba972e0e321b6a6124~PT9WdEo421378113781epcas2p3z;
        Fri, 24 Mar 2023 09:09:24 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.97]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Pjbxc2428z4x9Q1; Fri, 24 Mar
        2023 09:09:24 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.EB.31307.4C86D146; Fri, 24 Mar 2023 18:09:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230324090923epcas2p2710ba4dc8157f9141c03104cf66e9d26~PT9VXeM0d3122731227epcas2p2E;
        Fri, 24 Mar 2023 09:09:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230324090923epsmtrp10ac6c7c71d85c3d8be9d18ef0605d40d~PT9VWge250442704427epsmtrp1A;
        Fri, 24 Mar 2023 09:09:23 +0000 (GMT)
X-AuditID: b6c32a46-743fa70000007a4b-2f-641d68c4b5be
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.F2.18071.3C86D146; Fri, 24 Mar 2023 18:09:23 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230324090923epsmtip2bf24333b56efa57f9f4d7f9bfdc5b8ec~PT9VNSSzq0738207382epsmtip2f;
        Fri, 24 Mar 2023 09:09:23 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     david@redhat.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com
Subject: RE(4): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL 
Date:   Fri, 24 Mar 2023 18:09:23 +0900
Message-Id: <20230324090923.147947-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <31395703-5f0e-651e-1e3d-226751a22d1b@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmue6RDNkUg8VTeSymH1a0mD71AqPF
        1/W/mC3OzzrFYrFn70kWi3tr/rNa7Hu9l9miY8MbRgcOj38n1rB5LN7zkslj06dJ7B6Tbyxn
        9Hi/7yqbR9+WVYwenzfJBbBHZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynk
        Jeam2iq5+AToumXmAB2lpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswt
        Ls1L18tLLbEyNDAwMgUqTMjOmNSwkKWgVbLi8vlDTA2Mm0W6GDk5JARMJNouX2PuYuTiEBLY
        wSixpGsHE4TziVFi2+rdjBDON0aJZb/fMsK0vDpwDKpqL6PEjqcwLV1MEmuWb2UDqWIT0Jb4
        c+U8mC0iICLx4+FLsFHMAueB5r74zQ6SEBbwkPi16gIziM0ioCoxc8MLVhCbV8BGYvuudhaI
        dfISMy99B6vnFLCTmP1wOSNEjaDEyZlPwGqYgWqat85mhqhv5JB40JkBYbtI7D/+DiouLPHq
        +BZ2CFtK4mV/G5RdLPH49T8ou0Ti8JLfUHuNJd7dfA50DwfQfE2J9bv0QUwJAWWJI7egtvJJ
        dBz+yw4R5pXoaBOCaFSR2P5vOTPMotP7N0EN95Dofj+JHRJUExkl7t+9zz6BUWEWkmdmIXlm
        FsLiBYzMqxjFUguKc9NTi40KjOAxnJyfu4kRnEi13HYwTnn7Qe8QIxMH4yFGCQ5mJRHedyGy
        KUK8KYmVValF+fFFpTmpxYcYTYFBPZFZSjQ5H5jK80riDU0sDUzMzAzNjUwNzJXEeaVtTyYL
        CaQnlqRmp6YWpBbB9DFxcEo1MLGfmdaZqGR89u8utacLzFnElu/xF1mp1dnTNTeMp+rGBeut
        /564Trbcsi5l2pHI4kLuaTvncbvJLVvD8C1r2s6zh/8UVp4MnPh+sYHJytJzcWU7Gqf+8ZNj
        +b9UpyIotD79U1PU1xNZk01fPC8PeubJ+1G2eMPKB4xhnwKtY87mPumzjLQXefndvvEwv33+
        zhyvG6cDquI1fmd+quP02Pxn5Z//aw4aMvkb5y+O6DQNVGyZ071+m0Jx+8S2CXnSTjH5N29/
        UOt6yfdV5tcubqujb5kOdS6645MVMpmv+MjWvxd/VltXWfgVXy3plG15Wdy0t0jr5d+So5yr
        a22nbZDV8e1z2ZQqLnx648pH55RYijMSDbWYi4oTAS42nzUtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSvO7hDNkUg9vnNC2mH1a0mD71AqPF
        1/W/mC3OzzrFYrFn70kWi3tr/rNa7Hu9l9miY8MbRgcOj38n1rB5LN7zkslj06dJ7B6Tbyxn
        9Hi/7yqbR9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGVMaljIUtAqWXH5/CGmBsbNIl2MnBwS
        AiYSrw4cY+pi5OIQEtjNKHG27RM7REJK4v3pNihbWOJ+yxFWiKIOJonJi+8ygyTYBLQl/lw5
        zwZiiwiISPx4+JIRpIhZ4CqjxMcXK8GKhAU8JH6tugBmswioSszc8IIVxOYVsJHYvqudBWKD
        vMTMS9/BtnEK2EnMfricEcQWErCVmPLtPztEvaDEyZlPwOqZgeqbt85mnsAoMAtJahaS1AJG
        plWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFBr6W5g3H7qg96hxiZOBgPMUpwMCuJ
        8L4LkU0R4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgYlh
        z9v3DzJaVY1zTh9+M+FHYJp54QneXZH9fJskbiWtaGTnecHzfveiZhX2e3dU769u8o2+9Zfp
        S/S6NS7WV48wWBSpVpzu5n/P1Tnj6LP1Dk8z/BcnbTvDMFlKZcXtvIC4gJss68uTxYWL1h6x
        n7tjppfjyU858yx2q0kdOOS7YH4C+9dtJ593CKgKmnm3rxZ7kj/Jyrde3OtCC3tptx+7QoCJ
        zHwxifabMz+ZGl6MzfwkPUfEtda9/fHN59/kfqnt1+q7uPDzAdsYxbmfdzjyOZcca4zgLSib
        v2HimpTWW9Lnt1Rca0xZkLnx0LYH73gX3skKP712+uqfP3rLtfw6dBLuzHF8JB3uxp29YZIS
        S3FGoqEWc1FxIgD0GhGh6QIAAA==
X-CMS-MailID: 20230324090923epcas2p2710ba4dc8157f9141c03104cf66e9d26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230324090923epcas2p2710ba4dc8157f9141c03104cf66e9d26
References: <31395703-5f0e-651e-1e3d-226751a22d1b@redhat.com>
        <CGME20230324090923epcas2p2710ba4dc8157f9141c03104cf66e9d26@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you David Hinderbrand for your interest on this topic.

>>
>>> Kyungsan Kim wrote:
>>> [..]
>>>>> In addition to CXL memory, we may have other kind of memory in the
>>>>> system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>>>> memory in GPU card, etc.  I guess that we need to consider them
>>>>> together.  Do we need to add one zone type for each kind of memory?
>>>>
>>>> We also don't think a new zone is needed for every single memory
>>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>>> manage multiple volatile memory devices due to the increased device
>>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>>> represent extended volatile memories that have different HW
>>>> characteristics.
>>>
>>> Some advice for the LSF/MM discussion, the rationale will need to be
>>> more than "we think the ZONE_EXMEM can be used to represent extended
>>> volatile memories that have different HW characteristics". It needs to
>>> be along the lines of "yes, to date Linux has been able to describe DDR
>>> with NUMA effects, PMEM with high write overhead, and HBM with improved
>>> bandwidth not necessarily latency, all without adding a new ZONE, but a
>>> new ZONE is absolutely required now to enable use case FOO, or address
>>> unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>>> maintainability concern of "fewer degress of freedom in the ZONE
>>> dimension" starts to dominate.
>>
>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.

>That sounds like a bad hack :) .
I consent you.

>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.

>I once raised the idea of a ZONE_PREFER_MOVABLE [1], maybe that's
>similar to what you have in mind here. In general, adding new zones is
>frowned upon.

Actually, we have already studied your idea and thought it is similar with us in 2 aspects.
1. ZONE_PREFER_MOVABLE allows a kernelspace allocation using a new zone
2. ZONE_PREFER_MOVABLE helps less fragmentation by splitting zones, and ordering allocation requests from the zones.

We think ZONE_EXMEM also helps less fragmentation.
Because it is a separated zone and handles a page allocation as movable by default.

>> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
>> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
>>
>> Kindly let me know any advice or comment on our thoughts.
>
>[1] https://www.lkml.org/lkml/2020/9/9/667
>
>--
>Thanks,
>
>David / dhildenb
