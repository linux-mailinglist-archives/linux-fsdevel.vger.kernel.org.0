Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F416DF4AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 14:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDLMGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 08:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjDLMGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:06:11 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F73FB4
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 05:06:08 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230412111036epoutp02af5b3ee27d69b7867750b409c4e791a5~VK3llGrvk0936209362epoutp02j
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 11:10:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230412111036epoutp02af5b3ee27d69b7867750b409c4e791a5~VK3llGrvk0936209362epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681297836;
        bh=gxT9FVIWocXRSEi5tRsmUyrD2AFA4oFyGjZCRcax7eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzfiSuIfmsdHxJD3wU9WincAovM5r8BnYxFWLxylGntR9JN6ioBfjHVsbTDfmoXAw
         Y3GycuXq6gP77zjR3mCJtHo/q9yZHTqUGD4tvCaA9L4ldnZdKS8PWMvVTVNiu0GMkb
         vPauigjI8EWt2lwuo9CCG2ePNvbMd3uhtNJeTWyY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230412111035epcas2p351b6aa0cae5301c5620e21ae3731c404~VK3k-K1iC2920729207epcas2p3j;
        Wed, 12 Apr 2023 11:10:35 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PxKkf6jbNz4x9Pt; Wed, 12 Apr
        2023 11:10:34 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.6F.09650.AA196346; Wed, 12 Apr 2023 20:10:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230412111034epcas2p1b46d2a26b7d3ac5db3b0e454255527b0~VK3jypdUS2306323063epcas2p1-;
        Wed, 12 Apr 2023 11:10:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230412111034epsmtrp2ea4846993ebd7c4a6e805f72f978cf41~VK3jx72eZ1285412854epsmtrp2k;
        Wed, 12 Apr 2023 11:10:34 +0000 (GMT)
X-AuditID: b6c32a48-dc7ff700000025b2-74-643691aa072f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.8E.08609.AA196346; Wed, 12 Apr 2023 20:10:34 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230412111034epsmtip162b8e93b033651522a7edc8fbdb79d77~VK3josXS00632606326epsmtip1E;
        Wed, 12 Apr 2023 11:10:34 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     david@redhat.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: FW: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory
Date:   Wed, 12 Apr 2023 20:10:33 +0900
Message-Id: <20230412111033.434644-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f4f9eedf-c514-3388-29ad-dcb497a19303@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmhe6qiWYpBgsWGlpMP6xoMX3qBUaL
        r+t/MVucn3WKxWLP3pMsFvfW/Ge12Pd6L7PFi87jTBYdG94wWmy8/47Ngcvj34k1bB6L97xk
        8tj0aRK7x+Qbyxk93u+7yubRt2UVo8fnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGm
        ZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA5ykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVS
        C1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjPa3qQVrJComPlpD3MD4wvhLkYODgkBE4lT
        ja5djFwcQgI7GCX2nZvBCuF8YpT4tnceE4TzmVFi0pGrLF2MnGAd7+9PYoRI7GKUODRnFVRV
        F5PEhPkbmEGq2AS0Jf5cOc8GYosIiEj8ePiSEcRmFvjHKLHnsiSILSzgKfHy1CKwehYBVYnJ
        S26C1fAK2Ej8bDjFBLFNXmLmpe/sIDangJ3EmqdN7BA1ghInZz5hgZgpL9G8dTYzyBESAp0c
        En3LjzBCNLtIHD09hRnCFpZ4dXwLO4QtJfH53V42CLtY4vHrf1DxEonDS35DvWks8e7mc1ZQ
        IDELaEqs36UPCS9liSO3oNbySXQc/ssOEeaV6GgTgmhUkdj+bzkzzKLT+zdBlXhInPgfCQmp
        iYwSO+7uY5nAqDALyTOzkDwzC2HvAkbmVYxiqQXFuempxUYFJvDoTc7P3cQITqtaHjsYZ7/9
        oHeIkYmD8RCjBAezkgjvDxfTFCHelMTKqtSi/Pii0pzU4kOMpsCgnsgsJZqcD0zseSXxhiaW
        BiZmZobmRqYG5krivB87lFOEBNITS1KzU1MLUotg+pg4OKUamNYtVpojsmCXSN5Zz8M/2t49
        TPp9cGNjaEVtvPaFRxW5X5JiOdJfCH1dnsX5z+yNcNPWLfsudpRX7nS4rRdvEafVWz59w4+J
        dT1dgqc+hofcbznIEbvub6vlseV/dy6dJilxenbCfN+/y962dy2UdlW9UfLLRf6b+K9ZyZv8
        fFfpnhN9eDVVeYtxv/QHQYYyZscne1eWFB2++U4w6cqyiTMW3fCotdgw1TK34tT/XVMXBp1u
        +mTFvkTPcGpmvWxPw/weIY7DV85unG53i+llqMvNuTsvx2u+/mu1rE0oZOnBtkVeFl2r990X
        nLdNe4vGf5M53uHhZTd64pNDi8/r73AQvaPFuaSNa92UHT4ux02UWIozEg21mIuKEwHlzE74
        NAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnO6qiWYpBv/XCVlMP6xoMX3qBUaL
        r+t/MVucn3WKxWLP3pMsFvfW/Ge12Pd6L7PFi87jTBYdG94wWmy8/47Ngcvj34k1bB6L97xk
        8tj0aRK7x+Qbyxk93u+7yubRt2UVo8fnTXIB7FFcNimpOZllqUX6dglcGW1v0gpWSFTM/LSH
        uYHxhXAXIyeHhICJxPv7kxi7GLk4hAR2MEpc2r6FBSIhJfH+dBs7hC0scb/lCCtEUQeTxKGb
        TWwgCTYBbYk/V86D2SICIhI/Hr4Em8QMUrT18nSwhLCAp8TLU4uYQWwWAVWJyUtuMoLYvAI2
        Ej8bTjFBbJCXmHnpO9g2TgE7iTVPm8BsIQFbiSsPr7FB1AtKnJz5BOw6ZqD65q2zmScwCsxC
        kpqFJLWAkWkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwHGhp7WDcs+qD3iFGJg7G
        Q4wSHMxKIrw/XExThHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl
        4uCUamDSkIgPnnhI56N5/mK9OKXFFe+2hPhPlXuqPqGz5HBl32vulw/mHOMsZtJd9nOJ2s1+
        ScHTHPNnfb5ec8ou0v81v8qJOu8iX3sBn4Ds9Wk9T9IPtGmd8BEuT3jtKVhvq5O45PY7eyFT
        z73snAq/ZaJuTWG8eTTrhoDJ5Sm+b+5Mu/Ft+6TgJe/7rrRybXbM2rFwineTsSGP/6WaT0tb
        vRlbL32dYBOtbSC48WsyRxTLZfu/z3SPpLEY/zf7dfD+Il2u0+XbeHONQo7oHJ273vLA/AsX
        VWrcfl53uXjrV+zEe2JsBQozuJdsXKKvt/P0edZ3L69cD38qtdz4tfr7TXGfb973+HzfQXvL
        1y/9KhNMlViKMxINtZiLihMB7mtRd/ICAAA=
