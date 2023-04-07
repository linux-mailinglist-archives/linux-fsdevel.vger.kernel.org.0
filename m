Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2366DAADF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 11:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbjDGJa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 05:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240543AbjDGJaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:30:14 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940B4A5E1
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 02:30:11 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230407093009epoutp0139d40747ccf5a9478b38cbe1709f3cbb~TnRdJfoCm0924709247epoutp01I
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 09:30:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230407093009epoutp0139d40747ccf5a9478b38cbe1709f3cbb~TnRdJfoCm0924709247epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680859809;
        bh=K+njIEn0kfGxg0tVKTgO3/qQJmR6XtelyExKXW83fbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/mE7aAx3TWBm73cs1zyhrjIizuUd0VHUwYeALEw+seUcnGUARtNJeUeSiu3S24fH
         CSc5kr/n2a7ybP9QioyFfmV6KqgH3eH7HBRYDwL3tTjgzg4l6T8K37yFLNoeqABJeT
         FThtxybZ+9/LhJUGbtwENA0Ae09amoQJ4zyBBhFM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230407093008epcas2p3064bf22d141200505d03456c0e81c675~TnRcph2qe1668416684epcas2p32;
        Fri,  7 Apr 2023 09:30:08 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PtCl41Q6Sz4x9Q6; Fri,  7 Apr
        2023 09:30:08 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.60.35469.0A2EF246; Fri,  7 Apr 2023 18:30:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230407093007epcas2p32addf5da24110c3e45c90a15dcde0d01~TnRbwl9HX1668516685epcas2p3R;
        Fri,  7 Apr 2023 09:30:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230407093007epsmtrp2eb4e1ae515dca1616e56bef36b3b0644~TnRbv3Lwc1724917249epsmtrp2T;
        Fri,  7 Apr 2023 09:30:07 +0000 (GMT)
X-AuditID: b6c32a48-9e7f970000008a8d-62-642fe2a0d95a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.05.18071.F92EF246; Fri,  7 Apr 2023 18:30:07 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230407093007epsmtip13b502aa41ea39a9fc43e69407fb8d763~TnRbljCGY1295112951epsmtip1T;
        Fri,  7 Apr 2023 09:30:07 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     david@redhat.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Fri,  7 Apr 2023 18:30:07 +0900
