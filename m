Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D0423F83E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Aug 2020 18:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgHHQfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Aug 2020 12:35:33 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:18401 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgHHQfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Aug 2020 12:35:32 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200808163529epoutp04e7ab9817986d82615f4b05e365bd116a~pWDWIv5nd2092020920epoutp04e
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2020 16:35:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200808163529epoutp04e7ab9817986d82615f4b05e365bd116a~pWDWIv5nd2092020920epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596904529;
        bh=tC3F95YqfLzbeAJ5++JT42zEvxWh1lrpK7LykFjWBYk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=vU5bFIuszBWVKR5JMKA1i4/hg937VD84PR4s73hY5G8n868pbYei1laidYGET50nQ
         S7HQhp8NiaNQVpof0eTAQ+7+ZQvogJlhbtTEMkHsdcs1IgqfD3IhhoeUxCyVyqqB2V
         bTsrU2w5E+XA2ObqzBZtyE3C8EQm7Q2tHEbZpxsU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200808163528epcas1p3e99db7503bf813c19f6731ab175a7525~pWDU0LrPa1779917799epcas1p3A;
        Sat,  8 Aug 2020 16:35:28 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BP7BR31HMzMqYlh; Sat,  8 Aug
        2020 16:35:27 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.89.28578.F44DE2F5; Sun,  9 Aug 2020 01:35:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200808163526epcas1p13c481d08b9f3c66d545518a366c53cdf~pWDTF5KCQ2258422584epcas1p14;
        Sat,  8 Aug 2020 16:35:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200808163526epsmtrp1ba077f95dd9861edba63e5c6cf2ccb90~pWDTFQjVU1509815098epsmtrp1P;
        Sat,  8 Aug 2020 16:35:26 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-e5-5f2ed44f8007
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.54.08303.E44DE2F5; Sun,  9 Aug 2020 01:35:26 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200808163526epsmtip23e8820e5c879f60b2292f4ead19c5a8c~pWDS2Z6jE2016620166epsmtip2N;
        Sat,  8 Aug 2020 16:35:26 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806010229.24690-1-kohada.t2@gmail.com>
