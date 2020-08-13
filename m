Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7808243316
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 06:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMEDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 00:03:36 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:59457 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgHMEDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 00:03:36 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200813040331epoutp03dfd6688b3191e988255606e7c132d11d~quBOKeIwP2158521585epoutp03c
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 04:03:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200813040331epoutp03dfd6688b3191e988255606e7c132d11d~quBOKeIwP2158521585epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597291411;
        bh=gB+8yUlFrkMvVf09surihHyhYTCjSfRF7gIP4ew9+og=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=V9t5rsR5eoslynQVzZ91PEpNf74mdqJSfcmZJ0a2faq+ux8sEHvx/1lCoEgRXOqa2
         /y6lsu71fLEi/e2Yni9xf/Yh26WwXQRCQHu1KhGtzJoDhXHL3cJKQ5SAhQy/tWfCli
         2mL/6l4xNbuA3XL0UH31u/MJUNKeBCFNC05JuHsM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200813040331epcas1p15c253a9f0888ea029a451b7e5464c6a2~quBNlY8t30383703837epcas1p1k;
        Thu, 13 Aug 2020 04:03:31 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BRtGV1MKrzMqYkk; Thu, 13 Aug
        2020 04:03:30 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.EC.18978.19BB43F5; Thu, 13 Aug 2020 13:03:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200813040329epcas1p3019e96dba8ac8592dbb2dec1c7120a57~quBLohVhR2391823918epcas1p3J;
        Thu, 13 Aug 2020 04:03:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200813040329epsmtrp27845189943a832cab6dac23a4aee1a6b~quBLizr7W3111331113epsmtrp20;
        Thu, 13 Aug 2020 04:03:29 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-ba-5f34bb913685
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.99.08303.09BB43F5; Thu, 13 Aug 2020 13:03:28 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200813040328epsmtip2a6e865257b153c0d0200232f9df3ecaa~quBLW6E_i0336303363epsmtip2Z;
        Thu, 13 Aug 2020 04:03:28 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <490837eb-6765-c7be-bb80-b30fe34adb55@gmail.com>
Subject: RE: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
Date:   Thu, 13 Aug 2020 13:03:28 +0900
Message-ID: <001501d67126$b3976df0$1ac649d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF0BoMPlscPSpT3Th8lCwQKqdMbhQJGtMGMAcFEUC0CM27r7AJXiyRiAvP59PwCFflaTAKXbWa7qXiTdBA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmge7E3SbxBm/2m1r8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYrHl3xFWB3aPL3OOs3u0Tf7H7tF8bCWbx85Zd9k9+ras
        YvT4vEkugC0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
        LTMH6BYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6V
        oYGBkSlQZUJOxtljggUHhSsmr57A2MC4j7+LkZNDQsBE4vnO2yxdjFwcQgI7GCX2/jzMDuF8
        YpRY/+sflPOZUWLj2bXsMC1rN1xnBbGFBHYxSsy4FAhR9JJR4vfb52wgCTYBXYl/f/aD2SIC
        ehInT15nAyliFmhkkphwvQcswSlgKzH7xCOgSRwcwgKWEguvK4OEWQRUJRbMuQVWwgsUvt+3
        jxXCFpQ4OfMJC4jNLCAvsf3tHGaIgxQkfj5dBjZGRCBJ4sSsLIgSEYnZnW3MIGslBBZySKzp
        mQb1gItE4/zvbBC2sMSr41ug4lISn9/tZQOZIyFQLfFxP9T4DkaJF99tIWxjiZvrN4CtYhbQ
        lFi/Sx8irCix8/dcRoi1fBLvvvawQkzhlehoE4IoUZXou3SYCcKWluhq/8A+gVFpFpK/ZiH5
        axaSB2YhLFvAyLKKUSy1oDg3PbXYsMAQOaY3MYITqZbpDsaJbz/oHWJk4mA8xCjBwawkwst8
        2TheiDclsbIqtSg/vqg0J7X4EKMpMKQnMkuJJucDU3leSbyhqZGxsbGFiZm5mamxkjjvw1sK
        8UIC6YklqdmpqQWpRTB9TBycUg1MC1K/7AkLXGTF0RG0V/eks1Tu1vJw1XjfSP/FkV+zLp5r
        Yrkk8UZ4t7hruEqAcM/itXEfHkdffH1r9sJgy08qbk2dhadl5TUaZAU3aB1dr/ThTe2M3Fl7
        Yv9cKOAw7IiXKn6VEizHZqf7dqrpc6ejEr8eb5k0P1DO6+wps4STt1S8vrPuu/lgvZZL65vC
        B10qy/gV/fp2rVIo8l5swqgZrC4iwfX9/wl3FV4XZ9eyg2sVS/fLyX9Sen7zvNRl35a5zZ/m
        cE6unPKWJU1Q/fS2mwLP5yf8+OPlcPrHBvdNBmmVAtzXIn2ObBV7vNL6Wuju3f9tepdUT0gQ
        EJ1gGb5pYvH2c52XudfmZhUzapYrsRRnJBpqMRcVJwIAUTPvXi0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXnfibpN4g8PJFj/m3maxeHNyKovF
        nr0nWSwu75rDZnH5/ycWi2VfJrNYbPl3hNWB3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi+KySUnNySxLLdK3S+DKOHtMsOCgcMXk1RMYGxj38XcxcnJICJhIrN1wnbWLkYtD
        SGAHo0THy3ssEAlpiWMnzjB3MXIA2cIShw8Xg4SFBJ4zSnz4wwhiswnoSvz7s58NxBYR0JM4
        efI6G8gcZoFmJonPe2+zQwxdxizRf/ITK0gVp4CtxOwTj1hBhgoLWEosvK4MEmYRUJVYMOcW
        2CBeoPD9vn2sELagxMmZT8DuYRbQluh92MoIYctLbH87hxniTgWJn0+XgY0UEUiSODErC6JE
        RGJ2ZxvzBEbhWUgmzUIyaRaSSbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7
        iREcUVpaOxj3rPqgd4iRiYPxEKMEB7OSCC/zZeN4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxf
        Zy2MExJITyxJzU5NLUgtgskycXBKNTBtuMPEeiEqtkiCQfGB06qXizgX8nMnKt6/XzPpmqnY
        XOPfLnw72i9P+9Xt1r1y9fY/F9a5uUl+FgqsMnl7IHXmw41tjHu7dM6ZxaRkrS40nBfBkdQu
        u68luMg032PxuyNN/WsePzVNllnVbl7yfbfgBs0+qxnK7tPMFR5L1EckFTAuPzc59Mzx3g+x
        3/b3L47SOvTyUefhtQYzhHbEWX4LOft1stXmf826czK82oMmMe85uC+Nw0H/33KTI3OlPnQU
        LLs35d/+CNa3ruotT+3S5xhIxMwOv8oc/ndbuvPMeLOvDQvO3Drl9kSNvUtr4+GbXE1flCPP
        39FaIXVUW2rv489fn4i+2JYf1FHySqJWiaU4I9FQi7moOBEANTYHrxcDAAA=
