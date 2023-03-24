Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D526C7A37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 09:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjCXIsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 04:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjCXIsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:48:19 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5319EEF
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 01:48:13 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230324084810epoutp01da9ef5829feae2aab8f29d6eddf77588~PTqzmi02Y0869208692epoutp01k
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 08:48:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230324084810epoutp01da9ef5829feae2aab8f29d6eddf77588~PTqzmi02Y0869208692epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679647690;
        bh=AjQoF8Fed+RE6UpWGSQrtqtF7ukexOCrE26+nIxPqbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jq8kNL4Efvjyjxl1DmevuU+BlaSqsjeSrgXsShyQ8Px0/gKeTQgx5aM16yBPBIBzV
         v9P/vOY9GmQpHKS00cjvsoHVGm954P3mCZTSLRVzGdntkfPwE61M4YJLHb2lGfBBra
         +XBBsXmUE7oZcpSv3+qwb/4B+x1YsrXIOHbdZDvE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230324084809epcas2p1a23fc93205725389c873a6752d5f3aca~PTqy0HmQZ1206712067epcas2p1D;
        Fri, 24 Mar 2023 08:48:09 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PjbT50Q7Cz4x9Ps; Fri, 24 Mar
        2023 08:48:09 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.5C.61927.8C36D146; Fri, 24 Mar 2023 17:48:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230324084808epcas2p354865d38dccddcb5cd46b17610345a5f~PTqx29NNK1857218572epcas2p3S;
        Fri, 24 Mar 2023 08:48:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230324084808epsmtrp20e9c2a1bacbce1ac98887e48c9756e1a~PTqx2Hyr61189511895epsmtrp21;
        Fri, 24 Mar 2023 08:48:08 +0000 (GMT)
X-AuditID: b6c32a45-8bdf87000001f1e7-1b-641d63c89334
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.21.18071.8C36D146; Fri, 24 Mar 2023 17:48:08 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230324084808epsmtip291c89ae8550db7812fc651628fe9d88f~PTqxrYFn93226532265epsmtip2N;
        Fri, 24 Mar 2023 08:48:08 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     ying.huang@intel.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com
Subject: RE(4): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL 
Date:   Fri, 24 Mar 2023 17:48:08 +0900
Message-Id: <20230324084808.147885-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87wn37q8v5.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmme6JZNkUgy3/bCymH1a0mD71AqPF
        +VmnWCz27D3JYnFvzX9Wi32v9zJbdGx4w2hxctZkFgcOj38n1rB5LN7zkslj06dJ7B6Tbyxn
        9OjbsorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5
        qSVWhgYGRqZAhQnZGdPfrWEtmCJd8e/CNKYGxpliXYycHBICJhJv5+5m7mLk4hAS2MEo8XbO
        XiYI5xOjxOzTv1khnG+MEvfnfGeGaZm5bSNUy15GiSf7PzBCOF1MEtOWLmACqWIT0Jb4c+U8
        G4gtIiAhsX5HL1gRs8B5RoltL36zgySEBTwkfq26ADaWRUBVom9+K5jNK2AjcfL7E6h18hIz
        L30Hq+cUsJN4uaiDFaJGUOLkzCcsIDYzUE3z1tlgJ0kIfGWXWLHkACNEs4vEqsvLoAYJS7w6
        voUdwpaS+PxuLxuEXSzx+PU/qHiJxOElv1kgbGOJdzefAy3jAFqgKbF+lz6IKSGgLHHkFtRa
        PomOw3/ZIcK8Eh1tQhCNKhLb/y1nhll0ev8mqOEeEkufvYKG6ERGiWtvp7NNYFSYheSbWUi+
        mYWweAEj8ypGsdSC4tz01GKjAkN4FCfn525iBCdQLdcdjJPfftA7xMjEwXiIUYKDWUmE912I
        bIoQb0piZVVqUX58UWlOavEhRlNgWE9klhJNzgem8LySeEMTSwMTMzNDcyNTA3MlcV5p25PJ
        QgLpiSWp2ampBalFMH1MHJxSDUxR2TukD2qVbL/zvPxB6988hRfMPfciK1m0nn8T2qJWOXGG
        sPeUuXxmV+8HNPz45mw4zexH5lPmFvkTcQr5H7tvRwWIilomJXHt+JX31NaJv5xFoLXkSbZd
        SMaldbybCg5//nI2bdP3q67LpCtvxRo6OFQ5HOb4khGSGvH7dEru5cbJF1Ksle9l+mUdYi0s
        Oja3QPfiBr9Xswr3mN2+uv7WidLpCz2l6vZcqxWVneznGrOp6l5Fv+IJQx2TrS8iV3/8EXPt
        oqFc4L4bCZWpgYrFgq1vz0/89uaDtLfubs2vnsqX1k0NXxfgY6J89/1FS+Ptaqua7GPWGx0M
        X+K2rfrRsvUex/fs+1+xQUTv7SYlluKMREMt5qLiRAB0mlB8KQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvO6JZNkUg8WtyhbTDytaTJ96gdHi
        /KxTLBZ79p5ksbi35j+rxb7Xe5ktOja8YbQ4OWsyiwOHx78Ta9g8Fu95yeSx6dMkdo/JN5Yz
        evRtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfG9HdrWAumSFf8uzCNqYFxplgXIyeHhICJxMxt
        G5m7GLk4hAR2M0qcuPGDGSIhJfH+dBs7hC0scb/lCCuILSTQwSTx+4AUiM0moC3x58p5NhBb
        REBCYv2OXkaQQcwCVxklPr5YCTZIWMBD4teqC2A2i4CqRN/8VjCbV8BG4uT3J1DL5CVmXvoO
        toxTwE7i5aIOqGW2EnOvPmaCqBeUODnzCQuIzQxU37x1NvMERoFZSFKzkKQWMDKtYpRMLSjO
        Tc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDnQtzR2M21d90DvEyMTBeIhRgoNZSYT3XYhsihBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MxQ+nxX5WuGZ7
        tKO34ky2OcvydvNXIk7HTxznc/rbNH/eg61cBofniepl5LhdfXzsgsq2fzk+U+9YNy3Kfmdq
        ejO5zdmUI+ZMcpWCxRWPHDHOe2uD5u6PVc/zO//BVOfv6ptRn/wXnClNv7/5yPzv/pEsv4zP
        sdw5cEeZj7Ff5Eyox6GT6tyT/Hvk9ollLD37sXfTfBtpNkPhOSWa019I/V88f+VJ2W2hXZ8Y
        951Y8lB3jm4190uDo/deBsXfDDNIcPi4yuts9IbH8/0Xqc7P2PuFNcem/6/vXy8rs+6GmHtf
        uzrvd7Xazqg4edbsfYv1MR7mOv4JRlOkv/+VmFKuxDxr7czvXgaPxK68sVYrUWIpzkg01GIu
        Kk4EAMC9x83jAgAA
