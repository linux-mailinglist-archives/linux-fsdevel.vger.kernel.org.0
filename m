Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEBD6D6B00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 19:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbjDDR6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 13:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjDDR6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:58:10 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792135A6;
        Tue,  4 Apr 2023 10:58:08 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230404175807usoutp02d61751c12250436338936df1139a8e1e~SzRHVbHJQ2513825138usoutp02T;
        Tue,  4 Apr 2023 17:58:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230404175807usoutp02d61751c12250436338936df1139a8e1e~SzRHVbHJQ2513825138usoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680631087;
        bh=GyNCiN5NyYtYGx6ZpPHXpBvWu4FEC16e+2G8ooYWrNY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=cRkI8DNp1c0w2lIi3fxfUCDEV2ERJd39HzjmelUiGxokRJaBiNzhZNA2qTcrFuZZA
         rUMW84MxSHI2AwfgivhswAyGNAfnmHb0j1n4Zshw9RdltmV6eWOy8JcqkhsXvHX3fi
         SFVS3Rlqp9h9hw6rVJOnkDx2waJhP35j5T08bbDo=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230404175807uscas1p1bd70cf779e5118432059284714c217a4~SzRHHnift0080200802uscas1p1s;
        Tue,  4 Apr 2023 17:58:07 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id D8.49.09670.F256C246; Tue, 
        4 Apr 2023 13:58:07 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230404175806uscas1p123e671c3c0a5b2e536c161f91a47331f~SzRG04Atx0078500785uscas1p1i;
        Tue,  4 Apr 2023 17:58:06 +0000 (GMT)
X-AuditID: cbfec36f-6f9ff700000025c6-9f-642c652f005a
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 41.68.09515.E256C246; Tue, 
        4 Apr 2023 13:58:06 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 4 Apr 2023 10:58:05 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Tue,
        4 Apr 2023 10:58:05 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Kyungsan Kim <ks0204.kim@samsung.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "seungjun.ha@samsung.com" <seungjun.ha@samsung.com>,
        "wj28.lee@samsung.com" <wj28.lee@samsung.com>
Subject: Re: RE: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for
 CXL
Thread-Topic: RE: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for
        CXL
