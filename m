Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112F16D797E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 12:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbjDEKTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbjDEKSw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:18:52 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78AF527F
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 03:18:44 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230405101841epoutp03b9d386f27080d21b54e1f81f40ca259e~TApRN3UOn0838908389epoutp03W
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 10:18:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230405101841epoutp03b9d386f27080d21b54e1f81f40ca259e~TApRN3UOn0838908389epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680689921;
        bh=9ydTuce663enN56S8RaGBrGjILCmiz4Kr4WItfjDk/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BaYePQxNmKPA8yB8FJa8EIGJjqbmdTnmsMYpG6Jlk2tOxajvO0cKG+toPkQ+yWxG4
         ivxRbLFIPcZvBGFGVziu1OAx7oDFaewXzjdi6lSmfPRZhkdsstemC0v4c3hBMc5Iib
         kkg8NI0g4PB2Yuri0NWvdHaGLyWoCM17/X5fZHbI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230405101841epcas2p43ec0d117bfb67bc0039dcccc71620dff~TApQyCTXr1128311283epcas2p4q;
        Wed,  5 Apr 2023 10:18:41 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Ps0w05x2Vz4x9Q1; Wed,  5 Apr
        2023 10:18:40 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.4A.08750.00B4D246; Wed,  5 Apr 2023 19:18:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230405101840epcas2p4c92037ceba77dfe963d24791a9058450~TApPlzOO40598005980epcas2p4N;
        Wed,  5 Apr 2023 10:18:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230405101840epsmtrp18ae01efa7f010cc1ce24a41edd9f0925~TApPlE1LQ0603106031epsmtrp1e;
        Wed,  5 Apr 2023 10:18:40 +0000 (GMT)
X-AuditID: b6c32a47-777ff7000000222e-52-642d4b001d7c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.0E.31821.00B4D246; Wed,  5 Apr 2023 19:18:40 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230405101839epsmtip285b42780b3c47ef8410e5781474a8442~TApPXryTt2659526595epsmtip2L;
        Wed,  5 Apr 2023 10:18:39 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     dragan@stancevic.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Wed,  5 Apr 2023 19:18:39 +0900
Message-Id: <20230405101839.415029-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <81baa7f2-6c95-5225-a675-71d1290032f0@stancevic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmhS6Dt26KwanVOhbTDytaTJ96gdHi
        0Nyb7BbnZ51isdiz9ySLxb01/1kt9r3ey2zxovM4k0XHhjeMFhvvv2Nz4PL4d2INm8fiPS+Z
        PDZ9msTuMfnGckaPvi2rGD0WL7Xx+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xr3ZxxkL7thV9Hf+Y2lgXG/cxcjJISFgIjF1
        3nrWLkYuDiGBHYwSh269ZoRwPjFKvF30ixmkSkjgM6PEj9ZgmI6dd/eyQRTtYpRY9WoulNPF
        JLHx4BZ2kCo2AW2JP1fOs4HYIgISEvvWLGIEsZkF/jFK7Lks2cXIwSEs4CGxdgoHSJhFQFXi
        3crlTCA2r4CNxPK+b4wQy+QlZl76DjaSU8BRYv3bZ+wQNYISJ2c+YYEYKS/RvHU2M8gNEgKd
        HBLNZ9+zQDS7SOy6Mp8JwhaWeHUc4jYJASmJl/1tUHaxxOPX/6DsEonDS35D9RpLvLv5nBXk
        TmYBTYn1u/RBTAkBZYkjt6DW8kl0HP7LDhHmlehoE4JoVJHY/m85M8yi0/s3QQ33kHg19Tk0
        pKYwSsx5s5ptAqPCLCTfzELyzSyExQsYmVcxiqUWFOempxYbFRjD4zc5P3cTIzitarnvYJzx
        9oPeIUYmDsZDjBIczEoivKpdWilCvCmJlVWpRfnxRaU5qcWHGE2BYT2RWUo0OR+Y2PNK4g1N
        LA1MzMwMzY1MDcyVxHmlbU8mCwmkJ5akZqemFqQWwfQxcXBKNTAJnnPUeW9bWm1Z9UDiVOyk
        z5Pyv+855H4jUuiSfvyMBc7qD6s+zcyaqJe1Zcf707PztP8YFu3gbImu6dwp9qBhYuf/I3J9
        p9pNvG7ILE24duGBeGrc6zyVpW8zDDt2H6i94nhpk9EeqbZtmyNCBI/cVBXuuft9iamw4p7E
        r1lxWV+L3m3b9DHxO4OkwP2jfbNFVz+Zl1rbMOty0LpF+lr8F78sbJKau58tY4OPbHRnv9IK
        b9/Tf/6Ifpt3jmHCc4d1ChJ6ew6tUw3bVhq54826MEaNxQfl/wXfvv4347xs/8wvE51n6lTY
        /2mRU5yfefuwqX63lKT15Ufxyz9tTeJZW7g1UGbR0zkpB5YUTOsKV2Ipzkg01GIuKk4EAGZX
        1a80BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvC6Dt26KwZIXzBbTDytaTJ96gdHi
        0Nyb7BbnZ51isdiz9ySLxb01/1kt9r3ey2zxovM4k0XHhjeMFhvvv2Nz4PL4d2INm8fiPS+Z
        PDZ9msTuMfnGckaPvi2rGD0WL7Xx+LxJLoA9issmJTUnsyy1SN8ugSvj3uzjjAV37Cr6O/+x
        NDCuN+5i5OSQEDCR2Hl3LxuILSSwg1Fi6T9fiLiUxPvTbewQtrDE/ZYjrBA1HUwS7+bEg9hs
        AtoSf66cB+sVEZCQ2LdmEWMXIxcHM0jN1svTgRIcHMICHhJrp3CA1LAIqEq8W7mcCcTmFbCR
        WN73jRFivrzEzEvfwXZxCjhKrH/7jB1il4PE58lT2CDqBSVOznzCAmIzA9U3b53NPIFRYBaS
        1CwkqQWMTKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIjQEtrB+OeVR/0DjEycTAe
        YpTgYFYS4VXt0koR4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJ
        g1OqgUlI1L5d6UNMCveSzKmTuzieB53bvIzv3OGlipYb/ne9sNh1yrjyPeMG2cv8V6QqhJTu
        Tgx0/jBdhcP/+ib283sz5wUGlnn5LJTikc0r/qBUeGdWl6mg7rPoNRMK/At2NhjODfrM4nZd
        54J4W872qKnbd/rNfMG1kt/a/+zzR7u1esQ+XTRbIP7GMHV+4GoFx3492+WazQvLLqQ0r1xf
        bTz53+7DkRkeWqVLDmtuPXRdNe6rwhYTH439iworpy3ZxzvddI+Di/MNhb2pvEIz5E89L720
        UeoJw7Zn1TOuGzVNrN6byPgmiKko7Em9eGuhdP3DP8+7n9++y/SYWdL99i7v1NsMzxn3z1e7
        JjP1upMSS3FGoqEWc1FxIgCLeSdS7wIAAA==
