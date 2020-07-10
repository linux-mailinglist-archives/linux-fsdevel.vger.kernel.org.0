Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01F621AE64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 07:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgGJFMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 01:12:34 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:27616 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgGJFMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:12:30 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200710051226epoutp03d1e4ca456f2b612dd42d78dda9af6722~gTBrPOxc92660226602epoutp03g
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 05:12:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200710051226epoutp03d1e4ca456f2b612dd42d78dda9af6722~gTBrPOxc92660226602epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594357946;
        bh=rNNX9b6tZ6S7AUB3rkF2clKx3XwI8G65y+6UE3xRA1s=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=tbMmZy3AIWbjjF+W5FCiAq8J+xAV91WKdR8yflCWH2Qoi6G3OgtQrn8gfPolD0mmY
         dDGpbATo1fTMLJZr066MFwv/B/0BE8vuPYV+U61nY0l/QgD/ZcFeNZ6i1MhqUsl45w
         AgU+5gRR8/obk4VcwkBNstSJW4M/sktRP34alNfU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200710051225epcas1p2d7d019eca37d4f786f547ce77d1aaeae~gTBq5yA7Y2125421254epcas1p2h;
        Fri, 10 Jul 2020 05:12:25 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4B31Ph5q2ZzMqYm0; Fri, 10 Jul
        2020 05:12:24 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.79.29173.8B8F70F5; Fri, 10 Jul 2020 14:12:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200710051224epcas1p3c534126a5da8e1ca0fbb1ac8d6a009e8~gTBpaF6-i1355613556epcas1p3L;
        Fri, 10 Jul 2020 05:12:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200710051224epsmtrp27c1d60f434e879dfe2ce9b9a62ca85fb~gTBpZeJqN0586905869epsmtrp2E;
        Fri, 10 Jul 2020 05:12:24 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-0c-5f07f8b8f5fd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.91.08303.8B8F70F5; Fri, 10 Jul 2020 14:12:24 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200710051223epsmtip1c42b64b665e657d1b4ff051f1616bdde~gTBpO6GpQ2279322793epsmtip1i;
        Fri, 10 Jul 2020 05:12:23 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Hyeongseok Kim'" <hyeongseok@gmail.com>, <sj1557.seo@samsung.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708095233.56131-1-hyeongseok@gmail.com>