Thread-Index: AQHZRZWYKsKibCrYtEW5v18Ffh90dK7oooD8gB42sICAASUvgIAA1oqAgAR8YoCACCVygIAGEwwAgACeYQA=
Date:   Tue, 4 Apr 2023 17:58:05 +0000
Message-ID: <20230404175754.GA633356@bgt-140510-bm01>
In-Reply-To: <ZCvgTA5uk/HcyMAk@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28C9E57282D5264F96CD90AC7651B607@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djXc7r6qTopBm/vc1lMn3qB0eL8rFMs
        Fnv2nmSxuLfmP6vFvtd7mS2OrN/OZNGx4Q2jA7vHvxNr2DwW73nJ5LFpVSebx6ZPk9g9Jt9Y
        zujxeZNcAFsUl01Kak5mWWqRvl0CV8bPxkbWggnKFRM7TjI3MB6X7mLk5JAQMJG43PSYtYuR
        i0NIYCWjxINHO1kgnFYmiZYbv9hgqm68WgpVtZZRYvauI0wQzkdGiTXT3rGAVAkJLGWUWPRT
        E8RmEzCQ+H18IzOILSKgLPF98T5mkAZmgXYWiYNHzoONFRYIlFjw5TcbRFGQxJXPTexdjBxA
        dpLEp99SIGEWARWJ1wsngs3nFTCV2PrtGjuIzSmgJfFq9VVWEJtRQEzi+6k1TCA2s4C4xK0n
        85kgrhaUWDR7DzOELSbxb9dDqG8UJe5/f8kOUa8jsWD3JzYI205i+a6/rBC2tsSyha+ZIfYK
        Spyc+YQFoldS4uCKG1D2Ew6JNzO8IGwXiXsLG6DmS0tMX3MZqiZfYlfbFagbKiSuvu6GqrGW
        WPhnPdMERpVZSM6eheSkWUhOmoXkpFlITlrAyLqKUby0uDg3PbXYKC+1XK84Mbe4NC9dLzk/
        dxMjMFGd/nc4fwfj9Vsf9Q4xMnEwHmKU4GBWEuFV7dJKEeJNSaysSi3Kjy8qzUktPsQozcGi
        JM5raHsyWUggPbEkNTs1tSC1CCbLxMEp1cBkuPzO4XesD08cZnzpeul6rcitu4sXe1nO/WFS
        rvYmTXrSluPn+oq/PD1zWd+JN4B/8p+zW5qqW15OqhRaO/PzgcM/T6bfq/T8nHZhKrv3uzvf
        9ayObXiwQMDds9pBnOmSZE3IqaI2s5obRoaf2XtLIvu3294pzfuic+Hrtp3TzCpZ5vVf0vMq
        PCh6ZMf/DRvk6n63lni85PJeqhcp7tsj+db/hHNm5d0dgmUmST/vKgZFy5zJSRR5bKaduHv5
        baZdP2um1wetW3x6VQDf17R/D6bl2nIci01d5fxx/gLmB6fKv81bw3/pY+BrOeXOBKllTX+r
        3L4qJ7x7b8lwdYWm4uHb63TvB5t4vivfp3h7pRJLcUaioRZzUXEiAAhRvA/DAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWS2cA0SVcvVSfF4N8xQ4vpUy8wWpyfdYrF
        Ys/ekywW99b8Z7XY93ovs8WR9duZLDo2vGF0YPf4d2INm8fiPS+ZPDat6mTz2PRpErvH5BvL
        GT0+b5ILYIvisklJzcksSy3St0vgyvjZ2MhaMEG5YmLHSeYGxuPSXYycHBICJhI3Xi1l7WLk
        4hASWM0ocezYGxYI5yOjxJ8dF1lAqoQEljJKzJvIBmKzCRhI/D6+kRnEFhFQlvi+eB8zSAOz
        QDuLRMuqyWANwgKBEgu+/AZq4AAqCpJo+yoOYSZJfPotBVLBIqAi8XrhRLBqXgFTia3frrFD
        7L3AKLH44kZWkASngJbEq9VXwWxGATGJ76fWMIHYzALiEreezGeC+EBAYsme88wQtqjEy8f/
        WCFsRYn731+yQ9TrSCzY/YkNwraTWL7rLyuErS2xbOFrZogjBCVOznzCAtErKXFwxQ2WCYwS
        s5Csm4Vk1Cwko2YhGTULyagFjKyrGMVLi4tz0yuKjfNSy/WKE3OLS/PS9ZLzczcxAqP89L/D
        MTsY7936qHeIkYmD8RCjBAezkgivapdWihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFej9iJ8UIC
        6YklqdmpqQWpRTBZJg5OqQYmhiKFusny79da+KdG7mAI2RrLU6/rG/Xnc86KK4XPCif2O+8O
        tZw487d9XPBB3Zuf7vzybTkXf7juvpP2ZtkSjZQl8Ru2lm0/kyp4yfhekdi0N/Gfdr003vm3
        93/g1NQewTd1pW2eizKPmM72ZtfIOfxM+Wv/oiA9oSWv/xy/O0P3wjGz1JfPEi6/F4lfkhJ7
        xL+A5Yrk7X1/DvwTran0z3VJ6NtUvC115gfVD2c7yt9Hr9RxOiibl/yb68xV/Wqtb5tnnTpS
        3MBpOOvi8tXP13+dFufOvul4X+fOxPOqnzWufd/lMl/he3zkDVkOjeNWLILTuTbN1n5icSBc
        iTPt3vH/Qb4Gb73WijxifviKSYmlOCPRUIu5qDgRAKiR6MthAwAA
X-CMS-MailID: 20230404175806uscas1p123e671c3c0a5b2e536c161f91a47331f
CMS-TYPE: 301P
X-CMS-RootMailID: 20230331114526epcas2p2b6f1d4c8c1c0b2e3c12a425b6e48c0d8
References: <ZB/yb9n6e/eNtNsf@kernel.org>
        <CGME20230331114526epcas2p2b6f1d4c8c1c0b2e3c12a425b6e48c0d8@epcas2p2.samsung.com>
        <20230331114525.400375-1-ks0204.kim@samsung.com>
        <ZCvgTA5uk/HcyMAk@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 04, 2023 at 11:31:08AM +0300, Mike Rapoport wrote:
> On Fri, Mar 31, 2023 at 08:45:25PM +0900, Kyungsan Kim wrote:
> > Thank you Mike Rapoport for participating discussion and adding your th=
ought.
> >=20
> > >Hi,
> > >
> > >On Thu, Mar 23, 2023 at 07:51:05PM +0900, Kyungsan Kim wrote:
> > >> I appreciate dan for the careful advice.
> > >>=20
> > >> >Kyungsan Kim wrote:
> > >> >[..]
> > >> >> >In addition to CXL memory, we may have other kind of memory in t=
he
> > >> >> >system, for example, HBM (High Bandwidth Memory), memory in FPGA=
 card,
> > >> >> >memory in GPU card, etc.  I guess that we need to consider them
> > >> >> >together.  Do we need to add one zone type for each kind of memo=
ry?
> > >> >>=20
> > >> >> We also don't think a new zone is needed for every single memory
> > >> >> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough=
 to
> > >> >> manage multiple volatile memory devices due to the increased devi=
ce
> > >> >> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used t=
o
> > >> >> represent extended volatile memories that have different HW
> > >> >> characteristics.
> > >> >
> > >> >Some advice for the LSF/MM discussion, the rationale will need to b=
e
> > >> >more than "we think the ZONE_EXMEM can be used to represent extende=
d
> > >> >volatile memories that have different HW characteristics". It needs=
 to
> > >> >be along the lines of "yes, to date Linux has been able to describe=
 DDR
> > >> >with NUMA effects, PMEM with high write overhead, and HBM with impr=
oved
> > >> >bandwidth not necessarily latency, all without adding a new ZONE, b=
ut a
> > >> >new ZONE is absolutely required now to enable use case FOO, or addr=
ess
> > >> >unfixable NUMA problem BAR." Without FOO and BAR to discuss the cod=
e
> > >> >maintainability concern of "fewer degress of freedom in the ZONE
> > >> >dimension" starts to dominate.
> > >>=20
> > >> One problem we experienced was occured in the combination of hot-rem=
ove and kerelspace allocation usecases.
> > >> ZONE_NORMAL allows kernel context allocation, but it does not allow =
hot-remove because kernel resides all the time.
> > >> ZONE_MOVABLE allows hot-remove due to the page migration, but it onl=
y allows userspace allocation.
> > >> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by =
adding GFP_MOVABLE flag.
> > >> In case, oops and system hang has occasionally occured because ZONE_=
MOVABLE can be swapped.
> > >> We resolved the issue using ZONE_EXMEM by allowing seletively choice=
 of the two usecases.
> > >> As you well know, among heterogeneous DRAM devices, CXL DRAM is the =
first PCIe basis device, which allows hot-pluggability, different RAS, and =
extended connectivity.
> > >> So, we thought it could be a graceful approach adding a new zone and=
 separately manage the new features.
> > >
> > >This still does not describe what are the use cases that require havin=
g
> > >kernel allocations on CXL.mem.=20
> > >
> > >I believe it's important to start with explanation *why* it is importa=
nt to
> > >have kernel allocations on removable devices.
> > >=20
> >=20
> > In general, a memory system with DDR/CXL DRAM will have near/far memory=
.
> > And, we think kernel already includes memory tiering solutions - Meta T=
PP, zswap, and pagecache.
> > Some kernel contexts would prefer fast memory. For example, a hot data =
with time locality or a data for fast processing such as metadata or indexi=
ng.
> > Others would enough with slow memory. For example, a zswap page which i=
s being used while swapping.=20
>=20
> The point of zswap IIUC is to have small and fast swap device and
> compression is required to better utilize DRAM capacity at expense of CPU
> time.
>=20
> Presuming CXL memory will have larger capacity than DRAM, why not skip th=
e
> compression and use CXL as a swap device directly?

I like to shy away from saying CXL memory should be used for swap. I see a=
=20
swap device as storing pages in a manner that is no longer directly address=
able
by the cpu.=20

Migrating pages to a CXL device is a reasonable approach and I believe we
have the ability to do this in the page reclaim code.=20

>=20
> And even supposing there's an advantage in putting zswap on CXL memory,
> why that can be done with node-based APIs but warrants a new zone?
>=20
> --=20
> Sincerely yours,
> Mike.=