Subject: RE: [PATCH v3] exfat: integrates dir-entry getting and validation
Date:   Sun, 9 Aug 2020 01:35:26 +0900
Message-ID: <000001d66da1$eb814c50$c283e4f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQEbExpjEPjSXl8AARcuee++128TSgIF0gSvqpTuVyA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmvq7/Fb14g9VPhC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi8qxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2Vo
        YGBkClSZkJPRMe0GY8Ek7or7P76yNTD+4+hi5OCQEDCR+DunuIuRi0NIYAejxOkNN9kgnE+M
        El+mfmXuYuQEcj4zSjzdmw9igzRsnt7IClG0i1Hi7vK37BDOS0aJ7o5dLCBVbAK6Ek9u/ATr
        FhHQkzh58jobiM0s0MgkceJlNojNKWApcereP1aQM4QFvCTm9UqBhFkEVCSmz13KBGLzApVs
        vHQRyhaUODnzCQvEGHmJ7W/nMEMcpCCx+9NRVohVVhLX9q1jhagRkZjd2cYMcpuEwFwOiV27
        7jBCNLhINE17yAphC0u8Or6FHcKWknjZ3wZl10v8n7+WHaK5hVHi4adtTJDwspd4f8kCxGQW
        0JRYv0sfolxRYufvuYwQe/kk3n3tYYWo5pXoaBOCKFGR+P5hJwvMpis/rjJNYFSaheSzWUg+
        m4Xkg1kIyxYwsqxiFEstKM5NTy02LDBFjupNjOBEqmW5g3H62w96hxiZOBgPMUpwMCuJ8Ga9
        0I4X4k1JrKxKLcqPLyrNSS0+xGgKDOuJzFKiyfnAVJ5XEm9oamRsbGxhYmZuZmqsJM778JZC
        vJBAemJJanZqakFqEUwfEwenVANT6e2//9giXCQ/i+jZaE428d1vLLv1nv/BDwdsX3lOu/no
        8rrQqZXHrrgbbM5+kxN8yID9vMjfXfUxDs9DArmtzv+4de6IyuONip8m5otdeOCq/cqWp8vo
        t+zB6Ev3VbZOW7HkykUv9wyHu98ZbnrpLX5ibfe2ON9Pcc5k30q7GRO6zV7/W95VuG1NVuV6
        M72njXOvPbARZ5sYo6fDrG7mH/Dg9QJ2tXdtx1jy+xaa/Jx82ePF/fSJIouLWkx9fu8IWnxp
        qeCJgqUHt3h0b2w60THz79muSPbL83Vupn8S2dD52FGxLL5084kX1Qm53PurZvtK+7TpT2nX
        3fi4tE7vkaaTwqfrYpo36roe/a6vVGIpzkg01GIuKk4EAGxw+d4tBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXtfvil68wbdfkhY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwRXHZpKTmZJalFunbJXBldEy7wVgwibvi/o+vbA2M/zi6GDk5JARMJDZPb2TtYuTi
        EBLYwShx4/8Zxi5GDqCElMTBfZoQprDE4cPFECXPGSXW3p/JBNLLJqAr8eTGT2YQW0RAT+Lk
        yetsIEXMAs1MEq1fmpkgOroYJSbM+MsGUsUpYClx6t4/VpCpwgJeEvN6pUDCLAIqEtPnLgUb
        ygtUsvHSRShbUOLkzCcsIOXMQAvaNjKChJkF5CW2v53DDHG/gsTuT0dZIW6wkri2bx0rRI2I
        xOzONuYJjMKzkEyahTBpFpJJs5B0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJ
        ERxRWlo7GPes+qB3iJGJg/EQowQHs5IIb9YL7Xgh3pTEyqrUovz4otKc1OJDjNIcLErivF9n
        LYwTEkhPLEnNTk0tSC2CyTJxcEo1MDnyzppid91h5qZlO29V8l1b1PzKQPbwT/MPx6tOn++f
        eig87KHPZWU3y/ZNQcxtO3WYPn+58Ffx9LMJuoF3AqQKTZ8dyFfJlfl4mz3TuJpl8dn9K3IL
        Xrxj+ce12aIqSNlD9MUK1jdBNQaizA5la3J2c+RfTD3cs7XdsKB3il5jVi3brtmCU1OOGNc+
        M3U9zGb7d9PsOTPCVrHu1Uxnucz0qud8jt8PtQ9ZrIcmt7Zbpij0Ws+Vsu9LvLXL6NrBsvP3
        TWoioraVfjB6M9v65uMlIpuam/ZcFvzhe8SF/RYXu0KyyfGU6duzp+2/kM6fJlezUiFoist0
        Vi2mDVuLNi3VUJnseyj6/6TbqTH8kkosxRmJhlrMRcWJAEvf8+AXAwAA
X-CMS-MailID: 20200808163526epcas1p13c481d08b9f3c66d545518a366c53cdf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200806010249epcas1p18fd6e3febad305975b43e1b55b56bcae
References: <CGME20200806010249epcas1p18fd6e3febad305975b43e1b55b56bcae@epcas1p1.samsung.com>
        <20200806010229.24690-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Add validation for num, bh and type on getting dir-entry.
> Renamed exfat_get_dentry_cached() to exfat_get_validated_dentry() due to a
> change in functionality.
> 
> Integrate type-validation with simplified.
> This will also recognize a dir-entry set that contains 'benign secondary'
> dir-entries.
> 
> Pre-Validated 'file' and 'stream-ext' dir-entries are provided as member
> variables of exfat_entry_set_cache.
> 
> And, rename TYPE_EXTEND to TYPE_NAME.
> 
> Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
> Suggested-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

Looks good to me. Thanks.

> ---
> Changes in v2
>  - Change verification order
>  - Verification loop start with index 2
> Changes in v3
>  - Fix indent
>  - Fix comment of exfat_get_dentry_set()
>  - Add de_file/de_stream in exfat_entry_set_cache
>  - Add srtuct tag name for each dir-entry type in exfat_dentry
>  - Add description about de_file/de_stream to commit-log
> 
>  fs/exfat/dir.c       | 147 +++++++++++++++++--------------------------
>  fs/exfat/exfat_fs.h  |  17 +++--
>  fs/exfat/exfat_raw.h |  10 +--
>  fs/exfat/file.c      |  25 ++++----
>  fs/exfat/inode.c     |  49 ++++++---------
>  fs/exfat/namei.c     |  36 +++++------
>  6 files changed, 122 insertions(+), 162 deletions(-)

