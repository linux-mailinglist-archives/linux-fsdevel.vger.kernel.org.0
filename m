Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C7B6D1F3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 13:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjCaLiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 07:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCaLiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:38:50 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66271113DB
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 04:38:49 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230331113847epoutp04eb8f014afff2fd48b10594d3f4e9fc76~RfgxwfGD71565015650epoutp04X
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 11:38:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230331113847epoutp04eb8f014afff2fd48b10594d3f4e9fc76~RfgxwfGD71565015650epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680262727;
        bh=m6oOKIfSGdecWe7hDUvUJs8+1CRCWXKf5VckCvcczRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnogEgM+F+oIwnX0uGpzFWUhBvI/e2VWxxF5c792NoDrZ5T7S3JLl0DBSZonwtX6Y
         86yIiDdOqFwwnEFKLZfHbWD4insG09/EAAolt/W92W9dpwbTG5iCwSnsrYE8AZmWlG
         ReaREO9A2cK2Fzoj8J0zK9XbsvvNHsDJRcMyydK4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230331113846epcas2p2c8b7112b122ee623186fb645fd69b874~Rfgwp6bqh1479114791epcas2p25;
        Fri, 31 Mar 2023 11:38:46 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Pnywk0WzTz4x9Pv; Fri, 31 Mar
        2023 11:38:46 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.3D.35469.546C6246; Fri, 31 Mar 2023 20:38:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230331113845epcas2p313118617918ae2bf634c3c475fc5dbd8~Rfgvp5b-f2490324903epcas2p37;
        Fri, 31 Mar 2023 11:38:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230331113845epsmtrp208e66127ff1f61b4c3978fc8ca0e68b4~RfgvpHiOw0503605036epsmtrp2M;
        Fri, 31 Mar 2023 11:38:45 +0000 (GMT)
X-AuditID: b6c32a48-9e7f970000008a8d-71-6426c6455a7a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.A5.18071.546C6246; Fri, 31 Mar 2023 20:38:45 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230331113845epsmtip1a9e322fd7df39cada90431bae9cae492~Rfgvb23PU0805808058epsmtip1S;
        Fri, 31 Mar 2023 11:38:45 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     willy@infradead.org
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: Re: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for
 CXL
Date:   Fri, 31 Mar 2023 20:38:45 +0900
Message-Id: <20230331113845.400220-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZB3ijJBf3SEF+Xl2@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmma7rMbUUg2XHrC2mH1a0mD71AqPF
        +VmnWCz27D3JYnFvzX9Wi32v9zJbvOg8zmTRseENo8XvH3PYLDbef8fmwOXx78QaNo/NK7Q8
        Fu95yeSx6dMkdo/JN5YzevRtWcXo8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZ
        gaGuoaWFuZJCXmJuqq2Si0+ArltmDtB1SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSC
        lJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjEWTPApOC1TMXvqauYFxJ28XIyeHhICJxM11
        X9m7GLk4hAR2MEps+d3FBuF8YpS4PHE+I4TzjVHi8eclbDAt177sgWrZyyhx9eBPVpCEkEAX
        k8TJf9ogNpuAtsSfK+fBGkQExCWOTT3JCGIzC/xjlNhzWRLEFhYIlGhespUZxGYRUJV4vX0G
        UxcjBwevgI3EgT/GELvkJWZe+s4OYnMC7b0y/ScTiM0rIChxcuYTFoiR8hLNW2czg9wjIdDJ
        IdG3ZTXUoS4SB5feZ4WwhSVeHd/CDmFLSXx+txeqplji8et/UPESicNLfrNA2MYS724+ZwW5
        h1lAU2L9Ln0QU0JAWeLILai1fBIdh/+yQ4R5JTrahCAaVSS2/1vODLPo9P5NUMM9JHY+W8UK
        CbV2RonVD2czTmBUmIXkm1lIvpmFsHgBI/MqRrHUguLc9NRiowITePQm5+duYgQnVS2PHYyz
        337QO8TIxMF4iFGCg1lJhLfQWDVFiDclsbIqtSg/vqg0J7X4EKMpMKgnMkuJJucD03peSbyh
        iaWBiZmZobmRqYG5kjjvxw7lFCGB9MSS1OzU1ILUIpg+Jg5OqQams1ILe7gYPU0OWJXc/BOz
        dOlvq+miBntv139ldH29/pFTusOHk4/Wvvt58/ZxzXtyrIt1dqZv/HzimlyY5ovSHLfTKQaT
        f2pbfPty6ERPbePCA4IuNVvn71d2fHPo9/WPy5vsp8kJ33hzaU9iuCGDz7aJXdmO/66LXXTu
        CpVT0nKUTvhzPOK18WPmoP8lLrWf1xx/sf27xUcDWxuFRwu42GzZfP/LbFi23329o/qrAPdT
        EY4P7+/mqml6nni24Wi20ibnz1PnH1zXpqPxPmrS1wePpaX+VUse/lSR9aaDOyN417Vsjs95
        N++GP+kX2fNVU+nWjokHFaN3Cn3+4Oe95L/GxO3V5cIarOW2dxxjFZVYijMSDbWYi4oTASaq
        mt8zBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnK7rMbUUg5ZnshbTDytaTJ96gdHi
        /KxTLBZ79p5ksbi35j+rxb7Xe5ktXnQeZ7Lo2PCG0eL3jzlsFhvvv2Nz4PL4d2INm8fmFVoe
        i/e8ZPLY9GkSu8fkG8sZPfq2rGL0+LxJLoA9issmJTUnsyy1SN8ugStj0SSPgtMCFbOXvmZu
        YNzJ28XIySEhYCJx7cse9i5GLg4hgd2MEm2fljNDJKQk3p9uY4ewhSXutxxhhSjqYJJYtaeH
        CSTBJqAt8efKeTYQW0RAXOLY1JOMIEXMIEVbL08HSwgL+EscfXWGFcRmEVCVeL19BlAzBwev
        gI3EgT/GEAvkJWZe+g62jBPooivTf4LNFxIwlrjcsRjsIF4BQYmTM5+wgNjMQPXNW2czT2AU
        mIUkNQtJagEj0ypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOAY0NLcwbh91Qe9Q4xM
        HIyHGCU4mJVEeAuNVVOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoE
        k2Xi4JRqYGK+JR/40v/GH8NVsSuPfJ/pWrj8DTvb08fntPlERdQ5Jlcovvf+1GRVd/dBvMIp
        VkWDxXnSVc4fF+Q+UFQ9MkfQr/RG3tWwTq+OQ2aLfZf2MQS0+zdnedmbr9jwpeJZS79K8fml
        TLVaUXdr9pwSWfUqav1ShgcBj2/mPVUIk17Dt/Wn420XnztuinPW3Mwv9FVpqDy2eerte8Zm
        3u4xCaZN63WN/i05eLYx0tbcXWiK0vWHf5790y3akTvl+aGkF/w7KsRWyUSvi9s2dW1PTegu
        j+a10zid99p0++9LeRG/YEF2zY6Ia2uvaTt4xe+ObVivo8N+Y7KyC8vtrlCBS293dXR9FCgz
        195SyTbjthJLcUaioRZzUXEiABDyLN3wAgAA