X-CMS-MailID: 20230324084808epcas2p354865d38dccddcb5cd46b17610345a5f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230324084808epcas2p354865d38dccddcb5cd46b17610345a5f
References: <87wn37q8v5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CGME20230324084808epcas2p354865d38dccddcb5cd46b17610345a5f@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>Kyungsan Kim <ks0204.kim@samsung.com> writes:
>
>> I appreciate dan for the careful advice.
>>
>>>Kyungsan Kim wrote:
>>>[..]
>>>> >In addition to CXL memory, we may have other kind of memory in the
>>>> >system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>>> >memory in GPU card, etc.  I guess that we need to consider them
>>>> >together.  Do we need to add one zone type for each kind of memory?
>>>> 
>>>> We also don't think a new zone is needed for every single memory
>>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>>> manage multiple volatile memory devices due to the increased device
>>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>>> represent extended volatile memories that have different HW
>>>> characteristics.
>>>
>>>Some advice for the LSF/MM discussion, the rationale will need to be
>>>more than "we think the ZONE_EXMEM can be used to represent extended
>>>volatile memories that have different HW characteristics". It needs to
>>>be along the lines of "yes, to date Linux has been able to describe DDR
>>>with NUMA effects, PMEM with high write overhead, and HBM with improved
>>>bandwidth not necessarily latency, all without adding a new ZONE, but a
>>>new ZONE is absolutely required now to enable use case FOO, or address
>>>unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>>>maintainability concern of "fewer degress of freedom in the ZONE
>>>dimension" starts to dominate.
>>
>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>
>Sorry, I don't get your idea.  You want the memory range
>
> 1. can be hot-removed
> 2. allow kernel context allocation
>
>This appears impossible for me.  Why cannot you just use ZONE_MOVABLE?

Indeed, we tried the approach. It was able to allocate a kernel context from ZONE_MOVABLE using GFP_MOVABLE.
However, we think it would be a bad practice for the 2 reasons.
1. It causes oops and system hang occasionally due to kernel page migration while swap or compaction. 
2. Literally, the design intention of ZONE_MOVABLE is to a page movable. So, we thought allocating a kernel context from the zone hurts the intention.

Allocating a kernel context out of ZONE_EXMEM is unmovable.
  a kernel context -  alloc_pages(GFP_EXMEM,)
Allocating a user context out of ZONE_EXMEM is movable.
  a user context - mmap(,,MAP_EXMEM,) - syscall - alloc_pages(GFP_EXMEM | GFP_MOVABLE,)
This is how ZONE_EXMEM supports the two cases.

>
>Best Regards,
>Huang, Ying
>
>> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
>> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
>>
>> Kindly let me know any advice or comment on our thoughts.
