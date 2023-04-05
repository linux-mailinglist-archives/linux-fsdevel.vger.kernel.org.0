Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654346D7252
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 04:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjDECRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 22:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjDECRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:17:03 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798A230EE
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 19:16:59 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230405021657epoutp040ef6bc80fdcc89e48c196c6796eb3c7c~S6EqAtTnw3250632506epoutp04N
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 02:16:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230405021657epoutp040ef6bc80fdcc89e48c196c6796eb3c7c~S6EqAtTnw3250632506epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680661017;
        bh=TASeBulOKnK9uOD6DLtvLBlcZ0VhGhS0gc0yz9WQ99E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4rRTD97qMXAp3gyaLAwyU7Odda92EC3KM1kQY4+KSgn1RYZ7MGVu/HXF6cEUgl7D
         J5B85jVT2vIwiq2TebTjFZMBoePyh+bGCCPhAC8Io6oG9F4wxRoV12s0Tm84kUE/dW
         NTDDpUdXEKJm6UXn7Usk4v47Ldx7MHqgCx4EFY9c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230405021657epcas2p25842d152a1d86755d4b1da9f16b34261~S6EpeS4Wb1436014360epcas2p24;
        Wed,  5 Apr 2023 02:16:57 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PrpD83whpz4x9Pv; Wed,  5 Apr
        2023 02:16:56 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.23.35469.81ADC246; Wed,  5 Apr 2023 11:16:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230405021655epcas2p2364b1f56dcde629bbd05bc796c2896aa~S6EoaXcFb1436014360epcas2p20;
        Wed,  5 Apr 2023 02:16:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230405021655epsmtrp14393599d913c95745972bdaf357c1fc5~S6EoZlzUm1107711077epsmtrp1m;
        Wed,  5 Apr 2023 02:16:55 +0000 (GMT)
X-AuditID: b6c32a48-9e7f970000008a8d-d9-642cda18325a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.B7.31821.71ADC246; Wed,  5 Apr 2023 11:16:55 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230405021655epsmtip1043f2cbb011fa63232a39b84ceb3a0de~S6EoNACwb2274822748epsmtip1x;
        Wed,  5 Apr 2023 02:16:55 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     david@redhat.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Wed,  5 Apr 2023 11:16:55 +0900
Message-Id: <20230405021655.414131-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5d6a35c8-94cd-5968-3110-7ea4737e728b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmha7ELZ0Ug5YfUhbTDytaTJ96gdHi
        6/pfzBbnZ51isdiz9ySLxb01/1kt9r3ey2zxovM4k0XHhjeMFhvvv2Nz4PL4d2INm8fiPS+Z
        PDZ9msTuMfnGckaP9/uusnn0bVnF6PF5k1wAe1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7yp
        mYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QeUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
        gpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Ixjff2sBeukK1bfn8bewLhArIuRg0NCwETi
        Wx9jFyMXh5DADkaJpr517BDOJ0aJ/g1v2CCcz4wSZ8/dZO1i5ATrePftJjNEYhejxOLmX1BO
        F5PE51df2UGq2AS0Jf5cOc8GYosIiEj8ePiSEcRmFvjHKLHnsiTIbmEBD4m1Uzi6GNk5WARU
        JVo8QAp4BWwkdn/uYYRYJS8x89J3sIGcAnYSh9b0skDUCEqcnPmEBWKgusThK3OghstLNG+d
        DXaNhMBcDokv804wQQxykbi3ZifU/cISr45vYYewpSRe9rdB2cUSj1//g7JLJA4v+c0CYRtL
        vLv5nBUSWsoSR25B7eWT6Dj8lx0izCvR0SYEUa0isf3fcmaY6af3b4Ka6CGxZMkjJkhATWSU
        uNB6jnkCo8IsJO/MQvLOLCTvLGBkXsUollpQnJueWmxUYAKP3+T83E2M4MSq5bGDcfbbD3qH
        GJk4GA8xSnAwK4nwqnZppQjxpiRWVqUW5ccXleakFh9iNAWG9URmKdHkfGBqzyuJNzSxNDAx
        MzM0NzI1MFcS5/3YoZwiJJCeWJKanZpakFoE08fEwSnVwJT+5jozu9Fe5jvx0R/y/y07uc74
        yNfiifzVDq82Xn979Oz3dcltuTW9cwIfK68Q/+zqsptX9R1DoI7xtK9tyzf/zT+eZxwjqzVB
        VMyzOeUTg7bnuQMnTc1N9jS+47ng5//wwpvQyM1qDDP+irWLxrQmT5pkI2u//3be+7qZuUwL
        /ovt6b3n3XLzl/hKv/MnLTR2v9sV2r/ny+baqBPaOXPWGl5dPzMl4Vmqi5dtIG/f37VsKRer
        Nor8/TNXLEzm46kFvYe1l3yx042Y/KjVQFDOzcpvi8jd00XSaVEsPVtnbn8gm75ntss5R6fs
        gwcSdvDo+RXsWqiuKNQ3sb7ZVsQ0yHeCW4njh73rJndOWavEUpyRaKjFXFScCADejQwYNQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSnK74LZ0Ug+MXDS2mH1a0mD71AqPF
        1/W/mC3OzzrFYrFn70kWi3tr/rNa7Hu9l9niRedxJouODW8YLTbef8fmwOXx78QaNo/Fe14y
        eWz6NIndY/KN5Ywe7/ddZfPo27KK0ePzJrkA9igum5TUnMyy1CJ9uwSujGN9/awF66QrVt+f
        xt7AuECsi5GTQ0LAROLdt5vMXYxcHEICOxglbi06yQiRkJJ4f7qNHcIWlrjfcoQVoqiDSeLK
        xK+sIAk2AW2JP1fOs4HYIgIiEj8evmQEKWIGKdp6eTpQgoNDWMBDYu0Uji5Gdg4WAVWJFg+Q
        al4BG4ndn3ugVslLzLz0HWwVp4CdxKE1vSwgtpCArcThFc9ZIOoFJU7OfAJmMwNNebzvJBuE
        LS/RvHU28wRGwVlIymYhKZuFpGwBI/MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg
        mNHS2sG4Z9UHvUOMTByMhxglOJiVRHhVu7RShHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZ
        LySQnliSmp2aWpBaBJNl4uCUamDaHjxR/Diz6uziiZ/TGs/f/xnjv1dtgvDCGGfd9xbHOYtP
        7plZ9D9lavSqlvnhIl4fbdaZCMibKd9nnpw6/WlUlUSFoc+vxeJtOvukZyha3i3teqPJHKwY
        ZLjPhDX/q0fO/La0HS3eJUWJKbmG0wI4r6Yfk774xG/V3pcxcZcW7NlhE9v2Pe3B9kn8Xw+9
        feH9rlxOijvAvGPdht/ZrO/5tVnTGVuDDhfcsZpdkl7yZ+9V7Zc1AWY723j3bt2QLveCu15k
        c5f91L259/TV44+5hJ46f3bbxyvfGq7zzvjSNTP2xyWHFbNEj/1Q0bBZZ1U3q1rqyvWTDgeM
        wwy6Pt26f0fmyar5Feq8q3JV77IpsRRnJBpqMRcVJwIAN6FIGwgDAAA=
