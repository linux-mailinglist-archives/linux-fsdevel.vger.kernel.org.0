Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F26B6D1F59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 13:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjCaLpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 07:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCaLpb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:45:31 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE77C2688
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 04:45:29 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230331114527epoutp0362abdd71775d7d8330f80d65556a8e52~RfmmWgVWU1841418414epoutp03B
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 11:45:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230331114527epoutp0362abdd71775d7d8330f80d65556a8e52~RfmmWgVWU1841418414epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680263127;
        bh=xe7BtmtLnH4DXm8w21CW7Kud50GrprJxmJ107O9JGIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfVbUM0RSvyRvxOg9QN5SibBXJ8cg5eyYAI/QwmIa+rIQVVhtE0Oswx9xVblPg8RT
         rLMdkadi6sDxDnD0XrMFlSYUhkUKEhMB3mIt0XUPz5mbtMrpGa64qRO2hx3zwGZNoU
         mEs1iQEToBwppEJeZCFVQI2+g91PefkeiXaBhm04=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230331114527epcas2p1f49419ce25b034fae0c57aa9147d6a6a~RfmlqHd_l1988319883epcas2p1O;
        Fri, 31 Mar 2023 11:45:27 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Pnz4Q41Zwz4x9Pt; Fri, 31 Mar
        2023 11:45:26 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.EE.35469.6D7C6246; Fri, 31 Mar 2023 20:45:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230331114526epcas2p2b6f1d4c8c1c0b2e3c12a425b6e48c0d8~RfmkqTeCu0937109371epcas2p2e;
        Fri, 31 Mar 2023 11:45:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230331114526epsmtrp2891df4bff90a96ef8670d98fec8cf1fd~Rfmkpg6oW0911809118epsmtrp2x;
        Fri, 31 Mar 2023 11:45:26 +0000 (GMT)
X-AuditID: b6c32a48-791ff70000008a8d-b9-6426c7d65967
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.62.31821.5D7C6246; Fri, 31 Mar 2023 20:45:26 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230331114525epsmtip1e121ff5f214bbf1e6620326f323a66c3~RfmkecJAs1642716427epsmtip1o;
        Fri, 31 Mar 2023 11:45:25 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     rppt@kernel.org
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: Re: RE: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for
 CXL 
Date:   Fri, 31 Mar 2023 20:45:25 +0900
Message-Id: <20230331114525.400375-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZB/yb9n6e/eNtNsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmhe6142opBm8WSVtMP6xoMX3qBUaL
        87NOsVjs2XuSxeLemv+sFvte72W2OLJ+O5PFi87jTBYdG94wWmy8/47Ngcvj34k1bB6L97xk
        8ti0qpPNY9OnSewek28sZ/To27KK0ePzJrkA9qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hT
        MwNDXUNLC3MlhbzE3FRbJRefAF23zByg85QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqp
        BSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2Rnvfh1lLOiVqmg+uJ6tgXGSaBcjJ4eEgInE
        /jMTWLsYuTiEBHYwShy6v4AJwvnEKHF68nxmkCohgc+MErfnmcF0vJu5mh2iaBejxKTmtSwQ
        TheTxPrv71hAqtgEtCX+XDnPBmKLCAhLPPo5DyzOLPCPUWLPZUkQW1ggSOLwkU+MIDaLgKrE
        99d3WEFsXgEbiXs3prBCbJOXmHnpO9A2Dg5OAS2JA2f5IEoEJU7OfAI1Ul6ieetsZpAbJAR6
        OSRefD7PDNHrInFkYi8jhC0s8er4FnYIW0ri87u9bBB2scTj1/+g4iUSh5f8ZoGwjSXe3XzO
        CrKXWUBTYv0ufRBTQkBZ4sgtqLV8Eh2H/7JDhHklOtqEIBpVJLb/W84Ms+j0/k1Qwz0kTp9f
        yA4JzlqJHTc7WScwKsxC8swsJM/MQti7gJF5FaNYakFxbnpqsVGBCTx6k/NzNzGC06qWxw7G
        2W8/6B1iZOJgPMQowcGsJMJbaKyaIsSbklhZlVqUH19UmpNafIjRFBjSE5mlRJPzgYk9ryTe
        0MTSwMTMzNDcyNTAXEmc92OHcoqQQHpiSWp2ampBahFMHxMHp1QDU0PDbGuvSa3hq87cDHx+
        Uf+vv8D83s86bJ6ly3o0/q7IvRy8IZT5n/K0lD1Ldl6JNJf6kLrviiJnBDuf+Srl37Er7woo
        ral5afw1dt2MqSFdecIXWBXe/tniu/h1kuxa27//81oYM3ucJ7YpfzNQNppn+afFJUl20XPP
        3ccWRuk1F7T8NlRW/3RNb/rtLZMqzXYfjxM8XxB0OJ9F7k57dCp/9bJjASafcz27T51afu5v
        tdLjbmeNjMbECat4NcVKhB08GVqT6qxTZdKP/OXiuKA7y2Hb7oN5nReK94q8/LCrMuPMirYr
        Z19sD1id6HY3KyA55lEy4yL3H5teL1jKE3JzNl954N/osCM7fPLeKbEUZyQaajEXFScCAMTp
        xEU0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnO6142opBktOMFlMP6xoMX3qBUaL
        87NOsVjs2XuSxeLemv+sFvte72W2OLJ+O5PFi87jTBYdG94wWmy8/47Ngcvj34k1bB6L97xk
        8ti0qpPNY9OnSewek28sZ/To27KK0ePzJrkA9igum5TUnMyy1CJ9uwSujHe/jjIW9EpVNB9c
        z9bAOEm0i5GTQ0LAROLdzNXsXYxcHEICOxgl7l5ezgyRkJJ4f7qNHcIWlrjfcoQVoqiDSaJh
        3TwWkASbgLbEnyvn2UBsEaCiRz9B4lwczCBFWy9PB0pwcAgLBEicPgs2iEVAVeL76zusIDav
        gI3EvRtTWCEWyEvMvPSdHaScU0BL4sBZPpCwkICmxO5L79ghygUlTs58AraWGai8eets5gmM
        ArOQpGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcBVpaOxj3rPqgd4iR
        iYPxEKMEB7OSCG+hsWqKEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KL
        YLJMHJxSDUxa0SXLTvnV3+mTry5TEykUCZyfouQnktL9OtpguWYkw7a45Y+3s91ZKST1epHG
        m9k/8+YomjJEvvUVmLnz3/9uvhP/bOyPvti97nVP2dwXN9RS1s2Pcvr//1KvwtyPT5flbz8w
        f9c8pyKexn2W5V3Pnu7Z13A2fV7Ypv3SH/7+MK3dvCv51foVT8/cdLgnk36p6ravZFNPfuvs
        V+/s38at8mMo/n5VXobx1C2xB8Z+B+ojF+Tt2/ddv0lWuselcK8CW1vWsiLFpJqU9OD9R34b
        MkyyDmO/ZzTxlX1lfZSuUHzO40kuh15IRCzpT8/ZtNlz3s5pkmrnGy3jU3br/csq/yKgGfWd
        N2KCjsC/9lQlluKMREMt5qLiRABqK+oa8QIAAA==
