Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770E26D1F27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjCaLem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 07:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjCaLec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:34:32 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0295171F
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 04:34:21 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230331113420epoutp02e8522528f3cd7211ae2ab1ebdf8f4660~Rfc4lgDHP2677926779epoutp02o
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 11:34:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230331113420epoutp02e8522528f3cd7211ae2ab1ebdf8f4660~Rfc4lgDHP2677926779epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680262460;
        bh=pTAoPsTYMf5uRNFA7Dctv3mKoae3M7AjuQn6oIpo9Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zqov9iCynZ0guXnPUOb005JNCXZ4MVVt6ZJQAb+J7uO0d181uXJpXKFo6i8b+MBhG
         FNTpPPM6ufr0qV2kfMQd9wpOmN4CR5XX5yx21hqNOEfFLmDs1T7xTo4NRBH7sF/Ryd
         PBrdNZyRC+LFTjf9+xBFX999hTxtolQSDcwz/WTI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230331113419epcas2p42081172994e81f630bae550425c951ae~Rfc3YUC2j1265512655epcas2p4P;
        Fri, 31 Mar 2023 11:34:19 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PnyqZ2vQ1z4x9Pw; Fri, 31 Mar
        2023 11:34:18 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.BB.61927.A35C6246; Fri, 31 Mar 2023 20:34:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230331113417epcas2p20a886e1712dbdb1f8eec03a2ac0a47e2~Rfc2RA8Oa2604426044epcas2p2J;
        Fri, 31 Mar 2023 11:34:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230331113417epsmtrp1a363905f732f20f4e2e51d34acbe777d~Rfc2QQr-R0759407594epsmtrp1O;
        Fri, 31 Mar 2023 11:34:17 +0000 (GMT)
X-AuditID: b6c32a45-8bdf87000001f1e7-f0-6426c53a8b87
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.D1.31821.935C6246; Fri, 31 Mar 2023 20:34:17 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230331113417epsmtip212672f647a7582cd7394d08215b4ca55~Rfc2Gu3GE2862228622epsmtip2C;
        Fri, 31 Mar 2023 11:34:17 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     gregory.price@memverge.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: RE: RE(4): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for
 CXL 
Date:   Fri, 31 Mar 2023 20:34:17 +0900
Message-Id: <20230331113417.400072-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZB2pugK9Vu+nINSV@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmqa7VUbUUg8NdIhbTDytaTJ96gdGi
        oekRi8X5WadYLPbsPclicW/Nf1aLfa/3Mlu86DzOZNGx4Q2jxcb779gcuDz+nVjD5rF4z0sm
        j02fJrF7TL6xnNFj48f/7B59W1YxenzeJBfAHpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9q
        ZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0npJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1
        ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+P951fMBdelKp5++M7ewHhdtIuRk0NCwERi
        87bPbF2MXBxCAjsYJU50H2KEcD4xSsxf28oM4XxmlJix/TIrTMvTU/+YIBK7GCV2/VgD1dLF
        JHFw9XoWkCo2AW2JP1fOs4HYIgJyEhf2XQOzmQX+MUrsuSwJYgsLBEksefoHrJ5FQFXi0Jx+
        RhCbV8BGYu6re0wQ2+QlZl76zg5icwroSNxcPIUZokZQ4uTMJywQM+UlmrfOBjtVQqCVQ+LE
        vLlsEM0uEr0dO5ghbGGJV8e3sEPYUhIv+9ug7GKJx6//QdklEoeX/GaBsI0l3t18DvQyB9AC
        TYn1u/RBTAkBZYkjt6DW8kl0HP7LDhHmlehoE4JoVJHY/m85M8yi0/s3QQ33kDi89gU4DIUE
        6iUmnvjFNoFRYRaSZ2YheWYWwt4FjMyrGMVSC4pz01OLjQoM4RGcnJ+7iRGcWrVcdzBOfvtB
        7xAjEwfjIUYJDmYlEd5CY9UUId6UxMqq1KL8+KLSnNTiQ4ymwKCeyCwlmpwPTO55JfGGJpYG
        JmZmhuZGpgbmSuK80rYnk4UE0hNLUrNTUwtSi2D6mDg4pRqYFlpt7UnPLlLs2T53+XmOq40N
        UZxa5Rk9+onFTwTXe884/mp6cPra6K6TIu3c7u/Wlf9el/Vmoepy79XXur5OSbr2w2+vRcs2
        ddlja0Mnbpy/WG4fT/dUl8X/j/3fNePAkoml0XuOZ0/OW7u3dZPn+zcX5GXz3K1ET5YuWCnK
        0qL5TiPpzybJjvPLV3TdDW5gkE123Rr/99/z+t6j4n8uvq37EDp7sZ+wzj7jaRwbOZ/eXPxd
        zzvZNonjcN/Ffyfar3lmTPm0p1GnL8L0zpn/LP94mW6KbFLbncTfNm/bsc9lyx+4HJu8xq/H
        0Ne7znuFafENadv5dcKTS6wLFkXoZKstXcv7onbDOcGPZw6ePKfEUpyRaKjFXFScCABt1HeD
        NgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSvK7lUbUUg0Mv9CymH1a0mD71AqNF
        Q9MjFovzs06xWOzZe5LF4t6a/6wW+17vZbZ40XmcyaJjwxtGi43337E5cHn8O7GGzWPxnpdM
        Hps+TWL3mHxjOaPHxo//2T36tqxi9Pi8SS6APYrLJiU1J7MstUjfLoEr4/3nV8wF16Uqnn74
        zt7AeF20i5GTQ0LAROLpqX9MILaQwA5GiV0f0yHiUhLvT7exQ9jCEvdbjrBC1HQwSXz+Jgli
        swloS/y5cp4NxBYRkJO4sO8akM3FwQxSs/XydLCEsECAxLaDL8CaWQRUJQ7N6WcEsXkFbCTm
        vrrHBLFAXmLmpe9gyzgFdCRuLp7CDLFMW+Ll90XMEPWCEidnPmEBsZmB6pu3zmaewCgwC0lq
        FpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwVGgpbWDcc+qD3qHGJk4GA8x
        SnAwK4nwFhqrpgjxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TB
        KdXAVOp34c/puTJ1Xe06vmEyshOV2hiWvVq/s/Nrrk76VXGrg5pXUrdYzrxaN1exPCuYoVOO
        4+qUU3rnalksrgXfE2hKjjP4IXxCR2mdlluA5aoY2aMX3VYH2V4x+Wvkd33NIokZtlOucpy7
        z78n5vGimM6mxqi/j++xzdDO9rm5pHXu/eWnpktufB8/T+88y3xB3j0SrxP5jrskqh3U3PxK
        4NnFQ68dlGRjbKJ/XgjKFNp/Nude5Z7gijMKK7xSriywE+62Xd1ieotb4nHP9xT5yJ7y9cuP
        6UlZ/jFqMT8RsPX/HJ+ZLd3SLHu0l5XLsk9/+PtL/a6w2dEumTe+alw6FBx9qoCL/7dUYUTV
        +lnLlFiKMxINtZiLihMBNLZBL/ECAAA=