Message-Id: <20230407093007.420852-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6ebf38f1-b7c4-cb38-b72f-2e406d2a2fdc@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmme6CR/opBte6OSymH1a0mD71AqPF
        1/W/mC3OzzrFYrFn70kWi3tr/rNa7Hu9l9niRedxJouODW8YLTbef8fmwOXx78QaNo/Fe14y
        eWz6NIndY/KN5Ywe7/ddZfPo27KK0ePzJrkA9qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hT
        MwNDXUNLC3MlhbzE3FRbJRefAF23zByg85QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqp
        BSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2RnNy9ezFdxSqdi6/idbA+McuS5GDg4JAROJ
        5zeZuxi5OIQEdjBKfD44gQnC+cQoMfPhTyjnG6PEvP7LLF2MnGAdFy/vZoNI7GWUWPUIpqqL
        SeLP7s1MIFVsAtoSf66cZwOxRQREJH48fMkIYjML/GOU2HNZEmS3sICHxNopHCBhFgFVieMd
        +8BaeQVsJKZ+esMKsUxeYual7+wgNqeAncTfhxfZIWoEJU7OfMICMVJeonnrbLAfJAR6OSTe
        ntnBCNHsIjF/eTOULSzx6vgWdghbSuLzu71sEHaxxOPX/6DiJRKHl/yG+tJY4t3N56wgdzIL
        aEqs36UPCS5liSO3oNbySXQc/ssOEeaV6GgTgmhUkdj+bzkzzKLT+zdBDfeQ2Pz2NSskpCYy
        SvxecZR9AqPCLCTfzELyzSyExQsYmVcxiqUWFOempxYbFZjA4zc5P3cTIzixannsYJz99oPe
        IUYmDsZDjBIczEoivJfr9FKEeFMSK6tSi/Lji0pzUosPMZoCw3ois5Rocj4wteeVxBuaWBqY
        mJkZmhuZGpgrifN+7FBOERJITyxJzU5NLUgtgulj4uCUamDqbdq7wvPo/Bqetdt9CnfG6a5+
        9pUn4GRf9hob+9qy51+Lis93a+cIC6+cqOjjkr02R0zuzKddj7TkG3yYvHrj3kVF7WPc/ZLv
        1v4F4UHNHAxdIbNs2sU0Be7s83E5ELr39dkXtm5n04+v6ZBUc+JbUPMo1OeX/buAHfq3O1Wi
        1Xd+11nEvOFFptrmQNPJxsFh5detLsyW1T1746FFhG1u1tOZ5upNTP8WHWk2a401mLLdNfmL
        w6by+y1Tnp+13HMpsCSg6+vbrmOmE+9t6fOct1830aVm6rawbx+WXy1gVVZbecXWlKv1XtAD
        x/UGN/8aB94Q0r5wytvQxfmIv9eKWQWvDkY9d2vgdvHu7FRiKc5INNRiLipOBAA+67qnNQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnO78R/opBp+ealtMP6xoMX3qBUaL
        r+t/MVucn3WKxWLP3pMsFvfW/Ge12Pd6L7PFi87jTBYdG94wWmy8/47Ngcvj34k1bB6L97xk
        8tj0aRK7x+Qbyxk93u+7yubRt2UVo8fnTXIB7FFcNimpOZllqUX6dglcGc3L17MV3FKp2Lr+
        J1sD4xy5LkZODgkBE4mLl3ezdTFycQgJ7GaUWHVwLxtEQkri/ek2dghbWOJ+yxFWiKIOJome
        O+1gCTYBbYk/V86DNYgIiEj8ePiSEaSIGaRo6+XpQAkODmEBD4m1UzhAalgEVCWOd+xjArF5
        BWwkpn56wwqxQF5i5qXvYDM5Bewk/j68CGYLCdhKtNzYxA5RLyhxcuYTFhCbGai+eets5gmM
        ArOQpGYhSS1gZFrFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcB1qaOxi3r/qgd4iR
        iYPxEKMEB7OSCO/lOr0UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQW
        wWSZODilGpjOz1E74TOpeZLcW6uUwnNzG2R4i9tVzmvLW2U3vUioWXvIP23TmYnek7qr9h73
        ZSmNW/HD+Bur5PSgC6Y31nzduitWaLPthAUhl092ZBW7pEgubzun91X8+eruJWLvdC+tCatl
        dJc+4Naw8/rdTOOzAbeVv+sV6AmoJ71zLz309uzN+07r3BaWPL308E6k3sy1iWu4/73vVxWL
        0djL+q214Y/1f+bfc+SvWC+dsXHWKc7v3d5Lg2av01x3+/mFtBw7w2rXaec2T9iYpP84al/r
        KaUM1yshHscMlH4qHX0/ySQh4Gj+jJaOSYteX5n44pgJ+/ashOcyy32qnnAY6Z5capjyyeZ1
        r9rCi/dm7g5WU2Ipzkg01GIuKk4EAMN3VJLyAgAA
X-CMS-MailID: 20230407093007epcas2p32addf5da24110c3e45c90a15dcde0d01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230407093007epcas2p32addf5da24110c3e45c90a15dcde0d01
References: <6ebf38f1-b7c4-cb38-b72f-2e406d2a2fdc@redhat.com>
        <CGME20230407093007epcas2p32addf5da24110c3e45c90a15dcde0d01@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On 05.04.23 21:42, Dan Williams wrote:
>> Matthew Wilcox wrote:
>>> On Tue, Apr 04, 2023 at 09:48:41PM -0700, Dan Williams wrote:
>>>> Kyungsan Kim wrote:
>>>>> We know the situation. When a CXL DRAM channel is located under ZONE_NORMAL,
>>>>> a random allocation of a kernel object by calling kmalloc() siblings makes the entire CXL DRAM unremovable.
>>>>> Also, not all kernel objects can be allocated from ZONE_MOVABLE.
>>>>>
>>>>> ZONE_EXMEM does not confine a movability attribute(movable or unmovable), rather it allows a calling context can decide it.
>>>>> In that aspect, it is the same with ZONE_NORMAL but ZONE_EXMEM works for extended memory device.
>>>>> It does not mean ZONE_EXMEM support both movability and kernel object allocation at the same time.
>>>>> In case multiple CXL DRAM channels are connected, we think a memory consumer possibly dedicate a channel for movable or unmovable purpose.
>>>>>
>>>>
>>>> I want to clarify that I expect the number of people doing physical CXL
>>>> hotplug of whole devices to be small compared to dynamic capacity
>>>> devices (DCD). DCD is a new feature of the CXL 3.0 specification where a
>>>> device maps 1 or more thinly provisioned memory regions that have
>>>> individual extents get populated and depopulated by a fabric manager.
>>>>
>>>> In that scenario there is a semantic where the fabric manager hands out
>>>> 100G to a host and asks for it back, it is within the protocol that the
>>>> host can say "I can give 97GB back now, come back and ask again if you
>>>> need that last 3GB".
>>>
>>> Presumably it can't give back arbitrary chunks of that 100GB?  There's
>>> some granularity that's preferred; maybe on 1GB boundaries or something?
>> 
>> The device picks a granularity that can be tiny per spec, but it makes
>> the hardware more expensive to track in small extents, so I expect
>> something reasonable like 1GB, but time will tell once actual devices
>> start showing up.
>
>It all sounds a lot like virtio-mem using real hardware [I know, there 
>are important differences, but for the dynamic aspect there are very 
>similar issues to solve]
>
>Fir virtio-mem, the current best way to support hotplugging of large 
>memory to a VM to eventually be able to unplug a big fraction again is 
>using a combination of ZONE_MOVABLE and ZONE_NORMAL -- "auto-movable" 
>memory onlining policy. What's online to ZONE_MOVABLE can get (fairly) 
>reliably unplugged again. What's onlined to ZONE_NORMAL is possibly lost 
>forever.
>
>Like (incrementally) hotplugging 1 TiB to a 4 GiB VM. Being able to 
>unplug 1 TiB reliably again is pretty much out of scope. But the more 
>memory we can reliably get back the better. And the more memory we can 
>get in the common case, the better. With a ZONE_NORMAL vs. ZONE_MOVABLE 
>ration of 1:3 on could unplug ~768 GiB again reliably. The remainder 
>depends on fragmentation on the actual system and the unplug granularity.
>
>The original plan was to use ZONE_PREFER_MOVABLE as a safety buffer to 
>reduce ZONE_NORMAL memory without increasing ZONE_MOVABLE memory (and 
>possibly harming the system). The underlying idea was that in many 
>setups that memory in ZONE_PREFER_MOVABLE would not get used for 
>unmovable allocations and it could, therefore, get unplugged fairly 
>reliably in these setups. For all other setups, unmmovable allocations 
>could leak into ZONE_PREFER_MOVABLE and reduce the number of memory we 
>could unplug again. But the system would try to keep unmovable 
>allocations to ZONE_NORMAL, so in most cases with some 
>ZONE_PREFER_MOVABLE memory we would perform better than with only 
>ZONE_NORMAL.

Probably memory hotplug mechanism would be separated into two stages, physical memory add/remove and logical memory on/offline[1].
We think ZONE_PREFER_MOVABLE could help logical memory on/offline. But, there would be trade-off between physical add/remove and device utilization.
In case of ZONE_PREFER_MOVABLE allocation on switched CXL DRAM devices, 
when pages are evenly allocated among physical CXL DRAM devices, then it would not help physical memory add/remove.
Meanwhile, when page are sequentially allocated among physical CXL DRAM devices, it would be opposite.

ZONE_EXMEM provides provision of CXL DRAM devices[2], we think the idea of ZONE_PREFER_MOVABLE idea can be applied on that.
For example, preferred movable page per CXL DRAM device within the zone.

[1] https://docs.kernel.org/admin-guide/mm/memory-hotplug.html#phases-of-memory-hotplug
[2] https://github.com/OpenMPDK/SMDK/wiki/2.-SMDK-Architecture#memory-partition
>
>-- 
>Thanks,
>
>David / dhildenb
