Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301206E1E7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 10:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDNIlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 04:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDNIlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:41:25 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E57B769C
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 01:41:19 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230414084116epoutp033d4bb7437b2cfc8665cd66d6d4e55f45~VwHxw2s8C1737117371epoutp03h
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 08:41:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230414084116epoutp033d4bb7437b2cfc8665cd66d6d4e55f45~VwHxw2s8C1737117371epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681461676;
        bh=o1x7dYcXHstD9yjWJ1oEEoZxwGZ0tzUvf3rLmXlZtrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TeGhIG9omrubX90e4NTVhiOTVFnrRw0D0PPH45DUV9QGddbMNhbQ+okgHmIV5siu1
         JL31G0VDy/5XBvIfgaAL1FT4jNR2nLO4eOzcph4vgV5rby0IJxfMXRhzuJuviV/gab
         jrvSy7B57GlLiSCQM8vJFlcmy4ZKPKBZy3iePxyg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230414084116epcas2p176f49788b6fdfaf8dd9527d67d9dba8f~VwHxRQrYK1557615576epcas2p1f;
        Fri, 14 Apr 2023 08:41:16 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PyVKR2TG9z4x9Pv; Fri, 14 Apr
        2023 08:41:15 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.09.09650.BA119346; Fri, 14 Apr 2023 17:41:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230414084114epcas2p4754d6c0d3c86a0d6d4e855058562100f~VwHwHOu3Y2049720497epcas2p4a;
        Fri, 14 Apr 2023 08:41:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230414084114epsmtrp12c1bc90e6d21d3f326abd82aca17651b~VwHwGZMyk2509225092epsmtrp1Z;
        Fri, 14 Apr 2023 08:41:14 +0000 (GMT)
X-AuditID: b6c32a48-5dcdca80000025b2-37-643911ab1f66
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.7D.08609.AA119346; Fri, 14 Apr 2023 17:41:14 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230414084114epsmtip165afde30d3f8bdb70e97963eb0ad423d~VwHv6UUU43026630266epsmtip1Z;
        Fri, 14 Apr 2023 08:41:14 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     willy@infradead.org
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com, hj96.nam@samsung.com
Subject: RE: RE: FW: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL
 memory 
Date:   Fri, 14 Apr 2023 17:41:14 +0900
Message-Id: <20230414084114.440749-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZDbQ5O7LAmGbhqFw@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmue5qQcsUg0VTuSymH1a0mD71AqPF
        hzf/WCzOzzrFYrFn70kWi3tr/rNa7Hu9l9niRedxJouODW8YLX7/mMNmsfH+OzYHbo9/J9aw
        eWxeoeWxeM9LJo9Nnyaxe0y+sZzRo2/LKkaPz5vkAtijsm0yUhNTUosUUvOS81My89JtlbyD
        453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgE5UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
        l9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnLOi+y1wwW7ji98YbbA2Mn/m7GDk5
        JARMJJ713mLtYuTiEBLYwSjxbnEnlPOJUeL1mXMsEM5nRokzax+zwLScX3OKGSKxi1Giddky
        KKeLSWLK/SvsIFVsAtoSf66cZwOxRQTEJY5NPckIUsQsMI1JYtHWs2AJYYEAid5Z3xlBbBYB
        VYl7d1cyg9i8AjYSU3f+gVonLzHz0newoZxAq1dOncsIUSMocXLmE7AaZqCa5q2zwa6QEJjI
        IfHn83EmiGYXiS8Td0MNEpZ4dXwLO4QtJfGyvw3KLpZ4/PoflF0icXjJb6h6Y4l3N58DQ4MD
        aIGmxPpd+iCmhICyxJFbUGv5JDoO/2WHCPNKdLQJQTSqSGz/t5wZZtHp/ZughntI7Fo2H+xz
        IYF2Rom7l9UnMCrMQvLMLCTPzELYu4CReRWjWGpBcW56arFRgQk8hpPzczcxgpOslscOxtlv
        P+gdYmTiYDzEKMHBrCTC+8PFNEWINyWxsiq1KD++qDQntfgQoykwqCcyS4km5wPTfF5JvKGJ
        pYGJmZmhuZGpgbmSOO/HDuUUIYH0xJLU7NTUgtQimD4mDk6pBiaDsx/KwvoK4g2CfK1qc51X
        /Wg4EX2qx75IbceUaSovL5oImxge3HLho2X3mjfRXYZ1S6bfWrFuLdulKVfZrj7b2PimqGH9
        npqkPr3rJvNn104RDDop+nX37IUxi18bPJ/2reX8wpu8t/lcTSO8WkVX3W9K2SS4/XTwRKct
        hxfdtrnb4+Qq6R/f4/vg1fPJee+XiDFHvhNjSHr+501i28etL3QafjrKnT7L+l9Pts7FJ2fj
        h38uvAe32MsnnlW76eJ3O+mZcXeh1rQfLr2Ne2S+Vn/5Jx9ZGHHv5ermP6tD2oU/l3bqvbw7
        ad+PsD//Jn8WcWKZx/xq7zRFpd/ryhpOmiXExTh4/Fln8epTgdg3JZbijERDLeai4kQA8h4j
        ODsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnO4qQcsUg1VTdCymH1a0mD71AqPF
        hzf/WCzOzzrFYrFn70kWi3tr/rNa7Hu9l9niRedxJouODW8YLX7/mMNmsfH+OzYHbo9/J9aw
        eWxeoeWxeM9LJo9Nnyaxe0y+sZzRo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDIWdN9lLpgt
        XPF74w22BsbP/F2MnBwSAiYS59ecYu5i5OIQEtjBKLFv61oWiISUxPvTbewQtrDE/ZYjrBBF
        HUwS6w4vBStiE9CW+HPlPBuILSIgLnFs6klGkCJmgQVMEhtnrAEay8EhLOAnMXdrBkgNi4Cq
        xL27K5lBbF4BG4mpO/9ALZOXmHnpO9gyTqCLVk6dywhiCwkYS1xvg6kXlDg58wlYPTNQffPW
        2cwTGAVmIUnNQpJawMi0ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOB60tHYw7ln1
        Qe8QIxMH4yFGCQ5mJRHeHy6mKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1O
        TS1ILYLJMnFwSjUwTVomMH2NJZss95976zy87f8wzuIQEp3DvP74/3k1lVLlz3KvOZ8J9L+y
        /mfPL2/90vsGtqvVRfYZ6K8x9vfI72WRt7pz+CGHT/af/7EhCj852SKXXxS19A6cPcO70XCv
        t+66/zIBvCEp0TxzSlTS98z+v+RUEe8hqTk8U8OO3VlZG3kpYlbam4Dq5x3Td/m8efuke/r6
        J2tyIktWWl56uUNDoG+/ulypzDMfnsx3DUHX9gQeOaq7K2cK68sfa7wnVRd9efWpoCfyvvLZ
        dT1uHvpr2Ts3mEx9N2ljj9pmOfVFLQ+rE6rY5eZ9O3trxVrJuG8330/InuWt/PHJ4cfyL8sZ
        hPrf3O9nTi4u+nK6RImlOCPRUIu5qDgRAADVR6b2AgAA
