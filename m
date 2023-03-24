Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4536C7B48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 10:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjCXJ1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 05:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCXJ1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:27:37 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43EBE3AB
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 02:27:35 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230324092733epoutp0401f5dbd938a9aaf059311a5b4ca96b77~PUNMi2tU92116821168epoutp04H
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 09:27:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230324092733epoutp0401f5dbd938a9aaf059311a5b4ca96b77~PUNMi2tU92116821168epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679650053;
        bh=BkHVlBh2dQrj5b5sUqG0tTU2IFNrE8I+rD3g7gSmgkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKhNjkkUXJkSrHIloFlj6BZIPy3pKgRBnO+0J1LCwPvgZSZ0Nh1IFS420TNNBIZ/2
         WfRr8Ff4nc9/QAFwOJHfLsPROafR6+1HEbf7LTHQGrZTwZ/lGR4MGLUdpK2Lb3wphO
         T79J3gH+PfX3vTfARqV9onbmwANHzTChL4021Q/o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230324092733epcas2p333b87553540f5d1b27cd9df55e22f25b~PUNMAooWX1786417864epcas2p3m;
        Fri, 24 Mar 2023 09:27:33 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PjcLX4KHsz4x9Pt; Fri, 24 Mar
        2023 09:27:32 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.4C.61927.40D6D146; Fri, 24 Mar 2023 18:27:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230324092731epcas2p315c348bd76ef9fc84bffdb158e4c1aa4~PUNKm07NH1786417864epcas2p3l;
        Fri, 24 Mar 2023 09:27:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230324092731epsmtrp2bcaee70a0531967ec200d533841f5816~PUNKlpACQ0218602186epsmtrp27;
        Fri, 24 Mar 2023 09:27:31 +0000 (GMT)
X-AuditID: b6c32a45-8bdf87000001f1e7-a3-641d6d04d62a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.7E.31821.30D6D146; Fri, 24 Mar 2023 18:27:31 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230324092731epsmtip18d93514b2b6bc10c4b5cb672025825bf~PUNKYNDPD3134731347epsmtip1k;
        Fri, 24 Mar 2023 09:27:31 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     david@redhat.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com
Subject: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Fri, 24 Mar 2023 18:27:31 +0900
Message-Id: <20230324092731.148023-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5536d792-867d-6390-81e2-b1ef135d347d@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmhS5LrmyKwaHb8hbTDytaTJ96gdHi
        6/pfzBbnZ51isdiz9ySLxb01/1kt9r3ey2zRseENowOHx78Ta9g8Fu95yeSx6dMkdo/JN5Yz
        erzfd5XNo2/LKkaPz5vkAtijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
        EnNTbZVcfAJ03TJzgI5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YW
        l+al6+WlllgZGhgYmQIVJmRn/H+zhbWgV6bi3MmzjA2ML8S6GDk5JARMJHYsusHaxcjFISSw
        g1Hi8+0PjBDOJ0aJFe3r2CCcz4wS39ZNYIdpaVn0kAkisYtR4v3TOSwgCSGBLiaJ3e/SQGw2
        AW2JP1fOs4HYIgIiEj8evgQbyyxwnlFi24vfYJOEBdwlti/pYQWxWQRUJTb9+wkW5xWwkZg7
        9xcLxDZ5iZmXvoPFOQXsJL5POswGUSMocXLmE7AaZqCa5q2zmSHq/7JLbP0c38XIAWS7SPzf
        agoRFpZ4dXwL1ANSEp/f7WWDsIslHr/+BxUvkTi85DfUWmOJdzefs4KMYRbQlFi/Sx9iorLE
        kVtQS/kkOg7/ZYcI80p0tAlBNKpIbP+3nBlm0en9m6CGe0j8/PefBRJqExklPs7cwTyBUWEW
        kl9mIfllFsLiBYzMqxjFUguKc9NTi40KDOHxm5yfu4kRnES1XHcwTn77Qe8QIxMH4yFGCQ5m
        JRHedyGyKUK8KYmVValF+fFFpTmpxYcYTYEhPZFZSjQ5H5jG80riDU0sDUzMzAzNjUwNzJXE
        eaVtTyYLCaQnlqRmp6YWpBbB9DFxcEo1MGVEOgq9XeEUsStG9UfUzP0vFbPcYi69Ofn4+mpL
        Y7/V58wXOufe8b/3cjvj2Rsuax8U/X/oUGnWr7ZBcv8N6zqPmX+X3N0S/CL4ykPh7767rE93
        bGFafrp39sxbeyNm9B28wBhq8lHjwVTDH9IzIstXr5p99Jjqq2altb0JUlv+njIILHCY//ae
        zVFLrepzh6+enJ3TXle4rvOAWD6vrY9/fmT+TA27F38d9irHb/aQuL9yr0SxmMuUnHmnOZje
        nXVbxLFaTUJ608ZD4vE1x99M2DJJVe/M4fUnHBesYTM+Nd1lmdgj1+2zLpbr2vw5cfXfyzf+
        +3Zafrwuo+G+6G7cNI9bf3buN+NawXHF5+XqBUosxRmJhlrMRcWJALG+7EorBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSnC5zrmyKwdXDShbTDytaTJ96gdHi
        6/pfzBbnZ51isdiz9ySLxb01/1kt9r3ey2zRseENowOHx78Ta9g8Fu95yeSx6dMkdo/JN5Yz
        erzfd5XNo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDL+v9nCWtArU3Hu5FnGBsYXYl2MnBwS
        AiYSLYseMnUxcnEICexglPjQNpERIiEl8f50GzuELSxxv+UIK0RRB5PEm7P3mEESbALaEn+u
        nGcDsUUERCR+PHzJCFLELHCVUeLji5VgRcIC7hLbl/SwgtgsAqoSm/79BJvKK2AjMXfuLxaI
        DfISMy99B4tzCthJfJ90GGyokICtxMvXLVD1ghInZz4Bq2cGqm/eOpt5AqPALCSpWUhSCxiZ
        VjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBAe9ltYOxj2rPugdYmTiYDzEKMHBrCTC
        +y5ENkWINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpqbq
        8PhZN05a/N0sm6foaZWxsKZ8xcaiiBMlsvvFb+1UUXHSdS1K3HDII2bdHd7pJXlXLHJ/T4k6
        MOVh1aNuV9nfRqu+HLFq3FP3gn+x+arU38peT+1cqx7ZWNQ6f/164v7ha4fLBGsXrehrS77I
        9JS/T6TG6O7+VUK8E6Y+nMST4V5i4Wt9xqomuTB8TVTnlujXDAsWPn1zeJLoqdOcCx0ExRgD
        VvrJnDzSlD3/rKLmO+depjzWdqmzTm8my9/QLC+7mmDlzMv9mbPrrNv1dLeHFxzfHWpcNsF6
        3bMrem3WQj1WE+M2t+ov7c1u6i/Peni/WDhfsX/XygwFG9EbMUYrHpt77l6lvN516XRlJZbi
        jERDLeai4kQA71uzLOkCAAA=
