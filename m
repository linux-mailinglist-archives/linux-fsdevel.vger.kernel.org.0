Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8A988BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 02:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfHVAyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 20:54:47 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:32998 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbfHVAyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:54:47 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190822005444epoutp02509616d67c930502f8e1d489f603b330~9GJd48OJr0040100401epoutp02b
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 00:54:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190822005444epoutp02509616d67c930502f8e1d489f603b330~9GJd48OJr0040100401epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566435284;
        bh=zkZXU4UgR2xVWaur+CPkoWa/h3dr00YRZlhWS9MWMAc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LgsqbT+hYIIBvCF5mcNpSLjX71VwNOW3ECNKiy2AW9M3uUPWM77Adx70KiCIl9S6g
         8BCo8Y4qWPQ92CXApOiUFoMXdJsXwcahI1N312DIPZXn1iuJDjZsyN95Wn0XJ9GJwM
         pcZJtA6x5sXzKBtI4w7edPjs3L/3X5MzcmqT9uaY=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190822005443epcas2p12f0b23d4dfaf0bb9b991b29ddfea4ff8~9GJdH1To80306303063epcas2p1A;
        Thu, 22 Aug 2019 00:54:43 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.186]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46DQzP0PDKzMqYkc; Thu, 22 Aug
        2019 00:54:41 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.1F.04156.FC7ED5D5; Thu, 22 Aug 2019 09:54:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20190822005438epcas2p337aba06b328cdcdd1549395f0bbcfdbc~9GJY5qmwx3233232332epcas2p3f;
        Thu, 22 Aug 2019 00:54:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190822005438epsmtrp223bcbfc1f01624cd3dc41a63517cface~9GJY4itJ50123901239epsmtrp2Q;
        Thu, 22 Aug 2019 00:54:38 +0000 (GMT)
X-AuditID: b6c32a45-df7ff7000000103c-ab-5d5de7cf581d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.D2.03706.EC7ED5D5; Thu, 22 Aug 2019 09:54:38 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190822005438epsmtip27b8ec42598e05dbe2605a805a7b78b25~9GJYp2w_l0938509385epsmtip2B;
        Thu, 22 Aug 2019 00:54:38 +0000 (GMT)
From:   "boojin.kim" <boojin.kim@samsung.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
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
        <linux-crypto@vger.kernel.org>, <linux-fscrypt@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5/9] block: support diskcipher
