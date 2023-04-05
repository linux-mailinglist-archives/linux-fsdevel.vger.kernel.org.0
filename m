Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2196D797F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbjDEKTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 06:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbjDEKTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:19:00 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E835C211F
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 03:18:50 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230405101846epoutp01c93770f7a29fb656996423be80cfea30~TApVKnYLQ2369123691epoutp016
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 10:18:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230405101846epoutp01c93770f7a29fb656996423be80cfea30~TApVKnYLQ2369123691epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680689926;
        bh=NNyozsd8ZPXyNiSFwL2/xF186WEccoogDSIUpnGA6K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6SBL/gYnr7mAAHNaiZmWGEUvXkSNknGajxrpDQhGaVSQUGoSTGXHWcFI6Sa8wvD6
         ijB6QK/iV4LaIjbbPBuhzXGVqoweVrHS8wIUt3x/YKUrp02UjBrLroqgxpbj6NVydg
         SL0TmPyxDm5G47O6KYBrfePBumDZTVwvS2SRnhAQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230405101844epcas2p161dcec895259a9f35eb5afc1620eae7d~TApT5i5M_2941229412epcas2p10;
        Wed,  5 Apr 2023 10:18:44 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Ps0w4284Fz4x9Py; Wed,  5 Apr
        2023 10:18:44 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.FD.27926.40B4D246; Wed,  5 Apr 2023 19:18:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230405101843epcas2p2c819c8d60b2a9a776124c2b4bc25af14~TApS3AsOz0470404704epcas2p2z;
        Wed,  5 Apr 2023 10:18:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230405101843epsmtrp23910ee61d85839f4c112aa98c2f6a432~TApS2NxPe2926029260epsmtrp2E;
        Wed,  5 Apr 2023 10:18:43 +0000 (GMT)
X-AuditID: b6c32a46-a4bff70000006d16-13-642d4b04690f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.0E.31821.30B4D246; Wed,  5 Apr 2023 19:18:43 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230405101843epsmtip260869a6f18a7fdf5d4f8366ec8f2f5e3~TApSpznEN2974129741epsmtip2E;
        Wed,  5 Apr 2023 10:18:43 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     gregory.price@memverge.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: Re: [External] RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM
 changes for CXL