X-CMS-MailID: 20230331113845epcas2p313118617918ae2bf634c3c475fc5dbd8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331113845epcas2p313118617918ae2bf634c3c475fc5dbd8
References: <ZB3ijJBf3SEF+Xl2@casper.infradead.org>
        <CGME20230331113845epcas2p313118617918ae2bf634c3c475fc5dbd8@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On Fri, Mar 24, 2023 at 02:55:02PM +0000, Matthew Wilcox wrote:
>> No, that's not true.  You can allocate kernel memory from ZONE_MOVABLE.
>> You have to be careful when you do that, but eg filesystems put symlinks
>> and directories in ZONE_MOVABLE, and zswap allocates memory from
>> ZONE_MOVABLE.  Of course, then you have to be careful that the kernel
>> doesn't try to move it while you're accessing it.  That's the tradeoff.
>
>I want to talk a little bit about what it would take to use MOVABLE
>allocations for slab.
>
>Initially, one might presume that it is impossible to have slab use a
>movable allocation.  Usually, we need a relatively complex mechanism of
>reference counting where one takes a reference on the page, uses it,
>then puts the reference.  Then migration can check the page reference
>and if it's unused, it knows it's safe to migrate (much handwaving here,
>of course it's more complex).
>
>The general case of kmalloc slabs cannot use MOVABLE allocations.
>The API has no concept of "this pointer is temporarily not in use",
>so we can never migrate any slab which has allocated objects.
>
>But for slab caches, individual objects may have access rules which allow
>them to be moved.  For example, we might be able to migrate every dentry
>in a slab, then RCU-free the slab.  Similarly for radix_tree_nodes.
>
>There was some work along these lines a few years ago:
>https://lore.kernel.org/all/20190603042637.2018-16-tobin@kernel.org/
>
>There are various practical problems with that patchset, but they can
>be overcome with sufficient work.  The question is: Why do we need to do
>this work?  What is the high-level motivation to make slab caches movable?


Thank you for sharing us the case.
We studied your sentences and the patchset. Let me summarize our understanding.
A kernel context is migratable at certain in case the reference count of a page is traceable and it is 0.

As I answered previously, our intention is the attribute of CXL DRAM page can be movable as well as unmovable.
A memory allocator context should be able to determine it.