Date:   Thu, 22 Aug 2019 09:54:38 +0900
Message-ID: <017901d55884$2cbc8f60$8635ae20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Content-Language: ko
Thread-Index: AdVYhCtkBjnnAwgAQWGl61cO3+ZKhw==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wTdxTf9+56V5TOszL9rllcvQ0TNdS2W9kXIsuS6bxE/sCZjcRZ8QKX
        QmyvTa9F3JIpTiogEd3iIi06f7KVTrtRqIiUOUA7N1nNWHEyx2KAbZappJ0E2BxrOcz47/M+
        733e5728PDmu9FAqeZng4O0CZ2bIBUSwZxXKivxuNGp9NTR69Fc1gfzfXsOR75d6En13tA9D
        jZH9BAo98MjQ+c5/cHQw9hwa8btx9NO0S4bqh8dwFIl8QaGW4QEZCg2uQb8OTWGo4cQdEv1w
        eiOKnZggUGfoOoH6OxpJ1DtTD9CxSBeGXF8+AqiqbopC4fOFrz3LtnpvY+z+wC42eCWT7e9z
        si3NNSR7Z6CTZANn97CXTyYwdt+Nqzj7sCtKsodamwGbaFlekL7VvK6U50p4u5oXiq0lZYIp
        j9m0pej1IkO2Vpely0GvMGqBs/B5zPr8gqw3yszJ3Rl1OWd2JqkCThSZta+us1udDl5dahUd
        eQxvKzHbdDqbRuQsolMwaYqtllydVqs3JCt3mEsHPmigbKNkxf3pSXIvuCSrBWlySL8M6891
        4LVggVxJtwPYuS9OSkEcwMdBPyUFEwCOzNzFn0guBD1ziRCAp9p6ZVJwD8Daq0dmG5P0GhgI
        N4MUzqDfhp/cmiFSRTgdouChtsrZxBJaD6tqD2IpTNCZ8MdgYtZCQedAX6xKJuHF8HrDCJHC
        OP08vHi/cW4MNWzvGwMSnwE9NS5cMtPA/s+HQMoM0pVy6ImOAkmwHp76rAmT8BIYC7dSElbB
        xIMQKeE9MNp0hpLEdQDemHbNFb0E3b8dSDaSJ91WQX/H2hSE9Auwd3Butqdhdc9jSqIVsNql
        lIQvwuPxfkyiVXC87n2JZuHPg23gMFjhnreke96S7nmLuf+3PQmIZrCUt4kWEy/qbbr5124B
        s4+xekM7OPZ9fjeg5YBJVxzOMhqVMq5c3G3pBlCOMxmKisatRqWihNv9Lm+3FtmdZl7sBobk
        DY7gqmeKrck3ExxFOoM+O1ubY0CGbD1ilikCC29vU9ImzsHv5Hkbb3+iw+Rpqr3AEz/rzf3j
        4/GxycJtkYEP0y487Ap/0+QNe24lKkSDb/zmgZ18+cjCtMylny7fBePvLK56j5q4sjL3zS1O
        IXN0yiv4e/5Fmrei3uHqXj93eVNg0VddlT4m8Hd+eqyQuftUlNbcO527aMi+wnTGcnTDyo1f
        T577c3Ng+7Kyyc03M659xBBiKadbjdtF7j9ZtnA9LgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWy7bCSvO6557GxBj+36Ft8/dLBYrH+1DFm
        i9V3+9ksTk89y2Qx53wLi8Xed7NZLdbu+cNs0f1KxuLJ+lnMFjd+tbFa9D9+zWxx/vwGdotN
        j6+xWuy9pW1x/95PJouZ8+6wWVxa5G7xat43Fos9e0+yWFzeNYfN4sj/fkaLGef3MVm0bfzK
        aNHa85Pd4vjacAdJjy0rbzJ5tGwu99h2QNXj8tlSj02rOtk87lzbw+axeUm9x+4Fn5k8ms4c
        ZfZ4v+8qm0ffllWMHp83yQXwRHHZpKTmZJalFunbJXBlXGueyV7wlK3i7a8fbA2MO1m7GDk5
        JARMJNZtm83excjFISSwm1HicesPqISUxNb2PcwQtrDE/ZYjrBBFzxklWi89YgdJsAloS2w+
        vooRxBYRiJD4vKmZDaSIWeAyu8Svvg9sIAlhASOJ1q5uJhCbRUBV4sq2z2BTeQUsJVa/amWF
        sAUlTs58wtLFyAHUrCfRthFsJrOAvMT2t3OgjlCQ2HH2NVRcRGJ2ZxszxF49ictr7jFOYBSc
        hWTSLIRJs5BMmoWkewEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOA0oKW5g/Hy
        kvhDjAIcjEo8vBN0Y2OFWBPLiitzDzFKcDArifBWzImKFeJNSaysSi3Kjy8qzUktPsQozcGi
        JM77NO9YpJBAemJJanZqakFqEUyWiYNTqoHR/3xjomm+UuNza36XT/syBRcuDdj2pvvHHj7v
        Co5+z/JqscvTsoNWmN98Ul6ye8f1Q09rHkpuep167iuXgXjuERnen0//OhpvrD5pwGOoorWs
        Qv6H8ONV3yZvv3Rx9qGtTFMtWAWc9u6duYqxsO17cllw0/bX93kWxe++rFG1xkdnd3HZOi0X
        JZbijERDLeai4kQAbRpSev8CAAA=
X-CMS-MailID: 20190822005438epcas2p337aba06b328cdcdd1549395f0bbcfdbc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190822005438epcas2p337aba06b328cdcdd1549395f0bbcfdbc
References: <CGME20190822005438epcas2p337aba06b328cdcdd1549395f0bbcfdbc@epcas2p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/19 21:09 AM, Jens Axboe wrote:
> This isn't going to happen. With this, and the inline encryption
> proposed by Google, we'll bloat the bio even more. At least the Google
> approach didn't include bio iter changes as well.

> Please work it out between yourselves so we can have a single, clean
> abstraction that works for both.

I'm looking at inline encryption by Google. 
I will find compatibility with inline encryption to avoid conflicts
in BIO/F2FS.
And changing bio iter has a benefit for diskcipher.
Without changing bio iter, diskcipher should control(alloc/free) a buffer
to hold a 'bi_dun' variable for every bio.
But changing bio iter is difficult to accept for block layer,
I will modify the diskcipher.
And, as you mentioned, inline encryption by Google has this control.
So I might be able to use it.

Thanks.
Boojin Kim.