Date:   Wed,  5 Apr 2023 19:18:43 +0900
Message-Id: <20230405101843.415080-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZCgasNpBjtQje8k+@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmuS6Lt26KQdtNXovphxUtpk+9wGjR
        0PSIxeL8rFMsFnv2nmSxuLfmP6vFvtd7mS1edB5nsujY8IbRYuP9d2wOXB7/Tqxh81i85yWT
        x6ZPk9g9Jt9Yzuix8eN/do++LasYPT5vkgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1
        MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6T0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5Ra
        kJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQndF2oZmt4Ithxfx5BxkbGH+rdzFyckgImEi8
        Xn2WsYuRi0NIYAejxLcN09khnE+MEpeX34JyPjNKvG/YxALTMqmnkQUisYtR4vHq6cwQTheT
        xKy/b5lAqtgEtCX+XDnPBmKLCMhJXNh3DcxmFvjHKLHnsiSILSwQI9H2ZT5YnEVAVeL00ZtA
        NgcHr4CNxOl3BRDL5CVmXvrODmJzCuhIPPjRDHYEr4CgxMmZT1ggRspLNG+dDXaDhEAvh8SF
        yeuYQeZICLhITJ/ADzFHWOLV8S3sELaUxOd3e9kg7GKJx6//QcVLJA4v+Q31pLHEu5vPWUHG
        MAtoSqzfpQ8xUVniyC2orXwSHYf/skOEeSU62oQgGlUktv9bzgyz6PT+TVDDPSSWrz8HFhcS
        qJf4eXcK+wRGhVlIfpmF5JdZCHsXMDKvYhRLLSjOTU8tNiowgkdvcn7uJkZwWtVy28E45e0H
        vUOMTByMhxglOJiVRHhVu7RShHhTEiurUovy44tKc1KLDzGaAgN6IrOUaHI+MLHnlcQbmlga
        mJiZGZobmRqYK4nzStueTBYSSE8sSc1OTS1ILYLpY+LglGpg2udQkNwXnLu3L8uKzyn33s79
        3HkeOS3OT1m+ZWTcs7v1N2fji0PPbh22rJfzfHVf/ZusUN8dUWfV7vSqS69T+bvMey57/A5Z
        +PlCIdfiwiVzzKY9/1qWs0Ux5IDCnbDD+1aXZ+lcC9SV5n/7w8gzeb9EWeGD1g7xx66veRIu
        zre5IGapUtMrLyd5MLTjUsKiifF7TJ516aydJ8k06bKoVPiliKw9ce9nLjj32ye9KNP87frN
        045k9kT+qLQs/LTuxNGlnGdKp3Wbn6vdfDb4g1T3pyVPru8rbF+9etK3IxuTHRRWr7tZuLjp
        dXAm8yKVKb8VMoVv/PrdV1o64bv/nUf+GtMmx07bYDm99O2RRUosxRmJhlrMRcWJAHZwFao0
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvC6zt26Kwa9fShbTDytaTJ96gdGi
        oekRi8X5WadYLPbsPclicW/Nf1aLfa/3Mlu86DzOZNGx4Q2jxcb779gcuDz+nVjD5rF4z0sm
        j02fJrF7TL6xnNFj48f/7B59W1YxenzeJBfAHsVlk5Kak1mWWqRvl8CV0Xahma3gi2HF/HkH
        GRsYf6t3MXJySAiYSEzqaWQBsYUEdjBKdPwJgYhLSbw/3cYOYQtL3G85wtrFyAVU08EksWnD
        BbAEm4C2xJ8r59lAbBEBOYkL+66xgRQxgxRtvTwdLCEsECWxcdkusAYWAVWJ00dvAsU5OHgF
        bCROvyuAWCAvMfPSd7ASTgEdiQc/mllASoSA5u/4FQ8S5hUQlDg58wnYncxA5c1bZzNPYBSY
        hSQ1C0lqASPTKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4BjQ0trBuGfVB71DjEwc
        jIcYJTiYlUR4Vbu0UoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgST
        ZeLglGpgmjZFe4bbuv7TZyO+rr+4e1HwwleVyi5Oy56yHZuXO3F/z1yHzd+TnMKmT4iPm8kR
        eN5zp+7yo+ESv8MzvbN7n75Zu351qERu5etD++esST69rfvspQcde91Oepzu2FIU4iOQU9Jh
        X3HkxMMbCtftvk67uFBmJ2dOpnJCekFaYfOnb8HTOZZc3S9R2dbzZ+GW27qM8iV+WxX3v1uu
        /s/MKcVt2pr+U2pdHx1M80+uenl3EQvf6Yrr9rv/rs3bF/GY5/O0rV9fnOhxLu0y2n3Ys+VF
        eFd28PZm7kNr4225tn1kPteUu0FqW+18i4P2afO+HTR+uiH7/Pkdh/SfnfAxzo9xKTQ9OH+f
        pGBGhNiB0tNKLMUZiYZazEXFiQBUCoZz8AIAAA==
X-CMS-MailID: 20230405101843epcas2p2c819c8d60b2a9a776124c2b4bc25af14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230405101843epcas2p2c819c8d60b2a9a776124c2b4bc25af14
References: <ZCgasNpBjtQje8k+@memverge.com>
        <CGME20230405101843epcas2p2c819c8d60b2a9a776124c2b4bc25af14@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On Tue, Apr 04, 2023 at 11:59:22AM -0700, Viacheslav A.Dubeyko wrote:
>> 
>> 
>> > On Apr 1, 2023, at 3:51 AM, Gregory Price <gregory.price@memverge.com> wrote:
>> > 
>> > On Tue, Apr 04, 2023 at 05:58:05PM +0000, Adam Manzanares wrote:
>> >> On Tue, Apr 04, 2023 at 11:31:08AM +0300, Mike Rapoport wrote:
>> >>> 
>> >>> The point of zswap IIUC is to have small and fast swap device and
>> >>> compression is required to better utilize DRAM capacity at expense of CPU
>> >>> time.
>> >>> 
>> >>> Presuming CXL memory will have larger capacity than DRAM, why not skip the
>> >>> compression and use CXL as a swap device directly?
>> >> 
>> >> I like to shy away from saying CXL memory should be used for swap. I see a 
>> >> swap device as storing pages in a manner that is no longer directly addressable
>> >> by the cpu. 
>> >> 
>> >> Migrating pages to a CXL device is a reasonable approach and I believe we
>> >> have the ability to do this in the page reclaim code. 
>> >> 
>> > 
>> > The argument is "why do you need swap if memory itself is elastic", and
>> > I think there are open questions about how performant using large
>> > amounts of high-latency memory is.
>> > 
>> > Think 1us-1.5us+ cross-rack attached memory.
>> > 
>> > Does it make sense to use that as CPU-addressible and migrate it on
>> > first use?  Isn't that just swap with more steps?  What happens if we
>> > just use it as swap, is the performance all that different?
>> > 
>> > I think there's a reasonable argument for exploring the idea at the
>> > higher ends of the latency spectrum.  And the simplicity of using an
>> > existing system (swap) to implement a form of proto-tiering is rather
>> > attractive in my opinion.
>> > 
>> 
>> I think the problem with swap that we need to take into account the additional
>> latency of swap-in/swap-out logic. I assume that this logic is expensive enough.
>> And if we considering the huge graph, for example, I am afraid the swap-in/swap-out
>> logic could be expensive. So, the question here is about use-case. Which use-case could
>> have benefits to employ the swap as a big space of high-latency memory? I see your point
>> that such swap could be faster than persistent storage. But which use-case can be happy
>> user of this space of high-latency memory?
>> 
>> Thanks,
>> Slava.
>> 
>
>Just spitballing here - to me this problem is two fold:
>
>I think the tiering use case and the swap use case are exactly the same.
>If tiering is sufficiently valuable, there exists a spectrum of compute
>density (cpu:dram:cxl:far-cxl) where simply using far-cxl as fast-swap
>becomes easier and less expensive than a complex tiering system.
>
>So rather than a single use-case question, it reads like a tiering
>question to me:
>
>1) Where on the 1us-20us (far cxl : nvme) spectrum does it make sense to
>   switch from a swap mechanism to simply byte-addressable memory?
>   There's a point, somewhere, where promote on first access (effectively
>   swap) is the same performance as active tiering (for a given workload).
>
>   If that point is under 2us, there's a good chance that a high-latency
>   CXL swap-system would be a major win for any workload on any cloud-based
>   system.  It's simple, clean, and reclaim doesn't have to worry about the
>   complexities of hotpluggable memory zones.
>
>
>Beyond that, to your point, what use-case is happy with this class of
>memory, and in what form?
>
>2) This is likely obscurred by the fact that many large-memory
>   applications avoid swap like the plague by sharding data and creating
>   clusters. So it's hard to answer this until it's tested, and you
>   can't test it unless you make it... woo!
>
>   Bit of a chicken/egg in here.  I don't know that anyone can say
>   definitively what workload can make use of it, but that doesn't mean
>   there isn't one.  So in the spectrum of risk/reward, at least
>   enabling some simple mechanism for the sake of exploration feels
>   exciting to say the least.
>
>
>More generally, I think a cxl-swap (cswap? ;V) would be useful exactly to
>help identify when watch-and-wait tiering becomes more performant than
>promote-on-first-use.  If you can't beat a simple fast-swap, why bother?
>
>Again, I think this is narrowly applicable to high-latency CXL. My gut
>tells me that anything under 1us is better used in a byte-addressable
>manner, but once you start hitting 1us "It makes me go hmmm..."
>
>I concede this is largely conjecture until someone tests it out, but
>certainly a fun thing to discess.

In fact, we enabled CXL swap, OS-level swap interface for CXL DRAM[1].
It was not LSF/MM proposal of this year, though.
Likewise zswap, CXL swap implements frontswap[2], but it does not perform compression using CPU cycle. 
The first motivation was to enhance TMO solution[3].
TMO uses both zswap and disk swap, and we intended to replace zswap part as CXL swap to seamlessly adopt CXL DRAM in the solution.

We agree that the primary usecase of CXL DRAM is byte-addressable memory. 
So, memory expansion with CXL DRAM will significantly resolve memory pressure of a system,
thus memory allocation would fail less and swapper would be less triggered by PFRA.

However,we think the Linux swap mechanism would be keep used for a different purpose. 
Due to CXL topology expansion and more SW overheads along with the topology, we guess the end-user latency to CXL DRAM would be increased. 
Along with the purpose of frontswap, we think CXL swap interface would fit between hypervisor and baremetal OS with more capacity sensitive and less user-interactive workload.

Let us share some performance numbers regarding CXL swap on a CXL capable testbed.
1. Latency evalution of swap in/out logic - swap-in/swap-out was 0.56us/1.07us, respectively.
2. CPU utilization - CXL swap on CXL DRAM saves x14.94 cpu utilization compared to zswap because of no (de)compression. zswap occupies aroud 70~80% cpu cycle on (de)compression logic.
3. QoS - The latency of zswap put/get was fluctuated around 1.3~14us, while that of CXL swap out/get was evenly around 0.49~0.94us. 

[1] https://github.com/OpenMPDK/SMDK/wiki/2.-SMDK-Architecture#swap
[2] https://www.kernel.org/doc/html/v5.0/vm/frontswap.html
[3] https://arxiv.org/abs/2206.02878

>~Gregory
