Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C870B3459A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 09:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCWI0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 04:26:53 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:15434 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCWI0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:26:34 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210323082629epoutp031e1297b8950d6e6989605b1c2b51f87f~u60MhYHzY0413204132epoutp03i
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 08:26:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210323082629epoutp031e1297b8950d6e6989605b1c2b51f87f~u60MhYHzY0413204132epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616487989;
        bh=Xo+jhCC10ChDIi0mr5wVxZzV9wpTjQjBsX6MB+xpKNU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=HLpIjDblADnOSXWP5KtamFr35Hah45y8PtmBCmd6QPRiB0y0U/7Wsq5uS7ev3mUYA
         nkyLgiMpSN3pecUJ3yHOEtnmYKg0Rm9YtFhPH4HOHPzZAQGkzf0piPjwlsBZISpQJU
         Ecxxe7CiOUwTtrhaXY4SF9wV8sw8YvFdNIPNsCJs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210323082629epcas1p1d3ea0b1172c6f8257e9ee9a7d4c5ecb8~u60MDlQh72945029450epcas1p1n;
        Tue, 23 Mar 2021 08:26:29 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F4PbR3147z4x9Q9; Tue, 23 Mar
        2021 08:26:27 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.DD.63458.336A9506; Tue, 23 Mar 2021 17:26:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210323082626epcas1p2209ccbad05c79eea78ef3b0fc54c3690~u60J17y3n3014630146epcas1p2y;
        Tue, 23 Mar 2021 08:26:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210323082626epsmtrp2ff6e25ab5642fad36ba3f68cd5880af2~u60J1LsCh2453724537epsmtrp2g;
        Tue, 23 Mar 2021 08:26:26 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-8e-6059a6332204
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.CD.08745.236A9506; Tue, 23 Mar 2021 17:26:26 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210323082626epsmtip2263af203b844a0ffb24901375eec488b~u60Joltr12321823218epsmtip2N;
        Tue, 23 Mar 2021 08:26:26 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Hyeongseok Kim'" <hyeongseok@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <016101d71edf$8542b240$8fc816c0$@samsung.com>
Subject: RE: [PATCH v3] exfat: speed up iterate/lookup by fixing start point
 of traversing cluster chain