X-CMS-MailID: 20230412111034epcas2p1b46d2a26b7d3ac5db3b0e454255527b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412111034epcas2p1b46d2a26b7d3ac5db3b0e454255527b0
References: <f4f9eedf-c514-3388-29ad-dcb497a19303@redhat.com>
        <CGME20230412111034epcas2p1b46d2a26b7d3ac5db3b0e454255527b0@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Gregory Price <gregory.price@memverge.com> writes:
>>
>>> On Tue, Apr 11, 2023 at 02:37:50PM +0800, Huang, Ying wrote:
>>>> Gregory Price <gregory.price@memverge.com> writes:
>>>>
>>>> [snip]
>>>>
>>>>> 2. During the migration process, the memory needs to be forced not to be
>>>>>     migrated to another node by other means (tiering software, swap,
>>>>>     etc).  The obvious way of doing this would be to migrate and
>>>>>     temporarily pin the page... but going back to problem #1 we see that
>>>>>     ZONE_MOVABLE and Pinning are mutually exclusive.  So that's
>>>>>     troublesome.
>>>>
>>>> Can we use memory policy (cpusets, mbind(), set_mempolicy(), etc.) to
>>>> avoid move pages out of CXL.mem node?  Now, there are gaps in tiering,
>>>> but I think it is fixable.
>>>>
>>>> Best Regards,
>>>> Huang, Ying
>>>>
>>>> [snip]
>>>
>>> That feels like a hack/bodge rather than a proper solution to me.
>>>
>>> Maybe this is an affirmative argument for the creation of an EXMEM
>>> zone.
>>
>> Let's start with requirements.  What is the requirements for a new zone
>> type?
>
>I'm stills scratching my head regarding this. I keep hearing all
>different kind of statements that just add more confusions "we want it
>to be hotunpluggable" "we want to allow for long-term pinning memory"
>"but we still want it to be movable" "we want to place some unmovable
>allocations on it". Huh?
>
>Just to clarify: ZONE_MOVABLE allows for pinning. It just doesn't allow
>for long-term pinning of memory.
>
>For good reason, because long-term pinning of memory is just the worst
>(memory waste, fragmentation, overcommit) and instead of finding new
>ways to *avoid* long-term pinnings, we're coming up with advanced
>concepts to work-around the fundamental property of long-term pinnings.
>
>We want all memory to be long-term pinnable and we want all memory to be
>movable/hotunpluggable. That's not going to work.

Looks there is misunderstanding about ZONE_EXMEM argument.
Pinning and plubbability is mutual exclusive so it can not happen at the same time.
What we argue is ZONE_EXMEM does not "confine movability". an allocation context can determine the movability attribute.
Even one unmovable allocation will make the entire CXL DRAM unpluggable. 
When you see ZONE_EXMEM just on movable/unmoable aspect, we think it is the same with ZONE_NORMAL,
but ZONE_EXMEM works on an extended memory, as of now CXL DRAM.

Then why ZONE_EXMEM is, ZONE_EXMEM considers not only the pluggability aspect, but CXL identifier for user/kenelspace API, 
the abstraction of multiple CXL DRAM channels, and zone unit algorithm for CXL HW characteristics.
The last one is potential at the moment, though.

As mentioned in ZONE_EXMEM thread, we are preparing slides to explain experiences and proposals.
It it not final version now[1].
[1] https://github.com/OpenMPDK/SMDK/wiki/93.-%5BLSF-MM-BPF-TOPIC%5D-SMDK-inspired-MM-changes-for-CXL

>If you'd ask me today, my prediction is that ZONE_EXMEM is not going to
>happen.
>
>--
>Thanks,
>
>David / dhildenb
