Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B00451FAE1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 13:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiEILG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 07:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiEILG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 07:06:27 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BB3184314
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 04:02:33 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220509110231euoutp017f54a81f075ad7466337050f673bde1c~tauCmkZ782876228762euoutp01y
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 11:02:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220509110231euoutp017f54a81f075ad7466337050f673bde1c~tauCmkZ782876228762euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652094151;
        bh=eRnf0CoH5S13LsLZ+gUV4c+ed3W57A7GuWCrr3sgnIo=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=C2KdSO3Ny3yn2BBrMvJBgM6QAcEz1k6M5zTBDCpVAzatXp/552glV1roZ14kxS1VO
         mxS8a4YApT+Ns1Ta1PYec+La4T8knbMEqJ4t0s42GS1m1PtVv65YihMR/yvSWPfQcp
         Oekkj0IVMBjmOpZthQb3RcpGgWfAR6G85MRU0rBg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220509110230eucas1p2bc1a54ccf4681a1cab65ccec40854f50~tauB8kytl1526915269eucas1p2W;
        Mon,  9 May 2022 11:02:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BE.10.10260.6C4F8726; Mon,  9
        May 2022 12:02:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220509110230eucas1p13e606c51930d58a88555e9c10ddc0095~tauBZ0unJ0402604026eucas1p17;
        Mon,  9 May 2022 11:02:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220509110230eusmtrp11af182cc213b7913b637d177288f7a8a~tauBYoRRA2398323983eusmtrp1z;
        Mon,  9 May 2022 11:02:30 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-98-6278f4c6cd7d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1A.4A.09404.5C4F8726; Mon,  9
        May 2022 12:02:30 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220509110229eusmtip154a297efbad58824866a49dc0219bcbb~tauBMVgfz1376713767eusmtip1-;
        Mon,  9 May 2022 11:02:29 +0000 (GMT)
Received: from [106.110.32.130] (106.110.32.130) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 9 May 2022 12:02:28 +0100
Message-ID: <c712f0d9-c7f8-172d-8bba-ca6d639bd7c0@samsung.com>
Date:   Mon, 9 May 2022 13:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH v3 00/11] support non power of 2 zoned devices
Content-Language: en-US
To:     <dsterba@suse.cz>, <jaegeuk@kernel.org>, <hare@suse.de>,
        <dsterba@suse.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <damien.lemoal@opensource.wdc.com>, <snitzer@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        <bvanassche@acm.org>, <linux-fsdevel@vger.kernel.org>,
        <matias.bjorling@wdc.com>, Jens Axboe <axboe@fb.com>,
        <gost.dev@samsung.com>, <jonathan.derrick@linux.dev>,
        <jiangbo.365@bytedance.com>, <linux-nvme@lists.infradead.org>,
        <dm-devel@redhat.com>, Naohiro Aota <naohiro.aota@wdc.com>,
        <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        Alasdair Kergon <agk@redhat.com>,
        <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
        "Keith Busch" <kbusch@kernel.org>, <linux-btrfs@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220506100054.GZ18596@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.130]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxTVxzN7Xt9fXS2PIqGK7CQVVGp4Wtj5C4jZANlL9M/TAzJdHFbkRcg
        lootMAZzlKFuIqO0CrqKA/kYlI/yObCUyuy0CNSxyWCsKoMAGcOJ6IqUwGCUhwn/nXvO+f3u
        OTeXxERNhDeZJE9lFHKpTEzw8Xbr4kCg1ZERF9K7ugM19lkxtNplJVDdIzWBiucWMaRVX+Gh
        pXsDGDLPXuWiX5w5HFSxtICjrnItB+nr7nDQZKMOQ/k/zuFIf2YcQ8vjoWjcYceR1jIM0NSQ
        joPM9r3o/kQND3WZe3E02FlCoNLvp3io8Nw8hjQ9rVxkePwUR3ftPu/40IO/HaBX7tYTtCZ3
        lkcPjDbj9OC9NLql9jxBX1cVYXRrZTZt+kNF0N/kzhK08eyfXPrpzSGCbmwbwmlb2W0e3dqf
        RRe2NnMPiY7yI+IZWVI6owiO/ISfOHyxnZMy7Z5xf95IqEDTljxAkpAKg8UmrzzgRoqoGgBv
        mw7nAf4adgDYOqLG2cO/AP78zAReDuht4SxfDWDVl80YO71mmq4LZoVOAC8VGAiXIKAiYUdR
        9boJp3ZCU7MesLwH7P12EnfhbdQHsFhnW/d7UlGwcPSrdYxRXtA+WcpxLd1KNRBworue50pB
        UBKYc57n8rhRgXCix7nhD4BnO5Z4LPaDHU9KMDa0GF4dDHLRkDoNG6w2nmslpIb4cKzsGo8V
        9kGHdXUDe8KZnrYN7Av7L+bjLM6CUyNLGDt8BkC1sZFgL3gbFthkrOddONo5z2VpIRx54sHG
        EUJt++WNOAL49TlRIdip2/QQuk2FdZvK6DaVKQN4LfBi0pTJCYzyDTnzaZBSmqxMkycEHT+Z
        3ALWPnX/Ss/8DVAz8yzIAjgksABIYuKtgu6CjDiRIF76WSajOPmxIk3GKC3Ah8TFXoLjSU1S
        EZUgTWVOMEwKo3ipckg3bxUntjPQua+9suJ9o8fy7MHKNw0hGTNfNK647X19LMLTmZN+qkn+
        alqk4724OXdHwLbdVZ3+RfuDB7cbnZ7cajIsn/x8j9Gv31+uLXFvS7rmd/1ovYw7Fhsvs/+X
        u/81SUBVgi1st/lWbNCCUBtdduTYFsPl3pXttb4Xok+I/4nCUjQNwo+iZQ9M4ELeYvCOW/CA
        RGARMznx3jHZiY+UHlkfdv/6sHzMOuDve6cl6xXDcLrxhwc1wgVl+KFjmbumIzw0Haee75E8
        PK0PqDWXhP+kualKPQxivlOXymOk9sy/Z0L7XvQ9l9zoann8+3KFueCvK28RUnF538GxqDB9
        SMiLbG93Ma5MlIZKMIVS+j9fHR+FQwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsVy+t/xu7rHvlQkGfSsZbRYf+oYs8X/PcfY
        LFbf7WezmPbhJ7PFpP4Z7Ba/z55nttj7bjarxYUfjUwWi39/Z7HYs2gSk8XK1UeZLJ6sn8Vs
        0XPgA4vFypaHzBZ/HhpaPPxyi8Vi0qFrjBZPr85isth7S9vi0uMV7BZ79p5ksbi8aw6bxfxl
        T9ktJrR9ZbaYeHwzq8W61+9ZLE7cknaQ9rh8xdvj34k1bB4Tm9+xe5y/t5HF4/LZUo9NqzrZ
        PBY2TGX22Lyk3mP3zQY2j97md2weO1vvs3q833eVzWP9lqssHmcWHGH32Hy62mPC5o2sAUJR
        ejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnXJm9j
        KnjBX3Hp6062BsYNPF2MHBwSAiYSK8+YdTFycQgJLGWUaD13mrWLkRMoLiPx6cpHdghbWOLP
        tS42iKKPjBJPu6ayQji7GCU+z77JDFLFK2AnsX3qcjCbRUBFYvfGlYwQcUGJkzOfsIDYogIR
        Eg92nwXbICzgJDHhXjsbiM0sIC5x68l8JpChIgJr2SQe71/DDrFhA6PEjmXTGEFuZRPQkmjs
        BDuJU0BX4vHxH1DNmhKt23+zQ9jyEtvfzmGGeE1JYvZlPYgPaiVe3d/NOIFRZBaSk2YhWT0L
        yaRZSCYtYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJEZjOth37uWUH48pXH/UOMTJxMB5i
        lOBgVhLh3d9XkSTEm5JYWZValB9fVJqTWnyI0RQYLhOZpUST84EJNa8k3tDMwNTQxMzSwNTS
        zFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgUnytc+ZJTIRTpWOMzxXHFJzrH6i9rUxoGv/
        HRnttxeEa+zOiTtf2DZt6Xtrf0fZJ1v5dhabvV96ftvl1W/SpIpFGmNkbIR6FjyevGrKLfFU
        Mfu5PX49a0ptmfuDtH9s/eVZeDvovERPtdOqF07vE8W0twuw/pi+ONmE7c3KmglNXjo7zpmF
        b07VvaHy+NMXxy7+85/KTi9ePWdFRmOk9/XksBeTwx9H6E98aiJV+oGbvyot+9/M2NLf4eo+
        /jLe05bk2F7fwcLFdP8p6+qZAm9UPfYLv7+44F9FH3/lfMkXt3dYHnzoFsVyQOO26/e95w8Y
        zO+NZGr9pCXZkfJQ4ezy68+5BY8xGWb2vg080qbEUpyRaKjFXFScCADdeNjb8AMAAA==
