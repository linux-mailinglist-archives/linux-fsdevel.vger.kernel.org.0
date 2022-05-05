Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F351B8F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 09:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344173AbiEEHcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 03:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344682AbiEEHcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 03:32:31 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4924754D
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 00:28:51 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220505072849euoutp02ab8365b5e00a45ec26f64438c07fbe4f~sJOTxCXYU2921629216euoutp02k
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 07:28:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220505072849euoutp02ab8365b5e00a45ec26f64438c07fbe4f~sJOTxCXYU2921629216euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651735729;
        bh=j19LG41QlgQqZ+lZFqrhtRma1C1jIg9OOFvDpBlTex4=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=qSK450mxwZZbcleGzZAl+PCJRc4osU6wshdEJje4Fgn9KOe9lVv4T6FR/JKhixwvP
         qKNh0rcCqoXrfZmcJVv2aZQ+mnheRHSPM/uVx2YzEJ1YQal8PeNEd5Pf01PDAaE7JJ
         KA9nLDxF4tAnrPXEbFnp5IxetDXPhhCXa7q3Ov+M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220505072848eucas1p1d66f136b7b1226351171cd4dd1152d26~sJOTKK_DF2541325413eucas1p1z;
        Thu,  5 May 2022 07:28:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B4.15.09887.0BC73726; Thu,  5
        May 2022 08:28:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220505072847eucas1p27c50364580d96918bc2a59b6877671ba~sJOSvbf6V0726607266eucas1p2b;
        Thu,  5 May 2022 07:28:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220505072847eusmtrp2acdb61270717097424f910760caaa9a7~sJOStu9m32757327573eusmtrp2B;
        Thu,  5 May 2022 07:28:47 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-26-62737cb08449
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 73.0D.09404.FAC73726; Thu,  5
        May 2022 08:28:47 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220505072847eusmtip133d8624e020309d5e17197a6d3fce6cd~sJOSiJ1WZ1867518675eusmtip1m;
        Thu,  5 May 2022 07:28:47 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.170) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 5 May 2022 08:28:44 +0100