Date:   Tue, 23 Mar 2021 17:26:26 +0900
Message-ID: <010601d71fbe$37b62450$a7226cf0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFCCaC8jPi/61EWNQoXs0UvpNzAUAIaXSUoAZfvdIOrndYpwA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmnq7xssgEg5M3xCz+TvzEZLFn70kW
        i8u75rBZbPl3hNWBxWPnrLvsHn1bVjF6fN4kF8AclWOTkZqYklqkkJqXnJ+SmZduq+QdHO8c
        b2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKr
        lFqQklNgaFCgV5yYW1yal66XnJ9rZWhgYGQKVJmQk3Fqo2zBJPaKvqP9LA2MZ1i7GDk5JARM
        JNavP8zcxcjFISSwg1Giu2UiI4TziVGibfFnsCohgc+MEh82hMJ0HGv5CFW0i1Hi4uUr7BDO
        S0aJWzffg3WwCehK/Puznw3EFhGIkti77B0TiM0s4CzRefE0WA2ngJXE7+Pb2EFsYYEsifU7
        O8DiLAKqElMeTwXr5RWwlHh17yk7hC0ocXLmExaIOfIS29/OYYa4SEHi59NlQL0cQLucJFZd
        1YEoEZGY3dkG9pqEwFt2iX/3HjFC1LtIvH8zA+p/YYlXx7ewQ9hSEp/f7WUDmSMhUC3xcT/U
        +A5GiRffbSFsY4mb6zeArWIW0JRYv0sfIqwosfP3XEaItXwS7772sEJM4ZXoaBOCKFGV6Lt0
        mAnClpboav/APoFRaRaSv2Yh+WsWkgdmISxbwMiyilEstaA4Nz212LDACDmmNzGCk6GW2Q7G
        SW8/6B1iZOJgPMQowcGsJMLbEh6RIMSbklhZlVqUH19UmpNafIjRFBjSE5mlRJPzgek4ryTe
        0NTI2NjYwsTM3MzUWEmcN9HgQbyQQHpiSWp2ampBahFMHxMHp1QDU2OJ+5ZTdmlHK39MtN3X
        06Nk/vnTceV5JeInFKXudCtvjotLUk7b3u/AyP/hjn4qZ0kha3nasdTIt5rsNR9Ol935Vrvm
        jxHre3FJNeXJK5Z8P878a8ay52oTHZZMr7700PS+dkDW/0fNKbftwu/NCQ19o+5RF9AqwFR4
        PElZo6H2iKFW5/1bhkKJKqvmX3kg95zz9KQ7vodOnhdPKHdexlO6in3Hk7eHFJov6C9zO620
        3F9bJMpzSr3cjFsPV/3JcpSrEd7hy5TUbc1556uoeulusa8fJ7xtzs1bLpLDkfdEIXrH++0v
        ahTmThJ0ys64cyi8fCrD1U9nzz20YLgmteXPZ+aCwj7GQPmGtDm7lFiKMxINtZiLihMBYV3e
        Ag8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSvK7RssgEg7MtRhZ/J35istiz9ySL
        xeVdc9gstvw7wurA4rFz1l12j74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4Mo4tVG2YBJ7Rd/R
        fpYGxjOsXYycHBICJhLHWj4ydjFycQgJ7GCUWHHhGAtEQlri2IkzzF2MHEC2sMThw8UQNc8Z
        JS7/u8AMUsMmoCvx789+NhBbRCBK4tzxM2A2s4CrRNuLI6wQDTsZJRq2QiQ4Bawkfh/fxg5i
        CwtkSNzZ/hbsChYBVYkpj6eC1fAKWEq8uveUHcIWlDg58wkLxFBtid6HrYwQtrzE9rdzmCEO
        VZD4+XQZK8ihIgJOEquu6kCUiEjM7mxjnsAoPAvJpFlIJs1CMmkWkpYFjCyrGCVTC4pz03OL
        DQuM8lLL9YoTc4tL89L1kvNzNzGCI0NLawfjnlUf9A4xMnEwHmKU4GBWEuFtCY9IEOJNSays
        Si3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoFprbx44Hsnu8NPP53v
        TCqaJ5Ow+Bb/Y+azBqqZOlU9zTVTezb5LWhcy5y4qiSquNldVnh+MM96nybNroSeeQ8Xzbfc
        0CLfcPkTLwtvolBuxuPFqpOCijniVhlsZgj4wiC/zl1CfW5+YHz6vtaySrUPncKB3yTFHrHJ
        stwqM7u2qidE4KGITdyuhzfaDxaeD/PVTJ31ozMq7vYRV27TMJ/7J20WBV8RXFiRPplTb8NZ
        xo5b/1/uc5SfX6gTL6Zc+6C7zcgwsLV+8o/7Das2H9X9Jyv3Z56GZIKRlKOdhtUB55cLo6Qz
        e5sZuFglTHMOmQleLG1mdmBkrZqXl/L8+BvZkPPam+MC86NKZuUosRRnJBpqMRcVJwIArwgT
        bfsCAAA=
X-CMS-MailID: 20210323082626epcas1p2209ccbad05c79eea78ef3b0fc54c3690
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322035356epcas1p35cf4d476030f5ebaf6357c5761355605
References: <CGME20210322035356epcas1p35cf4d476030f5ebaf6357c5761355605@epcas1p3.samsung.com>
        <20210322035336.81050-1-hyeongseok@gmail.com>
        <016101d71edf$8542b240$8fc816c0$@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > When directory iterate and lookup is called, there's a buggy rewinding
> > of start point for traversing cluster chain to the parent directory
> > entry's first cluster. This caused repeated cluster chain traversing
> > from the first entry of the parent directory that would show worse
> > performance if huge amounts of files exist under the parent directory.
> > Fix not to rewind, make continue from currently referenced cluster and
> > dir entry.
> >
> > Tested with 50,000 files under single directory / 256GB sdcard, with
> > command "time ls -l > /dev/null",
> > Before :     0m08.69s real     0m00.27s user     0m05.91s system
> > After  :     0m07.01s real     0m00.25s user     0m04.34s system
> >
> > Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
> 
> Looks good.
> Thanks for your contribution.
> 
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied. Thanks!

