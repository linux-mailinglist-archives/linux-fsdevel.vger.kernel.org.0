Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF6A513912
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349638AbiD1P5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 11:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245430AbiD1P5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:57:49 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273F6B82E6
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 08:54:34 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220428155431euoutp022e72041acbdba580c993c03564afef33~qGm2bDChw2795627956euoutp02W
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 15:54:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220428155431euoutp022e72041acbdba580c993c03564afef33~qGm2bDChw2795627956euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651161271;
        bh=mSww8MNcP9LQau6omtTYAJnuYJvatHm4P/3v9FrFuEQ=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=jX2mVvFSVhV+1u6Dfhpw1ePk0ekW0o6bIDhBkl0cs93PHfA0RNjCvczdJESBLMvmZ
         3QrHyJ6AMVWa9T7Ttoa+2sV0+6JEeCBq7qsfkmz/JuBmT9X5m/AQu4Ozkxz4lzmxsS
         uLrXbc6Oj+Gj296oBFsAmHn1yU8xlXftBVxJTOzo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220428155430eucas1p264e9d46e67a3b87a5f04612884dcf590~qGm195CMC1962619626eucas1p2j;
        Thu, 28 Apr 2022 15:54:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8E.9C.09887.6B8BA626; Thu, 28
        Apr 2022 16:54:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220428155430eucas1p19843a8820764ea2bff4c8e828ab4c77d~qGm1ejomq0861808618eucas1p1v;
        Thu, 28 Apr 2022 15:54:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220428155430eusmtrp1084ab273f286eb108908e2488bc3d4b6~qGm1dczfx2007420074eusmtrp18;
        Thu, 28 Apr 2022 15:54:30 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-d8-626ab8b6a3f7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C5.E6.09404.6B8BA626; Thu, 28
        Apr 2022 16:54:30 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220428155430eusmtip2101d0f2ab9ec7ad016c58052efc89d15~qGm1ROzsV0803308033eusmtip2k;
        Thu, 28 Apr 2022 15:54:30 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.162) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 28 Apr 2022 16:54:27 +0100
Message-ID: <c490bd45-deab-8c2b-151c-c8db9f97e10c@samsung.com>
Date:   Thu, 28 Apr 2022 17:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH 12/16] zonefs: allow non power of 2 zoned devices
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jaegeuk@kernel.org>, <axboe@kernel.dk>, <snitzer@kernel.org>,
        <hch@lst.de>, <mcgrof@kernel.org>, <naohiro.aota@wdc.com>,
        <sagi@grimberg.me>, <dsterba@suse.com>,
        <johannes.thumshirn@wdc.com>
