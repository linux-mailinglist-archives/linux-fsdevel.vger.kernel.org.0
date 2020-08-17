Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF32247B3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 01:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHQXse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 19:48:34 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:27595 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgHQXsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:48:32 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200817234829epoutp0438811fc283571917726f9282d4c30004~sMw9ufehj0120101201epoutp04K
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 23:48:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200817234829epoutp0438811fc283571917726f9282d4c30004~sMw9ufehj0120101201epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597708109;
        bh=coaDJpz0qObfEcnP97LLKt/rW37q6622OVtDy661qM0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=N6XSJ/lf388V7Qg2Cjh6sThEqBEMWAm8v6bj6Ba094PxELOh+veygO5pfDyg9W6nB
         rDX7MnfTB/iDLdkC7SH+yfRzC6yVg//iKLYeLnGzJU6858aT6+ZCLVVNhClXO04m6s
         QMQ58Cn7pYHuggYRqsa0D3JU+NayHLfQ654T/iyE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200817234828epcas1p10722c6189e525e1f0958445fafbac762~sMw9Kk9XM0820808208epcas1p1c;
        Mon, 17 Aug 2020 23:48:28 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BVrMv6h48zMqYkZ; Mon, 17 Aug
        2020 23:48:27 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.69.18978.B471B3F5; Tue, 18 Aug 2020 08:48:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200817234827epcas1p293567bbefc75379991a8a9d8f04c9877~sMw8NbXU00802908029epcas1p2E;
        Mon, 17 Aug 2020 23:48:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200817234827epsmtrp1d95abad216a68f15fd63d85befdfcd00~sMw8K-CxK0624906249epsmtrp1J;
        Mon, 17 Aug 2020 23:48:27 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-f9-5f3b174b64f0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.55.08382.B471B3F5; Tue, 18 Aug 2020 08:48:27 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200817234827epsmtip2cbc694a8099e36a5f3d936cfaeb90ea3~sMw79btCp2991929919epsmtip2O;
        Mon, 17 Aug 2020 23:48:27 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Xianting Tian'" <tian.xianting@h3c.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <20200815105707.19701-1-tian.xianting@h3c.com>
Subject: RE: [PATCH] exfat: use i_blocksize() to get blocksize
Date:   Tue, 18 Aug 2020 08:48:27 +0900
Message-ID: <003001d674f0$e724f3e0$b56edba0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQIE7cLKDaMD7jW+aef5YDrAJSgpzQLX3ndMqMlGxeA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmga63uHW8wZPLphZ79p5ksbi8aw6b
        xZZ/R1gtrh7dyOjA4tF7dzuLR9+WVYwenzfJBTBH5dhkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        pRak5BQYGhToFSfmFpfmpesl5+daGRoYGJkCVSbkZPT3nGMp2MNY8eDZYbYGxpmMXYycHBIC
        JhLt1yewdzFycQgJ7GCUWPlsKzOE84lRYv3EU6wQzjdGidmt3ewwLe+n7mSCSOxllPiz+ikj
        hPOSUeL2j5esIFVsAroS//7sZwOxRYDs1yf2gMWZBeIlFu84DhbnFLCWuDNjOROILSxgJ7F1
        2lywGhYBVYmHZ1eCbeMVsJTo2dDMAmELSpyc+YQFYo68xPa3c5ghLlKQ+Pl0GdR8EYnZnW3M
        EHutJN787GIDOU5C4CO7xM0z21kgGlwklnUeg3pHWOLV8S1QtpTEy/42IJsDyK6W+Lgfan4H
        o8SL77YQtrHEzfUbWEFKmAU0Jdbv0ocIK0rs/D2XEeIEPol3X3tYIabwSnS0CUGUqEr0XTrM
        BGFLS3S1f2CfwKg0C8ljs5A8NgvJM7MQli1gZFnFKJZaUJybnlpsWGCIHNmbGMEpUct0B+PE
        tx/0DjEycTAeYpTgYFYS4U06YR4vxJuSWFmVWpQfX1Sak1p8iNEUGNQTmaVEk/OBSTmvJN7Q
        1MjY2NjCxMzczNRYSZz34S2FeCGB9MSS1OzU1ILUIpg+Jg5OqQYm++2teqJnohkCzm++K9dT
        bjgzZQqrsH2i9pRrFyTc8/+GVBtphtutX2ebGqd3dKvXt/lPatI57vfpy2/tmrXiykXPG7FJ
        vntSTXaw3bq3LJhP449G5qtbprsMDi8y3+Osd/kZx9kLnqkSnCqL3se4q/al3A1ZObmqqK/L
        c6GS8ZoZrOb+py93T+jIXLm84Kd20+cYyR2v1z4wK5f61pLo/2+JipO99NTKwg5m1+3vRRdu
        q7OZGVMVLr1WcmOPb/bEVA7ruL7exqvP4qeXfeZYv6tUUlvtAYPpvMu9keEbrv653D919RSJ
        dB/PSal1Zeyfzkg8+M/L+mryxT11pkddgjd59M/h528+aTbHYqUSS3FGoqEWc1FxIgDnpOWY
        EgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvK63uHW8waYdkhZ79p5ksbi8aw6b
        xZZ/R1gtrh7dyOjA4tF7dzuLR9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGX095xjKdjDWPHg
        2WG2BsaZjF2MnBwSAiYS76fuZOpi5OIQEtjNKDHp0zaohLTEsRNnmLsYOYBsYYnDh4shap4z
        Snzeuhmshk1AV+Lfn/1sILYIkP36xB5WEJtZIFHizJI2VoiGHkaJJxMPMYEkOAWsJe7MWA5m
        CwvYSWydNhesgUVAVeLh2ZXsIDavgKVEz4ZmFghbUOLkzCcsEEP1JNavn8MIYctLbH87hxni
        UAWJn0+XQS0WkZjd2cYMcZCVxJufXWwTGIVnIRk1C8moWUhGzULSvoCRZRWjZGpBcW56brFh
        gWFearlecWJucWleul5yfu4mRnB0aGnuYNy+6oPeIUYmDsZDjBIczEoivEknzOOFeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ894oXBgnJJCeWJKanZpakFoEk2Xi4JRqYApbsVRK7nR9bGbltFdR
        2xpuLZyfJLU68kbTibqdy1gsNNvv/xBWP/5n9gKFlSZbKgS+e/f6V62QVru+XGPrGhZ7f+c9
        yxe0TeWran6adnTq1Odc36WLJ+5JCJr5YektxoDJNhl3mqUNHx7hlp2488Ezbp38TduDfT2M
        b174arnh5QLNIy8OVc7ZF3X2UvLLha3zQqxmGlglVT6s2bCHb0mXya4Cl6TNJ2dzOZnYPls0
        59MZndOvA8Rs315hzRHzdW54INoToOdQzsU53WrLr6Du0J+HXvZxy+p8sf6/3mi7xT/1ULfa
        2IILS7QDebwt1AOCxZ/w8ghXcyrF/byW8Pt2AgPz6rkNnEHJxcarliqxFGckGmoxFxUnAgAE
        E4f1/QIAAA==
X-CMS-MailID: 20200817234827epcas1p293567bbefc75379991a8a9d8f04c9877
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200815110400epcas1p409bc3055e7c3d7443b5fbf5409a43332
References: <CGME20200815110400epcas1p409bc3055e7c3d7443b5fbf5409a43332@epcas1p4.samsung.com>
        <20200815105707.19701-1-tian.xianting@h3c.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> We alreday has the interface i_blocksize() to get blocksize, so use it.
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
Pushed it into exfat #dev. Thanks for your patch!

