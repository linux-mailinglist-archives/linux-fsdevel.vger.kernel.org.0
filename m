Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90C06D1F69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 13:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCaLrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 07:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCaLrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:47:17 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091501E724
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 04:46:52 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230331114651epoutp043ce381b734f1bf975f2066a123576fa6~Rfn0GUPSM2486224862epoutp04Y
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 11:46:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230331114651epoutp043ce381b734f1bf975f2066a123576fa6~Rfn0GUPSM2486224862epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680263211;
        bh=Elvc3NDLcXtB7fip/yBqKkhlU5FfkiSc7O30H4CxdNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0mUtfYXBJNsYG3nfruPR5Gmhy9fusPyaOEoGFqjZnUk+y+AJ45J4Xk59tzgqT6jf
         fMwqdvZkFJ5N+6uCyUlUVzXUojSp9kFTfIIMJ4iwnopm2hbWfVlIDzxIp+Bm2TKlc/
         OAyi3bVfLGHVaFCLvD1yym51ytnccbUwD2TB9iow=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230331114650epcas2p28970002302e889ad7a030982bd9dd4ee~Rfnzql2Th1108511085epcas2p2O;
        Fri, 31 Mar 2023 11:46:50 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.101]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Pnz622HVsz4x9Pp; Fri, 31 Mar
        2023 11:46:50 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.61.27926.A28C6246; Fri, 31 Mar 2023 20:46:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230331114649epcas2p23d52cd1d224085e6192a0aaf22948e3e~RfnymVtVK2893028930epcas2p2-;
        Fri, 31 Mar 2023 11:46:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230331114649epsmtrp2ba6137db1fb1281dc84a9aa05d21a935~RfnylDZ8X1084510845epsmtrp2I;
        Fri, 31 Mar 2023 11:46:49 +0000 (GMT)
X-AuditID: b6c32a46-a4bff70000006d16-9a-6426c82ad749
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.06.18071.928C6246; Fri, 31 Mar 2023 20:46:49 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230331114649epsmtip15e76f833be6302e8058f00f8dafc8eaf~RfnyV6-m91642716427epsmtip1x;
        Fri, 31 Mar 2023 11:46:49 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     dragan@stancevic.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: Re: Re: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Fri, 31 Mar 2023 20:46:49 +0900
Message-Id: <20230331114649.400453-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e4a8433a-fdca-e806-c7e9-750e81176228@stancevic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmqa7WCbUUg223OS2mH1a0mD71AqPF
        obk32S3OzzrFYrFn70kWi3tr/rNa7Hu9l9niRedxJouODW8YLTbef8fmwOXx78QaNo/Fe14y
        eWz6NIndY/KN5YwefVtWMXosXmrj8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZ
        gaGuoaWFuZJCXmJuqq2Si0+ArltmDtB1SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSC
        lJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjNNbZ7IUrJOs2POgiaWBcZpoFyMnh4SAicSR
        E8tZuxi5OIQEdjBKnP/7gg0kISTwiVHi2E8tiMQ3RomJnV8ZYToOHjnBBpHYyyjx7c4BVoiO
        LiaJY1+qQGw2AW2JP1fOg00SEZCQ2LdmEVgzs8A/Rok9lyVBbGEBF4ndN/ewg9gsAqoSC2fM
        BrN5BWwkdr56zQaxTF5i5qXvYHFOAUeJtr5trBA1ghInZz5hgZgpL9G8dTYzyEESAp0cEm+6
        30Fd6iLRsXg9C4QtLPHq+BZ2CFtK4vO7vVALiiUev/4HFS+ROLzkN1S9scS7m8+BlnEALdCU
        WL9LH8SUEFCWOHILai2fRMfhv+wQYV6JjjYhiEYVie3/ljPDLDq9fxPUcA+JtY2rGCHBNoVR
        4vDkX+wTGBVmIflmFpJvZiEsXsDIvIpRLLWgODc9tdiowAgev8n5uZsYwWlVy20H45S3H/QO
        MTJxMB5ilOBgVhLhLTRWTRHiTUmsrEotyo8vKs1JLT7EaAoM64nMUqLJ+cDEnlcSb2hiaWBi
        ZmZobmRqYK4kzittezJZSCA9sSQ1OzW1ILUIpo+Jg1OqgaleiuPclIIC7rkrCxJFj3R+PeHd
        sInf/JVBkaHwbcna06dkbTPeyEYZ+JyM7nb6GVp9IHnRXEd5Q0/rdXuNxNKmqRsY+6xIniR0
        7daNkzbdbLHFiwp6+yLDNbd/WjHpj7nhx/KJn3aU+h5WDmmNO/lp5zm2O/sLQw3/XffdyPva
        jufhtek8Jxbt/LDZaF39lvVPmsydVdbIhCWfUux8/lfb/+GXqLlfHVW6thav7nWaqB4Vc7d/
        yhuO9Y3qE8u8PvEZPKzR6+WaGlGa8vBWycugYxdXlkznFloRsafn3bv3lcx3uBU0Z2xtqio7
        F1wQq2hu0W+mstK9saNR1DdkxYforSZt07L4L/X3fl0Rr8RSnJFoqMVcVJwIALJBKA40BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnK7mCbUUg9er1C2mH1a0mD71AqPF
        obk32S3OzzrFYrFn70kWi3tr/rNa7Hu9l9niRedxJouODW8YLTbef8fmwOXx78QaNo/Fe14y
        eWz6NIndY/KN5YwefVtWMXosXmrj8XmTXAB7FJdNSmpOZllqkb5dAlfG6a0zWQrWSVbsedDE
        0sA4TbSLkZNDQsBE4uCRE2xdjFwcQgK7GSXuT/jNDJGQknh/uo0dwhaWuN9yhBWiqINJ4tnq
        BSwgCTYBbYk/V86zgdgiAhIS+9YsYgQpYgYp2np5OlhCWMBFYvfNPWCTWARUJRbOmA1m8wrY
        SOx89ZoNYoO8xMxL38HinAKOEm1921hBbCEBB4npyxZD1QtKnJz5BGwxM1B989bZzBMYBWYh
        Sc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4DrQ0dzBuX/VB7xAjEwfj
        IUYJDmYlEd5CY9UUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZ
        ODilGpgCr9epx1/nEl6gLzRXSrRpRgOf6XSzVIs1HjnTenvWz0voM9A/JX3DfA9vsnO0XlL6
        xEXmVrYJYhsPKv7m2a2/7vukP0duOR70Pi1g+/hD0N9rU2NDEj54NtzktVfx19q9fc9xg3Dl
        3/dkP/xvz/x+LsDz49GZRlHX8yc/eev+X+C+h8irrCO35f4vftP3rkl/8vY9sp82sq8JdExQ
        K3BkKUmJSvt1RNjO2u++e5CSruSyy2xXDR3mHK/UMb4mUOahstn9qvW6k00c9evkt6g7S56b
        mb7sPePOui/SqnPehW/TFf52bsXyJoU17wLfWwqJOy4U/8PE6ueftdh1/smc2pIX3QWRW2vj
        JHMKNiixFGckGmoxFxUnAgDcHQgw8gIAAA==
