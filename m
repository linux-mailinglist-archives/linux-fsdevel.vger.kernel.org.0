Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37617AEAED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 12:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbjIZK6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 06:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbjIZK6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:58:46 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C76101
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 03:58:38 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230926105834epoutp01c241915920955560799f337aa931e75b~IbbwK87j33011130111epoutp01a
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 10:58:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230926105834epoutp01c241915920955560799f337aa931e75b~IbbwK87j33011130111epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695725914;
        bh=baHEKm/JhwHxKUMAHa2f809vp0ZdVYLW1aHpggC6chk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H2TTfIRZsc+b2dflGjm3seBo1Tq8V35px32Q2Rm38YURo3VAxYyvWTQ843p9+v8oJ
         kO7a783NEYLDE9Xfo69VAMP6kHAGjRTm/F9NqAdKjGUSa7MhwpT0J/vnZmLA00F0On
         hAEv+o4l7OLIZkfiLJf35n3ceILMDWyG0hdDOzns=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230926105833epcas5p39c4d5952102ceb27176b612d9882d254~Ibbvg8Iu21175911759epcas5p3X;
        Tue, 26 Sep 2023 10:58:33 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RvxYg4YLfz4x9Pp; Tue, 26 Sep
        2023 10:58:31 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.4A.09023.759B2156; Tue, 26 Sep 2023 19:58:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230926101329epcas5p2008e3144f177f1c88aeb2302a22488e8~Ia0Y6vcOg1077010770epcas5p2Y;
        Tue, 26 Sep 2023 10:13:29 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230926101329epsmtrp25d97cb68c034b365e2834f3b78c445c2~Ia0Y5ebse0140601406epsmtrp2x;
        Tue, 26 Sep 2023 10:13:29 +0000 (GMT)
X-AuditID: b6c32a44-c7ffa7000000233f-4e-6512b957578e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.7E.18916.8CEA2156; Tue, 26 Sep 2023 19:13:28 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230926101325epsmtip2cfcf64a0696d90208e1d465522eeae77~Ia0VrCoTp2661926619epsmtip2q;
        Tue, 26 Sep 2023 10:13:25 +0000 (GMT)
Date:   Tue, 26 Sep 2023 15:37:18 +0530
From:   Nitesh Jagadeesh Shetty <nj.shetty@samsung.com>
To:     Jinyoung Choi <j-young.choi@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        "anuj1072538@gmail.com" <anuj1072538@gmail.com>,
        SSDR Gost Dev <gost.dev@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Vincent Kang Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v16 04/12] block: add emulation for copy