X-CMS-MailID: 20230405101840epcas2p4c92037ceba77dfe963d24791a9058450
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230405101840epcas2p4c92037ceba77dfe963d24791a9058450
References: <81baa7f2-6c95-5225-a675-71d1290032f0@stancevic.com>
        <CGME20230405101840epcas2p4c92037ceba77dfe963d24791a9058450@epcas2p4.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>Hi Mike,
>
>On 4/3/23 03:44, Mike Rapoport wrote:
>> Hi Dragan,
>> 
>> On Thu, Mar 30, 2023 at 05:03:24PM -0500, Dragan Stancevic wrote:
>>> On 3/26/23 02:21, Mike Rapoport wrote:
>>>> Hi,
>>>>
>>>> [..] >> One problem we experienced was occured in the combination of
>>> hot-remove and kerelspace allocation usecases.
>>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>>>>> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
>>>>> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
>>>>
>>>> This still does not describe what are the use cases that require having
>>>> kernel allocations on CXL.mem.
>>>>
>>>> I believe it's important to start with explanation *why* it is important to
>>>> have kernel allocations on removable devices.
>>>
>>> Hi Mike,
>>>
>>> not speaking for Kyungsan here, but I am starting to tackle hypervisor
>>> clustering and VM migration over cxl.mem [1].
>>>
>>> And in my mind, at least one reason that I can think of having kernel
>>> allocations from cxl.mem devices is where you have multiple VH connections
>>> sharing the memory [2]. Where for example you have a user space application
>>> stored in cxl.mem, and then you want the metadata about this
>>> process/application that the kernel keeps on one hypervisor be "passed on"
>>> to another hypervisor. So basically the same way processors in a single
>>> hypervisors cooperate on memory, you extend that across processors that span
>>> over physical hypervisors. If that makes sense...
>> 
>> Let me reiterate to make sure I understand your example.
>> If we focus on VM usecase, your suggestion is to store VM's memory and
>> associated KVM structures on a CXL.mem device shared by several nodes.
>
>Yes correct. That is what I am exploring, two different approaches:
>
>Approach 1: Use CXL.mem for VM migration between hypervisors. In this 
>approach the VM and the metadata executes/resides on a traditional NUMA 
>node (cpu+dram) and only uses CXL.mem to transition between hypervisors. 
>It's not kept permanently there. So basically on hypervisor A you would 
>do something along the lines of migrate_pages into cxl.mem and then on 
>hypervisor B you would migrate_pages from cxl.mem and onto the regular 
>NUMA node (cpu+dram).
>
>Approach 2: Use CXL.mem to cluster hypervisors to improve high 
>availability of VMs. In this approach the VM and metadata would be kept 
>in CXL.mem permanently and each hypervisor accessing this shared memory 
>could have the potential to schedule/run the VM if the other hypervisor 
>experienced a failure.
>
>> Even putting aside the aspect of keeping KVM structures on presumably
>> slower memory, 
>
>Totally agree, presumption of memory speed dully noted. As far as I am 
>aware, CXL.mem at this point has higher latency than DRAM, and switched 
>CXL.mem has an additional latency. That may or may not change in the 
>future, but even with actual CXL induced latency I think there are 
>benefits to the approaches.
>
>In the example #1 above, I think even if you had a very noisy VM that is 
>dirtying pages at a high rate, once migrate_pages has occurred, it 
>wouldn't have to be quiesced for the migration to happen. A migration 
>could basically occur in-between the CPU slices, once VCPU is done with 
>it's slice on hypervisor A, the next slice could be on hypervisor B.
>
>And the example #2 above, you are trading memory speed for 
>high-availability. Where either hypervisor A or B could run the CPU load 
>of the VM. You could even have a VM where some of the VCPUs are 
>executing on hypervisor A and others on hypervisor B to be able to shift 
>CPU load across hypervisors in quasi real-time.
>
>
>> what ZONE_EXMEM will provide that cannot be accomplished
>> with having the cxl memory in a memoryless node and using that node to
>> allocate VM metadata?
>
>It has crossed my mind to perhaps use NUMA node distance for the two 
>approaches above. But I think that is not sufficient because we can have 
>varying distance, and distance in itself doesn't indicate 
>switched/shared CXL.mem or non-switched/non-shared CXL.mem. Strictly 
>speaking just for myself here, with the two approaches above, the 
>crucial differentiator in order for #1 and #2 to work would be that 
>switched/shared CXL.mem would have to be indicated as such in a way. 
>Because switched memory would have to be treated and formatted in some 
>kind of ABI way that would allow hypervisors to cooperate and follow 
>certain protocols when using this memory.
>
>
>I can't answer what ZONE_EXMEM will provide since we haven's seen 
>Kyungsan's talk yet, that's why I myself was very curious to find out 
>more about ZONE_EXMEM proposal and if it includes some provisions for 
>CXL switched/shared memory.
>
>To me, I don't think it makes a difference if pages are coming from 
>ZONE_NORMAL, or ZONE_EXMEM but the part that I was curious about was if 
>I could allocate from or migrate_pages to (ZONE_EXMEM | type 
>"SWITCHED/SHARED"). So it's not the zone that is crucial for me,  it's 
>the typing. That's what I meant with my initial response but I guess it 
>wasn't clear enough, "_if_ ZONE_EXMEM had some typing mechanism, in my 
>case, this is where you'd have kernel allocations on CXL.mem"

