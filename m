Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CEB1E554B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 07:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgE1FDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 01:03:14 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:64716 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgE1FDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 01:03:12 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200528050308epoutp01424644e631fbc0f9d82c77b52d361d7f~TGKShz3QT0566705667epoutp01J
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 05:03:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200528050308epoutp01424644e631fbc0f9d82c77b52d361d7f~TGKShz3QT0566705667epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590642188;
        bh=xD4XmvUgu/OdTokoZ/Ks5/KdOZvToRWCxhjAPwMBgho=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=cFBPJrVfM4mYzmvNAOAFQ/H02Jh7jPHdwFUOn7ZR+qyaVp6bj2jhPTvyLS++7ouhT
         2bZlUOwcz43lDYjgB8yfW/IW2RRIfMIDe5Td0xNIjSbToP+kS657vo0jbzvWS48D3i
         sGirQgpgfNjtEwokXut+EJCQbFEBf7Jva5mX1oTA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200528050308epcas1p3a5db166606dacdaa653023696d638e60~TGKR6ABeM0641606416epcas1p3p;
        Thu, 28 May 2020 05:03:08 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49XbDp68t4zMqYkZ; Thu, 28 May
        2020 05:03:06 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.9D.04392.A064FCE5; Thu, 28 May 2020 14:03:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200528050306epcas1p473209d12f3dc8b54b05c08bf6604e79d~TGKQSIvLg3127731277epcas1p4F;
        Thu, 28 May 2020 05:03:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200528050306epsmtrp11cc61c035301d1ce57410677cfe85dc9~TGKQRbvJf1473214732epsmtrp12;
        Thu, 28 May 2020 05:03:06 +0000 (GMT)
X-AuditID: b6c32a37-cabff70000001128-17-5ecf460ab0e1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.E7.08382.A064FCE5; Thu, 28 May 2020 14:03:06 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200528050306epsmtip1a41794baa008dc834d7c550117599d4a~TGKQI0dLc2192221922epsmtip18;
        Thu, 28 May 2020 05:03:06 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Namjae Jeon'" <linkinjeon@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <ccb66f50-b275-4717-f165-98390520077b@gmail.com>