X-CMS-MailID: 20230331113417epcas2p20a886e1712dbdb1f8eec03a2ac0a47e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331113417epcas2p20a886e1712dbdb1f8eec03a2ac0a47e2
References: <ZB2pugK9Vu+nINSV@memverge.com>
        <CGME20230331113417epcas2p20a886e1712dbdb1f8eec03a2ac0a47e2@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gregory Price. 
Thank you for joining this topic and share your viewpoint.
I'm sorry for late reply due to some major tasks of our team this week.

>On Fri, Mar 24, 2023 at 05:48:08PM +0900, Kyungsan Kim wrote:
>> 
>> Indeed, we tried the approach. It was able to allocate a kernel context from ZONE_MOVABLE using GFP_MOVABLE.
>> However, we think it would be a bad practice for the 2 reasons.
>> 1. It causes oops and system hang occasionally due to kernel page migration while swap or compaction. 
>> 2. Literally, the design intention of ZONE_MOVABLE is to a page movable. So, we thought allocating a kernel context from the zone hurts the intention.
>> 
>> Allocating a kernel context out of ZONE_EXMEM is unmovable.
>>   a kernel context -  alloc_pages(GFP_EXMEM,)
>
>What is the specific use case of this?  If the answer is flexibility in
>low-memory situations, why wouldn't the kernel simply change to free up
>ZONE_NORMAL (swapping user memory, migrating user memory, etc) and
>allocate as needed?
>
>I could see allocating kernel memory from local memory expanders
>(directly attached to local CXL port), but I can't think of a case where
>it would be preferable for kernel resources to live on remote memory.

We have thought kernelspace memory tiering cases.
What memory tiering we assumes is to locate a hot data in fast memory and a cold data in slow memory.
We think zswap, pagecache, and Meta TPP(page promotion/demotion among nodes) as the kernelspace memory tiering cases.

>Since local memory expanders are static devices, there shouldn't be a
>great need for hotplug, which means the memory could be mapped
>ZONE_NORMAL without issue.
>

IMHO, we think hot-add/remove is one of the key feature of CXL due to the composability aspect.
Right now, CXL device and system connection is limited. 
But industry is preparing a CXL capable system that allows more than 10 CXL channels at backplane, pluggable with EDSFF. 
Not only that, along with the progress of CXL topology - from direct-attached to switch, multi-level switch, and fabric connection -
I think the hot-add/remove usecase would become more important.


>> Allocating a user context out of ZONE_EXMEM is movable.
>>   a user context - mmap(,,MAP_EXMEM,) - syscall - alloc_pages(GFP_EXMEM | GFP_MOVABLE,)
>> This is how ZONE_EXMEM supports the two cases.
>> 
>
>Is it intended for a user to explicitly request MAP_EXMEM for it to get
>used at all?  As in, if i simply mmap() without MAP_EXMEM, will it
>remain unutilized?

Our intention is to allow below 3 cases
1. Explicit DDR allocation - mmap(,,MAP_NORMAL,)
 : allocation from ZONE_NORMAL or ZONE_MOVABLE, or allocation fails.
2. Explicit CXL allocation - mmap(,,MAP_EXMEM,)
 : allocation from ZONE_EXMEM, of allocation fails.
3. Implicit Memory allocation - mmap(,,,) 
 : allocation from ZONE_NORMAL, ZONE_MOVABLE, or ZONE_EXMEM. In other words, no matter where DDR or CXL DRAM.

Among that, 3 is similar with vanilla kernel operation in that the allocation request traverses among multiple zones or nodes.
We think it would be good or bad for the mmap caller point of view.
It is good because memory is allocated, while it could be bad because the caller does not have idea of allocated memory type.
The later would hurt QoS metrics or userspace memory tiering operation, which expects near/far memory.

>
>~Gregory