X-CMS-MailID: 20220509110230eucas1p13e606c51930d58a88555e9c10ddc0095
X-Msg-Generator: CA
X-RootMTR: 20220506081106eucas1p181e83ef352eb8bfb1752bee0cf84020f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081106eucas1p181e83ef352eb8bfb1752bee0cf84020f
References: <CGME20220506081106eucas1p181e83ef352eb8bfb1752bee0cf84020f@eucas1p1.samsung.com>
        <20220506081105.29134-1-p.raghav@samsung.com>
        <20220506100054.GZ18596@suse.cz>
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-05-06 12:00, David Sterba wrote:
>>   The current approach for npo2 devices is to place the superblock mirror
>>   zones near   512GB and 4TB that is **aligned to the zone size**.
> 
> I don't like that, the offsets have been chosen so the values are fixed
> and also future proof in case the zone size increases significantly. The
> natural alignment of the pow2 zones makes it fairly trivial.
> 
> If I understand correctly what you suggest, it would mean that if zone
> is eg. 5G and starts at 510G then the superblock should start at 510G,
> right? And with another device that has 7G zone size the nearest
> multiple is 511G. And so on.
> 
> That makes it all less predictable, depending on the physical device
> constraints that are affecting the logical data structures of the
> filesystem. We tried to avoid that with pow2, the only thing that
> depends on the device is that the range from the super block offsets is
> always 2 zones.
> 
> I really want to keep the offsets for all zoned devices the same and
> adapt the code that's handling the writes. This is possible with the
> non-pow2 too, the first write is set to the expected offset, leaving the
> beginning of the zone unused.
> 
I agree. Having a known place for superblocks is important for recovery
tools. We were thinking along the lines of what you have suggested. I
will add this support in the next revision.
>>   This
>>   is of no issue for normal operation as we keep track where the superblock
>>   mirror are placed but this can cause an issue with recovery tools for
>>   zoned devices as they expect mirror superblock to be in 512GB and 4TB.
> 
> Yeah the tools need to be updated, btrfs-progs and suite of blk* in
> util-linux.
> 
>>   Note that ATM, recovery tools such as `btrfs check` does not work for
>>   image dumps for zoned devices even for po2 zone sizes.
> 
> I thought this worked, but if you find something that does not please
> report that to Johannes or Naohiro.
Ok. Thanks.