X-CMS-MailID: 20230405021655epcas2p2364b1f56dcde629bbd05bc796c2896aa
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230405021655epcas2p2364b1f56dcde629bbd05bc796c2896aa
References: <5d6a35c8-94cd-5968-3110-7ea4737e728b@redhat.com>
        <CGME20230405021655epcas2p2364b1f56dcde629bbd05bc796c2896aa@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On 31.03.23 17:56, Frank van der Linden wrote:
>> On Fri, Mar 31, 2023 at 6:42 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> On Fri, Mar 31, 2023 at 08:42:20PM +0900, Kyungsan Kim wrote:
>>>> Given our experiences/design and industry's viewpoints/inquiries,
>>>> I will prepare a few slides in the session to explain
>>>>    1. Usecase - user/kernespace memory tiering for near/far placement, memory virtualization between hypervisor/baremetal OS
>>>>    2. Issue - movability(movable/unmovable), allocation(explicit/implicit), migration(intented/unintended)
>>>>    3. HW - topology(direct, switch, fabric), feature(pluggability,error-handling,etc)
>>>
>>> I think you'll find everybody else in the room understands these issues
>>> rather better than you do.  This is hardly the first time that we've
>>> talked about CXL, and CXL is not the first time that people have
>>> proposed disaggregated memory, nor heterogenous latency/bandwidth
>>> systems.  All the previous attempts have failed, and I expect this
>>> one to fail too.  Maybe there's something novel that means this time
>>> it really will work, so any slides you do should focus on that.
>>>
>>> A more profitable discussion might be:
>>>
>>> 1. Should we have the page allocator return pages from CXL or should
>>>     CXL memory be allocated another way?
>>> 2. Should there be a way for userspace to indicate that it prefers CXL
>>>     memory when it calls mmap(), or should it always be at the discretion
>>>     of the kernel?
>>> 3. Do we continue with the current ZONE_DEVICE model, or do we come up
>>>     with something new?
>>>
>>>
>> 
>> Point 2 is what I proposed talking about here:
>> https://lore.kernel.org/linux-mm/a80a4d4b-25aa-a38a-884f-9f119c03a1da@google.com/T/
>> 
>> With the current cxl-as-numa-node model, an application can express a
>> preference through mbind(). But that also means that mempolicy and
>> madvise (e.g. MADV_COLD) are starting to overlap if the intention is
>> to use cxl as a second tier for colder memory.  Are these the right
>> abstractions? Might it be more flexible to attach properties to memory
>> ranges, and have applications hint which properties they prefer?
>
>I think history told us that the discussions always go like "but user 
>space wants more control, let's give user space all the power", and a 
>couple of months later we get "but we cannot possibly enlighten all 
>applications, and user space does not have sufficient information: we 
>need the kernel to handle this transparently."
>
>It seems to be a steady back and forth. Most probably we want something 
>in between: cxl-as-numa-node model is already a pretty good and 
>simplistic abstractions. Avoid too many new special user-space knobs is 
>most probably the way to go.
>
>Interesting discussion, I agree. And we had plenty of similar ones 
>already with PMEM and NUMA in general.
>

Haha. funny sentences. IMHO the two kind of contradictory needs exists all the time in real-world.
Based on my experiences, some userlands prefer transparent use, others eager to an optimization chance. 
I also would put higher priority on transparent side, though. 
On linux point of view as the general purpose OS, I believe it has been also a common approach that Linux supports a basic operation, and further provides tunables through API or configurations to support a variety of needs as many as possible.

>-- 
>Thanks,
>
>David / dhildenb