X-CMS-MailID: 20230331114526epcas2p2b6f1d4c8c1c0b2e3c12a425b6e48c0d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331114526epcas2p2b6f1d4c8c1c0b2e3c12a425b6e48c0d8
References: <ZB/yb9n6e/eNtNsf@kernel.org>
        <CGME20230331114526epcas2p2b6f1d4c8c1c0b2e3c12a425b6e48c0d8@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you Mike Rapoport for participating discussion and adding your thought.

>Hi,
>
>On Thu, Mar 23, 2023 at 07:51:05PM +0900, Kyungsan Kim wrote:
>> I appreciate dan for the careful advice.
>> 
>> >Kyungsan Kim wrote:
>> >[..]
>> >> >In addition to CXL memory, we may have other kind of memory in the
>> >> >system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>> >> >memory in GPU card, etc.  I guess that we need to consider them
>> >> >together.  Do we need to add one zone type for each kind of memory?
>> >> 
>> >> We also don't think a new zone is needed for every single memory
>> >> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>> >> manage multiple volatile memory devices due to the increased device
>> >> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>> >> represent extended volatile memories that have different HW
>> >> characteristics.
>> >
>> >Some advice for the LSF/MM discussion, the rationale will need to be
>> >more than "we think the ZONE_EXMEM can be used to represent extended
>> >volatile memories that have different HW characteristics". It needs to
>> >be along the lines of "yes, to date Linux has been able to describe DDR
>> >with NUMA effects, PMEM with high write overhead, and HBM with improved
>> >bandwidth not necessarily latency, all without adding a new ZONE, but a
>> >new ZONE is absolutely required now to enable use case FOO, or address
>> >unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>> >maintainability concern of "fewer degress of freedom in the ZONE
>> >dimension" starts to dominate.
>> 
>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
>> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
>
>This still does not describe what are the use cases that require having
>kernel allocations on CXL.mem. 
>
>I believe it's important to start with explanation *why* it is important to
>have kernel allocations on removable devices.
> 

In general, a memory system with DDR/CXL DRAM will have near/far memory.
And, we think kernel already includes memory tiering solutions - Meta TPP, zswap, and pagecache.
Some kernel contexts would prefer fast memory. For example, a hot data with time locality or a data for fast processing such as metadata or indexing.
Others would enough with slow memory. For example, a zswap page which is being used while swapping. 

>> Kindly let me know any advice or comment on our thoughts.
>> 
>> 
>
>-- 
>Sincerely yours,
>Mike.