Message-ID: <fe8746d5-f7c4-efd6-b4a6-e198f6d95813@samsung.com>
Date:   Thu, 5 May 2022 09:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH 00/16] support non power of 2 zoned devices
Content-Language: en-US
To:     David Sterba <dsterba@suse.cz>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "clm@fb.com" <clm@fb.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "agk@redhat.com" <agk@redhat.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220504211440.GU18596@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.170]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxjed87pOaedkGOB8K2wbMOxcZk4yJJ9G5sDN+dJRtQfbGMmRiuc
        AI5yaenmmKZ0KFEY4+IFd0Rg3rCIFoEUqVwEpAgWXYA6JFrmKAkWqd1AkRRxtIct/Hve55L3
        fb58NC41kjI6NT2bU6bL04JICWEwzd9aW79Xtevd0iop0vebcHThfjGJjjnncXTz6ACGyoqP
        U8g1cBtHbY4TIvT7My2GTrvmCKS70IMhm57H0c/XnAR6XmDFkG7/AxwtPIhEZV13AJqw8Bhq
        Gw1Hg+PnKTR4ahNqbesj0JCxgkRV5yYoVJL/BEcjJRMAlfY2itClqccEujEaEBPIDg1/wS7e
        qCPZ0jwHxd62XibYoQE121B7iGR/yz2Ks41nNOzV6hmMvXo3l2SL8hwk23JgTMQ+breQrL7J
        QrDm6usUW9J4WbRVuk3yURKXlvodp1y3fqckZfKci8rsp/YYzA0gFxSRBUBMQ+Y9eG2hYQlL
        aClzHsCJwfuEMMwCaC3rWR5mAGxfyPs/8nSmiRKEGgCnrAaRW/C4bK0bBcEIoHM435PwYtbD
        uzWdhBsTzJuwcGx+mV8N+361eXg/JgEe480e3of5BF40zmJujDP+cNRW5cG+TBCsNFkw9wKc
        cUmgo7VyaTNNk0wY1B6i3B4xsxYeqejHhWwoPNDsogT8GmyersCFBmvg4ZFhTMD74EWT2dMG
        MpMS+MeJ08umz2DBi/Jlkw+09zZRAg6EL1qqlvkf4cSICxfC+wEsbtGT7oMgEw1/MacJnlj4
        Z5FNJNDecGR6tXCPNywzlOMlIJhf8RT8isr8igr8igrVgKgF/pxapUjmVFHp3PcRKrlCpU5P
        jkjMUDSApe99c7F39gqosf8d0QUwGnQBSONBvl6fns3cJfVKkv+QwykzdijVaZyqCwTQRJC/
        V2JqvVzKJMuzuW85LpNT/qditFiWi9VHWTd3NNfVGQoSAyLj7PH6O1mZEnF3yOB2/i8yUTG3
        o+M6r9k+3rNzxhA78E9e2qq5KeZhsdT+isw3sCZasTfE76zlJ8OXhYrBRwlbgrOfD8s0b4un
        D6ptYdMv51AObfSa/vKOW88SNogiOsMveXUfH+OzNmzN73WqU/OzdLEZB2UaLVF4ZHHVWzJr
        /MhL2Y/inPu2iaiN9R+caQgNd9KvmqIaO0VGy0Of8Th7RHDV6+HajP43Pv7Q4H3PmFPGvXMl
        ZtzvpObrb3ZbYp4CmqytXPc+3x5rD6xVn+oOTfqqNUVXVPx54ea6Jw6nbjIxku4R7/YOc9wb
        Cqm37tnUF58SRKhS5JFhuFIl/xeMBbOtTQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsVy+t/xu7rra4qTDDa0GVusP3WM2WL13X42
        i2kffjJbnJ56lsliUv8MdovfZ88zW+x9N5vV4sKPRiaLxb+/s1isXH2UyeLJ+lnMFj0HPrBY
        /O26x2SxsuUhs8Wfh4YWkw5dY7R4enUWk8XeW9oWlx6vYLe4tMjdYs/ekywWl3fNYbOYv+wp
        u8WEtq/MFjcmPGW0mHh8M6vFutfvWSxO3JJ2kPG4fMXb49+JNWweE5vfsXucv7eRxePy2VKP
        Tas62TwWNkxl9ti8pN5j94LPTB67bzawefQ2v2Pz2Nl6n9Xj/b6rbB7rt1xl8Tiz4Ai7x4TN
        G1kDhKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0
        Ml4s+81ecIq9YtuZTYwNjL1sXYycHBICJhLfPm9h72Lk4hASWMoocXXLJqiEjMSnKx/ZIWxh
        iT/Xutggij4ySsz61cIM4exilPj05DdYFa+AncTN5QdZQGwWARWJ7vs/2SDighInZz4Bi4sK
        REg82H2WFcQWFrCXWLvrCxOIzSwgLnHryXwwW0RASWLesatgtpDATiaJR99iQJYxC/zkkpj5
        uRFoMwcHm4CWRGMn2F5OAV2JKXNOMUPM0ZRo3Q5xD7OAvMT2t3OYIT5Qlph84woThF0r8er+
        bsYJjKKzkJw3C8kZs5CMmoVk1AJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBKW/bsZ9b
        djCufPVR7xAjEwfjIUYJDmYlEV7npQVJQrwpiZVVqUX58UWlOanFhxhNgWE0kVlKNDkfmHTz
        SuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYPJye+xrfntSvZ258
        sj6QJ9fgXaL0leeRGjbXc2Z27Emf8VX0/e7QfR3TnWf9nXBUmW1d3O05uo/j9ub9Xv+do/+c
        6k+Xz5Ncz6auZj7aEKfMKPCOLZH/r4iFUtiBjKMlDRwBTp+tOK/Eq/yU/GDnG3Juaej7f7c9
        32dmfnFOOtLQFn3ZwdynzppHc+uk5ZVL7ktFvw/KOpx5UzHl3601M7+fPD7P8ac8e2Kl6nvL
        qZ5LLqyY9XS+sreS5fy62uavc7R6Y8t6O8xzT3hWGIR517PbPPu33uTrLOvmbsGnEdf39hW2
        Hr8b+t6/Yu9yK/NfD2vdi45rWb9xTXYKSbueFt7nJ526oeeI8lJrUSclluKMREMt5qLiRABk
        5eXBAgQAAA==
X-CMS-MailID: 20220505072847eucas1p27c50364580d96918bc2a59b6877671ba
X-Msg-Generator: CA
X-RootMTR: 20220427160256eucas1p2db2b58792ffc93026d870c260767da14
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160256eucas1p2db2b58792ffc93026d870c260767da14
References: <CGME20220427160256eucas1p2db2b58792ffc93026d870c260767da14@eucas1p2.samsung.com>
        <20220427160255.300418-1-p.raghav@samsung.com>
        <PH0PR04MB74167FC8BA634A3DA09586489BC19@PH0PR04MB7416.namprd04.prod.outlook.com>
        <a702c7f7-9719-9f3e-63de-1e96f2912432@samsung.com>
        <20220504211440.GU18596@suse.cz>
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-05-04 23:14, David Sterba wrote:
>> This commit: `btrfs: zoned: relax the alignment constraint for zoned
>> devices` makes sure the zone size is BTRFS_STRIPE_LEN aligned (64K). So
>> even the npo2 zoned device should be aligned to `fs_info->sectorsize`,
>> which is typically 4k.
>>
>> This was one of the comment that came from David Sterba:
>> https://lore.kernel.org/all/20220315142740.GU12643@twin.jikos.cz/
>> where he suggested to have some sane alignment for the zone sizes.
> 
> My idea of 'sane' value would be 1M, that we have 4K for sectors is
> because of the 1:1 mapping to pages, but RAM sizes are on a different
> scale than storage devices. The 4K is absolute minimum but if the page
> size is taken as a basic constraint, ARM has 64K and there are some 256K
> arches.

That is a good point. I think it is safe to have 1MB as the minimum
alignment so that it covers all architecture's page sizes. Thanks. I
will queue this up.