X-CMS-MailID: 20230414084114epcas2p4754d6c0d3c86a0d6d4e855058562100f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230414084114epcas2p4754d6c0d3c86a0d6d4e855058562100f
References: <ZDbQ5O7LAmGbhqFw@casper.infradead.org>
        <CGME20230414084114epcas2p4754d6c0d3c86a0d6d4e855058562100f@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On Wed, Apr 12, 2023 at 08:10:33PM +0900, Kyungsan Kim wrote:
>> Pinning and plubbability is mutual exclusive so it can not happen at the same time.
>> What we argue is ZONE_EXMEM does not "confine movability". an allocation context can determine the movability attribute.
>> Even one unmovable allocation will make the entire CXL DRAM unpluggable.
>> When you see ZONE_EXMEM just on movable/unmoable aspect, we think it is the same with ZONE_NORMAL,
>> but ZONE_EXMEM works on an extended memory, as of now CXL DRAM.
>>
>> Then why ZONE_EXMEM is, ZONE_EXMEM considers not only the pluggability aspect, but CXL identifier for user/kenelspace API,
>> the abstraction of multiple CXL DRAM channels, and zone unit algorithm for CXL HW characteristics.
>> The last one is potential at the moment, though.
>>
>> As mentioned in ZONE_EXMEM thread, we are preparing slides to explain experiences and proposals.
>> It it not final version now[1].
>> [1] https://github.com/OpenMPDK/SMDK/wiki/93.-%5BLSF-MM-BPF-TOPIC%5D-SMDK-inspired-MM-changes-for-CXL
>
>The problem is that you're starting out with a solution.  Tell us what
>your requirements are, at a really high level, then walk us through
>why ZONE_EXMEM is the best way to satisfy those requirements.

Thank you for your advice. It makes sense.
We will restate requirements(usecases and issues) rather than our solution aspect.
A sympathy about the requirements should come first at the moment.
Hope we gradually reach up a consensus.

>Also, those slides are terrible.  Even at 200% zoom, the text is tiny.
>
>There is no MAP_NORMAL argument to mmap(), there are no GFP flags to
>sys_mmap() and calling mmap() does not typically cause alloc_page() to
>be called.  I'm not sure that putting your thoughts onto slides is
>making them any better organised.

I'm sorry for your inconvenience. Explaining the version of document, the 1st slide shows SMDK kernel, not vanilla kernel.
Especially, the slide is geared to highlight the flow of the new user/kernel API to implicitly/explicitly access DIMM DRAM or CXL DRAM
to help understanding at previous discussion context.
We added MAP_NORMAL/MAP_EXMEM on mmap()/sys_mmap(), GFP_EXMEM/GFP_NORMAL on alloc_pages().
If you mean COW, please assume the mmap() is called with MAP_POPULATE flag. We wanted to draw it simple to highlight the purpose.
The document is not final version, we will apply your comment while preparing.


