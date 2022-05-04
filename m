Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D3B519AFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346709AbiEDJB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 05:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346121AbiEDJBU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 05:01:20 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF5A2C112
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 01:53:48 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220504085333euoutp017ba6ffce21438ec272299890e712e45c~r2vBNPNaP1979219792euoutp01B
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 08:53:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220504085333euoutp017ba6ffce21438ec272299890e712e45c~r2vBNPNaP1979219792euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651654414;
        bh=QkjMVZ7YuUw8jJhXQnJpcoFnlPYOWuxnkq5J+jf/yN8=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=SwX7PQomwR9Jxg5kgaLJn1V3BbAIEDAGNBF9dw/LpWo72I+64v2TBGhhngZu8do4l
         YVQIHqyZIIB2PCc7quDNenoFeJLOuCIsas9mjT49mvOmnHHY80AWC78AA0DUtO97q+
         nqUbUPqpfYurzajP+vWaOF9+YZ7NVzpTPZ4lFrno=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220504085333eucas1p10e28ba95f5c2a26ea4db6270247ad64b~r2vAoyEmn0813908139eucas1p1Y;
        Wed,  4 May 2022 08:53:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3F.B5.10260.D0F32726; Wed,  4
        May 2022 09:53:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220504085332eucas1p28b16e7db390eb2ffb2906ed2f2aa06b5~r2vAHVCh_1462414624eucas1p2y;
        Wed,  4 May 2022 08:53:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220504085332eusmtrp1117c59c1ab66ee22363450053dfd8684~r2vAF33E11107411074eusmtrp1T;
        Wed,  4 May 2022 08:53:32 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-a7-62723f0d3918
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 50.F7.09404.C0F32726; Wed,  4
        May 2022 09:53:32 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220504085332eusmtip1ef554c6afdc7b3b69842971ebc6d663b~r2u-6o-s51569915699eusmtip1e;
        Wed,  4 May 2022 08:53:32 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.170) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 4 May 2022 09:53:29 +0100