Hi Dragan, I'm sorry for late reply, we are trying to reply well, though.
ZONE_EXMEM can be movable. A calling context is able to determine movability(movable/unmovable).

I'm not sure if it is related to the provision you keep in mind, but ZONE_EXMEM allows capacity and bandwidth aggregation among multiple CXL DRAM channels. 
Multiple CXL DRAM can be grouped into a ZONE_EXMEM, then it is able to be exposed as a single memory-node[1].
Along with the increase of CXL DRAM channels through (multi-level) switch and enhanced CXL server system, we thought kernel should manage it seamlessly.
Otherwise, userspace would see many nodes, then a 3rd party tool would be always needed such as numactl and libnuma. 
Of course, CXL switch can do the part, but HW/SW means have pros and cons in many ways, so we thought it would be co-existable.

Also, upon the composability expectation of CXL, I think memory sharing among VM/KVM instances well fits with CXL. 
This is just a gut now, but a security and permission matter would be handled in the zone dimension possibly.

In general, given CXL nature(PCIe basis) and topology expansions(direct->switches->fabrics), 
let us carefully guess more functionality and performance matter would be raised. 
We have proposed ZONE_EXMEM as a separated logical management dimension for extended memory types, as of now CXL DRAM.
To help your clarify, please find the slide that explains our proposal[2].

[1] https://github.com/OpenMPDK/SMDK/wiki/2.-SMDK-Architecture#memory-partition
[2] https://github.com/OpenMPDK/SMDK/wiki/93.-%5BLSF-MM-BPF-TOPIC%5D-SMDK-inspired-MM-changes-for-CXL

>
>
>Sorry if it got long, hope that makes sense... :)
>
>
>>   
>>> [1] A high-level explanation is at https://protect2.fireeye.com/v1/url?k=4536d55f-244b3fdc-45375e10-74fe48600158-3fa306550dc8830d&q=1&e=afaf972f-90cd-4c53-b50f-bead1fea18a3&u=http%3A%2F%2Fnil-migration.org%2F
>>> [2] Compute Express Link Specification r3.0, v1.0 8/1/22, Page 51, figure
>>> 1-4, black color scheme circle(3) and bars.
>>>
>