CC:     <linux-kernel@vger.kernel.org>, <clm@fb.com>,
        <gost.dev@samsung.com>, <chao@kernel.org>, <josef@toxicpanda.com>,
        <jonathan.derrick@linux.dev>, <agk@redhat.com>,
        <kbusch@kernel.org>, <kch@nvidia.com>,
        <linux-nvme@lists.infradead.org>, <bvanassche@acm.org>,
        <jiangbo.365@bytedance.com>, <linux-fsdevel@vger.kernel.org>,
        <matias.bjorling@wdc.com>, <linux-block@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <bfc1ddc3-5db3-6879-b6ab-210a00b82c6b@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.162]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxTVxzd7Xt977Wj5IE1XHFhC34kgwz8Ct4wwuY25GW6SefC5v5Qi7xR
        GCBrxW2KrkodUtxaC6I2RGSiTBQZpcNKrWM1FKEtIF2XDgMOA6JMvgKbZUW3ltcl/HfO+Z3z
        u/fcXAoLv0hEUtn5+1h5vjQ3mhDiLba5ntdaTDkZa7p716DGLhuGrgxoCFQ5NYch+yknD+k0
        Z0jkc/ZgqNd7hIcuX2nnoeFGPYZOtE3h6Jl60K+phjA0P7QW6ay/ATTi1vOQpT8W3bR04sjV
        WkWg6ksjJNJ+8xeGPNoRgE52NPPRtT8ncXSnf/mbkHH9uoV5fucqwZwsniCZnsEmnHE5CxlD
        fSnB1ChPYUxz7deM+XclwXxbPEEwN47d5zOTt9wE02h044y2uYnPzBiimJK2Ml4a/YkwKZPN
        zd7PyuOTdwtlpuIZssBNfelWPiSV4AmhBhQF6Q3wshGpgZAKp38A0NPeSXBkFsA+azFQA4Gf
        zADo+wkFcCAwVz6OcaY6ANUNuiDxm2qrS4LEDGDXExUeiIjoZOj6Rb9wHk6vgi7HIU4Og51n
        hxcsS+mPYaXeQQTwEjoFmhv+XdAxOgL2D1fzAjvFtA9AV/cEP0AwWoXByYd9ZGApQcfAI6Vk
        ICCgN8PRyu8JLvwqPHbdR3L4ZXh9vArjKqzwVygjOXwINtgcZGAnpNuFsLrJyOcG78C5f+YB
        h5fAsQ5jMPAStJefwDl8EI54fBgXVgGoudEYfNXX4XeOXM6zCU6XKINyKPSMh3H3CYW6ltOY
        FqzSL3oL/aLO+kUV9IsqnAd4PYhgCxV5WaxiXT77RZxCmqcozM+K27M3zwD8P9n+vGPWBOrG
        puOsgEcBK4AUFi0WzZplGeGiTOlXB1j53l3ywlxWYQXLKTw6QrQn+0dpOJ0l3cd+xrIFrPz/
        KY8SRCp5NbOPRnVFpab6gZ0f+AzX9u/wmjZ0H+9kvA9uG34u2/p5snbbffKcSjQUn2B9V+eM
        FVfsiDrcJji68XF3yr1RVCNJ3HjQdsuxuq/lLedxiRO23ux6O7XBm6GRvaIXxZ7bLPFWuZ7u
        tFjOgNWPPxSTu1SD5W9clFhyps/LJMs+zevVrchYv2xwxi5KeNZVZU9MEx8m7SG1Iakhho8y
        c0JWpsevn5c/2n02rHnL1UhBW+rSqfRNUwNRp0Pv2orqkkKN91qn4yIvwa3SbFSRuP12vMlb
        diE24X3sPerFdZOaAekff08kDPU9KCiKSbdse2HefPTpWKrmrj7JWKFJW5mSdMATjStk0rUx
        mFwh/Q9mQStiOAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsVy+t/xe7rbdmQlGXz9KWSx/tQxZovVd/vZ
        LKZ9+MlscXrqWSaLSf0z2C1+nz3PbHHhRyOTxcrVR5ksnqyfxWzRc+ADi8XfrntAsZaHzBZ/
        HhpaTDp0jdHi6dVZTBZ7b2lb7Nl7ksXi8q45bBbzlz1lt5jQ9pXZ4saEp4wWE49vZrVY9/o9
        i8WJW9IOEh6Xr3h7/Duxhs1jYvM7do/z9zayeFw+W+qxaVUnm8fChqnMHpuX1HvsvtnA5tHb
        /I7NY2frfVaP9/uusnms33KVxWPC5o2sHp83yXm0H+hmChCI0rMpyi8tSVXIyC8usVWKNrQw
        0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvY0fyZveAqR8XVhmfsDYxv2LoYOTkk
        BEwkfk5+y9zFyMUhJLCUUWLWvwdQCRmJT1c+skPYwhJ/rnWxQRR9ZJRYNf8TI4Szm1HiyKyv
        rCBVvAJ2EpcPzgKq4uBgEVCVuHymFiIsKHFy5hMWEFtUIELiwe6zYOXCAq4Su9f+B4szC4hL
        3HoynwlkpojAb0aJy+fesYI4zAItzBLvn11ih9j2h1Fix8KZYBvYBLQkGjvBzuMUcJN4Pm0R
        G8QkTYnW7b/ZIWx5ie1v5zBDvKAM9Gc31Du1Eq/u72acwCg6C8mBs5AcMgvJqFlIRi1gZFnF
        KJJaWpybnltspFecmFtcmpeul5yfu4kRmMy2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuH9sjsj
        SYg3JbGyKrUoP76oNCe1+BCjKTCQJjJLiSbnA9NpXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQ
        QHpiSWp2ampBahFMHxMHp1QDU42HXeK/o26lG6Z6tqRGbriU98GmXD43Ut1WbO5O8+d2l1N/
        nYnedqp67033uQyv56otsIuLUlV9Oe+mjmZHRffF36xPy+S3n9y1Z1rXAv5wtqqIzJfCs+rn
        sovPLOG5aXRqoUoqg87fxa+6Tj+JYer5yZp67WDedsvwfyFbcpk2zOlcrTXN2Yzj4fdVrpbp
        e//rpbGZlllIbprv9exjX3mK2Przq/iesizNiIgyZhHfuU9HzjZMsnehh5N6j+Ln1yzxU8+p
        n9Z682zPkhBXi5LrSgvai7bddLq6XaWv56nd1MmpH278PRP791bV8Z28Gv9Ltj8//enfe/0D
        wXOvlDfPlqtZ8qtD2OGTmT1DrhJLcUaioRZzUXEiAIHUKb3vAwAA
X-CMS-MailID: 20220428155430eucas1p19843a8820764ea2bff4c8e828ab4c77d
X-Msg-Generator: CA
X-RootMTR: 20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44@eucas1p2.samsung.com>
        <20220427160255.300418-13-p.raghav@samsung.com>
        <bfc1ddc3-5db3-6879-b6ab-210a00b82c6b@opensource.wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-04-28 01:39, Damien Le Moal wrote:
> On 4/28/22 01:02, Pankaj Raghav wrote:
>> The zone size shift variable is useful only if the zone sizes are known
>> to be power of 2. Remove that variable and use generic helpers from
>> block layer to calculate zone index in zonefs
> 
> Period missing at the end of the sentence.
> 
Ack
> What about zonefs-tools and its test suite ? Is everything still OK on
> that front ? I suspect not...
> 
I don't know why you assume that :). Zonefs had only one place that had
the assumption of po2 zsze sectors:
if (nr_zones < dev.nr_zones) {
	size_t runt_sectors = dev.capacity & (dev.zone_nr_sectors - 1);

In my local tree I changed it and I was able to run zonefs tests for non
po2 zone device. I have also mentioned it in my cover letter:
```
ZoneFS:
zonefs-tests.sh from zonefs-tools were run with no failures.
```
I will make sure to add my private tree for zonefs in my cover letter in
the next rev. But even without that change, a typical emulated npo2
device should work fine because the changes are applicable only for
"runt" zones.