X-CMS-MailID: 20200813040329epcas1p3019e96dba8ac8592dbb2dec1c7120a57
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3
References: <CGME20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3@epcas1p2.samsung.com>
        <20200616021808.5222-1-kohada.t2@gmail.com>
        <414101d64477$ccb661f0$662325d0$@samsung.com>
        <aac9d6c7-1d62-a85d-9bcb-d3c0ddc8fcd6@gmail.com>
        <500801d64572$0bdd2940$23977bc0$@samsung.com>
        <c635e965-6b78-436a-3959-e4777e1732c1@gmail.com>
        <000301d66dac$07b9fc00$172df400$@samsung.com>
        <490837eb-6765-c7be-bb80-b30fe34adb55@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Thanks for thinking on this complicated issue.
> 
> 
> > Most of the NAND flash devices and HDDs have wear leveling and bad sector replacement algorithms
> applied.
> > So I think that the life of the boot sector will not be exhausted first.
> 
> I'm not too worried about the life of the boot-sector.
> I'm worried about write failures caused by external factors.
> (power failure/system down/vibration/etc. during writing) They rarely occur on SD cards, but occur on
> many HDDs, some SSDs and USB storages by 0.1% or more.
Hard disk and SSD do not guarantee atomic write of a sector unit?

> Especially with AFT-HDD, not only boot-sector but also the following multiple sectors become
> unreadable.
Other file systems will also be unstable on a such HW.

> It is not possible to completely solve this problem, as long as writing to the boot-sector.
> (I think it's a exFAT's specification defect) The only effective way to reduce this problem is to
> reduce writes to the boot-sector.
exFAT's specification defect... Well..
Even though the boot sector is corrupted, It can be recovered using the backup boot sector
through fsck.
> 
> 
> > Currently the volume dirty/clean policy of exfat-fs is not perfect,
> 
> Thank you for sharing the problem with you.
> 
> 
> > but I think it behaves similarly to the policy of MS Windows.
> 
> On Windows10, the dirty flag is cleared after more than 15 seconds after all write operations are
> completed.
> (dirty-flag is never updated during the write operation continues)
> 
> 
> > Therefore,
> > I think code improvements should be made to reduce volume flag records while maintaining the current
> policy.
> 
> Current policy is inconsistent.
> As I wrote last mail, the problem with the current implementation is that the dirty-flag may not be
> cleared after the write operation.(even if sync is enabled or disabled) Because, some write operations
> clear the dirty-flag but some don't clear.
> Unmount or sync command is the only way to ensure that the dirty-flag is cleared.
> This has no effect on clearing the dirty-flag after a write operations, it only increases risk of
> destroying the boot-sector.
>   - Clear the dirty-flag after every write operation.
>   - Never clear the dirty-flag after every write operation.
> Unless unified to either one,  I think that sync policy cannot be consistent.
> 
> How do you think?
> 
> 
> BR
> ---
> etsuhiro Kohada <kohada.t2@gmail.com>