X-CMS-MailID: 20230331114649epcas2p23d52cd1d224085e6192a0aaf22948e3e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331114649epcas2p23d52cd1d224085e6192a0aaf22948e3e
References: <e4a8433a-fdca-e806-c7e9-750e81176228@stancevic.com>
        <CGME20230331114649epcas2p23d52cd1d224085e6192a0aaf22948e3e@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dragan Stancevic.
Thank you for your interests and joning the discussion.

>On 2/20/23 19:41, Kyungsan Kim wrote:
>> CXL is a promising technology that leads to fundamental changes in computing architecture.
>> To facilitate adoption and widespread of CXL memory, we are developing a memory tiering solution, called SMDK[1][2].
>> Using SMDK and CXL RAM device, our team has been working with industry and academic partners over last year.
>> Also, thanks to many researcher's effort, CXL adoption stage is gradually moving forward from basic enablement to real-world composite usecases.
>> At this moment, based on the researches and experiences gained working on SMDK, we would like to suggest a session at LSF/MM/BFP this year
>> to propose possible Linux MM changes with a brief of SMDK.
>> 
>> Adam Manzanares kindly adviced me that it is preferred to discuss implementation details on given problem and consensus at LSF/MM/BFP.
>> Considering the adoption stage of CXL technology, however, let me suggest a design level discussion on the two MM expansions of SMDK this year.
>> When we have design consensus with participants, we want to continue follow-up discussions with additional implementation details, hopefully.
>> 
>>   
>> 1. A new zone, ZONE_EXMEM
>> We added ZONE_EXMEM to manage CXL RAM device(s), separated from ZONE_NORMAL for usual DRAM due to the three reasons below.
>
>Hi Kyungsan-
>
>I read through your links and I am very interested in this 
>talk/discussion from the perspective of cloud/virtualization hypervisor 
>loads.
>
>The problem that I am starting to tackle is clustering of hypervisors 
>over cxl.mem for high availability of virtual machines. Or live 
>migration of virtual machines between hypervisors using cxl.mem [1].
>
>
>So I was wondering, with regards to the ZONE_XMEM, has any thought been 
>given to the shared memory across virtual hierarchies [2], where you 
>have cxl.mem access over cxl switches by multiple VH connections. It 
>seems to me that there might be a need for differentiation of direct 
>cxl.mem and switched cxl.mem. At least from the point of view where you 
>have multiple hypervisors sharing the memory over a switch. Where they 
>would potentially have to synchronize state/metadata about the memory.

At first, in general we have thought that more SW layers(baremetal, virtualization, orchestration) would be related
along with the progress of CXL topology(direct attached, switch/multilevel switch, rackscale/inter-rackscale with fabric).
We think ZONE_EXMEM can be used as a static CXL identifier between hypervisor and host OS interaction for memory inflation/deflation, transcendent memory interface(frontswap/cleancache)[1], and isolation.


[1] https://lwn.net/Articles/454795

>
>[1] A high-level explanation is at https://protect2.fireeye.com/v1/url?k=6962eb99-098076c4-696360d6-000babd9f1ba-f4ae8300c44044a7&q=1&e=fca5fea0-6b57-4874-8ec1-637a6c1019b6&u=http%3A%2F%2Fnil-migration.org%2F
>[2] Compute Express Link Specification r3.0, v1.0 8/1/22, Page 51, 
>figure 1-4, black color scheme circle(3) and bars.
>
>
>--
>Peace can only come as a natural consequence
>of universal enlightenment -Dr. Nikola Tesla