Message-ID: <850340eb-fc88-38a7-4c92-1c389e92b0ad@samsung.com>
Date:   Wed, 4 May 2022 10:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH 15/16] f2fs: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <axboe@kernel.dk>, <snitzer@kernel.org>, <hch@lst.de>,
        <mcgrof@kernel.org>, <naohiro.aota@wdc.com>, <sagi@grimberg.me>,
        <damien.lemoal@opensource.wdc.com>, <dsterba@suse.com>,
        <johannes.thumshirn@wdc.com>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <clm@fb.com>,
        <gost.dev@samsung.com>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <josef@toxicpanda.com>,
        <jonathan.derrick@linux.dev>, <agk@redhat.com>,
        <kbusch@kernel.org>, <kch@nvidia.com>,
        <linux-nvme@lists.infradead.org>, <dm-devel@redhat.com>,
        <bvanassche@acm.org>, <jiangbo.365@bytedance.com>,
        <linux-fsdevel@vger.kernel.org>, <matias.bjorling@wdc.com>,
        <linux-block@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <YnGK/8lu2GW4gEY0@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.170]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxjed249Lak7FJFPuulSnAlsoAx03zKkLszt6GZk/4y7FjlBslKh
        lW3qNksQkAZoAZFRQcSwjdvoaFG8UMKaAcpFFkux4IApoKaEiwFkHayOcjDj3/O+7/O87/N8
        +Whc0kAF0omqY5xapVDKKBFxpd3dGyqWq+O2F2f6IVNnO45qh/QUOjfjxlFXUQ+GCvQ/CNBi
        Ty+OrFPnSfTH32kYqq5tw9CYyYijnNYZAv2rG17unb6Po6X74ajA1g/QuMOIIevga+jOaJUA
        3bn0Pmq23iKQ/Xophcp/GhcgQ+Y8jpyGcYDyOywkqp+YJtDNQeluKWvv+4D13Kyj2Pz0KQHb
        O9xAsPaeVNZck02xFdoinLVUnmJvXJzF2BsDWorNTZ+i2GsZIyQ73eKgWFOjg2ANlgaSnTVv
        ivU9JIqK55SJX3HqbdFfiI487ntEJmf6fFPa6BFogZvWASENmUjosnVQOiCiJUwVgLfzcgm+
        mAPw7sKz1WIWwO5HC4LnEkPTyOrgZwAfdqX9zxrK76O8LAlzHcDf5nfqAE2LmWjYVrXB2yaY
        LfDy2XzgxWLGF94qGSO82J85CM8Zuykv3Y+JhcMZK/ZwJgAOjpVjXrx+WWq7ZBd4T+FMMwkb
        qu+RXj7FhMC07BVvwmU4bHaRvDYYZjQtCni8GTZNluK8/yBY6OzDePwd/KW9e2UnZAZEcG5i
        kvDuhMy7sLNiB8/xg66OxtXsL8GuwhyCxyfhuHMR57WnAdRfM1G89m2Y163kOe/ATP0FjG+v
        g85JX97OOlhwpRg3gFeNax7CuCaxcU0C45oEFwFRAwK4VE1SAqeJUHFfh2kUSZpUVULY4aNJ
        ZrD8q7s8HfNXQZXrSZgNYDSwAUjjsvXimB+T4yTieMXxE5z66OfqVCWnsQEpTcgCxIcTf1VI
        mATFMe5Ljkvm1M+nGC0M1GLyiHCfyastIfrdard8SPlP0Bmfp2+q+9V97m8L9mSlnOi/y1nq
        AZlgr8zevnVv1sOWpRr8gcvtvzd82GqcvW362NmifVCPxZEduT4qR+toxGe7DqagznRP1GOh
        pzf+1Jz7bGuZyecA80Lnp3Wjwdbo0NcXRsCflqzEyg8/iqpJUQVy06WxpqWBKGv16E7lRmmw
        LmjuSfF7te31JS9XPH3rxe9LcoCRNBV9srG5zrw5TLKvivJ3pP0VY8mtKyrfdDxyw+X9ZYZC
        l7xgz++LbZGhA2XnKdnMyZpnO96AYdHFB/R1u1qlrPMQLq8+o41hY7G8rXETiTEXtglfYcbg
        vX0yQnNEER6CqzWK/wAWnxgCRAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsVy+t/xu7o89kVJBs/OalusP3WM2WL13X42
        i2kffjJbnJ56lsliUv8MdovfZ88zW+x9N5vV4sKPRiaLlauPMlk8WT+L2aLnwAcWi79d94Bi
        LQ+ZLf48NLSYdOgao8XTq7OYLPbe0ra49HgFu8WlRe4We/aeZLG4vGsOm8X8ZU/ZLSa0fWW2
        uDHhKaPFxOObWS3WvX7PYnHilrSDtMflK94e/06sYfOY2PyO3eP8vY0sHpfPlnpsWtXJ5rGw
        YSqzx+Yl9R67F3xm8th9s4HNo7f5HZvHztb7rB7v911l81i/5SqLx4TNG1k9Pm+SCxCM0rMp
        yi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt4ceU5a0Eb
        d8WcLf/YGxh/cnQxcnJICJhITNh+n6WLkYtDSGApo0TzimVMEAkZiU9XPrJD2MISf651sUEU
        fWSUWL9oKSOEs4tRYu2jOUDtHBy8AnYSR1eIgTSwCKhIbJ0ykRHE5hUQlDg58wkLiC0qECHx
        YPdZVhBbWMBP4sHRy2ALmAXEJW49mQ+2WASo99AikDgXUHwPq8TGlbdZIZbdY5SYsu0JI8gy
        NgEticZOsGZOIPPeplesEIM0JVq3/4YaKi+x/e0cZogPlCUm37gC9VmtxKv7uxknMIrOQnLf
        LCR3zEIyahaSUQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEprltx35u2cG48tVHvUOM
        TByMhxglOJiVRHidlxYkCfGmJFZWpRblxxeV5qQWH2I0BQbSRGYp0eR8YKLNK4k3NDMwNTQx
        szQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgalp7I+v5v+ufFd/sXCqr/Kq8ctEG
        5WV+gtILyybMulX/f+ouXg1+dfZpNl3ht1+8ucSdYtPx7O0GqxeHFQ7WvZ5zfXt+Zv/Gld8e
        bNBXsVY4afir4YNhnueuSMOUS+yyPcZL1/47XjLp8PuPkw9Y/X8v9iXb44VRa5T1lmgLBQa7
        ZKXpSer1Nfmqh7ln3ljtsv6i2gOeMBbuoMz9s3cyGka+v7/7YNEkg9mR537zuS3fdYxJfG6u
        73SfI1wXVZJSihZZS+9Q0Ojuubj+jfOeGK1ekZkZnTOeiTEFHyzemdUntqZtnaKl5WPVtDMJ
        sXNTpn1OCf82a6250J27hhb/n0uH8ypfTPjhzJ0fGjlhmhJLcUaioRZzUXEiAIorxvr8AwAA
X-CMS-MailID: 20220504085332eucas1p28b16e7db390eb2ffb2906ed2f2aa06b5
X-Msg-Generator: CA
X-RootMTR: 20220427160312eucas1p279bcffd97ef83bd3617a38b80d979746
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160312eucas1p279bcffd97ef83bd3617a38b80d979746
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160312eucas1p279bcffd97ef83bd3617a38b80d979746@eucas1p2.samsung.com>
        <20220427160255.300418-16-p.raghav@samsung.com>
        <YnGK/8lu2GW4gEY0@google.com>
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2022-05-03 22:05, Jaegeuk Kim wrote:
> Applied to f2fs tree. Thanks,
>
Thanks Jaegeuk. I will remove the f2fs patches from my next revision

Regards,
Pankaj
> On 04/27, Pankaj Raghav wrote:
>> From: Luis Chamberlain <mcgrof@kernel.org>
>>
>> F2FS zoned support has power of 2 zone size assumption in many places
>> such as in __f2fs_issue_discard_zone, init_blkz_info. As the power of 2
>> requirement has been removed from the block layer, explicitly add a
>> condition in f2fs to allow only power of 2 zone size devices.
>>
>> This condition will be relaxed once those calculation based on power of
>> 2 is made generic.
>>
>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>  fs/f2fs/super.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index f64761a15df7..db79abf30002 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -3685,6 +3685,10 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>>  		return 0;
>>  
>>  	zone_sectors = bdev_zone_sectors(bdev);
>> +	if (!is_power_of_2(zone_sectors)) {
>> +		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
>> +		return -EINVAL;
>> +	}
>>  
>>  	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
>>  				SECTOR_TO_BLOCK(zone_sectors))
>> -- 
>> 2.25.1