Subject: RE: [PATCH] exfat: fix wrong size update of stream entry by typo
Date:   Fri, 10 Jul 2020 14:12:24 +0900
Message-ID: <00b301d65678$b268b880$173a2980$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIwFQOcuNwl5jhs2AXwhm4KWh7FlAF9CkZPqEDe0zA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmge6OH+zxBv9/aFn8nfiJyWLP3pMs
        Fpd3zWGz2PLvCKsDi8fOWXfZPfq2rGL0+LxJLoA5KscmIzUxJbVIITUvOT8lMy/dVsk7ON45
        3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2ibkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRW
        KbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ+PdhKesBReZKpbd/c3SwDiFqYuRk0NC
        wERi4of5LF2MXBxCAjsYJTZe2MUK4XxilDi6bwk7hPOZUeLskyXMMC0Hb86BatnFKLFi+S4m
        COclo8T5ndtZQKrYBHQl/v3ZzwZiiwi4S+x618MIYjMLOEscvnEKbBKngJXEt8fLwWxhAU+g
        3dPAbBYBVYmHrz+D1fMKWErc3XiIDcIWlDg58wkLxBx5ie1v50BdpCDx8+kyVohdVhIrD0xg
        hqgRkZjd2cYMcpyEwFd2idcrzrJANLhI/L6+GMoWlnh1fAs7hC0l8fndXqBlHEB2tcTH/VDz
        OxglXny3hbCNJW6u38AKUsIsoCmxfpc+RFhRYufvuVAv8km8+9rDCjGFV6KjTQiiRFWi79Jh
        aLBLS3S1f2CfwKg0C8ljs5A8NgvJA7MQli1gZFnFKJZaUJybnlpsWGCMHNmbGMEpUct8B+O0
        tx/0DjEycTAeYpTgYFYS4TVQZI0X4k1JrKxKLcqPLyrNSS0+xGgKDOqJzFKiyfnApJxXEm9o
        amRsbGxhYmZuZmqsJM777yx7vJBAemJJanZqakFqEUwfEwenVAOT1pJQRy3z6OkOLWv36DEs
        tpTm7P/91HBjYAjvvYzzNobPKh7ez0pmN085565+/Rbn59li7W7yz85vnLa9ir1n9ZaXVzpX
        LVyiyzW9XNqCu+ofX/D8fTfvWV+ZvX1qjNg53uyrwuZs5hH/7X6/SWxveLLp93WDFfdW3Emr
        6r/z5muQ3aVL5WlzX8v69xkp2295OPO599KQCsXVy9dm5r1aqP7RIFxMW1jWt/Ca9N2VofFF
        h4MF3gavCFucarUg4uirlOWyB1rldmd8PBizxWJ69aRiD811XvukMvY3C2z2rXJaeyzI5oDo
        YRePA0p2QXdkjY9erlb/6ZdQxJYXt2P9oVVPlWO4f8VNWnnKOm6LEktxRqKhFnNRcSIA5KU3
        9hIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSnO6OH+zxBh8fsVr8nfiJyWLP3pMs
        Fpd3zWGz2PLvCKsDi8fOWXfZPfq2rGL0+LxJLoA5issmJTUnsyy1SN8ugSvj3YSnrAUXmSqW
        3f3N0sA4hamLkZNDQsBE4uDNOSxdjFwcQgI7GCVOHbnBDpGQljh24gxzFyMHkC0scfhwMUhY
        SOA5o8ThTi8Qm01AV+Lfn/1sILaIgKfEioMrwGYyC7hKzH++mg1iZjejRPurZ2AzOQWsJL49
        Xs4MYgsDNWy8MA3MZhFQlXj4+jMjiM0rYClxd+MhNghbUOLkzCcsIDcwC+hJtG1khJgvL7H9
        7RxmiDMVJH4+XcYKcYOVxMoDE5ghakQkZne2MU9gFJ6FZNIshEmzkEyahaRjASPLKkbJ1ILi
        3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4LjQ0trBuGfVB71DjEwcjIcYJTiYlUR4DRRZ44V4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzfp21ME5IID2xJDU7NbUgtQgmy8TBKdXAZLik7z3T2+1B
        tqc3eHd+On530ubzd7lFGmImfyt+Z3uOv5f71+w1+s1/xUMcPi5+vFU7XOvit/uHVp61NNLP
        tnDbsN7o+JGILK7NG6QY/Ex+ubyWvM6iq3K+ua/c52TERMkGZZcfd38/fTz9prj9ce+0W7US
        Fc4b763d7Hkmj735lu2J+fJZrdIiih+CX55kyFnT5bKlbW72fd3T3kXHXjzJCvviJ2DxkVld
        Y+XCXTkWcaeXFb6xF1ARrfnx5vubU/IZtZpaVvd5T6kHBEos8KkKfCiykSdm8Z/MigN17oWt
        kw/vbeGYPUW9qqEsPOHZhS/xNhXLHv+5Zr1IIqVRyk3+Xlpqg83vw4f38p21VWIpzkg01GIu
        Kk4EAOgVh4H6AgAA
X-CMS-MailID: 20200710051224epcas1p3c534126a5da8e1ca0fbb1ac8d6a009e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200708095242epcas1p2a106825fa23003abb184739703c594cc
References: <CGME20200708095242epcas1p2a106825fa23003abb184739703c594cc@epcas1p2.samsung.com>
        <20200708095233.56131-1-hyeongseok@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> The stream.size field is updated to the value of create timestamp of the file entry. Fix this to use
> correct stream entry pointer.
> 
> Fixes: 29bbb14bfc80 ("exfat: fix incorrect update of stream entry in __exfat_truncate()")
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
My bad, Pushed it into exfat #dev.
Thanks!

