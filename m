Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427E17A49A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 14:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbjIRMaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 08:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbjIRM3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:29:36 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B668299
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 05:29:28 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230918122925euoutp029e7f0a2abab79520fa879930160bb19e~F-gzDXaj60875008750euoutp02c
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 12:29:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230918122925euoutp029e7f0a2abab79520fa879930160bb19e~F-gzDXaj60875008750euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695040165;
        bh=T8vDLSLgWlgqAAt+WTBX0Wul4eBpG5N9RZJcFXyghzA=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Vj+S+5MQL01hMeAXbmSlxDrobhV5Eae2Nbl2jOmNZ9d8WM1LpTq2LFqF7/hslvA3Q
         V9KY8o6m/2LkQBtPYDXcJUC5vJj9RCQr+DfVcLZA+c5pdHuJUch81IOBCtr5SNlXLX
         R5nCYaYcmc0WmGTJ4pvb4RCMVqvnTiwr1wD8WrFU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230918122925eucas1p299320dca1a3f9a01e99b30b07589323e~F-gylZHN91246712467eucas1p2w;
        Mon, 18 Sep 2023 12:29:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 98.F8.42423.4A248056; Mon, 18
        Sep 2023 13:29:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230918122924eucas1p122bce924223345533b05aed016357efa~F-gyG4mCb1618116181eucas1p1O;
        Mon, 18 Sep 2023 12:29:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230918122924eusmtrp1dd7e281107acb0ea17c1fdd0727b0b1a~F-gyGOxm21513115131eusmtrp1J;
        Mon, 18 Sep 2023 12:29:24 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-a4-650842a41b86
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4D.C8.10549.4A248056; Mon, 18
        Sep 2023 13:29:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230918122924eusmtip1596c50d6c894097e01fd6ac2602f0744~F-gx7PNpM1269412694eusmtip1f;
        Mon, 18 Sep 2023 12:29:24 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.18) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 18 Sep 2023 13:29:23 +0100
Message-ID: <806df723-78cf-c7eb-66a6-1442c02126b3@samsung.com>
Date:   Mon, 18 Sep 2023 14:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.15.1
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     Pankaj Raghav <kernel@pankajraghav.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <da.gomez@samsung.com>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <willy@infradead.org>,
        <djwong@kernel.org>, <linux-mm@kvack.org>,
        <chandan.babu@oracle.com>, <gost.dev@samsung.com>,
        <riteshh@linux.ibm.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZQfbHloBUpDh+zCg@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.18]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7pLnDhSDX49trSYs34Nm8Wlo3IW
        W47dY7S4/ITP4szLzywWe/aeZLG4vGsOm8W9Nf9ZLXb92cFucWPCU0aLV49vsVv8/jGHzYHH
        49QiCY/NK7Q8Nq3qZPPY9GkSu8eJGb9ZPCYsOsDo8fHpLRaPsysdPT5vkgvgjOKySUnNySxL
        LdK3S+DKOLP2B1vBY8GKV8f7GRsYO/m6GDk5JARMJHZdaWYDsYUEVjBKdE2W6mLkArK/MEpM
        65nCCJH4zCixt5kXpuHk71XMEEXLGSXe3D7GAuEAFc24PJsFomMXo8T2rSUgNq+AncSM+7fA
        JrEIqErM6NjBAhEXlDg58wmYLSoQLTFz2kKwGmEBW4mPn56xgtjMAuISt57MZwKxRQR8JH4v
        OswIsoxZ4AqTxJQbvUAOBwebgJZEYyc7SA2ngLHE4xmf2CB6NSVat/9mh7DlJba/ncMM8YGS
        xMK2O2wQdq3EqS23mEBmSgjs5pT4/vkuK0TCReL372XsELawxKvjW6BsGYnTk3tYIOxqiac3
        fjNDNLcwSvTvXM8GcpCEgLVE35kciBpHiTmvn7FDhPkkbrwVhLiHT2LStunMExhVZyEFxSwk
        L89C8sIsJC8sYGRZxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZjUTv87/mkH49xXH/UO
        MTJxMB5ilOBgVhLhnWnIlirEm5JYWZValB9fVJqTWnyIUZqDRUmcV9v2ZLKQQHpiSWp2ampB
        ahFMlomDU6qBic14jtzUj79MtLuc4m53O9y+uVXIbrmxvYOznsdp1k8NskHL43ZMiSjzuhHb
        abFsdlBz+nJ9pqzg85NesXb+Nb90kalboNP7gO6l5kcT95yymlUaEvd1/u1gg4uKjGL5Pxsj
        HkRnrXjreVdhOfdEjcBzdx2nb/2TfmnHEQXZe58msNaf2xs3gb9JfX2Q5om5ueavTJP+Net0
        T+6S6yvMyDo9z7J6wbvchqUK+Wtsnb5+2SVo2HUjf+qVxZGR37scpnGc3Pnyayfz0tygYP++
        iZcUpuy/fNBAkaH5uq/ai3LVGtMtDkeb7zaV+n5m2bfsrJ5+xoeyNasufD5jvyF6n0Km7yLO
        xV/9NPqvRJy+pcRSnJFoqMVcVJwIABx9aNvZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xu7pLnDhSDT68lrKYs34Nm8Wlo3IW
        W47dY7S4/ITP4szLzywWe/aeZLG4vGsOm8W9Nf9ZLXb92cFucWPCU0aLV49vsVv8/jGHzYHH
        49QiCY/NK7Q8Nq3qZPPY9GkSu8eJGb9ZPCYsOsDo8fHpLRaPsysdPT5vkgvgjNKzKcovLUlV
        yMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOLP2B1vBY8GKV8f7
        GRsYO/m6GDk5JARMJE7+XsXcxcjFISSwlFGi49NjJoiEjMTGL1dZIWxhiT/Xutggij4yShw/
        vh7K2cUo8eDMcnaQKl4BO4kZ928xgtgsAqoSMzp2sEDEBSVOznwCZHNwiApES3S9NAYJCwvY
        Snz89AxsAbOAuMStJ/PBFosI+Ej8XnSYEWQ+s8AVJokpN3oZIZZNYJI41PcebBCbgJZEYyfY
        Xk4BY4nHMz6xQQzSlGjd/psdwpaX2P52DjPEB0oSC9vusEHYtRKf/z5jnMAoOgvJebOQ3DEL
        yahZSEYtYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJEZgOth37uXkH47xXH/UOMTJxMB5i
        lOBgVhLhnWnIlirEm5JYWZValB9fVJqTWnyI0RQYRhOZpUST84EJKa8k3tDMwNTQxMzSwNTS
        zFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgWnVl8kvY+cetKl0SInyrtye0JJ29/fkta5m
        ptn8U0x9Y1cvTn+fY2lzx9/2z7Eki/3zdja3idW/fdCwYItEK8fB+uBzM+eJCvmwXr4eWTXV
        bsnnbNmsyGr55Zyu15Zl+CVP/XtmYtoex8sX9KXveT3Y1b9XTJz9ked7fqvt1rfcxdK/nH5v
        dvW9xc/5Yo474zM27rGVtve00WVye6anY2yfLtmkIripIqFfwJX7xSYGickRSlaXpFJ+FRTJ
        7/PP+tDlHHrWxTItbQ7Lwk9flSttXqZw1WQxSp//2T410sh0c9KehI5PWbd6z/Vdia/+cu2d
        1r+spL/KJz6El3wtt57P+OiH1qyZnUuXu4nbKbEUZyQaajEXFScCAO6nMWyQAwAA