Subject: RE: [PATCH 4/4] exfat: standardize checksum calculation
Date:   Thu, 28 May 2020 14:03:06 +0900
Message-ID: <015401d634ad$4628e4c0$d27aae40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEl0VwLAqGTGno4seWfP7lwGg+RAAKJW6foAcSd2fUB9WovMgNdMeCFAbRhwtQCDDf9yamyrSRA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk75zhanOaqtwU1DxUlqFtzeioXUVGjC4wUAw314I4X2o2d
        zW4/spuVRGVR4LLULpqGGmZeShGWJbMsKkEqu9BVpcTMTMm0bcfIf8/7vO/7PN/zfR+FKW4R
        Kirb5uKdNs7CEDK8/t4yTYRsw5MUTV2bjh29+Apnv/rO4WzB+WsY29ziw9nnd4oI9vnkEM6W
        DZ/F2bqJNukayjhc1E4a885OkMZDDyoIY5PnNWmsrTxOGE/WVSLjj9oFJjLJEpfFc2beqeZt
        6XZzti3TwGyOT12Xqo/RaCO0K9hYRm3jrLyBWb/FFLEh2+I/FaPO4SxuP2XiBIGJWh3ntLtd
        vDrLLrgMDO8wWxxajSNS4KyC25YZmW63rtRqNMv1/sk0S1Z+4SPS0ULtft3RQeaibiIfhVBA
        R0PP2xEsH8koBd2IoLG8BheLIQRjvWMSsRhBMNng8Xeo4Mq7oWiRb0Hw/s1VqVj0IejpGZcE
        dAk6AibGW4MeSjoSfL6An4zC6EoJnH95ThpohNAGqL5ynwiohtJr4H7p0gCN04uhvtob1JHT
        K+Buz2lCxLPAV/gRD2CMXggN34owMYMaxj6VSUWvJBgvb5maUcKF43nBbEBXUdB2pngq9Ho4
        0OVBIg6F/vY6UsQq6DuVR4op98H31in9Ywh6fxlErIMXNTelgRGMXgY1d6JEOgyafl9Eou1M
        GPh5QiqqyOFYnkIcWQwnn92TiHg+5B8dJE8jxjMtmGdaMM+0AJ7/ZiUIr0RzeIdgzeQFrUM3
        /a1rUfDDhsc2opuPt3gRTSFmhlxjfJyikHI5wh6rFwGFMUr52s6HKQq5mduzl3faU51uCy94
        kd5/7wWYana63f/9ba5UrX65Tqdjo2NiY/Q6Zq68ePRRioLO5Fz8Tp538M5/exIqRJWLIhPN
        6SMH/iwcIA/7Ek2jtozSVar37pLC1W+ampxfjhTEK3c0xEtaK9BuecKiXZcVn61lCUQiW/jx
        cvvT8ksDnVXbDGVxpiUbb4cl19+WXb+xruLQh0sxve+KM+RbD6Y19+/vbt/uklUL1cokr2AK
        6ypIS1bO25jzIW0T3fl1cNLM4EIWpw3HnAL3FzYOC9HGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnC6X2/k4g9d/BC1+zL3NYvHm5FQW
        i4nTljJb7Nl7ksXi8q45bBaX/39isVj2ZTKLxZZ/R1gdODy+zDnO7tE2+R+7R/OxlWweO2fd
        ZffYtKqTzaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgyumaeYS/Yy1Fx99Qp9gbG62xdjBwc
        EgImEg8+mXQxcnEICexmlLjYvpO1i5ETKC4tcezEGWaIGmGJw4eLIWqeM0rsb3/MDFLDJqAr
        8e/PfjYQW0RAT+LkSZCZXBzMAuuYJD7t28wG0dHDLDFnbQcLSBWngK3EusVHwTYLCzhIHF2o
        ARJmEVCV2LbuEBOIzStgKbH7zgQ2CFtQ4uTMJ2CtzALaEk9vPoWy5SW2v53DDHGogsTPp8tY
        IY6IkvizfC9UjYjE7M425gmMwrOQjJqFZNQsJKNmIWlZwMiyilEytaA4Nz232LDAMC+1XK84
        Mbe4NC9dLzk/dxMjONa0NHcwbl/1Qe8QIxMH4yFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNS
        iw8xSnOwKInz3ihcGCckkJ5YkpqdmlqQWgSTZeLglGpg2tocZHqEwU7h4i9lxohd4v9mXwyb
        9meFmcCnlAXRxQwbe3blMrnXrNugubmg2CpbfkPDz++TK2cGvZFJeq3W6p35ddUeF+vqVQZb
        ihvFg1M/vf1aqXRM5cPLdPVKK4NpafwJ/DlZ/1NZDyZd7zYLdvlQ36Ba2XUt9qq79/QiX0aN
        NsXOsg8Z4StZ3l//1crebblohv+lhaweNhqCxg+DG5nCniWJzBDkv9CUNf2q3PXXC/W/hlxI
        3PVEt/jiTI+8jslXr39467gn8u6S9o11+SXLL65RvzmraXXZ5TfzVilwnf64uLax8thpc43C
        mQ87NrU/idLnm68+Q1h4378Eu3UnrbzXiJ5q2d3V8DlViaU4I9FQi7moOBEA/bcHWCQDAAA=
X-CMS-MailID: 20200528050306epcas1p473209d12f3dc8b54b05c08bf6604e79d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200525115121epcas1p2843be2c4af35d5d7e176c68af95052f8
References: <20200525115052.19243-1-kohada.t2@gmail.com>
        <CGME20200525115121epcas1p2843be2c4af35d5d7e176c68af95052f8@epcas1p2.samsung.com>
        <20200525115052.19243-4-kohada.t2@gmail.com>
        <00d301d6332f$d4a52300$7def6900$@samsung.com>
        <d0d2e4b3-436e-3bad-770c-21c9cbddf80e@gmail.com>
        <CAKYAXd9GzYTxjtFuUJe+WjEOHSJnVbOfwn_4ZXZgmiVtjV4z6A@mail.gmail.com>
        <ccb66f50-b275-4717-f165-98390520077b@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >> II tried applying patch to dev-tree (4c4dbb6ad8e8).
> >> -The .patch file I sent
> >> -mbox file downloaded from archive
> >> But I can't reproduce the error. (Both succeed) How do you reproduce
> >> the error?
> > I tried to appy your patches in the following order.
> > 1. [PATCH] exfat: optimize dir-cache
> > 2. [PATCH 1/4] exfat: redefine PBR as boot_sector 3. [PATCH 2/4]
> > exfat: separate the boot sector analysis 4. [PATCH 3/4] exfat: add
> > boot region verification 5. [PATCH 4/4] exfat: standardize checksum
> > calculation
> 
> I was able to reproduce it.
> 
> The dir-cache patch was created based on the HEAD of dev-tree.
> The 4 patches for boot_sector were also created based on the HEAD of dev-tree.
> (at physically separated place)
> 
> I'm sorry I didn't check any conflicts with these patches.
> 
> I'll repost the patch, based on the dir-cache patched dev-tree.
> If dir-cache patch will merge into dev-tree, should I wait until then?
I will apply them after testing at once if you send updated 5 patches again.
Thanks!
> 
> BR

