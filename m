Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B579F840
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 04:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfH1CVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 22:21:00 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:44743 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfH1CVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:21:00 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190828022057epoutp014ce3ac1fedcd9d424c6b2b074384e198~_9MdZnBnQ3029430294epoutp01P
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2019 02:20:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190828022057epoutp014ce3ac1fedcd9d424c6b2b074384e198~_9MdZnBnQ3029430294epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566958857;
        bh=2Id8G/Xn6V06sAdZYXMptUi6MUxaX2z3h414AQSi5/I=;
        h=From:To:Cc:Subject:Date:References:From;
        b=k98yVcHoY5eRWy55whZ8rcavcrMGw1LpHMDptIqy9vdMw+WVazwzt15mo01XkRRd9
         7l4/CVj1LA+KD2X9zJQ7pDyqu9or8QDc9Y8Ar0ut0xku1LRrop+z5Ki0aMLe43HoyD
         3N5pbfTIZQ6BYehWU3Hx+E4IXA0zFrHfzsrXO79E=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190828022056epcas2p488315cc4e34969caaecc606d9bbd2c6e~_9Mc2Raic1168911689epcas2p4l;
        Wed, 28 Aug 2019 02:20:56 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.181]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46J8c74t4rzMqYkf; Wed, 28 Aug
        2019 02:20:55 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.C7.04156.705E56D5; Wed, 28 Aug 2019 11:20:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20190828022055epcas2p25525077d0a5a3fa5a2027bac06a10bc1~_9MbUtf8v2048620486epcas2p2Q;
        Wed, 28 Aug 2019 02:20:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190828022055epsmtrp247236feb1b81a6eaa608658d164e62a4~_9MbTgesT1110211102epsmtrp2U;
        Wed, 28 Aug 2019 02:20:55 +0000 (GMT)
X-AuditID: b6c32a45-ddfff7000000103c-c4-5d65e5073e36
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.33.03706.605E56D5; Wed, 28 Aug 2019 11:20:55 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190828022054epsmtip1cb959d74740696d9b606a29b76e0110e~_9MbAmhuG2545625456epsmtip1A;
        Wed, 28 Aug 2019 02:20:54 +0000 (GMT)
From:   "boojin.kim" <boojin.kim@samsung.com>
To:     "'Theodore Y. Ts'o'" <tytso@mit.edu>
Cc:     "'Herbert Xu'" <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Biggers'" <ebiggers@kernel.org>,
        "'Theodore Y. Ts'o'" <tytso@mit.edu>,
        "'Chao Yu'" <chao@kernel.org>,
        "'Jaegeuk Kim'" <jaegeuk@kernel.org>,
        "'Andreas Dilger'" <adilger.kernel@dilger.ca>,
        "'Theodore Ts'o'" <tytso@mit.edu>, <dm-devel@redhat.com>,
        "'Mike Snitzer'" <snitzer@redhat.com>,
        "'Alasdair Kergon'" <agk@redhat.com>,
        "'Jens Axboe'" <axboe@kernel.dk>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Kukjin Kim'" <kgene@kernel.org>,
        "'Jaehoon Chung'" <jh80.chung@samsung.com>,
        "'Ulf Hansson'" <ulf.hansson@linaro.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fscrypt@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5/9] block: support diskcipher