Message-ID: <20230926100718.wcptispc2zhfi5eh@green245>
MIME-Version: 1.0
In-Reply-To: <20230922130815epcms2p631fc5fc5ebe634cc948fef1992f83a38@epcms2p6>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHvX2P18JWffJjXH5sNCUmw43SOlouBKYbiG9KGJuZJssWeNIX
        SiiltEVk2SaUMX4NC4iIZRswfglO0CqGH5YREFGcA0P41YwtSqkGIiBCTEDYWgrG/z7nm+85
        555z7+Vgzga2JydRoWFUClrOJ5zwG31+7/of73BmhHmjPqh18DaGnq2s4UhbvI6hS1M6As31
        LQFk7skFyDhf6YAmezpYqOlSPwsV6doIVNo7BtDMqJ6FjKb3UM2PdTi6abyLo5HOnwlU1TDD
        RoXj7QRqHNhgoYniGYDazVkAtcwt4OiOyQtNF+YBNLQ+4HDAg+rQT7GpoX+u4tTI/TTK0JxP
        UNfqTlNdk5kEVXvmrANVlD1PUM9mTDi10D1KUGeuNwPqueEdymB+yorhfpkUKmNoKaPiMYr4
        FGmiIiGMf+RobHisWCIU+YuCURCfp6CTmTB+RFSMf2Si3LoEPu8kLU+zSjG0Ws0P+DBUlZKm
        YXiyFLUmjM8opXJloFKgppPVaYoEgYLRhIiEwn1iqzEuSfbkfBemnN916uG5HnYmWH2zADhy
        IBkIH/3WiBcAJ44z2QXg3GMLYQ+WADw/u8p+FSzeXgDbKTOdVVuuDgC1SyNbgQXA6juTbJsL
        J/fA5db/cBsTpBh2Xc22MofjSr4Pc5p9bX6MrObA7vHLm1V3kPuhYdCw6XchQ2Gb7ibb5ueS
        Eph1y8Umc8nd8O4F86bFkYyGL2uLCBu7kd6won4Fs9WE5F+O0PTn5a2TRsDSyUmWnV3g7MB1
        tp094fN5I2HndNhUdpGwJ/8AoH5cv5W8H+YM6jAbY6QMDuZpcbv+Njw32MKy6zth0Zp5qwEX
        tv+6zb7w99bqrQYecOxFFmEbBpIUzL7ytX1ZLwBsWKwAxYCnf204/Wvt7BwC8xe1Dnb2gdlt
        lZjeWgojvWDjBseOfrC1M6AaEM3Ag1GqkxOYeLFSpGDSX72E+JRkA9j8PHsj2sFE1YagF7A4
        oBdADsZ35a5adjLOXCmd8Q2jSolVpckZdS8QW++wBPN0i0+x/j6FJlYUGCwMlEgkgcEfSER8
        d+5czi9SZzKB1jBJDKNkVNt5LI6jZybLYjpUl1p6xPuCJFdOJziZSm598tgpIH1p2OfQk28/
        DqYulrP27DTum1+WZXlMxVe6X5nr1ZoeYILhlZVOJmhAW3bYuHsy5DB6OEa/LAGP1u753+uv
        r9Hsarj/hv5f43dnJZ7XnAbzYhOjDNEwKLTz0/b6qMVUS7NefkITzv+sKtK84C70WZeqvhju
        T8gUYHGuT9mp47N9otMnE3O+51EbuqaDVMGJsgcDx8SkpU9mKTwA3JZrjFVffS7THfP33dES
        R9JN/WErSx7mGMn6jQz3Cqib/kMQzB9am/b7W8nxrT0e/ZE0OfxUt69Xfu5PR2MmMiLdyrve
        Chvz1rS0NZTzcbWMFu3FVGr6f5m9k7TFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7bCSvO6JdUKpBj3PrCzWnzrGbPHx628W
        i6YJf5ktVt/tZ7N4ffgTo8WTA+2MFnvfzWa1uHlgJ5PFytVHmSx6+7eyWUw6dI3R4unVWUwW
        e29pWyxsW8JisWfvSRaLy7vmsFnMX/aU3aL7+g42i+XH/zFZ3JjwlNFix5NGRot1r9+zWJy4
        JW3xuLuD0eL83+OsDpIeO2fdZfc4f28ji8fls6Uem1Z1snlsXlLvsftmA5vH4r7JrB69ze/Y
        PD4+vcXi8X7fVTaPvi2rGD0+b5Lz2PTkLVMAbxSXTUpqTmZZapG+XQJXxpLDF5kK/vNU/Js1
        h6mBcQVXFyMnh4SAicTTXfPZuhi5OIQEtjNKzHvUxgaRkJRY9vcIM4QtLLHy33N2iKInjBJn
        /lxkBEmwCKhKfFn/nwXEZhMwldi9sRnI5uAQEdCRaF2lDFLPLLCCQ2Lhoh9gNQwC9hKbTm0C
        s4UFbCS29u9hB6nnFTCTaDwiDDH/O6NEz8IlYDW8AoISJ2c+AbOZgWrmbX7IDFLPLCAtsfwf
        B0RYXqJ562ywOzkF/CT+LO4Fu19UQEZixtKvzBMYhWchmTQLyaRZCJNmIZm0gJFlFaNoakFx
        bnpucoGhXnFibnFpXrpecn7uJkZw+tAK2sG4bP1fvUOMTByMhxglOJiVRHh/PeNLFeJNSays
        Si3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamByOCGwwpBBocPW5HPP
        rjkiNfdviSx9vG158ucZaxwihD45Vhq6FMWntsiHxxrPYP6dZ/lJwvm0qXSuZEm9x0Opji+f
        PrLUcoXv/nPi6/PibbWv4r1XvPy89M9WRb+JFV5PeasLqsNvvj2lzn7GaPrjfA/BZ9p23Bqc
        FjM1Xew9zQPUDpifu//8WcrHDQGn5FLqlKy3nWKffaK1TtXhlG+2T7Ditkbpn7kVSVOeFwnG
        P5q8xLUo0dD27YNQJ/mQ0723v85tO8HL5r84Yw1PYvUWRutlUkW6OoEr81aej+/mVwwI5biw
        tY7haqqjSf3HGW/Uj/1OaC+Y+d7kQx3jxD/2WrcuZ3CUrfqlus2FSYmlOCPRUIu5qDgRAGGm
        ZFGOAwAA
X-CMS-MailID: 20230926101329epcas5p2008e3144f177f1c88aeb2302a22488e8
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----LAXCzQHOdZ.PJY8ISgkP8Kui-li3V03FA_f8OYW0UVQARYhI=_21324_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081458epcas5p3a3e12d8b5661b5d6f4420316630b02e1
References: <20230920080756.11919-5-nj.shetty@samsung.com>
        <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081458epcas5p3a3e12d8b5661b5d6f4420316630b02e1@epcms2p6>
        <20230922130815epcms2p631fc5fc5ebe634cc948fef1992f83a38@epcms2p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------LAXCzQHOdZ.PJY8ISgkP8Kui-li3V03FA_f8OYW0UVQARYhI=_21324_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

>> +                write_bio->bi_iter.bi_size = chunk;
>> +                ret = submit_bio_wait(write_bio);
>> +                kfree(write_bio);
>
>blk_mq_map_bio_put(write_bio) ?
>or bio_uninit(write_bio); kfree(write_bio)?
>
>hmm...
>It continuously allocates and releases memory for bio,
>Why don't you just allocate and reuse bio outside the loop?
>

Agree, we will update this in next version.

>> +                if (ret)
>> +                        break;
>> +
>> +                pos_in += chunk;
>> +                pos_out += chunk;
>> +        }
>> +        cio->status = ret;
>> +        kvfree(emulation_io->buf);
>> +        kfree(emulation_io);
>
>I have not usually seen an implementation that releases memory for
>itself while performing a worker. ( I don't know what's right. :) )
>
The worker is already executing at this point.
We think releasing the reference after it starts executing should not
be an issue, and it didn't come-up in any of our testing too.

>Since blkdev_copy_emulation() allocates memory for the emulation
>and waits for it to be completed, wouldn't it be better to proceed
>with the memory release for it in the same context?
>
>That is, IMO, wouldn't it be better to free the memory related to
>emulation in blkdev_copy_wait_io_completion()?
>

Above mentioned design works for synchronous IOs. But for asynchronous
IOs emulation job is punted to worker and submitter task returns.
Submitter doesn't wait for emulation to complete and memory is freed
later by worker.

Thank you,
Nitesh Shetty

------LAXCzQHOdZ.PJY8ISgkP8Kui-li3V03FA_f8OYW0UVQARYhI=_21324_
Content-Type: text/plain; charset="utf-8"


------LAXCzQHOdZ.PJY8ISgkP8Kui-li3V03FA_f8OYW0UVQARYhI=_21324_--