X-CMS-MailID: 20230324092731epcas2p315c348bd76ef9fc84bffdb158e4c1aa4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230324092731epcas2p315c348bd76ef9fc84bffdb158e4c1aa4
References: <5536d792-867d-6390-81e2-b1ef135d347d@redhat.com>
        <CGME20230324092731epcas2p315c348bd76ef9fc84bffdb158e4c1aa4@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On 24.03.23 10:09, Kyungsan Kim wrote:
>> Thank you David Hinderbrand for your interest on this topic.
>> 
>>>>
>>>>> Kyungsan Kim wrote:
>>>>> [..]
>>>>>>> In addition to CXL memory, we may have other kind of memory in the
>>>>>>> system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>>>>>> memory in GPU card, etc.  I guess that we need to consider them
>>>>>>> together.  Do we need to add one zone type for each kind of memory?
>>>>>>
>>>>>> We also don't think a new zone is needed for every single memory
>>>>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>>>>> manage multiple volatile memory devices due to the increased device
>>>>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>>>>> represent extended volatile memories that have different HW
>>>>>> characteristics.
>>>>>
>>>>> Some advice for the LSF/MM discussion, the rationale will need to be
>>>>> more than "we think the ZONE_EXMEM can be used to represent extended
>>>>> volatile memories that have different HW characteristics". It needs to
>>>>> be along the lines of "yes, to date Linux has been able to describe DDR
>>>>> with NUMA effects, PMEM with high write overhead, and HBM with improved
>>>>> bandwidth not necessarily latency, all without adding a new ZONE, but a
>>>>> new ZONE is absolutely required now to enable use case FOO, or address
>>>>> unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>>>>> maintainability concern of "fewer degress of freedom in the ZONE
>>>>> dimension" starts to dominate.
>>>>
>>>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>> 
>>> That sounds like a bad hack :) .
>> I consent you.
>> 
>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>> 
>>> I once raised the idea of a ZONE_PREFER_MOVABLE [1], maybe that's
>>> similar to what you have in mind here. In general, adding new zones is
>>> frowned upon.
>> 
>> Actually, we have already studied your idea and thought it is similar with us in 2 aspects.
>> 1. ZONE_PREFER_MOVABLE allows a kernelspace allocation using a new zone
>> 2. ZONE_PREFER_MOVABLE helps less fragmentation by splitting zones, and ordering allocation requests from the zones.
>> 
>> We think ZONE_EXMEM also helps less fragmentation.
>> Because it is a separated zone and handles a page allocation as movable by default.
>
>So how is it different that it would justify a different (more confusing 
>IMHO) name? :) Of course, names don't matter that much, but I'd be 
>interested in which other aspect that zone would be "special".

FYI for the first time I named it as ZONE_CXLMEM, but we thought it would be needed to cover other extended memory types as well.
So I changed it as ZONE_EXMEM. 
We also would like to point out a "special" zone aspeact, which is different from ZONE_NORMAL for tranditional DDR DRAM.
Of course, a symbol naming is important more or less to represent it very nicely, though.
Do you prefer ZONE_SPECIAL? :)

>
>-- 
>Thanks,
>
>David / dhildenb
>