X-CMS-MailID: 20230918122924eucas1p122bce924223345533b05aed016357efa
X-Msg-Generator: CA
X-RootMTR: 20230918050749eucas1p13c219481b4b08c1d58e90ea70ff7b9c8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230918050749eucas1p13c219481b4b08c1d58e90ea70ff7b9c8
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
        <ZQd4IPeVI+o6M38W@dread.disaster.area>
        <ZQewKIfRYcApEYXt@bombadil.infradead.org>
        <CGME20230918050749eucas1p13c219481b4b08c1d58e90ea70ff7b9c8@eucas1p1.samsung.com>
        <ZQfbHloBUpDh+zCg@dread.disaster.area>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>
>>> As it is, I'd really prefer stuff that adds significant XFS
>>> functionality that we need to test to be based on a current Linus
>>> TOT kernel so that we can test it without being impacted by all
>>> the random unrelated breakages that regularly happen in linux-next
>>> kernels....
>>
>> That's understandable! I just rebased onto Linus' tree, this only
>> has the bs > ps support on 4k sector size:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=v6.6-rc2-lbs-nobdev
> 

I think this tree doesn't have some of the last minute changes I did before I sent the RFC. I will
sync with Luis offline regarding that.

> 
>> I just did a cursory build / boot / fsx with 16k block size / 4k sector size
>> test with this tree only. I havne't ran fstests on it.
> 
> W/ 64k block size, generic/042 fails (maybe just a test block size
> thing), generic/091 fails (data corruption on read after ~70 ops)
> and then generic/095 hung with a crash in iomap_readpage_iter()
> during readahead.
> 
> Looks like a null folio was passed to ifs_alloc(), which implies the
> iomap_readpage_ctx didn't have a folio attached to it. Something
> isn't working properly in the readahead code, which would also
> explain the quick fsx failure...
> 

Yeah, I have noticed this as well. This is the main crash scenario I am noticing
when I am running xfstests, and hopefully we will be able to fix it soon.

In general, we have had better results with 16k block size than 64k block size. I still don't
know why, but the ifs_alloc crash happens in generic/451 with 16k block size.


>> Just a heads up, using 512 byte sector size will fail for now, it's a
>> regression we have to fix. Likewise using block sizes 1k, 2k will also
>> regress on fsx right now. These are regressions we are aware of but
>> haven't had time yet to bisect / fix.
> 
> I'm betting that the recently added sub-folio dirty tracking code
> got broken by this patchset....
> 

Hmm, this crossed my mind as well. I am assuming I can really test the sub-folio dirty
tracking code on a system which has a page size greater than the block size? Or is there
some tests that can already test this? CCing Ritesh as well.

> Cheers,
> 
> Dave.