Date:   Wed, 28 Aug 2019 11:20:53 +0900
Message-ID: <009301d55d47$38606400$a9212c00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdVdRkQ7u+BKrKHPSQuBNN28o4N3VA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wbZRjOd3e9OybFs6vus6LrThYdE9arFj50qNG5XbL9gb+iMc56KZcW
        7a/0WjbUbATXUhiRQXRuhbG5GeNgla3UjQzKXGGSOqBOZGEEt8QxDKBsApuBiNr2WOS/53m+
        5/ne9/3efDSu+pzS0CV2t+iyC1aWXEGc7l6Xn0PdELfrWnqy0O05P4Faf/geRy2/1JLo4mf9
        GGqM7yFQZLpBgYKdf+No72QmGmsN4Gh4wadAtdencBSPn6RQ6PplBYqMrEfXrs5j6GDTKIl+
        OroFTTbdIVBnJEagwbONJOr5txagA/EuDPlO3QbIWzNPod7gG88/yIePX8H4PW07+NPfreUH
        +z18qLmK5Ecvd5J825e7+Y4jsxhf0XcB5292DZH8J+FmwM+GHilKf8u60SIKxaJLK9pNjuIS
        u7mQ3fqq8UWjIU/H5XAFKJ/V2gWbWMhu2laUs7nEmpid1ZYKVk9CKhIkid3w7EaXw+MWtRaH
        5C5kRWex1clxzlxJsEkeuznX5LA9zel0ekPC+a7VUn/1EOWsTN/Zd7hWUQ4uplUDmobMUzBY
        KVaDFbSKaQfw5/EmhUxmALw5vI+UyZ0E8VaAuwlveIusRwD8bfhPXCYTAJ7/ay4RT6NJZj1s
        620GSaxmHodDi/Opa3HmHwqOzUSJ5MFKRg+91XuxJCaYtXCi6hKWrKBkCuCl/auTspK5D8YO
        jqXsOLManvmjEU9iyGhhe/9UqiE1kwuPjr8iW9SwocqX6gcyixQcb/ATsn8T/NgbWcquhJO9
        YUrGGjg7HSFlvBsOfXWMksM1APYt+JZMT8LAeGWqGM6sg61nN8gP8SjsGVlqLQP6uxcpWVZC
        v08lB7PgoZlBTJY18FbNLlnmYThcD/aBNYFlMwaWzRhYNkzg/7JHANEMHhCdks0sSnont3zT
        IZD6FNkvtYMDA9uigKEBm6703ytuVymEUqnMFgWQxlm18teshKQsFso+EF0Oo8tjFaUoMCQ2
        UIdr7jc5El/M7jZyBn1enq7AgAx5esSuUrbdc+VtFWMW3OL7ougUXXdzGJ2mKQdm9e/PFMRj
        773zBV9v6lKSE4+Fdg3MVVyYek5SKp6IvRms40syMn5sObHq/EM7TOdOZkd21tVrz2WWWSYa
        Tk1jU4dBJy2xr58IfXvmNZtpf0UpZ87vuHGreyBmffiFeJeR+Kaj91prJhoJlleXfXpsob0n
        mv91KTg++mHN1o/EzJdZQrIIXDbukoT/AJPWV5kqBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7bCSnC7709RYg94Ki69fOlgs1p86xmyx
        +m4/m8XpqWeZLOacb2Gx2PtuNqvF2j1/mC26X8lYPFk/i9nixq82Vov+x6+ZLc6f38Busenx
        NVaLvbe0Le7f+8lkMXPeHTaLS4vcLV7N+8ZisWfvSRaLy7vmsFkc+d/PaDHj/D4mi7aNXxkt
        Wnt+slscXxvuIOmxZeVNJo+WzeUe2w6oelw+W+qxaVUnm8eda3vYPDYvqffYveAzk0fTmaPM
        Hu/3XWXz6NuyitHj8ya5AJ4oLpuU1JzMstQifbsEroxJ9+ayF7TzVJyZ38/awHias4uRg0NC
        wESidYt7FyMXh5DAbkaJkzPfsHYxcgLFpSS2tu9hhrCFJe63HAGLCwk8Z5T43FQAYrMJaEts
        Pr6KEcQWEdCQuPr3J1gNs8A0DoldH8RBbGEBI4nWrm4mEJtFQFXiZedFJpC9vAKWEhenyYOE
        eQUEgdY+YQEJMwvoSbRtZISYIi+x/e0cqAsUJHacfc0IUiICVLLoWRBEiYjE7M425gmMgrOQ
        DJqFMGgWkkGzkHQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHPtamjsYLy+J
        P8QowMGoxMPbwZ8aK8SaWFZcmXuIUYKDWUmE95EKUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        07xjkUIC6YklqdmpqQWpRTBZJg5OqQbGCe6KPu0piqufKnP1tu34wfCOpXqGoZpO67oI2VcH
        eqz4CosPzjLUeH51hWb/iW3c2p8WGrj7dMxw+SJmk/ti5rSjDMePZCbVPPVd3qPhWBbPHjtv
        ZbFB6qVNv9OePpv046uo851LB0VeyiS+PenWVX+k+d80Jp7Pto/8NjFKWcr4L715Z/M0JZbi
        jERDLeai4kQAn059LPkCAAA=
X-CMS-MailID: 20190828022055epcas2p25525077d0a5a3fa5a2027bac06a10bc1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190828022055epcas2p25525077d0a5a3fa5a2027bac06a10bc1
References: <CGME20190828022055epcas2p25525077d0a5a3fa5a2027bac06a10bc1@epcas2p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 05:33:33PM +0900, boojin.kim wrote:
>
> Hi Boojin,
>
> I think the important thing to realize here is that there are a large
> number of hardware devices for which the keyslot manager *is* needed.
> And from the upstream kernel's perspective, supporting two different
> schemes for supporting the inline encryption feature is more
> complexity than just supporting one which is general enough to support
> a wider variety of hardware devices.
>
> If you want somethig which is only good for the hardware platform you
> are charged to support, that's fine if it's only going to be in a
> Samsung-specific kernel.  But if your goal is to get something that
> works upstream, especially if it requires changes in core layers of
> the kernel, it's important that it's general enough to support most,
> if not all, if the hardware devices in the industry.
>
> Regards,

I understood your reply.
But, Please consider the diskcipher isn't just for FMP. 
The UFS in Samsung SoC also has UFS ICE. This UFS ICE can be registered 
as an algorithm of diskcipher like FMP.

Following is my opinion to introduce diskcipher.
I think the common feature of ICE like FMP and UFS ICE, 
is 'exposing cipher text to storage".
And, Crypto test is also important for ICE.  Diskcipher supports
the common feature of ICE. 
I think specific functions for each ICE such as the key control of UFS ICE
and the writing crypto table of FMP can be processed at algorithm level.

Thanks for your reply.
Boojin Kim.

